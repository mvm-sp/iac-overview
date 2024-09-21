Construindo uma Pipe de Infra-Estrutua na AWS
==============================================

Para avançarmos na implementação de pipelines em git actions integradas a AWS, vamos propor o provisionamento de uma Bucket S3, para isso seguiremos os seguintes passos:

- [ ] Utilizar a branch `dev` no repositório com a [pipeline de teste](03-Pipe-Github-AWS.md) configurada
- [ ] Criar uma pasta de Infra-Estrutura no seu repositório com a [pipeline de teste](03-Pipe-Github-AWS.md) configurada
- [ ] Criar uma pasta `env/dev` e outra `env/prod` dentro da pasta de `infra`
- [ ] Criar um arquivo `terraform.tfvars` em cada um dos subdiretórios acima
- [ ] Copiar os arquivos já utilizados no projeto de provisionamento do [S3](../apendix/Terraform/examples/s3/)
- [ ] Criar o Arquivo `provider.tf` no diretório `infra`
- [ ] Criar o Arquivo `variables.tf` no diretório `infra` 
- [ ] Criar os arquivos `terraform.yaml`, `dev.yaml` e `prod.yaml` no subdiretório `.github/workflows`
- [ ] Criar os arquivo `beckend.tf`dentro da pasta de `infra`


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