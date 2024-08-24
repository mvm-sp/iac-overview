Introdução ao Terraform
=========================

### O que são Providers no Terraform?

**Providers** são componentes fundamentais no Terraform que servem como uma ponte entre a configuração que você escreve e a API do serviço que deseja gerenciar. Eles são responsáveis por criar, atualizar e excluir recursos em nuvens e outras plataformas, como AWS, Azure, Google Cloud, Kubernetes, GitHub, entre outros.

Cada provider é desenvolvido para gerenciar recursos específicos de uma plataforma. Por exemplo, o provider da AWS (`provider "aws"`) gerencia recursos como instâncias EC2, buckets S3, VPCs, etc. Já o provider do Google Cloud (`provider "google"`) gerencia recursos da Google Cloud, como instâncias de Compute Engine, Cloud Storage, e muito mais.

### Como Configurar e Utilizar um Provider

A configuração de um provider normalmente envolve especificar as credenciais de autenticação e outras configurações necessárias para se conectar à API do serviço. Essas configurações são definidas no bloco `provider`.

#### Exemplo de Configuração de Provider

Aqui está um exemplo simples de como configurar um provider para a AWS dentro de um módulo Terraform:

```hcl
provider "aws" {
  region = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
```

Neste exemplo:
- **`provider "aws"`**: Especifica que estamos usando o provider da AWS.
- **`region`**: Define a região AWS onde os recursos serão criados.
- **`access_key` e `secret_key`**: São as credenciais necessárias para autenticação na AWS. Essas variáveis são definidas separadamente, geralmente em um arquivo `variables.tf` ou diretamente como variáveis de ambiente para maior segurança.

### Exemplo de Utilização de Provider Dentro de um Módulo

Quando você está usando módulos, é comum configurar os providers no nível do módulo para garantir que o código do módulo possa ser reutilizado em diferentes ambientes.

#### Estrutura de Módulo com Provider

```hcl
# Diretório do módulo: modules/ec2_instance/
.
├── main.tf
├── variables.tf
└── outputs.tf
```

**`main.tf` dentro do módulo:**

```hcl
provider "aws" {
  region = var.region
}

resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = var.instance_name
  }
}
```

**`variables.tf` dentro do módulo:**

```hcl
variable "region" {
  description = "AWS region"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "instance_name" {
  description = "Name tag for the instance"
  type        = string
}
```

**Exemplo de uso do módulo:**

```hcl
module "my_ec2_instance" {
  source        = "./modules/ec2_instance"
  region        = "us-east-1"
  ami_id        = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  instance_name = "ExampleInstance"
}
```

### `required_providers` no Terraform

A seção `required_providers` é usada no Terraform para especificar explicitamente quais providers são necessários para a configuração e qual a versão mínima ou exata de cada provider. Isso garante que, ao inicializar a configuração (com `terraform init`), o Terraform baixe e utilize os providers corretos, evitando incompatibilidades de versão.

Essa abordagem é especialmente útil em projetos onde diferentes equipes podem estar usando diferentes versões de providers, ou quando você quer garantir que a infraestrutura seja provisionada usando uma versão específica de um provider que você já testou e validou.

### Exemplo de Utilização de `required_providers`

Aqui está um exemplo simples de como utilizar a sessão `required_providers`:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.2"
    }
  }
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = var.aws_region
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}
```

#### Detalhes da implementação:

- **`terraform {}`**: Bloco de configuração global para especificar requisitos e configurações de versões.
- **`required_providers {}`**: Declara os providers necessários para a configuração. Neste exemplo, são o `aws` e o `google`.
  - **`source`**: Define o namespace e o nome do provider. `hashicorp/aws` significa que o provider está disponível no registro oficial da HashiCorp.
  - **`version`**: Especifica a versão do provider. No exemplo, `aws` deve ter uma versão maior ou igual a `4.0.0`, e o `google` deve estar na série `4.2.x`.
- **`required_version = ">= 1.0.0"`**: Garante que o Terraform CLI utilizado seja pelo menos a versão `1.0.0`.

### Configuração de Providers com `required_providers` em Módulos

Quando se utiliza módulos, a seção `required_providers` também pode ser usada para garantir que os módulos dependam das versões corretas dos providers. Se um módulo específico depende de uma versão particular de um provider, isso deve ser explicitamente declarado para evitar problemas ao compartilhar o módulo.

#### Exemplo de Módulo com `required_providers`

```hcl
# Diretório do módulo: modules/s3_bucket/
.
├── main.tf
├── variables.tf
└── outputs.tf
```

**`main.tf` dentro do módulo:**

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.50.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl    = "private"
}
```

**`variables.tf` dentro do módulo:**

```hcl
variable "region" {
  description = "AWS region"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}
```

### Uso do Módulo

```hcl
module "my_s3_bucket" {
  source      = "./modules/s3_bucket"
  region      = "us-west-2"
  bucket_name = "my-unique-bucket-name"
}
```

### Resumo
- **Providers** no Terraform são componentes que permitem a integração com APIs de diferentes serviços, como nuvens públicas, ferramentas de CI/CD, entre outros.
- A configuração de um provider é feita através de um bloco `provider` no Terraform, onde você especifica informações como região e credenciais.
- Dentro de módulos, os providers são configurados para que o módulo seja reutilizável em diferentes ambientes, passando as variáveis necessárias para a configuração do provider.

- **`required_providers`** é uma sessão importante para garantir que os providers corretos sejam usados e que as versões sejam compatíveis com a configuração do Terraform.
- **Versionamento de providers** é crucial para garantir a estabilidade e consistência do provisionamento de infraestrutura.
- **Módulos** podem e devem usar a sessão `required_providers` para garantir que as dependências de providers sejam corretamente gerenciadas e que os módulos sejam portáteis e seguros para serem usados em diferentes contextos.

