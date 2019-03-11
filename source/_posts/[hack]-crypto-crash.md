---
layout: title
title: 密码学-Crypto Crash intro一些重要概念
date: 2018-12-11 09:11:06
tags: cryptography
categories: Hack
---

## XOR
异或运算的概念肯定大家已经熟悉了。我们知道，XOR运算两次的时候就会使其得到原来的值。这一个特点可以用于我们最为熟知加密运算。

当然，这必然是一次性的 One-Time Pad

## Types of Ciphers
我们可以将加密主要分为两类：
1. Symmetric -- 使用同样的key

+ Stream 按照byte来加密

常见的比如RC4，我们熟知的SSL，他使用随机数并XOR每一个byte来加密数据；解密也是只要XOR密文，这意味着这两个操作需要完全一致/identical

根据这个定义，我们就可以构建一个简单的stream cipher，通过PRNG和seeding

算法的强度仅仅依赖于随机的质量，毕竟都是伪随机; better quality of random output, stronger the encryption

+ Block 按照block加密

Block Cipher 可能更加熟悉一些，AES（Rijndael），DES，3DES，TwoFish之类的

在block cipher里，数据被分为N-byte个块，然后分开加密。同时我们也不知道数据是怎样被分割的，我们不得不填补它，增加了复杂度。同时，加密和解密不是相同的。

也因为是通过block加密，许多的模式能够增加安全性，比如ECB Mode。

Electronic CodeBook mode是最简单的block cipher。每一个明文block独立的加密为密文。这意味着相同的密文对应着相同的明文。

CBC加密，Cipher Block Chaining同样很常见。每一个明文block在加密前使用XOR与前一个密文进行运算。这样避免了ECB模式的缺陷。因为每一个block存在于一个类似于链式结构的情况，于是可能导致一些有趣的bug。

2. Asymmetric -- 使用private key

对于非对称加密，最常见的就是RSA了，使用公钥和私钥。同时非对称加密也可以用于加密和签名。也有时候非对称加密没有直接用于加密是因为性能和复杂度的原因。

## HASHES
Hashes也组成了加密的重要部分，一个常见的hash方法 128-512 MD5 SHA1、SHA256。

hash对于单独的object加密十分有帮助，决定了数据的integrity。

## MACs
Message Authentication Codes通常基于hashes，这就意味着对于给定的MAC，你们可以确保数据没有被干扰，同时验证MAC能没有被篡改。这是因为，你需要共享同样的key用来验证MAC，如果没有就不能创建一个有效的MAC


## HMAC
最著名的MAC就是HMAC，使用一个简单的结构：
HMAC(key, message) = hash(key + hash(key + message))

Key被各自的哈希算法填充，是十分最简单的一种了。