Introdução ao Terraform
=========================

Aqui temos uma visão detalhada dos principais comandos do Terraform, a estrutura de pastas e arquivos após a execução do comando `terraform init`, e uma explicação sobre módulos e arquivos comuns como `main.tf`, `variables.tf`, `terraform.tfvars`, `outputs.tf`, e `terraform.tfstate`.

### Principais Comandos do Terraform

1. **`terraform init`**:
   -  Inicializa um novo ou existente diretório de configuração do Terraform. Este comando baixa os plugins necessários (provedores) e configura o ambiente.
   - **Exemplo**: 
     ```bash
     terraform init
     ```

2. **`terraform plan`**:
   -  Gera e exibe um plano de execução. Mostra quais ações o Terraform realizará para atingir o estado descrito no código.
   - **Exemplo**: 
     ```bash
     terraform plan
     ```

3. **`terraform apply`**:
   -  Aplica as mudanças necessárias para alcançar o estado desejado na infraestrutura. Executa as ações planejadas.
   - **Exemplo**: 
     ```bash
     terraform apply
     ```

4. **`terraform destroy`**:
   -  Remove todos os recursos gerenciados pelo Terraform que estão descritos na configuração.
   - **Exemplo**: 
     ```bash
     terraform destroy
     ```

5. **`terraform validate`**:
   -  Verifica se os arquivos de configuração do Terraform são sintaticamente válidos e coerentes.
   - **Exemplo**: 
     ```bash
     terraform validate
     ```

6. **`terraform fmt`**:
   -  Formata os arquivos de configuração para um estilo canônico que segue as convenções de formatação do Terraform.
   - **Exemplo**: 
     ```bash
     terraform fmt
     ```

7. **`terraform show`**:
   -  Exibe o conteúdo do estado ou de um plano de execução. Útil para visualizar o que foi criado ou o que será aplicado.
   - **Exemplo**: 
     ```bash
     terraform show
     ```

8. **`terraform output`**:
   -  Exibe os valores de saída definidos em `outputs.tf`.
   - **Exemplo**: 
     ```bash
     terraform output
     ```

9. **`terraform state`**:
   -  Permite visualizar, editar e gerenciar o estado da infraestrutura.
   - **Exemplo**: 
     ```bash
     terraform state list
     ```

### Estrutura de Pastas e Arquivos 

Após executar `terraform init` e um `terraform plan`, a estrutura de pastas e arquivos pode ser semelhante a esta:

```
.
├── .terraform/
│   ├── plugins/
│   |   └── [sistema-operacional]_[arquitetura]/
│   |       └── [provedor]/
│   |            └── [plugin].zip
|   └── providers/ 
│       └── [repositorio]/
│           └── [provedor]/
│                └── [fabricante]/
│                     └── [versao]...
├── main.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
└── terraform.tfstate
```

- **`.terraform/`**: Diretório onde o Terraform armazena arquivos relacionados aos provedores e ao backend.
- **`main.tf`**: Arquivo principal de configuração onde a infraestrutura é descrita.
- **`variables.tf`**: Contém definições de variáveis usadas nas configurações.
- **`terraform.tfvars`**: Arquivo onde os valores das variáveis são definidos.
- **`outputs.tf`**: Define os valores de saída que o Terraform deve expor após a criação dos recursos.
- **`terraform.tfstate`**: Arquivo que armazena o estado da infraestrutura gerenciada pelo Terraform.

### Explicação dos Arquivos Comuns

- **`main.tf`**:
  -  É o arquivo principal de configuração do Terraform. Nele, você define recursos, provedores, e configurações específicas de infraestrutura.
  - **Exemplo**:
    ```hcl
    provider "aws" {
      region = "us-east-1"
    }

    resource "aws_instance" "example" {
      ami           = "ami-0c55b159cbfafe1f0"
      instance_type = "t2.micro"
    }
    ```

- **`variables.tf`**:
  -  Define as variáveis usadas no `main.tf` ou em outros arquivos de configuração. Este arquivo declara as variáveis, seus tipos e, opcionalmente, valores padrão.
  - **Exemplo**:
    ```hcl
    variable "region" {
      description = "The AWS region to deploy resources"
      type        = string
      default     = "us-east-1"
    }
    ```

- **`terraform.tfvars`**:
  -  Define os valores das variáveis declaradas em `variables.tf`. Este arquivo permite que você mantenha os valores das variáveis fora dos arquivos de configuração principais.
  - **Exemplo**:
    ```hcl
    region = "us-west-2"
    instance_type = "t2.large"
    ```

- **`outputs.tf`**:
  -  Define as saídas que serão mostradas após a execução dos comandos `terraform apply` ou `terraform plan`. Essas saídas são frequentemente usadas para fornecer informações importantes, como IPs ou IDs de recursos criados.
  - **Exemplo**:
    ```hcl
    output "instance_ip" {
      value = aws_instance.example.public_ip
    }
    ```

- **`terraform.tfstate`**:
  -  Arquivo que contém o estado atual da infraestrutura gerenciada pelo Terraform. Ele é usado para acompanhar o que já foi criado, alterado ou destruído, garantindo que o Terraform possa aplicar mudanças incrementais corretamente.
  - **Exemplo**:
    Este arquivo é automaticamente gerado e atualizado pelo Terraform, e geralmente não é manipulado manualmente.

### O que são Módulos no Terraform?

**Módulos** no Terraform são conjuntos reutilizáveis de configurações. Eles permitem que você organize e reutilize blocos de código para diferentes partes da infraestrutura. Um módulo pode ser um diretório contendo arquivos `.tf`, que define um conjunto de recursos e pode ser chamado em outros arquivos de configuração.

**Exemplo de Módulo:**

- Estrutura de um módulo:
  ```
  my_module/
  ├── main.tf
  ├── variables.tf
  ├── outputs.tf
  ```
- Usando um módulo:
  ```hcl
  module "vpc" {
    source = "./modules/vpc"

    vpc_name = "my_vpc"
    cidr_block = "10.0.0.0/16"
  }
  ```

Os módulos ajudam a manter o código limpo, modular e fácil de gerenciar, especialmente em projetos de infraestrutura grandes e complexos.
