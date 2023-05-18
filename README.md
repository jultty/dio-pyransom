# dio-pyransom

Desafio de projeto **"Criando um Ransomware com Python"**, desenvolvido para a formação _Cybersecurity Specialist_ da DIO.

Para rodar os testes, use `./dev gui` ou `./dev cli`. O script monitora as mudanças no diretório, e exibe as imagens ou faz verificações usando um hash sha256.

O script de testes requer os pacotes `feh` e `inotify-tools`.

**Melhorias realizadas**:

- Trabalha de forma recursiva passando por todos os subdiretórios e arquivos
- Inclui um script para testes automatizados durante o desenvolvimento
- Realiza o _padding_ dos dados para evitar erros por tamanho de bloco

----
Imagens da demonstração por: F. Nemos, _Europas bekannteste Schmetterlinge_ (1895). Domínio público.

