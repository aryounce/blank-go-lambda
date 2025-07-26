package main

import (
	"context"
	"encoding/json"

	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-lambda-go/lambdacontext"
)

func lambda_handler(ctx context.Context, event json.RawMessage) (string, error) {
	lc, _ := lambdacontext.FromContext(ctx)
	return say_hello(lc, lc.InvokedFunctionArn), nil
}

func main() {
	lambda.Start(lambda_handler)
}
