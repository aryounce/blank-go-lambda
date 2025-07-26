package main

import (
	"github.com/aws/aws-lambda-go/lambdacontext"
	"github.com/aryounce/blank-go-lambda/shared/demo"
)

func say_hello(lc *lambdacontext.LambdaContext, to_name string) string {
	response := demo.NewDemoResponse(to_name, lc.AwsRequestID)
	return response.Serialize()
}
