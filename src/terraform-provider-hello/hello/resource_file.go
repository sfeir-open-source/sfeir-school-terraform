package hello

import (
	"log"

	"github.com/hashicorp/terraform/helper/schema"
)

func resourceHelloFile() *schema.Resource {
	return &schema.Resource{
		Create: resourceHelloFileCreate,
		Delete: resourceHelloFileDelete,
		Read:   resourceHelloFileRead,
		Update: resourceHelloFileUpdate,

		Schema: map[string]*schema.Schema{
			"name": &schema.Schema{
				Type:     schema.TypeString,
				Required: true,
			},
			// Add a "path" required attribute where type is string
		},
	}
}

func resourceHelloFileCreate(d *schema.ResourceData, meta interface{}) error {
	log.Printf("[DEBUG] %s: Beginning hello creation", resourceHelloFileIDString(d))

	// Get arguments
	path := d.Get("path").(string)

	// Do job
	content := generateContent(d, meta)

	// Create file
	//
	//
	//

	log.Printf("[DEBUG] %s: Creation of hello complete", resourceHelloFileIDString(d))

	//Save ID
	d.SetId(path)

	//Let read function set all arguments
	return resourceHelloFileRead(d, meta)
}

func resourceHelloFileDelete(d *schema.ResourceData, meta interface{}) error {
	log.Printf("[DEBUG] %s: Reading the required network block", resourceHelloFileIDString(d))

	// Get arguments
	path := d.Get("path").(string)

	// Delete resource
	//
	//

	//Remove tfstate
	d.SetId("")

	log.Printf("[DEBUG] %s: Completed reading network block", resourceHelloFileIDString(d))
	return nil
}

func resourceHelloFileRead(d *schema.ResourceData, meta interface{}) error {
	log.Printf("[DEBUG] %s: Reading the required network block", resourceHelloFileIDString(d))

	// Get arguments
	path := d.Get("path").(string)

	// Read resource
	//
	//
	//

	//Set all HelloFile object properties in the tfstate using regular expression to find "name" value
	//
	//
	//

	d.Set("name" /* name value here */)

	log.Printf("[DEBUG] %s: Completed reading network block", resourceHelloFileIDString(d))
	return nil
}

func resourceHelloFileUpdate(d *schema.ResourceData, meta interface{}) error {
	// Get arguments
	path := d.Get("path").(string)

	content := generateContent(d, meta)

	// Update the file is a value change (erase all file content)
	//
	//
	//

	return nil
}
