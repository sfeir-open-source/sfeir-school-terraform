package hello

import (
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
)

func Provider() *schema.Provider {
	return &schema.Provider{
		Schema: map[string]*schema.Schema{
			"nickname": {
				Type:        schema.TypeString,
				Optional:    true,
				DefaultFunc: schema.EnvDefaultFunc("NICKNAME", nil),
				Description: "Surnom affiché dans le fichier. Défaut : variable d'environnement NICKNAME.",
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

	// Add a property hostname on the provider attributes (see os.Hostname)

	return &identity{Nickname: nickname, Hostname: hostname}, err
}
