# Terraform AWS EC2 com Apache HTTP

Este projeto provisiona uma instância EC2 na AWS usando Terraform, configura um Security Group para liberar o tráfego HTTP na porta 80 e instala o servidor web Apache na instância.

## Estrutura do Projeto

- `aws_ec2_instance.tf`: Define o módulo para provisionar a instância EC2 com os parâmetros definidos.
- `aws_security_group.tf`: Configura o Security Group que permite o tráfego HTTP (porta 80).
- `files/install_http.sh`: Script usado para instalar e configurar o Apache HTTP na instância EC2.

## Pré-requisitos

1. [Terraform](https://www.terraform.io/downloads.html) instalado na sua máquina.
2. Credenciais AWS configuradas na máquina local ou através de um perfil do AWS CLI.
3. Chave SSH configurada para acessar a instância EC2.

## Arquivos Base

### `aws_ec2_instance.tf`

```hcl
module "aws_ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = var.instanceName

  ami                    = var.imageId
  instance_type          = var.instanceType
  key_name               = var.keyName
  monitoring             = true
  vpc_security_group_ids = [module.aws_security_group.security_group_id]
  user_data = file("files/install_http.sh")

  depends_on = [module.aws_security_group]
}
```

### `aws_security_group.tf`

```hcl
module "aws_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = var.securityGroupName
  description = var.securityGrouDescription
  vpc_id      = var.vpcId

  ingress_cidr_blocks = [local.vpc_cidr]
}

locals {
  region = var.aws_region
  vpc_cidr = "0.0.0.0/0"
}
```

### `files/install_http.sh`

```bash
#!/bin/bash
yum update -y
yum install httpd.x86_64 -y
systemctl start httpd
systemctl enable httpd
echo '<!DOCTYPE html>' > /var/www/html/index.html
echo '<html>' >> /var/www/html/index.html
echo '<body>' >> /var/www/html/index.html
echo '  <h1 style="color:red;">Sensacional!!!! Terminei o módulo de IAC-Terraform</h1>' >> /var/www/html/index.html
echo '</body>' >> /var/www/html/index.html
echo '</html>' >> /var/www/html/index.html
```

## Variáveis

As seguintes variáveis devem ser definidas no arquivo `variables.tf` ou passadas diretamente via CLI ao executar o Terraform:

- `instanceName`: Nome da instância EC2.
- `imageId`: ID da AMI (Imagem de Máquina da AWS) a ser usada.
- `instanceType`: Tipo da instância EC2 (ex: `t2.micro`).
- `keyName`: Nome da chave SSH para acessar a instância.
- `vpcId`: ID do VPC onde a instância será criada.
- `securityGroupName`: Nome do grupo de segurança.
- `securityGroupDescription`: Descrição do grupo de segurança.
- `aws_region`: Região da AWS onde os recursos serão provisionados.
1. Defina as variáveis necessárias no arquivo `terraform.tfvars` ou passe via CLI:

   ```hcl
   instanceName = "minha-instancia-ec2"
   imageId = "ami-xxxxxxxx"
   instanceType = "t2.micro"
   keyName = "minha-chave"
   vpcId = "vpc-xxxxxxxx"
   securityGroupName = "meu-security-group"
   securityGroupDescription = "Security group para liberar HTTP na porta 80"
   aws_region = "us-east-1"

   ```


## Arquitetura

O projeto usa dois módulos principais:

1. **Instância EC2**: Provisiona a instância usando o [módulo oficial do Terraform para EC2](https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws).
2. **Security Group**: Configura um grupo de segurança que permite o tráfego HTTP (porta 80) através do [módulo de Security Group](https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws).

## Conteúdo do Script de Inicialização

O script `install_http.sh` realiza as seguintes tarefas:

- Atualiza os pacotes da instância.
- Instala o servidor web Apache.
- Inicia o serviço do Apache e o habilita para iniciar automaticamente no boot.
- Cria uma página HTML simples como página inicial.

