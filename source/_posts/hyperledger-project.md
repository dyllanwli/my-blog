---
layout: title
title: Different between 5 Hyperleder project
date: 2018-02-10 15:45:42
tags: Hyperledger
categories: Tech
---
The Linux Foundation’s Hyperledger project, which is focused on open source blockchain technology, divides its work into five sub projects. Hyperledger Executive Director Brian Behlendorf said Hyperledger’s technical steering committee must approve each new sub project, and it’s looking for projects that “represent different thinking.”

The first five projects are: Fabric, Sawtooth, Indy, Burrow, and Iroha.

“Every one of these projects started life outside of Hyperledger, first, by a team that had certain use cases in mind,” said Behlendorf. Each project must bring something unique to the open source group, and its technology must be applicable to other companies.

### Fabric
Fabric is Hyperledger’s most active project to date. The Fabric 1.0 release was issued in July. IBM initiated the Fabric project. It’s intended as a foundation for developing blockchain distributed ledger applications with a modular architecture. It allows components, such as consensus and membership services, to be plug-and-play.

“Fabric is the granddaddy, if you will,” said Behlendorf. “Several companies are already selling products and services based on it.” The core of the platform is written in the Go programming language. A unique characteristic of Fabric is that its distributed ledger and smart contract platform allows for private channels. “If you have a large blockchain network and you want to share data with only certain parties, you can create a private channel with just those participants,” Behlendorf said. “It’s the most distinctive thing about Fabric right now.”

### Sawtooth
The Sawtooth project originally came from Intel. It includes a novel consensus algorithm called Proof of Elapsed Time. Consensus is a critical element of all blockchains. Generally, it is the technique by which new information is reviewed and confirmed before being accepted as the next entry in the ledger.

The Sawtooth consensus software targets large distributed validator populations with minimal resource consumption. “It may give us the ability to build very broad and flat networks of hundreds to thousands of nodes,” said Behlendorf. “It’s harder to do with traditional consensus mechanisms without having the CPU burden of cryptocurrencies.”

### Indy
The Indy project was originally the brainchild of the nonprofit group the Sovrin Foundation. The idea is to provide digital identities for individuals and give them the power to share their identity with whom they chose. “Instead of being an entry in a giant data base, you have your data and deal programmatically with different organizations who want to check your identity,” said Behlendorf. “And companies don’t have to store so much personal data. They can store a pointer to the identity.”

Indy’s work looks especially timely, given the recent Experian hack. Behlendorf said Indy’s blockchain software is based on data minimization. When a company is done with your data, it throws it away. “It’s a toxic asset that could present a liability,” he said.

### Burrow
The Burrow project includes a permissioned, smart-contract interpreter built in part to the specification of the Ethereum Virtual Machine (EVM). The Ethereum platform is used both for cryptocurrency as well as for smart contracts. It’s written with the Solidity programming language. Within the Burrow Project, the EVM is the interpreter for smart contracts (not related to cryptocurrency) that run across the Ethereum network.

Many well-known companies belong to the Enterprise Ethereum Alliance, including JPMorgan, Microsoft, Accenture, BP, and Cisco.

“It’s important to build a relationship with the Ethereum community,” said Behlendorf. “Burrow is the only Apache-licensed Ethereum VM implementation out there.”

### Iroha
Finally, the Iroha project is a bit of an outlier within Hyperledger. It originated with some developers in Japan who had built their own blockchain technology for a couple of mobile use cases. “It’s implemented in C++ which can be more high performance for small data and focused use cases,” said Behlendorf. “Iroha is still looking for its niche, but it’s a great development team.”