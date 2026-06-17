# Relatório Técnico: Segurança em Redes

## 1. Descrição da CVE Escolhida
* **Identificador CVE:** CVE-2011-2523  
* **Sistema Afetado:** vsftpd (Very Secure FTP Daemon), versão 2.3.4
* **Tipo de Vulnerabilidade:** Remote Code Execution através de backdoor plantado em Supply Chain Attack
* **Como a falha ocorre:** [resumo de como ocorreu o supply chain attack]
* **Impacto da exploração:** O atacante ganha um shell com os mesmos privilégios do processo que iniciou o vsftpd (que normalmente é executado como)
* **Classificação de severidade:** CVSS 2.0: 10.0 HIGH, CVSS 3.X: 9.8 CRITICAL

## 2. Funcionamento Técnico da Vulnerabilidade
O atacante injetou código em dois arquivos críticos:
* `str.c`: dentro da função `str_contains_space()` (que processa a string de login), foi inserido um `if` que verifica a presença dos bytes `0x3a` (dois pontos) e `0x29` (parêntese). Se verdadeiro, é chamada a função `vsf_sysutil_extra()`.

* `sysdeputil.c`: foi inserida a função `vsf_sysutil_extra()`, que abre um socket TCP raw na porta 6200, faz o bind e utiliza o comando execl para redirecionar o processo /bin/sh para os descritores de arquivo deste socket, criando uma conexão de terminal sem necessidade de autenticação.

## 3. Arquitetura do Experimento
* **Ambiente Controlado:** O experimento foi modelado em um ambiente de containers Docker estritamente isolados através de uma rede bridge dedicada (vsftpd-lab).
* **Simulação:**

  * attacker: Container Ubuntu 20.04 com ftp e netcat.

  * victim: Container Ubuntu 20.04 no qual o código-fonte preservado do programa infectado é clonado, compilado e executado. Foram criados links simbólicos e ajustes de bibliotecas (libcrypt, libcap) para permitir a compilação do código legado sem precisar alterá-lo.
  
## 4. Demonstração da Exploração
* **Passo a Passo:**
* **Impacto Observado:**

## 5. Estratégia de Mitigação
* **Correção Implementada:**

## 6. Resultados e Análise
* **Sistema Vulnerável:**
* **Sistema Corrigido:**

## 7. Lições Aprendidas sobre Segurança
* **Conclusão:**