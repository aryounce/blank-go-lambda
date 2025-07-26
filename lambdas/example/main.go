package main

import (
	"context"
	"encoding/json"

	"github.com/aws/aws-lambda-go/lambda"
)

func lambda_handler(ctx context.Context, event json.RawMessage) (string, error) {
	return say_hello(), nil
}

func main() {
	lambda.Start(lambda_handler)
}
