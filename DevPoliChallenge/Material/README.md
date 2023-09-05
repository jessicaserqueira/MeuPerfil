# DevPoli Challenge

Agradecemos sua participação no Desafio DevPoli! Estamos animados para ver sua criatividade e habilidades em ação.

## Descrição

O Desafio DevPoli é uma oportunidade para você demonstrar suas habilidades de desenvolvimento e resolver problemas interessantes. Cada desafio é projetado para fornecer uma experiência de aprendizado prática e divertida, onde você poderá desenvolver projetos inspiradores.

Aproveite este desafio para aprimorar suas habilidades e se destacar como desenvolvedor mobile. Para acessar mais desafios e expandir ainda mais seu conhecimento, confira outros desafios disponíveis na [DevPoli](https://devpoli.com/challenges).

## Instruções

Você deverá implementar a tela de perfil, onde deve permitir o usuário navegar na tela e apresentar as opções de menu.

### Funcionalidades:

Nesse desafio, você desenvolverá uma tela de perfil com um menu interativo. O usuário poderá alterar sua imagem de perfil, que será salva localmente. Clicar na imagem ativará diferentes ações:

- Caso o usuário não possua imagem, ao clicar deve abrir a galeria para selecionar uma imagem. (Usar recursos nativos)
- Caso o usuário possua uma imagem, ao clicar deve exibir um alerta perguntando se deseja remover a foto ou alterar.

Além disso, você deve criar um menu que, ao ser clicado, direcionará o usuário para diferentes telas, sem abrir modais. Por exemplo, se o usuário selecionar "Dados pessoais", uma nova tela com o título "Dados pessoais" deve aparecer no centro, permitindo que ele retorne.

A seção "Ajuda" do menu deve abrir links usando uma webview, levando o usuário para os seguintes endereços:
 
- Termos de uso: (https://www.devpoli.com/termos-de-uso)
- Política de privacidade: (https://www.devpoli.com/politica-de-privacidade)
- Dúvidas frequentes: (https://www.devpoli.com/faq)

Ao clicar em "Encerrar sessão", um alerta deve perguntar se o usuário deseja sair. Se confirmado, o usuário será direcionado para uma tela semelhante à tela de login.

Os números de telefone no rodapé devem permitir chamadas telefônicas quando tocados. O link para o site "https://devpoli.com" também deve funcionar ao abrir em um navegador externo.

A versão do aplicativo deve ser exibida no rodapé, com detalhes sobre a versão atual, incluindo o número de build.

------ 

Você deverá ter uma tela de entrada com design livre, onde você terá um botão para navegar para tela de perfil.  

### Dicas:

Considere criar uma estrutura dinâmica para montar o menu, o que tornaria futuras adições ou mudanças de regra mais simples de implementar. Você pode usar um enum ou uma estrutura para representar os diferentes estados da tela, como "Editar Imagem de Perfil" e "Selecionar Menu". Isso ajuda a simplificar o fluxo da tela e facilita o controle das ações do usuário. Mantenha o código organizado e comentado para facilitar futuras modificações.

## Material

As imagens necessárias estão na pasta `Material/Icons`.

## Solução

Quando terminar de codar a sua obra-prima, é hora de brilhar! Acesse o desafio no site da [DevPoli](https://devpoli.com/challenges) e compartilhe a sua criação com a nossa comunidade animada! Estamos ansiosos para ver o que você construiu! 🚀😄

## Precisa de ajuda?

Acesso nosso [Fórum](https://devpoli.com/forum/devpoli-challenge) para receber suporte, compartilhar conhecimento e esclarecer dúvidas sobre o desafio.


## Licença

Este desafio é fornecido sob a [Licença MIT](https://opensource.org/licenses/MIT). Sinta-se à vontade para usar, modificar e distribuir o código resultante conforme os termos da licença.
