
Ferramentas de infraestrutura como código
=====================

Aqui listamos algumas ferramentas utilizadas para a criação e gerenciamento de recursos em nuvem.

<details open>
<summary><b>Chef</b></summary>

O **Chef** é uma ferramenta de gerenciamento de configuração com diversas integrações e algumas soluções para cenários específicos, tem ampla aplicação e dispõe de muitos recursos para implementaçoes de infraestrutura.

### Características:

*   Servers Pimary & Backup
*   Arquitetura Master-Agent
*   Integração com todos os produtos da Chef.io
*   Produtos podem ser utilizados sem a necessidade de toda a Stack
*   Possui ferramenta para Compliance-as-Code

### Quando e porque eu utilizaria o Chef?

O chef torna-se uma ferramenta poderosissima uma vez que ele possúi uma stack completa para gerenciamento de infraestrutura, automação de apps e dependências, compliance e segurança.

Todas as ferramentas da stack do Chef utilizam a linguagem Ruby DSL (Ruby Domain Specific Language) que tem uma curva de aprendizado bastante inclinada e é orientada a desenvolvedores.

A ferramenta [**Chef Inspec**](https://www.inspec.io) é a ferramenta do mercado que criou uma nova área chamada de **Compliance-as-Code** e criou uma iniciativa chamada [**dev-sec**](https://dev-sec.io) que é um framework de hardening criado para integrar **devops** com **security**.
</details>

<details open>
<summary><b>Puppet</b></summary>


O **Puppet** é uma ferramenta de gerenciamento de configurações de sistemas Unix-like e Windows através de uma linguagem declarativa baseada em **Ruby.**

Características:
----------------

*   Servers Multi-Master
*   Arquitetura Agent to Master;
*   Suporta segregação de Ambientes (Prod/Homolog/Dev);
*   Comunicação segura SSL;
*   Idempotência;
*   Indisponibilidade do **Master** pode não impactar no funcionamento dos agents.

### Quando e porque eu utilizaria o Puppet?

O puppet é uma ferramenta sensacional para gerenciar um datacenter ou um parque de workstations, por possuir recursos como o **runinterval** em que a configuração é aplicada diversas vezes de acordo com a configuração de intervalo configurada e caso o Server esteja indisponível o agente não para de tentar aplicar a configuração do mesmo, uma vez que ele não precise receber algum arquivo do Server que esteja indisponível.

O Puppet trabalha com a arquitetura multi-master, onde todos os Servers instalados e configurados na rede trabalham em tempo integral, diferente de ferramentas como o Chef que utiliza Servers primários e backups.

Outra grande vantagem do puppet é que ele funciona em ambientes Unix e Microsoft nativamente através da instalação do Puppet Agent.

Podemos também expandir as funcionalidades através de recursos como o **Puppet DB** para coletar e inventariar as máquinas e o **Puppet Dashboard** ou o **Foreman** como ferramentas de dashboard para visualizar e verificar as configurações aplicadas no ambiente.
</details>

<details open>
<summary><b>Ansible</b></summary>


O **Ansible** é uma ferramenta de automação criada para gerenciar múltiplas máquinas de uma única vez através de **playbooks** escritas no formato **YAML.**

### Características:

*   Arquitetura Master to Nodes;
*   Linguagem de Configuração Simples;
*   Não necessita de agents;
*   Simples de realizar manutenção;
*   Curva de aprendizado curta.

O Ansible é uma ferramenta muito poderosa, uma vez que ela necessita apenas de confiança **SSH** (seja por chave ou senha) e **Python**, o que a maioria das máquinas linux já possúi por padrão.


### Quando e porque eu utilizaria o Ansible?

Gosto muito de utilizar o ansible para algumas finalidades como parametrizar minha workstation, posso criar uma playbook que já instala e parametriza minha máquina por completa.

Um dos pontos mais positivos do ansible é sua curva de aprendizado, facilmente após estudar o ansible por cerca de 4 horas já é possível começar a utilizar ele em sua infraestrutura para pequenas tarefas e tomar proveito de todo o seu poder.

Não gosto de utilizar o ansible para garantir a configuração de um parque de máquinas, por exemplo, porque o ansible não garante (por si só) que a configuração estará ativa em todas as máquinas. Porém podemos utilizar ferramentas de Server como o **Ansible Tower** (ferramenta proprietária da Red Hat e paga) ou o **Ansible AWX** (projeto open source alternativo ao Tower) para potencializar sua utilização.

Outra maneira que eu gosto de utilizar o ansible é somado a outras ferramentas principalmente com o **Terraform** (ainda vamos falar sobre isto.

Através do **chocolatey** ou outro recurso é possível utilizar o ansible para parametrizar e gerenciar softwares em estações Windows.
</details>

<details open>
<summary><b>SaltStack</b></summary>


O **SaltStack** é um software de gerenciamento de configuração open source baseado em Python. Ele permite execução remota, ideal para aplicação da abordagem de infraestrutura como código na implantação e gerenciamento de nuvem. 

### Características:

*   Sistema de integração nativa com outros frameworks
*   Controla o estado das configurações
*   Baseado em CLI
*   Escalabilidade e resistência.
*   Configurações de [**Salt Master**](https://docs.saltproject.io/en/latest/glossary.html#term-Master) e [**Salt Minion**](https://docs.saltproject.io/en/latest/glossary.html#term-Minion)

### Quando e porque eu utilizaria o SaltStack

O Salt é um framework de código aberto escrito em Python para configuração de equipamentos, portanto similar ao [**Ansible**](02-1-3%20Ansible.md). Ele é capaz de manter **_Nodes_** remotos em estados definidos. Por exemplo, pode garantir que pacotes específicos sejam instalados e que serviços específicos estejam em execução e também pode consultar e executar comandos em **_Nodes_** individuais ou usando um critério de seleção arbitrário.
</details>

<details open>
<summary><b>Terraform</b></summary>


**Terraform** é uma ferramenta para construir, modificar e versionar infraestruturas criada para atuar  principalmente com as clouds como **Azure, Digital Ocean, AWS, GCP, Oracle Cloud, VMWare Cloud.** bem como outras diversas ferramentas _DevOps._

Caracteristicas:
----------------

*   É agnostica a clouds;
*   Linguagem Própria ( **HCL** - Hashicorp Configuration Language);
*   Executa o planejamento de execução antes da aplicação da configuração;
*   Interage com as Clouds mais utilizadas no mercado;
*   Integração com outras ferramentas de Infrastructure as code.

### Quando e porque eu utilizaria o Terraform?

O Terraform é uma ferramenta perfeita para gerenciar infraestrutura em clouds, existem diversos recursos e módulos para interagir com diversas clouds tornando ela uma ferramenta, como a própria hashicorp diz, **cloud-agnostic**, ou seja, independentemente de cloud se você conhece a o terraform, você consegue gerenciar sua cloud.

O maior poder do terraform é ele se integrar de maneira simples e fácil a ferramentas como Ansible e Puppet, bem como as ferramentas da própria [**Hashicorp**](https://www.hashicorp.com) como o [**Vault**](https://www.hashicorp.com/products/vault/) e o [**Packer**](https://packer.io/)**.** Com esta versatilidade podemos garantir nossa infraestrutura completa em uma cloud.
</details>

<details open>
<summary><b>CloudFormation </b></summary>


O AWS **CloudFormation** é um serviço que fornece aos desenvolvedores e empresas uma forma fácil de criar um conjunto de recursos relacionados da AWS e de terceiros para provisioná-los e gerenciá-los de forma organizada e previsível.

### Características:

*   Arquivo de código declarativo JSON ou YAML
*   Implementa e gerencia o grupo de recursos da [**AWS**](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html) e de terceiros agrupados em Pilhas.
*   Permite que o estado e as dependências dos recursos sejam gerenciados em conjunto.
*   Fornece um conjunto de scripts de inicialização de aplicações que permitem a instalação de pacotes, arquivos e serviços nas instâncias do EC2
*   Permite integração com outros frameworks, entre eles o **`Chef`**, **`Puppet`** e **`Terraform`**

### Quando e porque eu utilizaria o CloudFormation

O AWS **CloudFormation** é um mecanismo de provisionamento conveniente para uma grande variedade de recursos da AWS e de terceiros. Ele atende às necessidades de infraestrutura de muitos tipos diferentes de aplicações, como aplicações corporativas existentes, aplicações herdadas, aplicações criadas usando uma série de recursos da AWS e soluções baseadas em contêineres (incluindo as criadas usando o [**AWS Elastic Beanstalk**](https://aws.amazon.com/pt/elasticbeanstalk/)).
</details>

<details open>
<summary><b>Azure Resource Manager </b></summary>


O Azure Resource Manager é o serviço de implantação e gestão do Azure. Fornece uma camada de gestão que lhe permite criar, actualizar, e eliminar recursos na sua conta Azure. Utiliza funcionalidades de gestão, como controle de acesso, bloqueios e etiquetas, para proteger e organizar os seus recursos após a implantação.

### Características:
*   possui templates otimizados para Azure
*   Integraçáo com o portal azure, clients REST ou SDKs 
*   Sintaxe declarativa

### Quando e porque eu utilizaria o Azure Resource Manager 
Como trata-se de uma soluçáo desenvolvida para rodar em uma plataforma única, assim como o **`CloudFormation`** seu uso é restrito. Utilizaria por questões de performance e velocidade de implementação em um provedor específico, desde que estivesse certo de que não haveria necessidade de reaizar uma migração de plataforma.
</details>

<details open>
<summary><b>Google Cloud Deployment Manager</b></summary>
-------------------------------

O Google Cloud Deployment Manager é um serviço de implementação de infra-estruturas que automatiza a criação e gestão dos recursos do Google Cloud. Escreve modelos e repositórios de configuração flexíveis e utiliza-os para criar implementações que têm uma variedade de serviços Google Cloud, tais como Cloud Storage, Compute Engine, e Cloud SQL, configurados para trabalharem em conjunto. Uma configuração descreve todos os recursos que se pretende para uma única implementação


### Características:
*   configurações escritas no formato YAML
*   Possui templates otimizados para Google Cloud
*   Possibilidade de uso de imagens de outros projetos
*   Possui política de cotas para uso de alguns recursos

### Quando e porque eu utilizaria o Google Cloud Deployment Manager 
É mais uma soluçáo desenvolvida para um fornecedor de serviços cloud específico, assim como o **`CloudFormation`** seu uso é restrito. Possui a vantagem de ter configurações no formato YAML o que poderia facilitar a migração dos templates para uma outra ferramente ou plataforma, mesmo assim, sua utilização seria recomendada em cenários onde não se prevê alguma tipo de migração.
</details>

<details open>
<summary><b>Crossplane</b></summary>


Crossplane é um projecto de código aberto, CNCF construído sobre a fundação da Kubernetes para orquestrar qualquer coisa. Encapsular políticas, permissões e outros _guardrails_ utilizando uma API personalizada para permitir aos seus clientes o auto-serviço sem necessidade de se tornarem especialistas em infra-estruturas.


### Características:
*   possui diversas extenções para Kubernetes
*   Possui uma API bem completa integrando múltiplos provedores de serviços Coud
*   Seu Resource Model padroniza as interações entre o Kubernetes e seu provedor


### Quando e porque eu utilizaria o Crossplane
Com o Crossplane não há necessidade de escrever código: podemos construir um plano de controlo sem escrever código de sistemas distribuídos complicados. É declarativo, e pode definir, compor, e oferecer as suas próprias abstracções de API de infra-estrutura em cima de primitivos serviços de nuvem. Isto torna-a altamente configurável.
</details>

<details open>
<summary><b>Vagrant</b></summary>


Vagrant é uma ferramenta para a construção de ambientes de desenvolvimento completos. Com um fluxo de trabalho fácil de usar e foco na automatização, Vagrant reduz o tempo de configuração do ambiente de desenvolvimento, aumenta a paridade desenvolvimento/produção, e faz do "funciona na minha máquina" uma relíquia do passado.


### Características:
*   Faciita o set up de uma VM e pode salvar as configurações na própria imagem
*   Permite compartilhamento de configurações entre Maquinas Virtuais
*   Trabalha com outras ferramentas como VirtualBox, alguma ferramenta de IAC ou qualquer provedor de Cloud


### Quando e porque eu utilizaria o Vagrant
O Vagrant proporciona ambientes de trabalho fáceis de configurar, reproduzíveis e portáteis, construídos sobre tecnologia padrão da indústria e controlados por um único fluxo de trabalho consistente para ajudar a maximizar a produtividade e flexibilidade de si e da sua equipa. Se for um programador, a Vagrant isolará as dependências e a sua configuração num único ambiente descartável e consistente, sem sacrificar nenhuma das ferramentas com que está habituado a trabalhar (editores, navegadores, depuradores, etc.).
</details>

<details open>
<summary><b>Pulumi</b></summary>


Pulumi é uma infra-estrutura open source, e funciona melhor com o Serviço Pulumi para tornar a gestão da infra-estrutura segura, confiável, e sem complicações.Pulumi ajuda os programadores e as equipes de infra-estruturas a colaborar e a gerenciar a complexidade da nuvem.
O Pulumi usa Pacotes para fornecer os blocos de construção para implantar facilmente infra-estruturas com TypeScript/JavaScript, Python, Go, e C#. Fornece recursos de cloud superiores e fornecedores de SaaS para construir infra-estruturas  que satisfaçam as suas necessidades. Para arquiteturas populares como Kubernetes ou serverless.


### Características:
*   Utiliza linguagens de programação comuns
*   Amplo Ecossistema de Desenvolvimento
*   Experiência de Desenvolvimento de Aplicações Modernas
*   Ambiente Unificado da Aplicação e da Pipeline


### Quando e porque eu utilizaria o Pulumi
Em empresas que não possuem uma grande variedade de especialistas o Pulumi pode ser a solução ideal. Partindo do ponto em que os próprios desenvolvedores podem codificar a infra-estrutura para suas aplicações na mesma linguagem em que estão desenvolvendo temos um ganho de produtividade e uma curva de aprendizado baixa.
</details>

<details open>
<summary><b>OpenTofu</b></summary>


OpenTofu é uma iniciatitiva da [Linux Foundation](https://www.linuxfoundation.org/) a partir de um fork do repositório do terraform da versão 1.16, ou seja, o OpenTofu nasce já na mesma versão e totalmente compatível com o Terraform.
Mas qual o motivo para o nascimento desta iniciativa? Você pode ter todos os detalhes no [manifesto](https://opentofu.org/manifesto/) do projeto, mas basicamente, há uma desconfiança da comunidade [open source](https://www.redhat.com/en/topics/open-source/what-is-open-source-software) a partir da alteração da licença de distribuição do terraform por parte da empresa mantenedora, a [Hashcorp](https://www.hashicorp.com/), que a partir de Agosto de 2023 passou a distribuir todas as suas soluções sob um contrato baseado na [BSL](https://en.wikipedia.org/wiki/Business_Source_License) *Business Source License* em substituição a [MPL](https://www.mozilla.org/en-US/MPL/) *Mozilla Source License*. 
A partir dessa divisão, os projetos devem seguir caminhos independentes, a comunidade Linux será responsável pelas evoluções do OpenToFu atendendo aos interesses da própria comunidade e de desenvolvedores e promete garantir que teremos uma ferramenta tão robusta quanto o Terraform sob um licença de uso público, alinhada com o conceito de software *open source*.

### Características:
*   É agnostica a clouds;
*   Linguagem de código aberto mantida pela comunidade;
*   Executa o planejamento de execução antes da aplicação da configuração;
*   Interage com as Clouds mais utilizadas no mercado;
*   Integração com outras ferramentas de Infrastructure as code.
*   Possui seu proprio repositório de módulos (Registry)

### Quando e porque eu utilizaria o Opentofu
Como o OpenTofu foi concebido a partir do conceito do **`Terraform`** suas recomendações são, basicamente, as mesmas. Como trata-se de um projeto recente, suas evoluções poderão sugerir aplicações diferentes de seu "projeto pai", a conferir.
</details>