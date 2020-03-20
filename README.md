# From scratch with Quarkus in k8s

This is a demo application to show the benefice of having a very fast startup and low memory footprint using Quarkus with GraalVm (native compilation) inside a docker container based on the minimal image "FROM SCRATCH".

See this article https://medium.com/@yannalbou/faster-lower-better-with-quarkus-in-k8s-83185af46f36

## Quarkus & Graalvm
This lab is based on Quarkus: https://quarkus.io/

Quarkus is on open-source set of technologies adapted to GraalVM and HotSpot to write Java applications. It offers (promise) a super-fast startup time and a lower memory footprint. This makes it ideal for containers and serverless workloads. It uses the Eclipse Microprofile (JAX-RS, CDI, JSON-P), a subset of Java EE to build Microservices.

GraalVM is a universal and polyglot virtual machine (JavaScript, Python, Ruby, R, Java, Scala, Kotlin). The GraalVM (specifically Substrate VM) makes possible the ahead-of-time (AOT) compilation, converting the bytecode into native machine code, resulting in a binary that can be executed natively.


## Application

The application is based on https://github.com/quarkusio/quarkus-quickstarts/tree/master/getting-started 
This is a minimal CRUD service exposing a couple of endpoints over REST.
Under the hood, this demo uses:
- RESTEasy to expose the REST endpoints
- REST-assured and JUnit 5 for endpoint testing



