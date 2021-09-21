# :project_name

<!---Esses são exemplos. Veja https://shields.io para outras pessoas ou para personalizar este conjunto de escudos. Você pode querer incluir dependências, status do projeto e informações de licença aqui--->

![GitHub repo size](https://img.shields.io/github/repo-size/:username/:reponame?style=for-the-badge)
![GitHub language count](https://img.shields.io/github/languages/count/:username/:reponame?style=for-the-badge)
![GitHub forks](https://img.shields.io/github/forks/:username/:reponame?style=for-the-badge)
![Bitbucket open issues](https://img.shields.io/bitbucket/issues/:username/:reponame?style=for-the-badge)
![Bitbucket open pull requests](https://img.shields.io/bitbucket/pr-raw/:username/:reponame?style=for-the-badge)

<img src=":image_source" alt=":image_alt">

> :project_description

### Ajustes e melhorias

O projeto ainda está em desenvolvimento e as próximas atualizações serão voltadas nas seguintes tarefas:

- [x] Tarefa 1
- [x] Tarefa 2
- [x] Tarefa 3
- [ ] Tarefa 4
- [ ] Tarefa 5

## 💻 Pré-requisitos

Antes de começar, verifique se você atendeu aos seguintes requisitos:
<!---Estes são apenas requisitos de exemplo. Adicionar, duplicar ou remover conforme necessário--->
* Você instalou a versão mais recente de `<:language / :main_dependency / :requirements>`
* Você tem uma máquina `<:operational_systems>`. Indique qual sistema operacional é compatível / não compatível.
* Você leu :documentation_link.

## 🚀 Instalando :project_name

Para instalar o :project_name, siga estas etapas:

Linux e macOS:
```
:linux_mac_install
```

Windows:
```
:windows_install
```

## ☕ Usando :project_name

Para usar :project_name, siga estas etapas:

```
<exemplo_de_uso>
```

Adicione comandos de execução e exemplos que você acha que os usuários acharão úteis. Fornece uma referência de opções para pontos de bônus!

## 🧰 Fluxo de Trabalho

### Branches principais (Fixas):
As branches principais não devem ser apagadas após pull requests. A criação das branches principais sempre se inicia em Main para novos projetos. 

* Develop (Inicialmente Main ou Master)  
    * Branch principal
    * Código mais atualizado do sistema
    * Mudanças frequentes advindas de bugfixes e features
    * Protegida. Apenas pull requests (de qualquer branch exceto production)
    * Todas as branches do tipo feature devem nascer de main

* Staging:
    * Ambiente de pré-produção. 
    * Deve espelhar Main na maior parte do tempo.  
    * Protegida. Aceita pull requests de hotfix/bugfix e develop.
    * Testes automatizados e manuais. 

* Production: 
    * Código atualmente em produção
    * Protegida. Apenas pull requests advindas de staging ou de hotfixes devem ser aceitas. 
    * Todas as branches do tipo hotfix devem nascer de production
    * Testes automatizados

### Branches de suporte (Temporárias):
As branches de suporte são as branches para as quais novos commits serão adicionados. Não são feitos pull request para estas branches, apenas para as branches principais, e elas sempre se originam de uma branch principal. Preferencialmente, devem ser trabalhadas por um único desenvolvedor, evitando problemas de conflito entre merges. 

* Feature
    * Deve sempre conter o prefixo feature/* .
    * Entende-se * como o nome claro, conciso e curto da funcionalidade sendo implementada. 
    * Podem ter curta ou média duração. 
    * Funcionalidades complexas que talvez demandem a duração de diversos dias ou até semanas devem ser quebrados em features menores. 
    * Ao finalizar uma feature, pull request contra a Main. Caso seja aceito e os testes sejam realizados com sucesso, mesclar e deletar. Senão, realizar alterações necessárias e realizar uma nova pull request. 

* Bugfix/Hotfixes
    * Devem sempre conter o prefixo bugfix/* ou hotfix/*
    * Entende-se * como o nome claro, conciso e curto do problema sendo corrigido. NÃO utilizar o nome da correção em si, mas sim do problema. (Exemplo: bugfix/formated-messages (errado) bugfix/no-error-messages (certo)
    * Devem ter curta duração. Problemas estruturais devem ser quebrados em problemas menores. 
    * Antes de criar um novo bug ou hotfix, verificar se o bug foi corrigido durante o desenvolvimento de uma nova feature.
    * A presença muito alta de branches desses tipos pode indicar problemas de arquitetura. Quanto menos branches do tipo bugfix e hotfix, melhor. 
    * A diferença entre Bugfix e Hotfix se deve enquanto a branch de origem e de destino. 

* Bugfixes:
    * Sempre se originam da branch staging. 
    * Não são críticos para o funcionamento do sistema.
    * Pull request contra a branch original. Caso não hajam conflitos, mesclar e repetir o processo contra a branch Main.

* Hotfixes:
    * Sempre se originam da branch production. 
    * São críticos para o funcionamento do sistema. Demandam maior atenção do time. 
    * Pull request contra a branch original. Caso não hajam conflitos, mesclar e repetir o processo contra as branches staging e main, respectivamente.

### Branches especiais:
As branches especiais buscam atender as necessidades específicas de determinado repositório/projeto. Podem ser tratadas como branches fixas ou de longa duração. Exemplos: Diversas versões de um produto em produção, como pacotes, bibliotecas, apis; mudanças de tecnologia; migrações de código; suporte legado; etc.

## 🤝 Colaboradores

Hoje nosso time é formado por:

<table>
  <tr>
    <td align="center">
      <a href="https://github.com/will-amaral">
        <img src="https://avatars.githubusercontent.com/u/25940897?v=4" width="100px;" alt="Foto do Will Amaral no GitHub"/><br>
        <sub>
          <b>Will Amaral</b>
        </sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/cefasgarciapereira">
        <img src="https://avatars.githubusercontent.com/u/14894928?v=4" width="100px;" alt="Foto do Cefas Garcia Pereira no GitHub"/><br>
        <sub>
          <b>Cefas Garcia Pereira</b>
        </sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/ramonpego">
        <img src="https://avatars.githubusercontent.com/u/6185157?v=4" width="100px;" alt="Foto do Ramon Pêgo no GitHub"/><br>
        <sub>
          <b>Ramon Pêgo</b>
        </sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/felipebrsk">
        <img src="https://avatars.githubusercontent.com/u/75860661?v=4" width="100px;" alt="Foto do Felipe Oliveira no GitHub"/><br>
        <sub>
          <b>Felipe Oliveira</b>
        </sub>
      </a>
    </td>
  </tr>
</table>

## 📝 Licença

Este projeto NÃO é licenciado, isso significa que os direitos são reservados e não é de código aberto ou gratuito. Você não pode modificar ou redistribuir este código sem a permissão explícita do detentor dos direitos autorais.

[⬆ Voltar ao topo](#:project_name)<br>