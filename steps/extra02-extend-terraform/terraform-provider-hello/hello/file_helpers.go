package hello

import (
	"fmt"

	"github.com/hashicorp/terraform/helper/schema"
)

func generateContent(d *schema.ResourceData, meta interface{}) string {
	// Get provider informations
	p := meta.(*identity)

	// Get arguments
	name := d.Get("name").(string)

	content := fmt.Sprintf("Hello %s, i'm %s@%s", name, p.Nickname, p.Hostname)
	return content
}

type resourceHelloFileIDStringInterface interface {
	Id() string
}

func resourceHelloFileIDString(d resourceHelloFileIDStringInterface) string {
	id := d.Id()
	if id == "" {
		id = "<new resource>"
	}
	return fmt.Sprintf("helloFile (ID = %s)", id)
}
