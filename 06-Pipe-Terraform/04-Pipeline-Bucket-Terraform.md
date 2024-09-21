Construindo uma Pipe de Infra-Estrutua na AWS
==============================================

Para avançarmos na implementação de pipelines em git actions integradas a AWS, vamos propor o provisionamento de uma Bucket S3, para isso seguiremos os seguintes passos:

- [ ] Utilizar a branch `dev` no repositório onde a [pipeline de teste](03-Pipe-Github-AWS.md) foi configurada
- [ ] Criar uma pasta de Infra-Estrutura no seu repositório com a [pipeline de teste](03-Pipe-Github-AWS.md) configurada
- [ ] Criar uma pasta `env/dev` e outra `env/prod` dentro da pasta de `infra`
- [ ] Criar um arquivo `terraform.tfvars` em cada um dos subdiretórios acima
- [ ] Copiar os arquivos já utilizados no projeto de provisionamento do [S3](../apendix/Terraform/examples/s3/)
- [ ] Criar o Arquivo `provider.tf` no diretório `infra`
- [ ] Criar o Arquivo `variables.tf` no diretório `infra` 
- [ ] Criar os arquivos `terraform.yaml`, `dev.yaml` e `prod.yaml` no subdiretório `.github/workflows`
- [ ] Criar os arquivo `backend.tf`dentro da pasta de `infra`


Conteúdo do arquivo `backend.tf`
```hcl
terraform {
  backend "s3" {}
}
```

Conteúdo do arquivo `variables.tf`
```hcl
variable "pipe_bucket_prefix" {
    type = string
    description = "Prefix to the bucket_name"
}

variable "pipe_region" {
  type = string
  description = "region to aws provider"
}
```


Conteúdo do arquivo `providers.tf`
```hcl
provider "aws" {
  region = "us-east-2"
}
```

conteúdo do `terraform.tfvars` de `dev`
```hcl
pipe_bucket_prefix = "dev-terraform-bucket-posmack"
pipe_region = "us-east-2"
```

conteúdo do `terraform.tfvars` de `prod`
```hcl
pipe_bucket_prefix = "prod-terraform-bucket-posmack"
pipe_region = "us-east-2"
```


conteúdo do `terraform.yaml` da pasta `.github/workflows`

```yaml
name: "Terraform Bucket Pipeline"

on:
  workflow_call:
    inputs:
      environment:
        type: string
        required: true
      aws-assume-role-arn:
        type: string
        required: true
      aws-region:
        type: string
        required: true
      aws-state-s3-bucket:
        type: string
        required: true
      aws-lock-table:
        type: string
        required: true

jobs:
  terraform:
    runs-on: ubuntu-latest
    defaults:
      run:
        shell: bash

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: 1.8.3

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: ${{ inputs.aws-assume-role-arn }}
          role-session-name: GitHub_to_AWS_via_FederatedOIDC
          aws-region: ${{ inputs.aws-region }}


      - name: Terraform Init
        run: |
          cd infra && terraform init \
            -backend-config="bucket=${{ inputs.aws-state-s3-bucket }}" \
            -backend-config="key=${{ github.event.repository.name }}" \
            -backend-config="region=${{ inputs.aws-region }}" \
            -backend-config="dynamodb_table=${{ inputs.aws-lock-table }}"

      - name: Terraform Validate
        id: terraform-validate
        run: terraform validate


      - name: Terraform Plan
        id: terraform-plan
        run: cd infra &&
          terraform workspace select ${{ inputs.environment }} || terraform workspace new ${{ inputs.environment }} &&
          terraform plan -var-file="./env/${{ inputs.environment }}/terraform.tfvars" -out="${{ inputs.environment }}.plan"

      - name: Terraform Apply
        id: terraform-apply
        run: cd infra &&
          terraform workspace select ${{ inputs.environment }} || terraform workspace new ${{ inputs.environment }} &&
          terraform apply "${{ inputs.environment }}.plan"
```

conteúdo do `dev.yaml` na pasta `.github/workflows`
```yaml
name: "Pipeline DEV"

on:
  push:
    branches: [ dev ]

permissions:
  id-token: write
  contents: read

jobs:
  terraform:
    uses: ./.github/workflows/terraform.yaml
    with:
      environment: dev
      aws-region: "us-east-2"
      aws-state-s3-bucket: "<nome da bucket para o state>"
      aws-lock-table: "<nome da tabela dynamoDB para controle de lock>"
      aws-assume-role-arn: "<ARN da role para executar o terraform na AWS>"
```

Um último passo seria preparar a nossa estrutura para controlar a remoção dos recursos da AWS, para isso precisamos:

- [ ] Criar um arquivo destroy.json na pasta `infra`
- [ ] Adicionar o step para leitura do json logo após o Configure AWS Credentials no arquivo `terraform.yaml`
- [ ] Criar o step de Destroy no no arquivo `terraform.yaml` logo após o terraform Init
- [ ] Adicionar os controle de execução baseados na confiuração de destroy


Exemplo do step de leitura do json
```yaml
      - name: Read destroy.json
        id: read-destroy
        run: |
          DESTROY="$(jq -r '.${{ inputs.environment }}' ./infra/destroy.json)"
          echo "destroy=$(echo $DESTROY)" >> $GITHUB_OUTPUT

```

Exemplo de step de Destroy
```yaml
      - name: Terraform Destroy
        if: steps.read-destroy.outputs.destroy == 'true'
        id: terraform-destroy
        run: cd infra &&
          terraform workspace select ${{ inputs.environment }} || terraform workspace new ${{ inputs.environment }} &&
          terraform destroy -var-file="./env/${{ inputs.environment }}/terraform.tfvars" -auto-approve

```