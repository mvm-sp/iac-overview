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

No AWS CloudFormation, um **template** é um arquivo de configuração que define a infraestrutura desejada na nuvem. Esse arquivo pode ser escrito nos formatos JSON ou YAML e serve como um plano ou blueprint para a criação e gestão de recursos na AWS. 

### Estrutura de um Template CloudFormation

Um template CloudFormation é composto por vários blocos ou seções, cada um desempenhando um papel específico na definição da infraestrutura:

1. **AWSTemplateFormatVersion**: 
   - Indica a versão do formato do template. Embora opcional, ajuda a assegurar compatibilidade com versões futuras do CloudFormation.

2. **Description**:
   - Proporciona uma breve descrição do que o template faz. Essa seção é opcional e serve para documentar a finalidade do template.

3. **Resources**:
   - Esta é a seção mais importante, onde você define todos os recursos da AWS que deseja criar e gerenciar. Cada recurso é especificado com um nome lógico, tipo (por exemplo, `AWS::EC2::Instance` para uma instância EC2), e suas propriedades.

4. **Parameters**:
   - Permite a personalização do template fornecendo variáveis que podem ser definidas no momento da criação da Stack. Por exemplo, você pode parametrizar o tipo de instância EC2 ou o nome de um bucket S3.

5. **Mappings**:
   - Fornece uma maneira de mapear valores, como AMIs específicas para diferentes regiões. Essa seção é útil para criar templates reutilizáveis que dependem de dados específicos de regiões.

6. **Outputs**:
   - Define os valores que serão retornados ao final da criação da Stack. Isso pode incluir informações como IDs de recursos, URLs, ou qualquer outro dado relevante gerado durante a criação da infraestrutura.

7. **Conditions**:
   - Permite a criação de lógica condicional dentro do template. Por exemplo, você pode criar condições que determinem se certos recursos devem ser criados com base em parâmetros ou variáveis ambientais.

8. **Metadata**:
   - Contém informações adicionais sobre os recursos, como instruções para os desenvolvedores ou detalhes sobre o uso do template.

9. **Transform**:
   - Uma seção especial usada para incluir macros ou expandir o template com transformações como o AWS Serverless Application Model (SAM).

### Como Funciona na Prática?

Quando você usa um template no CloudFormation, ele é submetido ao serviço para criar uma **Stack**, que é a instância concreta da infraestrutura definida no template. O CloudFormation lê o template, interpreta os recursos e as dependências, e cria, atualiza ou exclui esses recursos de forma orquestrada.

Os templates permitem que toda a infraestrutura seja tratada como código (Infrastructure as Code), facilitando a replicação, versionamento, e auditoria da infraestrutura ao longo de seu ciclo de vida.

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