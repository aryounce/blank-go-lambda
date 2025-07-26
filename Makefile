#
# It is recommended that you copy (not clone) this project into a git repo of your
# own creation.
#

#
# This Makefile attempts to only utilize the intersection of features available
# in `make` on both Linux and macOS. No attempt has been made to support Windows
# Subsystem for Linux.
#

.PHONY: setup build clean aws-sdk

.DEFAULT_GOAL := build-local

#
# Disable linking with libc on Linux. This covers the case of cross-compilation
# targeting Linux and may interfere with the use of certain dependencies. See,
# also: https://github.com/aws/aws-lambda-go?tab=readme-ov-file#using-cgo
#
export CGO_ENABLED := 0

#
# Explictly declare the default behavior for the build architecture so that it
# may be overridden.
#
export GOARCH ?= $(shell uname -m)

# AWS Lambda runs exclusively on Amazon Linux 2 so this needs to be uncommented
# when cross-compiling for deployment to Lambda.
#export GOOS := "linux"

setup:
	@go mod tidy

#
# Builds (potentially cross-compiled) binaries for deployment to AWS Lambda.
# Since AWS Lambda runs exclusively on Amazon Linux 2 the depolyment build must
# target that operating system.
#
build: export GOOS = linux
build: $(wildcard lambdas/*)
	@mkdir -p dist
	go build -o dist/$(patsubst lambdas/%,%,$<) $</*.go

#
# Builds binaries for the local machine to allow for dev testing.
#
build-local: $(wildcard lambdas/*)
	@mkdir -p dist
	go build -o dist/$(patsubst lambdas/%,%,$<)-$(shell uname -s)-$(GOARCH) $</*.go

clean:
	rm -rf dist

aws-sdk: setup
	go get github.com/aws/aws-sdk-go
	go get github.com/aws/aws-lambda-go/lambda

#
# Shortcut to rename the Go module (in `go.mod`) for your copy of this repo.
#
mod-reinit:
	go mod edit -module $(shell read -r -p 'Enter updated Go module name: ' new_name && echo $${new_name})
	@go mod edit -fmt
