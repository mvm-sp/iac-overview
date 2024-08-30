HashiCorp Configuration Language
=========================


### **1. O que é HCL?**

HCL (HashiCorp Configuration Language) é uma linguagem de configuração declarativa desenvolvida pela HashiCorp. Ela é projetada para ser legível por humanos e é usada em várias ferramentas da HashiCorp, como Terraform, Consul, e Vault. No contexto do Terraform, HCL é usada para descrever a infraestrutura como código (IaC).

### **2. Estrutura Básica do HCL**

Um arquivo HCL é composto por blocos de configuração. Cada bloco possui uma estrutura geral que inclui:

- **Tipo de Bloco**: Indica o que o bloco faz (ex.: `resource`, `variable`, `output`).
- **Identificadores**: Dependendo do bloco, você pode ter um ou mais identificadores. Por exemplo, no caso de um recurso, temos o tipo do recurso (`aws_s3_bucket`) e o nome lógico do recurso (`my_bucket`).
- **Propriedades**: Configurações dentro do bloco que definem os atributos do recurso.

#### Exemplo de Bloco:

```hcl
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-bucket-name"
  acl    = "private"
}
```

### **3. Tipos de Blocos em HCL**

#### 3.1. Bloco `terraform`

O bloco `terraform` configura aspectos gerais do Terraform, como os provedores e a versão do Terraform que deve ser usada.

```hcl
terraform {
  required_version = ">= 1.2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}
```

#### 3.2. Bloco `provider`

Define as configurações específicas para um provedor de infraestrutura (como AWS, Azure, Google Cloud).

```hcl
provider "aws" {
  region = "us-east-1"
}
```

#### 3.3. Bloco `resource`

O bloco `resource` é usado para criar recursos na infraestrutura, como máquinas virtuais, buckets de armazenamento, bancos de dados, etc.

```hcl
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-bucket-name"
  acl    = "private"
}
```

#### 3.4. Bloco `variable`

Usado para definir variáveis que tornam o código reutilizável e flexível. As variáveis podem ter valores padrão, tipos e descrições.

```hcl
variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}
```

#### 3.5. Bloco `output`

O bloco `output` é usado para expor valores gerados pela infraestrutura, como IDs de recursos criados, que podem ser usados em outros módulos ou diretamente acessados pelos usuários.

```hcl
output "bucket_id" {
  value = aws_s3_bucket.my_bucket.id
}
```

#### 3.6. Bloco `module`

Os blocos `module` permitem a reutilização de configurações ao referenciar módulos externos ou internos que definem recursos e lógicas comuns.

```hcl
module "network" {
  source = "./modules/network"
  cidr_block = "10.0.0.0/16"
}
```

#### 3.7. Bloco `data`

O bloco `data` em Terraform é usado para buscar ou referenciar dados existentes na infraestrutura, em vez de criar novos recursos. Esses dados podem ser informações sobre recursos que já foram criados, como AMIs (Amazon Machine Images), IPs, IDs de recursos, entre outros.

##### Exemplo 1: Buscando uma AMI Existente

```hcl
data "aws_ami" "my_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # ID do proprietário da AMI (neste caso, a Amazon)
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.my_ami.id
  instance_type = "t2.micro"
}
```

**Explicação:**
- **`data "aws_ami" "my_ami"`**: Define um bloco de dados para buscar uma AMI. O nome lógico `my_ami` pode ser usado para referenciar esse dado em outros lugares do código.
- **`most_recent = true`**: Informa ao Terraform para pegar a AMI mais recente que corresponde aos critérios fornecidos.
- **`filter`**: Define filtros para encontrar a AMI que atende às condições especificadas, como nome e tipo de virtualização.
- **`owners`**: Especifica o ID do proprietário da AMI. Aqui, estamos usando o ID da Amazon.

##### Exemplo 2: Buscando um VPC Existente

```hcl
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["my-vpc"]
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id     = data.aws_vpc.selected.id
  cidr_block = "10.0.1.0/24"
}
```

**Explicação:**
- **`data "aws_vpc" "selected"`**: Define um bloco de dados para buscar uma VPC específica. O nome lógico `selected` é usado para referenciar esse dado.
- **`filter`**: Filtra as VPCs existentes, buscando aquela que tenha uma tag `Name` com o valor `"my-vpc"`.
- **`vpc_id = data.aws_vpc.selected.id`**: Na criação da sub-rede, o ID da VPC é recuperado da VPC que foi filtrada usando o bloco `data`.

### **4. Tipos de Dados em HCL**

#### 4.1. String

```hcl
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
```

#### 4.2. Number

```hcl
variable "instance_count" {
  type    = number
  default = 3
}
```

#### 4.3. Boolean

```hcl
variable "enable_logging" {
  type    = bool
  default = true
}
```

#### 4.4. List

```hcl
variable "availability_zones" {
  type = list(string)
  default = ["us-east-1a", "us-east-1b"]
}
```

#### 4.5. Map

```hcl
variable "tags" {
  type = map(string)
  default = {
    Name    = "MyApp"
    Env     = "Prod"
  }
}
```

### **5. Expressões e Funções**

#### 5.1. Expressões Condicionais

```hcl
variable "instance_type" {
  type    = string
  default = var.env == "prod" ? "t2.large" : "t2.micro"
}
```

#### 5.2. Funções de Manipulação de Strings

```hcl
resource "aws_s3_bucket" "my_bucket" {
  bucket = lower("My-Bucket-Name")
}
```

#### 5.3. Funções de Manipulação de Listas

```hcl
resource "aws_instance" "my_instance" {
  count = length(var.availability_zones)
  ami = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
```

### **6. Práticas Comuns**

#### 6.1. Reutilização de Módulos

Módulos ajudam na organização e reutilização de código. Eles encapsulam lógica e recursos comuns que podem ser reutilizados em diferentes projetos.

```hcl
module "s3_bucket" {
  source = "./modules/s3_bucket"
  bucket_prefix = "my-app"
}
```

#### 6.2. Uso de Workspaces

Workspaces permitem gerenciar múltiplos ambientes (como `dev`, `prod`) de forma isolada dentro do mesmo código.

```hcl
terraform {
  backend "s3" {
    bucket = "my-tf-state"
    key    = "env/${terraform.workspace}/terraform.tfstate"
    region = "us-east-1"
  }
}
```

## ** Exemplo Completo**

Vamos ver um exemplo completo de um módulo Terraform que cria uma instância EC2 e um bucket S3, ambos configurados com variáveis e outputs.

#### `main.tf`

```hcl
provider "aws" {
  region = var.region
}

resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "WebServer"
  }
}

resource "aws_s3_bucket" "web_bucket" {
  bucket_prefix = var.bucket_prefix
  acl           = "private"
}

output "instance_id" {
  value = aws_instance.web.id
}

output "bucket_id" {
  value = aws_s3_bucket.web_bucket.id
}
```

#### `variables.tf`

```hcl


variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "ami" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

variable "bucket_prefix" {
  description = "Bucket prefix"
  type        = string
}
```

#### `outputs.tf`

```hcl
output "instance_id" {
  value = aws_instance.web.id
}

output "bucket_id" {
  value = aws_s3_bucket.web_bucket.id
}
```

Claro! Vou fornecer uma explicação detalhada dos blocos `locals` e `dynamic` em Terraform, junto com exemplos de uso.

### **7. Bloco `locals`**

#### **O que é o Bloco `locals`?**

O bloco `locals` em Terraform é usado para definir variáveis locais, ou seja, valores que são calculados ou definidos uma única vez e depois reutilizados em várias partes da configuração. As variáveis locais são úteis para melhorar a legibilidade do código e evitar repetição, especialmente quando o valor de uma expressão complexa precisa ser referenciado várias vezes.

#### **Estrutura do Bloco `locals`**

```hcl
locals {
  nome_local = <expressão>
}
```

- **`nome_local`**: O nome da variável local.
- **`<expressão>`**: A expressão ou valor atribuído à variável local.

#### **Exemplo 1: Simplificação de Expressões**

Suponha que você tenha várias instâncias que precisam de um nome composto com base em uma variável de ambiente e um nome de aplicativo. Em vez de concatenar a string em cada uso, você pode definir um local.

```hcl
variable "env" {
  description = "Environment"
  type        = string
  default     = "prod"
}

variable "app_name" {
  description = "Application name"
  type        = string
  default     = "myapp"
}

locals {
  instance_name = "${var.env}-${var.app_name}"
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = local.instance_name
  }
}

resource "aws_s3_bucket" "app_bucket" {
  bucket_prefix = local.instance_name
  acl           = "private"
}
```

**Explicação**:
- **`local.instance_name`**: Armazena o nome composto `prod-myapp`, que é reutilizado nas tags da instância EC2 e no prefixo do bucket S3.

#### **Exemplo 2: Cálculo de Valores Derivados**

Você pode usar `locals` para calcular valores derivados com base em outras variáveis ou recursos.

```hcl
variable "instance_count" {
  description = "Number of instances"
  type        = number
  default     = 3
}

locals {
  total_cpu = local.instance_count * 2
}

resource "aws_autoscaling_group" "app_asg" {
  desired_capacity = var.instance_count
  max_size         = var.instance_count
  min_size         = 1

  launch_configuration = aws_launch_configuration.app_launch_config.id
}

output "total_cpu" {
  value = local.total_cpu
}
```

**Explicação**:
- **`local.total_cpu`**: Calcula o total de CPUs com base no número de instâncias, supondo que cada instância tenha 2 CPUs.

### **8. Bloco `dynamic`**

#### **O que é o Bloco `dynamic`?**

O bloco `dynamic` em Terraform é usado para gerar blocos de configuração dinamicamente com base em uma lista ou mapa. Isso é útil quando você precisa criar múltiplas instâncias de um bloco aninhado dentro de um recurso, sem ter que repetir manualmente o código.

#### **Estrutura do Bloco `dynamic`**

```hcl
dynamic "<nome_do_bloco>" {
  for_each = <expressão_que_retorna_lista_ou_mapa>
  content {
    <conteúdo_do_bloco>
  }
}
```

- **`<nome_do_bloco>`**: Nome do bloco que será gerado dinamicamente (ex.: `ingress` para regras de segurança).
- **`for_each`**: Itera sobre uma lista ou mapa, criando um bloco para cada item.
- **`content`**: Define o conteúdo do bloco gerado.

#### **Exemplo 1: Regras de Segurança Dinâmicas**

Suponha que você precise definir múltiplas regras de entrada (ingress) para um grupo de segurança, com base em uma lista de portas permitidas.

```hcl
variable "allowed_ports" {
  description = "List of allowed ingress ports"
  type        = list(number)
  default     = [80, 443]
}

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow web traffic"

  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

**Explicação**:
- **`for_each = var.allowed_ports`**: Itera sobre a lista de portas permitidas.
- **`ingress.value`**: Refere-se ao valor atual da porta na iteração, criando uma regra `ingress` para cada porta na lista.

#### **Exemplo 2: Bloco de Tags Dinâmico**

Se você quiser adicionar tags dinamicamente com base em um mapa, o bloco `dynamic` pode ajudar.

```hcl
variable "resource_tags" {
  description = "Map of tags for resources"
  type        = map(string)
  default     = {
    "Environment" = "prod"
    "Application" = "webapp"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  dynamic "tags" {
    for_each = var.resource_tags
    content {
      key   = tags.key
      value = tags.value
    }
  }
}
```

**Explicação**:
- **`for_each = var.resource_tags`**: Itera sobre o mapa de tags.
- **`tags.key` e `tags.value`**: Referenciam a chave e o valor da tag atual, gerando dinamicamente blocos de tags.



### **9. Conclusão**

A linguagem HCL utilizada pelo Terraform é poderosa, flexível e permite a definição de infraestrutura de forma clara e organizada. Compreender a estrutura básica, os tipos de blocos, e como reutilizar e modularizar o código é essencial para aproveitar ao máximo o Terraform e implementar práticas de Infraestrutura como Código de maneira eficiente.

---
