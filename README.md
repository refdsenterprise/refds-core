# Clean Architecture

> Biblioteca para auxiliar na construção de um projeto em swift aplicando clean architecture, afim de padronizar e organizar o código desenvolvido, favorecer a sua reusabilidade, assim como independência de tecnologia.

[![CI](https://github.com/rafaelesantos/refds-clean-architecture/actions/workflows/swift.yml/badge.svg)](https://github.com/rafaelesantos/refds-clean-architecture/actions/workflows/swift.yml)
[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]

### O que é Clean Architecture?

Clean Architecture é uma arquitetura de software proposta por Robert Cecil Martin (ou Uncle Bob, como é mais conhecido) que tem por objetivo padronizar e organizar o código desenvolvido, favorecer a sua reusabilidade, assim como independência de tecnologia.

Por mais que a Clean Architecture foi criada em meados de 2012, está repleta de princípios atemporais que podem ser aplicados independente da tecnologia utilizada e linguagem de programação.

### Camadas Implementadas

- [X] Camada de Domínio `Domain Layer`
- [X] Camada de Dados - `Data Layer`
- [X] Camada de Infraestrutura - `Infra Layer`

### Instalação

Adicione esse projeto em seu arquivo `Package.swift`.

```swift
import PackageDescription

let package = Package(
    dependencies: [
        .package(url: "https://github.com/rafaelesantos/refds-clean-architecture.git", branch: "main")
    ],
    targets: [
        .target(
            name: "YourProject",
            dependencies: ["RefdsDomainLayer", "RefdsDataLayer", "RefdsInfraLayer"]),
    ]
)
```

[swift-image]: https://img.shields.io/badge/swift-5.7-orange.svg
[swift-url]: https://www.swift.org/blog/swift-5.7-released/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
