# Refds Core with Clean Architecture

> Library to assist in the construction of a project in swift applying clean architecture, in order to standardize and organize the developed code, favoring its reusability, as well as technology independence.

[![CI](https://github.com/rafaelesantos/refds-clean-architecture/actions/workflows/swift.yml/badge.svg)](https://github.com/rafaelesantos/refds-clean-architecture/actions/workflows/swift.yml)
[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]

## Table of Contents
* [General Information](#general-information)
* [Technologies Used](#technologies-used)
* [Features](#features)
* [Setup](#setup)

## General Information

- Clean Architecture is a software architecture proposed by Robert Cecil Martin (or Uncle Bob, as he is better known) that aims to standardize and organize the developed code, favoring its reusability, as well as technology independence.
- As much as Clean Architecture was created in mid-2012, it is full of timeless principles that can be applied regardless of the technology used and programming language.

## Technologies Used

- Xcode - version 14.1
- Swift Tools - version 5.7
- Swift Package Manager

## Features

- [X] Domain Layer - `RefdsDomain`
- [X] Data Layer - `RefdsData`
- [X] Infra Layer - `RefdsInfra`

## Setup

Add this project to your `Package.swift` file.

```swift
import PackageDescription

let package = Package(
    dependencies: [
        .package(url: "https://github.com/refdsenterprise/refds-core.git", branch: "main")
    ],
    targets: [
        .target(
            name: "YourProject",
            dependencies: ["RefdsCore"]),
    ]
)
```

[swift-image]: https://img.shields.io/badge/swift-5.7-orange.svg
[swift-url]: https://www.swift.org/blog/swift-5.7-released/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
