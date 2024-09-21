Criando uma pipeline em GitActions integrando com a AWS
========================================================

Agora vamos configurar nossa pipeline no Github integrada com a AWS:

O primeiro passo é criar a estrutura na AWS que suporta a integração com o Github.

Para realizar essa etapa você precisará:
 - [ ] [Criar um provedor de identidade na AWS](../apendix/IdentityProvider/AssumeRole-AWS.md)
 - [ ] Crie uma Bucket em sua conta na AWS para armazenar os estados de execução de su pipeline
 - [ ] Crie uma Tabela no DynamoDB para controlar as execuções de sua pipeline

Em seguida crie um repositório na sua conta do Github
 - [ ] Repositório para rodar sua pipeline
 - [ ] Crie o arquivo .gitignore para ignorar arquivos da pasta .terraform
 - [ ] Crie 3 Branchs (test, dev e prod)
 - [ ] Clone o repositório e escolha a Branch test
 - [ ] Crie a pasta .github/workflows na raíz do seu repositório
 - [ ] Crie oa arquivo `terraform-aws-test.yaml` dentro do subdiretório workflows
 - [ ] Crie o arquivo `providers.tf`
 - [ ] Realize o commit e acompanhe o `Actions` no seu repositório do Github



**Exemplo do arquivo `terraform-aws-test.yaml`**
```yaml
# This is a basic workflow to help you get started with Actions
name: "Connect to an AWS role from a GitHub repository"

# Controls when the action will run. Invokes the workflow on push events but only for the main branch
on:
  push:
    branches: [ test ]

env:
  
  AWS_REGION : "us-east-2" #Change to reflect your Region

# Permission can be added at job level or workflow level    
permissions:
      id-token: write   # This is required for requesting the JWT
      contents: read    # This is required for actions/checkout
jobs:
  AssumeRoleAndCallIdentity:
    runs-on: ubuntu-latest
    steps:
      - name: Git clone the repository
        uses: actions/checkout@v3
      - name: configure aws credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: "<ARN da sua Role>" 
          role-session-name: GitHub_to_AWS_via_FederatedOIDC
          aws-region: ${{ env.AWS_REGION }}
      # Hello from AWS: WhoAmI
      - name: Sts GetCallerIdentity
        run: |
          aws sts get-caller-identity    
```

**Exemplo do Arquivo `providers.tf`**
```hcl
provider "aws" {
  region = "us-east-2"
}
```