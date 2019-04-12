# JMPay

[![Platform](https://img.shields.io/badge/Platform-iOS-blue.svg?style=for-the-badge)](https://www.apple.com/br/ios/ios-12/)
[![Compatibility](https://img.shields.io/badge/Compatibility-iPhone%20-lightgrey.svg?style=for-the-badge)](https://www.apple.com/br/iphone/)

[![Platform](https://img.shields.io/badge/iOS_Version-12.0+-green.svg?style=for-the-badge)](https://www.apple.com/br/ios/ios-12/)
[![Swift Version](https://img.shields.io/badge/swift-4.2-orange.svg?style=for-the-badge)](https://swift.org/)
[![XCode Version](https://img.shields.io/badge/Xcode_Version-10.1+-blue.svg?style=for-the-badge)](https://developer.apple.com/xcode/)

![JoaoMarcos](https://i0.wp.com/fllwtv.files.wordpress.com/2019/04/jmpay.png?ssl=1&w=450)

## Bem vindo

## Principais Funcionalidades
- Listagem de contatos
- Cadastro de cartão de crédito
- Tranferência para um contato

## O que falta ser desenvolvido
- Testes Unitários
- Validação do número do cartão de crédito
- Validação da data de validade
- Documentação dos componentes
- Criar micro componentes de alguns elementos visuais

## Bibliotecas Utilizadas 
- `Alamofire` (gerenciar requisições de todo o app)
- `AlamofireImage` (baixar imagens e cachear)
- `AlamofireNetworkActivityIndicator` (indicar o uso de rede através do activity de rede)
- `AlamofireNetworkActivityLogger` (printar todas as requisições, para facilitar o debug)
- `MaterialTextField` (textfield com comportamento float e estado de erro)
- `SwiftLint` (aprimorar o padrão de código)

** Todas bibliotecas utilizadas com o `CocoaPods`

## Como executar o projeto a primeira vez
O projeto utiliza o `Bundler` para gerenciamento de versão das ferramentas, então é necessário ter instaldo:
```shell
sudo gem install bundler
```
Depois instale os componentes do `Bundler` (dentro da pasta do projeto):
```shell
bundle install
```
Por fim basta instalar o `Pods` na sua máquina:
```shell
bundle exec pod install
```