# DogWalking Challenge

Essa aplicação foi criado para o desafio técnico da DogHero, conforme instruções na [documentação anexada](doc/Fullstack_Software_Engineer_Test.docx).


## Considerações

Após conversas sobre o desafio, interpretei as seguintes necessidades:
 - alteração do nome da entidade de dog walking para dog walk, por entender ser mais semântico
 - criação dos modelos dono(owner), pet, passeador(walker) para se relacionar ao dog_walk
 - remoção da latitude e longitude como parâmetro de dog_walk e promoção para uma entidade separada(Position), assim um dog_walk poder ter muitas posições no tempo (RoutePosition) e pode-se acompanhar e desenhar a rota do dog_walk
 - criação do starting_postion(Position) e ending_postion(Position) para marcar os pontos de encontro entre o dono e o passeador
 - criação do endpoint walkers/update_position para representar como seria atualizado a rota pelo walker de tempos em tempos
 - criação do endpoint owners/pets necessário ao client para listar as opções de pets associados ao dog_walk
 

Para poder abordar as necessidades e ainda assim manter a simplicidade do desafio, fiz as seguintes restrições:
 - as entidades dono, pet e passeador não terão suporte a crud, serão todas criadas com seed
 - todas DogWalkings criadas pelo owner serão automaticamente aceitas pelo  (app/controllers/v1/owners/dog_walks_controller.rb:74)
 - não haverá controle de usuários, assim entendendo que toda ação de dono se dará a partir do namespace owners e toda ação do passeador pelo namespace walkers
 
## Pré requisitos

Para rodar a aplicação precisa estar instalado PostgreSQL, Ruby:2.3.4 e a gem Bundler

## Instalação

Instale as dependências

```sh
$ bundle install
```

Crie o banco e popule com as seeds

```sh
$ rails db:setup
```

## Testes

Para rodar os testes

```sh
$ rspec
```
