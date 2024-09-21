Construindo uma Pipe de Infra-Estrutua na AWS
==============================================

Para avançarmos na implementação de pipelines em git actions integradas a AWS, vamos propor o provisionamento de uma Bucket S3, para isso seguiremos os seguintes passos:

- [ ] Utilizar a branch `dev` no repositório com a [pipeline de teste](03-Pipe-Github-AWS.md) configurada
- [ ] Criar uma pasta de Infra-Estrutura no seu repositório com a [pipeline de teste](03-Pipe-Github-AWS.md) configurada
- [ ] Criar uma pasta `env/dev` e outra `env/prod`
- [ ] Criar um arquivo `terraform.tfvars` em cada um dos subdiretórios acima
- [ ] Copiar os arquivos já utilizados no projeto de provisionamento do [S3](../apendix/Terraform/examples/s3/)
- [ ] Criar o Arquivo `provider.tf` no diretório `infra`
- [ ] Criar o Arquivo `Variables.tf` no diretório `infra` 
- [ ] Criar os arquivos `terraform.yaml`, `dev.yaml` e `prod.yaml` no subdiretório `.github/workflows`