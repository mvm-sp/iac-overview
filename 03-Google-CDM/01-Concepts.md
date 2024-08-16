Cloud Deployment Manager
=====================


**Google Cloud Deployment Manager** é uma ferramenta de infraestrutura como código (IaC) usada para criar e gerenciar recursos no Google Cloud Platform (GCP). Com o Deployment Manager, você pode definir a infraestrutura do seu ambiente GCP em arquivos de configuração YAML, JSON ou Python, que especificam os recursos a serem criados e gerenciados, como máquinas virtuais, bancos de dados, redes, entre outros.

### Estrutura do Deployment Manager

1. **Arquivos de Configuração**:
   - **YAML, JSON ou Python**: Esses arquivos contêm a descrição dos recursos que você deseja criar ou gerenciar no GCP. Cada recurso é definido com propriedades específicas, como tipo de recurso, zona, região, entre outros.

2. **Templates**:
   - Deployment Manager permite o uso de **templates** em Python ou Jinja2 para gerar dinamicamente configurações, facilitando a reutilização de código e a manutenção das configurações de infraestrutura.

3. **Schemas**:
   - São usados para definir as propriedades de um template, incluindo tipos de dados, valores padrão e descrições. Os schemas ajudam a garantir que os templates sejam usados corretamente.

### Hierarquia do GCP: Organizações, Pastas, Projetos e Recursos

O GCP organiza recursos em uma hierarquia que reflete a estrutura organizacional de uma empresa. A hierarquia é composta por **Organizações**, **Pastas**, **Projetos** e **Recursos**.

1. **Organização**:
   - **Organização** é o nível mais alto na hierarquia do GCP. Representa uma entidade empresarial e agrupa todas as pastas, projetos e recursos associados à empresa. Quando uma organização é criada, todos os usuários, políticas e permissões são gerenciados neste nível, facilitando o controle centralizado.

2. **Pastas**:
   - **Pastas** são usadas para organizar projetos em categorias lógicas dentro da organização. Por exemplo, uma empresa pode ter uma pasta para cada departamento (TI, Marketing, Vendas, etc.). As pastas permitem aplicar políticas de IAM (Identity and Access Management) e de faturamento de forma mais granular.

3. **Projetos**:
   - **Projetos** são o contêiner principal para todos os recursos do GCP. Cada projeto contém recursos como máquinas virtuais, buckets de armazenamento, bancos de dados, etc. Um projeto tem um nome, um ID e uma conta de faturamento associada. É o nível onde você gerencia permissões, ativa APIs e configura os serviços que serão utilizados.

4. **Recursos**:
   - **Recursos** são os objetos gerenciados dentro de um projeto, como máquinas virtuais (VMs), buckets do Cloud Storage, redes, etc. Os recursos são criados, configurados e gerenciados pelo Deployment Manager e podem ser movidos entre projetos dentro da mesma organização, se necessário.

### Fluxo de Provisionamento de Infraestrutura

1. **Definir Configuração**:
   - Você começa definindo um arquivo de configuração que especifica os recursos que deseja provisionar. Esses arquivos podem referenciar templates e usar variáveis para facilitar a reutilização.

2. **Deploy**:
   - Com a configuração pronta, você executa o comando `gcloud deployment-manager deployments create [DEPLOYMENT_NAME] --config [CONFIG_FILE]` para iniciar o provisionamento dos recursos. O Deployment Manager irá interagir com as APIs do GCP para criar os recursos conforme especificado.

3. **Gerenciamento e Atualizações**:
   - Após o provisionamento, você pode gerenciar e atualizar os recursos modificando o arquivo de configuração e aplicando as mudanças com `gcloud deployment-manager deployments update [DEPLOYMENT_NAME]`. O Deployment Manager calcula as diferenças e aplica apenas as mudanças necessárias, mantendo a consistência do ambiente.

4. **Monitoramento e Logs**:
   - Durante todo o processo, é possível monitorar o status dos deployments através do Console do Google Cloud, onde você também pode visualizar logs e informações detalhadas sobre cada recurso provisionado.

### Considerações Finais

O Google Cloud Deployment Manager é uma ferramenta poderosa que facilita o gerenciamento de infraestrutura em escala, promovendo boas práticas de DevOps e automação. Ele se integra com outras ferramentas do Google Cloud, como o IAM e o Cloud Monitoring, para oferecer uma experiência completa e integrada de gerenciamento de recursos na nuvem.