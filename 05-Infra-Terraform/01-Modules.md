Trabalhando com módulos no Terraform
=========================


- **Objetivo**: Este módulo Terraform cria um bucket S3 na AWS, com um nome que começa com um prefixo especificado pelo usuário. Ele é configurado para ser flexível em termos de região e prefixo do bucket, através de variáveis. Além disso, expõe o ID do bucket criado para que possa ser usado em outros módulos ou scripts.

- **Principais Configurações**:
  - A versão do Terraform e do provedor AWS é controlada para garantir compatibilidade.
  - As variáveis permitem que o módulo seja configurado de forma flexível e reutilizável.
  - A saída do ID do bucket S3 facilita o uso do recurso criado em outras partes da infraestrutura.

Este é um exemplo simples, mas eficaz, de como o Terraform pode ser usado para criar e gerenciar recursos de infraestrutura na nuvem de forma declarativa e modular.


### 1. `main.tf`

Este arquivo é o coração do módulo, onde os recursos e configurações principais são definidos. Vamos detalhar o que cada parte faz:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}
```

- **Bloco `terraform`**: Este bloco define requisitos globais para o módulo, como as versões dos provedores e do Terraform que devem ser usados.
  - **`required_providers`**: Define os provedores necessários para o módulo. Aqui, estamos usando o provedor AWS (`source = "hashicorp/aws"`) na versão `~> 4.16`, o que significa que qualquer versão 4.x.x será aceita, mas não as versões 5.x.x.
  - **`required_version`**: Especifica a versão mínima do Terraform que é compatível com este módulo. No caso, a versão deve ser `>= 1.2.0`.

```hcl
provider "aws" {
  region = var.region
}
```

- **Provedor `aws`**: Este bloco configura o provedor AWS, que é essencial para interagir com a infraestrutura da Amazon Web Services (AWS). O campo `region` é configurado usando a variável `var.region`, o que permite flexibilidade na escolha da região AWS onde os recursos serão criados.

```hcl
resource "aws_s3_bucket" "terraform-aws-bucket" {
  bucket_prefix = var.bucket_prefix
}
```

- **Recurso `aws_s3_bucket`**: Este bloco cria um bucket S3 na AWS. O bucket é um armazenamento de objetos altamente escalável. O nome do bucket é parcialmente definido pelo prefixo especificado na variável `var.bucket_prefix`. A AWS exige que os nomes dos buckets S3 sejam únicos globalmente, por isso o uso de um prefixo pode ajudar a garantir a singularidade.

### 2. `variables.tf`

Este arquivo define as variáveis que o módulo usa. Definir variáveis permite parametrizar o módulo, tornando-o reutilizável com diferentes configurações.

```hcl
variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}
```

- **Variável `region`**: Define a região AWS onde os recursos serão implantados. A descrição (`description`) ajuda a documentar o que essa variável faz, e o tipo (`type`) garante que o valor seja uma string. O valor padrão (`default`) é `us-east-1`, que é uma das regiões da AWS.

```hcl
variable "bucket_prefix" {
  description = "The Prefix to name the bucket"
  type        = string
}
```

- **Variável `bucket_prefix`**: Define o prefixo que será usado para nomear o bucket S3. Esta variável não tem um valor padrão, então ela deve ser fornecida ao usar o módulo. Isso permite flexibilidade na definição dos nomes dos buckets.

### 3. `outputs.tf`

Este arquivo define as saídas do módulo. As saídas são usadas para expor informações sobre os recursos criados para outros módulos ou para o usuário final.

```hcl
output "aws-bucket-id" {
  value = aws_s3_bucket.terraform-aws-bucket.id
}
```

- **Saída `aws-bucket-id`**: Este bloco expõe o ID do bucket S3 criado. O valor (`value`) da saída é definido como o ID do recurso `aws_s3_bucket.terraform-aws-bucket`. Esse ID pode ser útil para outras partes da infraestrutura ou scripts que precisam referenciar o bucket criado.


