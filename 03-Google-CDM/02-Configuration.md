
Criação de uma configuração básica
==============================

bookmark\_borderbookmark Mantenha-se organizado com coleções Salve e categorize o conteúdo com base em suas preferências.

Esta página descreve como criar uma configuração que pode ser usada para criar uma implementação. Para saber mais sobre implantações, leia [Creating a Deployment](https://cloud.google.com/deployment-manager/docs/deployments).

Um arquivo de configuração define todos os recursos do Google Cloud que compõem uma implementação. É necessário ter um arquivo de configuração para criar uma implementação. Um arquivo de configuração deve ser escrito na sintaxe YAML.

Antes de começar
----------------

* Se você quiser usar os exemplos de linha de comando neste guia, instale a ferramenta de linha de comando [\`gcloud\`](https://cloud.google.com/sdk).
* Se você quiser usar os exemplos de API deste guia, configure o [acesso à API](https://cloud.google.com/deployment-manager/docs/reference/latest).
* Entenda os conceitos básicos sobre [arquivos de configuração](https://cloud.google.com/deployment-manager/docs/configuration).

Estrutura do arquivo de configuração
----------------------------

Um arquivo de configuração é gravado no formato YAML e tem a seguinte estrutura:

```yaml

   #  imported templates, if applicable
imports:
  #  path relative to the configuration file
- path: path/to/template.jinja
  name: my-template
- path: path/to/another/template.py
  name: another-template

resources:
  - name: NAME_OF_RESOURCE
    type: TYPE_OF_RESOURCE
    properties:
      property-a: value
      property-b: value
      ...
      property-z: value
  - name: NAME_OF_RESOURCE
    type: TYPE_OF_RESOURCE
    properties:
      property-a: value
      property-b: value
      ...
      property-z: value
```      
Cada uma das seções define uma parte diferente da implantação:

* A seção `imports` é uma lista de [modelos](https://cloud.google.com/deployment-manager/docs/configuration/templates/create-basic-template) que serão usados pela configuração. O Deployment Manager expande recursivamente todos os modelos importados para formar sua configuração final.
    
* A seção `resources` é uma lista de recursos que compõem essa implementação. Um recurso pode ser:
    
    * Um tipo de base gerenciado pelo Google, como uma instância de VM do Compute Engine.
    * Um modelo importado
    * Um [composite](https://cloud.google.com/deployment-manager/docs/fundamentals#composite_types).
    * Um [type provider](https://cloud.google.com/deployment-manager/docs/fundamentals#basetypes).

Você também pode incluir outras seções opcionais, como as seções `outputs` e `metadata`. A seção `outputs` permite que você [exponha dados dos seus modelos e configurações como saídas](https://cloud.google.com/deployment-manager/docs/configuration/expose-information-outputs) para que outros modelos na mesma implantação consumam ou como saídas para seus usuários finais, enquanto a seção `metadata` permite que você use outros recursos, como [definir dependências explícitas](https://cloud.google.com/deployment-manager/docs/configuration/create-explicit-dependencies) entre recursos.

No mínimo, uma configuração deve sempre declarar a seção `resources`, seguida de uma lista de recursos. Outras seções são opcionais.

Declaração de um tipo de recurso
-------------------------

Cada recurso em sua configuração deve ser especificado como um tipo. Os tipos podem ser um tipo de base gerenciado pelo Google, um tipo composto, um provedor de tipos ou um modelo importado.

Os tipos de base gerenciados pelo Google são tipos que resolvem para os recursos do Google Cloud. Por exemplo, uma instância do Cloud SQL ou um bucket do Cloud Storage é um tipo de base gerenciado pelo Google. Você pode declarar esses tipos usando a seguinte sintaxe:

```yaml
    Tipo: <api>.<api-version>.<resource-type>
```
Por exemplo, uma instância do Compute Engine teria o seguinte tipo:

```yaml
    tipo: compute.v1.instance
```    

Para um banco de dados BigQuery, o tipo pode ser:

```yaml
    tipo: bigquery.v2.dataset
```

Para obter uma lista de todos os tipos compatíveis, use o seguinte comando:

```yaml
gcloud deployment-manager types list
```

Para obter uma lista completa dos tipos de base gerenciados pelo Google compatíveis, consulte [Supported Resource Types](https://cloud.google.com/deployment-manager/docs/configuration/supported-resource-types).

Se você estiver usando um [composite](https://cloud.google.com/deployment-manager/docs/configuration/templates/create-composite-types) ou [type provider](https://cloud.google.com/deployment-manager/docs/configuration/type-providers/calling-type-provider), declare o tipo da seguinte forma:

```yaml
# Composite type

resources:
- name: my-composite-type
  type: [PROJECT]/composite:[TYPE_NAME]

```

```yaml
# Base type

resources:
- name: my-base-type
  type: [PROJECT_ID]/[TYPE_PROVIDER_NAME]:[TYPE_NAME]
```

Você também pode criar recursos usando os provedores de tipos gerenciados pelo Google (beta). Para obter uma lista dos provedores de tipos do Google Cloud, consulte [Supported Type Providers] (/deployment-manager/docs/configuration/supported-gcp-types).

Se você quiser usar [templates](https://cloud.google.com/deployment-manager/docs/configuration/templates/create-basic-template), declare o modelo como um tipo, com o nome ou o caminho do modelo como o valor de `type`. Por exemplo, a configuração a seguir importa um modelo chamado my\_vm\_template.jinja e o fornece como um tipo:

```yaml
imports:
- path: path/to/template/my_vm_template.jinja
  name: my-template.jinja

resources:
- name: my-first-virtual-machine
  type: my-template.jinja
```

Para obter mais informações sobre modelos, leia [Creating a Basic Template](https://cloud.google.com/deployment-manager/docs/configuration/templates/create-basic-template).

Declaração de propriedades de recursos
-----------------------------

Depois de declarar o tipo de recurso, você também deve atribuir ao recurso um `nome` e especificar as propriedades que deseja para o recurso. Por exemplo, o arquivo de configuração a seguir define uma instância de máquina virtual chamada `vm-created-by-deployment-manager` e suas propriedades desejadas. O Deployment Manager usa essas informações para criar uma instância de VM que tenha essas propriedades.



```yaml
# Copyright 2016 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

resources:
- name: vm-created-by-deployment-manager
  type: compute.v1.instance
  properties:
    zone: us-central1-a
    machineType: zones/us-central1-a/machineTypes/n1-standard-1
    disks:
    - deviceName: boot
      type: PERSISTENT
      boot: true
      autoDelete: true
      initializeParams:
        sourceImage: projects/debian-cloud/global/images/family/debian-11
    networkInterfaces:
    - network: global/networks/default
```

Para determinar as `propriedades` de um recurso, você usa a documentação da API do recurso:

* Veja o formato da solicitação no método `insert` ou `create` do recurso.
* Se o URI da solicitação contiver a zona, adicione a zona às propriedades.
* Para matrizes, use a sintaxe de lista YAML para listar os elementos da matriz. Por exemplo, se você estiver criando uma instância do Compute Engine usando a API, deverá fornecer uma matriz de discos para anexar à instância, no seguinte formato:
    
 ```json   
    "disks": [
    {
        "type": "PERSISTENT",
        "deviceName": "disk1",
        ...
    },
    {
        "type": "PERSISTENT",
        "deviceName": "disk2",
        ...
    }
]
```    

Na configuração do Deployment Manager, você adiciona esses discos usando a seguinte sintaxe:

    
```yaml    
    disks:
    - deviceName: disk1
    type: PERSISTENT
    ...
    - deviceName: disk2
    type: PERSISTENT
 ```    

Você também pode fornecer qualquer propriedade gravável desse recurso. Para determinar se uma propriedade pode ser gravada, use a documentação de referência da API para o tipo de recurso. Por exemplo, a [referência do Compute Engine](https://cloud.google.com/compute/docs/reference/latest) marca determinadas propriedades que são somente de saída, portanto, você não pode definir essas propriedades em sua configuração, pois elas são imutáveis.


Algumas APIs exigem um conjunto mínimo de propriedades para criar um recurso. Um [disco persistente do Compute Engine](https://cloud.google.com/compute/docs/reference/latest/disks/insert), por exemplo, requer o nome do disco, a origem da imagem, o tamanho do disco e assim por diante, ao criar um novo disco. Para obter informações sobre um recurso específico, consulte a referência da API para esse recurso.

### Definição das propriedades do modelo

Se você importar um modelo para usar na sua configuração, use a seção `properties` para definir valores para [template properties](https://cloud.google.com/deployment-manager/docs/configuration/templates/define-template-properties) em vez de propriedades de recursos. Como alternativa, se o modelo não tiver propriedades de modelo, você poderá omitir completamente a seção `properties`.

Criação de recursos de diferentes serviços do Google Cloud
-------------------------------------------------------

Por fim, um arquivo de configuração pode criar recursos de diferentes serviços do Google Cloud. Por exemplo, o arquivo de configuração a seguir cria recursos do Compute Engine e do BigQuery:

```yaml
# Copyright 2016 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

resources:
- name: vm-created-by-deployment-manager
  type: compute.v1.instance
  properties:
    zone: us-central1-a
    machineType: zones/us-central1-a/machineTypes/n1-standard-1
    disks:
    - deviceName: boot
      type: PERSISTENT
      boot: true
      autoDelete: true
      initializeParams:
        sourceImage: projects/debian-cloud/global/images/family/debian-11
    networkInterfaces:
    - network: global/networks/default

- name: big-query-dataset
  type: bigquery.v2.dataset
  properties:
    datasetReference:
      datasetId: example_id

```

Tipos e propriedades de recursos compatíveis
---------------------------------------

Consulte a lista completa de recursos gerenciados pelo Google compatíveis na documentação [Supported Resource Types](https://cloud.google.com/deployment-manager/docs/configuration/supported-resource-types).