Cloudformation 
=====================


**AWS CloudFormation** é um serviço que permite modelar, provisionar e gerenciar recursos da AWS e de terceiros por meio de arquivos de configuração. Esses arquivos são descritos em formato JSON ou YAML, e você pode usar o CloudFormation para automatizar e orquestrar a criação e a gestão de sua infraestrutura de nuvem.

Sua implementação básica está baseada nos conceitos de **`Stacks`** que podem ser agrupadas em **`StackSets`**

### Aplicação da Tecnologia

CloudFormation é amplamente utilizado em ambientes de DevOps e SRE (Site Reliability Engineering), onde a automação da infraestrutura é crucial. Ele é aplicável em qualquer ambiente da AWS, desde desenvolvimento até produção, permitindo a consistência e a repetição da infraestrutura através de múltiplos ambientes.

### O que é uma Stack?

Uma **Stack** no CloudFormation é um conjunto de recursos da AWS que são criados, atualizados ou excluídos juntos como uma unidade única. Quando você submete um arquivo de configuração ao CloudFormation, ele cria uma Stack que inclui todos os recursos definidos nesse arquivo, como instâncias EC2, grupos de segurança, buckets S3, entre outros.

### O que é um StackSet?

Um **StackSet** é uma coleção de Stacks que você pode gerenciar de forma centralizada em várias contas da AWS e regiões. Isso é útil para organizações que precisam replicar a mesma infraestrutura em ambientes diferentes ou em diferentes partes da organização.

### Exemplo de Criação de uma Instância EC2

#### Exemplo em YAML

```yaml
AWSTemplateFormatVersion: "2010-09-09"
Resources:
  MyEC2Instance:
    Type: "AWS::EC2::Instance"
    Properties:
      InstanceType: "t2.micro"
      ImageId: "ami-0c55b159cbfafe1f0"
      KeyName: "my-key-pair"
```

#### Exemplo em JSON

```json
{
  "AWSTemplateFormatVersion": "2010-09-09",
  "Resources": {
    "MyEC2Instance": {
      "Type": "AWS::EC2::Instance",
      "Properties": {
        "InstanceType": "t2.micro",
        "ImageId": "ami-0c55b159cbfafe1f0",
        "KeyName": "my-key-pair"
      }
    }
  }
}
```

### Explicação dos Exemplos

- **AWSTemplateFormatVersion**: Define a versão do template.
- **Resources**: Bloco onde são declarados os recursos que serão criados na AWS.
- **MyEC2Instance**: Nome lógico da instância EC2 dentro da Stack.
- **Type**: Tipo de recurso da AWS que está sendo criado (neste caso, uma instância EC2).
- **Properties**: Propriedades específicas do recurso, como o tipo de instância, AMI (Imagem de Máquina da Amazon) e o par de chaves SSH para acesso.

Esses exemplos básicos demonstram como criar uma instância EC2 com o CloudFormation. Em um ambiente real, templates podem ser muito mais complexos, incluindo vários recursos interconectados, parâmetros dinâmicos, e condições.