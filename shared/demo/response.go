package demo

import (
	"encoding/json"
	"fmt"
)

type DemoResponse struct {
	Message   string `json:"message"`
	Name      string `json:"name"`
	RequestID string `json:"request_id"`
}

func NewDemoResponse(name string, requestID string) DemoResponse {
	return DemoResponse{
		Message: fmt.Sprintf("Hello, friend. My name is '%s'", name),
		Name: name,
		RequestID: requestID,
	}
}

func (dr *DemoResponse) Serialize() string {
	raw_bytes, err := json.MarshalIndent(dr, "", "  ")

	if err != nil {
		panic("Unable to JSON encode struct DemoResponse")
	}

	return string(raw_bytes)
}
