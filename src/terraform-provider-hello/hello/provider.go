package hello

import (
	"github.com/hashicorp/terraform/helper/schema"
	"github.com/hashicorp/terraform/terraform"
)

func Provider() terraform.ResourceProvider {
	return &schema.Provider{
		Schema: map[string]*schema.Schema{
			"nickname": &schema.Schema{
				Type:     schema.TypeString,
				Required: true,
				DefaultFunc: schema.MultiEnvDefaultFunc([]string{
					"NICKNAME",
				}, ""),
			},
		},
		ResourcesMap: map[string]*schema.Resource{
			"hello_file": resourceHelloFile(),
		},
		ConfigureFunc: providerConfigure,
	}
}

type identity struct {
	Nickname string
	Hostname string
}

func providerConfigure(d *schema.ResourceData) (interface{}, error) {
	nickname := d.Get("nickname").(string)

	// Add a property hostname on the provider attributes

	return &identity{Nickname: nickname, Hostname: hostname}, err
}
