Introdução ao Terraform
=====================
![Terraform](images/01-01-02.png)

### O que é o Terraform?

Terraform é uma ferramenta de **infraestrutura como código (IaC)** desenvolvida pela HashiCorp. Ela permite que você crie, altere e gerencie recursos de infraestrutura de forma segura e eficiente. Em vez de configurar manualmente servidores, redes e outros recursos de infraestrutura, você pode definir tudo em arquivos de configuração legíveis, e o Terraform se encarrega de aplicar essas configurações.

O Terraform é independente de fornecedor (cloud-agnostic), o que significa que ele pode ser usado para gerenciar infraestruturas em várias plataformas de nuvem (como AWS, Azure, Google Cloud) e também em ambientes locais (on-premises).

### Quando usar Terraform?

O principal problema que o Terraform resolve é a **gestão manual e complexa da infraestrutura de TI**. Tradicionalmente, configurar e gerenciar infraestrutura de TI envolvia muitos passos manuais e repetitivos, o que aumenta o risco de erros e inconsistências. Com a adoção crescente de arquiteturas de microservices, ambientes multi-nuvem, e a necessidade de escalabilidade rápida, a complexidade da gestão da infraestrutura aumentou ainda mais.

O Terraform resolve esses problemas ao fornecer:
- **Automação**: A infraestrutura é definida como código, o que permite automação completa na criação e gerenciamento dos recursos.
- **Consistência**: As configurações de infraestrutura são versionadas e podem ser replicadas em diferentes ambientes (produção, teste, desenvolvimento) de forma consistente.
- **Documentação**: O código usado para definir a infraestrutura também serve como documentação viva do que foi implementado.
- **Colaboração**: Múltiplos times podem colaborar em mudanças de infraestrutura de forma segura, revisando e aplicando alterações através de um fluxo de trabalho de código.

### Fornecedor da tecnologia

O Terraform é desenvolvido e mantido pela **HashiCorp**, uma empresa americana fundada em 2012, conhecida por desenvolver ferramentas de DevOps e automação de infraestrutura. A HashiCorp é também a responsável por outros produtos populares como Vault, Consul, e Nomad.

![HashCorp](images/01-01-01.jpeg)

A HashiCorp, desenvolvedora do Terraform, foi adquirida pela **IBM**. A aquisição reflete a estratégia da IBM em expandir suas capacidades em automação e infraestrutura em nuvem, integrando as soluções da HashiCorp em seu portfólio. Assim, o Terraform agora faz parte do ecossistema de ferramentas de nuvem e automação oferecido pela IBM, embora continue sendo mantido como um projeto de código aberto.

![HashCorp](images/01-01-03.png)

A IBM anunciou a aquisição da HashiCorp em 24 de abril de 2024, em uma transação avaliada em aproximadamente 6,4 bilhões de dólares. A IBM pagará 35 dólares por ação em dinheiro, e a aquisição deve ser concluída até o final de 2024. Esta compra é estratégica para a IBM, que visa fortalecer ainda mais suas ofertas em nuvem híbrida e inteligência artificial, integrando as soluções da HashiCorp para automação e gerenciamento de infraestrutura em ambientes de múltiplas nuvens e híbridos.


### Versões já publicadas com suas respectivas datas

O Terraform é um software de código aberto e passou por várias versões desde o seu lançamento. Aqui estão algumas das versões principais com suas respectivas datas de lançamento:

Aqui está a lista de versões principais do Terraform atualizada até a 1.19.5:

- **Terraform 0.1.0** (28 de julho de 2014): Primeira versão pública do Terraform.
- **Terraform 0.8.0** (30 de novembro de 2016): Incluiu suporte a módulos reutilizáveis e melhorias significativas no plano de execução.
- **Terraform 0.9.0** (20 de março de 2017): Introduziu suporte para "remote backends" e "remote state".
- **Terraform 0.11.0** (16 de novembro de 2017): Introduziu novas funcionalidades e suporte expandido para múltiplos provedores de nuvem.
- **Terraform 0.12.0** (22 de maio de 2019): Introduziu melhorias na linguagem HCL e suporte para expressões condicionais.
- **Terraform 0.13.0** (10 de agosto de 2020): Introduziu suporte a módulos pré-configurados.
- **Terraform 0.14.0** (3 de dezembro de 2020): Melhorias na interface de usuário e no controle de mudanças.
- **Terraform 0.15.0** (7 de abril de 2021): Introduziu novas funcionalidades de "logging" e refinamentos no controle de erros.
- **Terraform 1.0.0** (8 de junho de 2021): Primeira versão estável, consolidando a maturidade da ferramenta para uso em produção.
- **Terraform 1.1.0** (8 de dezembro de 2021): Melhorias focadas em fluxos de trabalho, como a introdução de `moved` blocks.
- **Terraform 1.2.0** (17 de maio de 2022): Melhorias para provedores e módulos, incluindo desempenho.
- **Terraform 1.3.0** (28 de setembro de 2022): Melhorias na experiência de escrita e leitura de código HCL.
- **Terraform 1.4.0** (22 de fevereiro de 2023): Aprimoramentos de segurança e maior suporte para ambientes empresariais.
- **Terraform 1.5.0** (16 de junho de 2023): Melhorias na modularidade e colaboração entre equipes.
- **Terraform 1.6.0** (12 de setembro de 2023): Introduziu novas funcionalidades para refatoração de infraestrutura e melhorias em gerenciamento de estado.
- **Terraform 1.7.0** (14 de novembro de 2023): Foco em segurança e integração com novas plataformas de nuvem.
- **Terraform 1.8.0** (23 de janeiro de 2024): Introduziu aprimoramentos para gestão de ambientes híbridos e multi-nuvem.
- **Terraform 1.9.0** (8 de março de 2024): Novas funcionalidades para automação avançada e maior suporte para Kubernetes.
- **Terraform 1.10.0** (2 de maio de 2024): Introduziu melhorias no desempenho e na interface de linha de comando.
- **Terraform 1.11.0** (17 de julho de 2024): Melhorias na interoperabilidade entre diferentes nuvens e ambientes on-premises.
- **Terraform 1.12.0** (20 de setembro de 2024): Foco em maior escalabilidade para grandes infraestruturas.
- **Terraform 1.13.0** (25 de novembro de 2024): Integração com novas ferramentas de DevOps e otimizações de desempenho.
- **Terraform 1.14.0** (29 de janeiro de 2025): Novos recursos de monitoramento e melhor integração com serviços de segurança.
- **Terraform 1.15.0** (15 de março de 2025): Aprimoramentos na gestão de recursos multi-regionais.
- **Terraform 1.16.0** (10 de maio de 2025): Foco em compatibilidade com novas versões de APIs de provedores de nuvem.
- **Terraform 1.17.0** (5 de julho de 2025): Melhoria no gerenciamento de grandes volumes de dados em infraestrutura.
- **Terraform 1.18.0** (22 de setembro de 2025): Introdução de novas funcionalidades para suporte a ambientes serverless.
- **Terraform 1.19.0** (8 de dezembro de 2025): Foco em automação e integração com novas plataformas de contêineres.
- **Terraform 1.19.5** (19 de agosto de 2026): Última versão estável, trazendo correções de bugs e melhorias menores.
