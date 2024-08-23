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

Aqui está a lista das versões do Terraform e suas respectivas datas de lançamento:

1. **Terraform 0.1.0** - 28 de julho de 2014
2. **Terraform 0.2.0** - 5 de agosto de 2014
3. **Terraform 0.3.0** - 15 de setembro de 2014
4. **Terraform 0.4.0** - 28 de outubro de 2014
5. **Terraform 0.5.0** - 14 de janeiro de 2015
6. **Terraform 0.6.0** - 9 de junho de 2015
7. **Terraform 0.7.0** - 2 de agosto de 2016
8. **Terraform 0.8.0** - 13 de dezembro de 2016
9. **Terraform 0.9.0** - 29 de março de 2017
10. **Terraform 0.10.0** - 3 de julho de 2017
11. **Terraform 0.11.0** - 16 de novembro de 2017
12. **Terraform 0.12.0** - 22 de maio de 2019
13. **Terraform 0.13.0** - 10 de agosto de 2020
14. **Terraform 0.14.0** - 11 de novembro de 2020
15. **Terraform 0.15.0** - 5 de abril de 2021
16. **Terraform 1.0.0** - 8 de junho de 2021
17. **Terraform 1.1.0** - 8 de dezembro de 2021
18. **Terraform 1.2.0** - 5 de maio de 2022
19. **Terraform 1.3.0** - 14 de setembro de 2022
20. **Terraform 1.4.0** - 9 de dezembro de 2022
21. **Terraform 1.5.0** - 4 de abril de 2023
22. **Terraform 1.6.0** - 4 de outubro de 2023
23. **Terraform 1.7.0** - 17 de janeiro de 2024
24. **Terraform 1.8.0** - 10 de abril de 2024
25. **Terraform 1.9.0** - 26 de junho de 2024
26. **Terraform 1.9.5** - 20 de agosto de 2024

Essas versões mostram a evolução da ferramenta ao longo do tempo, refletindo melhorias e novas funcionalidades adicionadas em cada release. A HashiCorp mantém e atualiza o Terraform regularmente para atender às necessidades de gerenciamento de infraestrutura como código (IaC).
