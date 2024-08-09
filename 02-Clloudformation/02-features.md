
No console da AWS, AWS CloudFormation oferece várias funcionalidades que ajudam na criação, gerenciamento e monitoramento de infraestrutura. Aqui estão as principais funcionalidades, juntamente com uma explicação de cada uma:

### 1. **Stacks**
   - **Descrição:** Uma Stack é uma coleção de recursos da AWS que você pode gerenciar como uma unidade única. Quando você cria, atualiza ou exclui uma Stack, todos os recursos definidos no template são criados, atualizados ou excluídos juntos.
   - **Funcionalidades no Console:**
     - **Create Stack:** Permite criar uma nova Stack a partir de um template. Você pode carregar um arquivo YAML ou JSON, usar um template armazenado no S3 ou criar a partir de um conjunto de templates fornecidos pela AWS.
     - **Update Stack:** Permite modificar uma Stack existente, aplicando as mudanças de um novo template ou alterando parâmetros específicos.
     - **Delete Stack:** Exclui todos os recursos gerenciados pela Stack.

### 2. **StackSets**
   - **Descrição:** Um StackSet é uma coleção de Stacks que pode ser implantada em várias contas da AWS e regiões, permitindo gerenciamento centralizado e replicação de infraestrutura.
   - **Funcionalidades no Console:**
     - **Create StackSet:** Cria um StackSet com um template CloudFormation, definindo as contas e regiões onde ele será implantado.
     - **Update StackSet:** Permite atualizar o StackSet existente, aplicando mudanças em todas as contas e regiões onde ele foi implantado.
     - **Delete StackSet:** Remove o StackSet e as Stacks associadas de todas as contas e regiões.
     - **Instances:** Visualize e gerencie as instâncias individuais da StackSet em diferentes regiões e contas.

### 3. **Application Composer**
   - **Descrição:** Anteriormente o CloudFormation Designer foi a interface gráfica integrada ao console da AWS, que permitia criar e visualizar templates de infraestrutura. 
   - **Funcionalidades no Console:**
     - **Drag-and-Drop:** Você pode arrastar e soltar componentes (recursos da AWS) para criar um diagrama visual da sua infraestrutura.
     - **Visualize Relationships:** Mostra como os diferentes recursos no template estão conectados uns aos outros.
     - **Edit Template:** Permite editar o código YAML ou JSON diretamente na interface do Designer.

O AWS CloudFormation Designer foi atualizado para o **AWS Application Composer**, que traz novas funcionalidades e melhorias significativas. Essa ferramenta facilita a criação e visualização de templates de infraestrutura como código (IaC) de forma visual. Aqui estão as principais mudanças e funcionalidades:

### **Principais Funcionalidades do Application Composer:**

1. **Design Visual**:
   - O Application Composer permite a criação de infraestruturas arrastando e soltando componentes em um canvas visual, gerando automaticamente o código YAML correspondente. Você pode alternar entre a visualização do canvas e a edição direta do código, com mudanças sincronizadas automaticamente [Amazon Web Services, Inc.](https://aws.amazon.com/blogs/compute/visually-design-your-application-with-aws-application-composer/)​ [AWS Community](https://community.aws/content/2dukXTxyIrXK6vHPARBL40BZQxT/deploy-sam-application-composer).

2. **Integração com o CloudFormation**:
   - Agora, o Application Composer pode ser acessado diretamente do console do AWS CloudFormation, onde você pode visualizar, criar e atualizar templates. Isso integra a visualização e edição de templates ao fluxo de trabalho de criação de stacks no CloudFormation [Amazon AWS Documentation](https://docs.aws.amazon.com/application-composer/latest/dg/what-is-composer.html).

3. **Conexões Automáticas**:
   - Ao conectar diferentes recursos no canvas, como Lambda e DynamoDB, o Application Composer automaticamente atualiza o template com a configuração correta, facilitando a integração entre serviços e minimizando erros manuais [AWS Community](https://community.aws/content/2dukXTxyIrXK6vHPARBL40BZQxT/deploy-sam-application-composer).

4. **Configuração Detalhada**:
   - Cada componente adicionado ao canvas pode ser configurado detalhadamente através do painel de propriedades, onde é possível ajustar as configurações e propriedades dos recursos[Amazon AWS Documentation](https://docs.aws.amazon.com/application-composer/latest/dg/what-is-composer.html), [AWS Community](https://community.aws/content/2dukXTxyIrXK6vHPARBL40BZQxT/deploy-sam-application-composer)..

5. **Grupos de Funções**:
   - Para melhor organização, funções Lambda relacionadas podem ser agrupadas, facilitando a visualização e o gerenciamento dentro do canvas. Você pode personalizar esses grupos para refletir a lógica do seu aplicativo [AWS Community](https://community.aws/content/2dukXTxyIrXK6vHPARBL40BZQxT/deploy-sam-application-composer)..

6. **Melhorias na Experiência do Usuário**:
   - A interface do Application Composer foi otimizada para facilitar a criação de templates complexos, com sugestões automáticas e boas práticas integradas, como a ativação de logging e monitoramento para funções Lambda [AWS Community](https://community.aws/content/2dukXTxyIrXK6vHPARBL40BZQxT/deploy-sam-application-composer)..

Essa atualização oferece uma experiência mais integrada e intuitiva para os desenvolvedores que utilizam o AWS CloudFormation para gerenciar infraestruturas complexas, especialmente em arquiteturas serverless.  

### 4. **Change Sets**
   - **Descrição:** Change Sets são uma funcionalidade que permite visualizar as mudanças que serão aplicadas a uma Stack antes de realmente executá-las. Isso ajuda a prevenir alterações inesperadas ou indesejadas.
   - **Funcionalidades no Console:**
     - **Create Change Set:** Gera um conjunto de mudanças que mostra quais recursos serão alterados, criados ou excluídos quando o template for aplicado.
     - **View Change Set:** Permite visualizar as mudanças propostas, oferecendo detalhes sobre o impacto que a atualização terá na Stack.
     - **Execute Change Set:** Aplica as mudanças propostas pela Change Set à Stack.

### 5. **Drift Detection**
   - **Descrição:** Drift Detection é usada para detectar divergências entre a configuração atual dos recursos na AWS e o que está definido no template da Stack.
   - **Funcionalidades no Console:**
     - **Detect Drift:** Inicia uma verificação de drift para uma Stack ou recurso específico, comparando o estado atual do recurso na AWS com o que está definido no template.
     - **View Drift Results:** Exibe os resultados da detecção de drift, mostrando quais recursos estão em conformidade e quais não estão.
     - **Resolve Drift:** Toma ações para corrigir ou ajustar as divergências detectadas, como reverter para o estado definido no template.

### 6. **Outputs**
   - **Descrição:** Outputs são valores que você pode definir no template para serem exibidos após a criação da Stack. Eles são frequentemente usados para compartilhar informações entre Stacks ou fornecer dados de configuração para outros processos.
   - **Funcionalidades no Console:**
     - **View Outputs:** Permite visualizar os valores de saída gerados pela Stack, como IDs de recursos, URLs ou outros dados configuráveis.

### 7. **Events**
   - **Descrição:** A aba Events mostra um histórico detalhado das ações realizadas na Stack, como a criação, atualização ou exclusão de recursos, e o status dessas ações.
   - **Funcionalidades no Console:**
     - **View Events:** Permite visualizar um registro cronológico das operações realizadas na Stack, facilitando o diagnóstico e a resolução de problemas.

### 8. **Resources**
   - **Descrição:** A aba Resources lista todos os recursos gerenciados pela Stack e seus respectivos status.
   - **Funcionalidades no Console:**
     - **View Resources:** Exibe detalhes sobre cada recurso, incluindo o tipo, status, ID físico e outras propriedades importantes.

### 9. **Parameters**
   - **Descrição:** Parameters permitem que você personalize a configuração da Stack ao inseri-los durante a criação. Eles podem definir valores como tipos de instância, nomes de S3 buckets, e outras configurações que precisam ser ajustáveis.
   - **Funcionalidades no Console:**
     - **View Parameters:** Permite visualizar os parâmetros usados na criação ou atualização da Stack.
     - **Edit Parameters:** Permite alterar os valores dos parâmetros durante a atualização de uma Stack.

### 10. **Template**
   - **Descrição:** A aba Template permite visualizar o template YAML ou JSON que foi usado para criar ou atualizar a Stack.
   - **Funcionalidades no Console:**
     - **View Template:** Exibe o código completo do template atualmente aplicado à Stack.
     - **Template Summary:** Oferece uma visão resumida dos principais componentes e configurações definidas no template.

Essas funcionalidades combinadas tornam o AWS CloudFormation uma ferramenta poderosa para gerenciar infraestruturas em nuvem de maneira automatizada e eficiente.