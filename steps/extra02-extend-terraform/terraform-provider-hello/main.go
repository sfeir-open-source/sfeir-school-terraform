package main

import (
	"terraform-provider-hello/hello"

	"github.com/hashicorp/terraform/plugin"
)

func main() {
	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: hello.Provider})
}
