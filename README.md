# Blank Go Lambda Template

This is a starter template for AWS Lambda functions written in Golang.

## Setup

Two steps are recommended to get started:

1. Export (do not clone) this project, or use it as a repo template, into a new
   git repository.
2. Run `make mod-reinit` to rename the Go module for your project (in `go.mod`).

## Building

Targets for both local builds and Amazon Linux are supplied.

### Local Builds

```make build-local```

This will create binaries under `dist/` named after the host operating system
and architecture. They are primarily for use in cases when the Go program's
entrypoint handles both invocation via Lambda (and some form of AWS Lambda emulation
is being used) or the binary doubles as a CLI utility that accepts arguments.

### Deployment Builds

```make build```

This creates binaries under `dist/` that are appropriate for deployment to AWS.

> [!IMPORTANT]
>
> *Build artifact file names:* when deploying a Go binary as a Lambda function one must rename
> the executable file to `bootstrap`. For more about handler naming conventions for Go Lambdas see:
> [Building with Go > Handler naming conventions](https://docs.aws.amazon.com/lambda/latest/dg/golang-handler.html#golang-handler-naming)
> in the AWS Lambda documentation.

## Updating the AWS SDKs

Using `make aws-sdk` will update the versions of the AWS Go SDK and the AWS Lambda for Go
SDK that the project's Go module references.

# TODO

- Demonstrated references to the shared module.
