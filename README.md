# FTrack - Flutter Rastreio App

FTrack é um aplicativo Flutter de rastreio que utiliza a API disponível em [chipytux/correiosApi](https://github.com/chipytux/correiosApi). Este aplicativo segue as diretrizes do Material Design 3.

## Como Começar

Este projeto é um ponto de partida para o desenvolvimento de um aplicativo Flutter. Se você está começando com o Flutter, confira os recursos abaixo:

- [Codelab: Escreva seu primeiro aplicativo Flutter](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Exemplos úteis de Flutter](https://docs.flutter.dev/cookbook)

Para obter ajuda com o desenvolvimento Flutter, consulte a [documentação online](https://docs.flutter.dev/), que oferece tutoriais, amostras, orientações sobre o desenvolvimento móvel e uma referência completa da API.

## Configuração

Certifique-se de ter o Flutter instalado em sua máquina. Você pode seguir as instruções no [site oficial do Flutter](https://flutter.dev/docs/get-started/install) para instalação e configuração.

Após configurar o Flutter, clone este repositório:

```bash
git clone https://github.com/MRaphaelpy/frastreio2.git
cd frastreio2
```
Após clonar o repositório, é necessário realizar algumas configurações adicionais antes de executar o aplicativo. Siga as etapas abaixo:

1. No diretório do projeto (`frastreio2`), crie um arquivo Dart chamado `general_variables.dart` na pasta `lib`.

2. No arquivo `general_variables.dart`, adicione as seguintes variáveis com os valores apropriados:

   ```dart
   // lib/general_variables.dart

   const String token = "seu_token_aqui";
   const String user = "seu_usuario_aqui";
   const String codigo = "seu_codigo_aqui";
   
3. Substitua "seu_token_aqui", "seu_usuario_aqui" e "seu_codigo_aqui" pelos valores reais fornecidos pela API [chipytux/correiosApi](https://github.com/chipytux/correiosApi).

Pronto! Agora você pode executar o aplicativo em seu dispositivo ou emulador. 😀 