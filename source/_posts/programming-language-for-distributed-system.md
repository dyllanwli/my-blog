---
layout: title
title: Programming language for Distribute System
date: 2018-02-09 21:19:15
tags: Distributed System
categories: Tech
---
## 1. Erlang
[Erlang][1], as described by [Wikipedia][2]:

> It was designed by Ericsson to support distributed, fault-tolerant, soft-real-time, non-stop applications.

You might also want to read the [*Distributed Erlang*][3] section of their manual.

However, note that Erlang is a [*functional* language][4] and will require a much different paradigm of thought as compared to C++.

> A distributed Erlang system consists of a number of Erlang runtime systems communicating with each other. Each such runtime system is called a node. Message passing between processes at different nodes, as well as links and monitors, are transparent when pids are used. Registered names, however, are local to each node. This means that the node must be specified as well when sending messages, and so on, using registered names.






## 2. Golang
GoLang from Google is a pretty new language. It seems that among its many attributes, it may some day be suitable for large distributed systems requiring a lot of message queues to achieve scalable consistent and reliable behaviours, at least according to [these folks][5] at heroku.

Go seems to be focused on concurrency issues, threading primitives in the language, and so on, and this is perhaps a necessary-but-not-quite-sufficient starting point for distributed systems. Perhaps their thoughts will be helpful to you. I wouldn't call Go-lang's support for distributed systems "first-class", but rather, say that it would be possible to build a first class distributed-systems framework using Go's library and language primitives.

At first, I'm less impressed with Go. I think it suffers from some sad and limited thinking on the part of its authors. I think its decisions on fault and exception handling are retrograde, and render the language unusable.

But I now think in terms of large team development where having N-factorial implementation options leads to N-factorial different coding tarpits. At least Go doesn't seem to have labrea scale tarpits, only certain conventional mudwallows. They absolutely love tabs and will insert them into your code for you if you fail to love them enough.

## 3. Bloom
[Bloom][6] is a new domain-specific language for distributed programming. The current alpha release is embedded in Ruby, and targeted at early adopters. Bloom leverages new research on "CALM" analysis to provide tools that pinpoint distributed consistency and coordination issues in your code.

## 4. Python
[Parallel Python][7] is a python module which provides mechanism for parallel execution of python code on SMP (systems with multiple processors or cores) and clusters (computers connected via network):

**Features:** 

 * Parallel execution of python code on SMP and clusters 
 * Easy to understand and implement job-based parallelization technique (easy to convert serial application in parallel)
 * Automatic detection of the optimal configuration (by default the number of worker processes is set to the number of effective processors)
 * Dynamic processors allocation (number of worker processes can be changed at runtime)
 * Low overhead for subsequent jobs with the same function (transparent caching is implemented to decrease the overhead)
 * Dynamic load balancing (jobs are distributed between processors at runtime)
 * Fault-tolerance (if one of the nodes fails tasks are rescheduled on others)
 * Auto-discovery of computational resources
 * Dynamic allocation of computational resources (consequence of auto-discovery and fault-tolerance) 
 * SHA based authentication for network connections
 * Cross-platform portability and interoperability (Windows, Linux, Unix, Mac OS X)
 * Cross-architecture portability and interoperability (x86, x86-64, etc.)
 * Open source

One can get a quick idea of how the code might look by [looking at the quick-start guide for clusters][8].

## 5. Reia
[Reia][9] is a scripting language for distributed system:

> Reia aims to expose the powerful
> capabilities of Erlang in a way which
> is easier for your average programmer
> to understand. It aims to bring the
> beauty and simplicity of Ruby, a
> language which is easy and fun to
> program in, to Erlang, a language
> which very few will think of as easy
> or fun to use.



  [1]: http://www.erlang.org/
  [2]: http://en.wikipedia.org/wiki/Erlang_%28programming_language%29
  [3]: http://www.erlang.org/doc/reference_manual/distributed.html
  [4]: http://en.wikipedia.org/wiki/Functional_programming
  [5]: http://blog.golang.org/2011/04/go-at-heroku.html
  [6]: http://bloom-lang.net/
  [7]: http://www.parallelpython.com/
  [8]: http://www.parallelpython.com/content/view/15/30/#QUICKCLUSTERS
  [9]: http://reia-lang.org/