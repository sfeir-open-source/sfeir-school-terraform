package hello

import (
	"log"

	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
)

func resourceHelloFile() *schema.Resource {
	return &schema.Resource{
		Create: resourceHelloFileCreate,
		Delete: resourceHelloFileDelete,
		Read:   resourceHelloFileRead,
		Update: resourceHelloFileUpdate,

		Schema: map[string]*schema.Schema{
			"name": {
				Type:     schema.TypeString,
				Required: true,
			},
			// Add a "path" required attribute where type is string (a new path must recreate the file)
		},
	}
}

func resourceHelloFileCreate(d *schema.ResourceData, meta interface{}) error {
	log.Printf("[DEBUG] %s: Beginning hello creation", resourceHelloFileIDString(d))

	// Get arguments
	path := d.Get("path").(string)

	// Do job
	content := generateContent(d, meta)

	// Create file (see os.WriteFile)
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
	log.Printf("[DEBUG] %s: Beginning hello deletion", resourceHelloFileIDString(d))

	// Get arguments
	path := d.Get("path").(string)

	// Delete resource (see os.Remove)
	//
	//

	//Remove tfstate
	d.SetId("")

	log.Printf("[DEBUG] %s: Deletion of hello complete", resourceHelloFileIDString(d))
	return nil
}

func resourceHelloFileRead(d *schema.ResourceData, meta interface{}) error {
	log.Printf("[DEBUG] %s: Reading hello file", resourceHelloFileIDString(d))

	// Get arguments
	path := d.Get("path").(string)

	// Read resource (see os.ReadFile)
	// If the file does not exist anymore, remove it from the state with d.SetId("")
	//
	//

	//Set all HelloFile object properties in the tfstate using regular expression to find "name" value
	//
	//
	//

	d.Set("name" /* name value here */)

	log.Printf("[DEBUG] %s: Completed reading hello file", resourceHelloFileIDString(d))
	return nil
}

func resourceHelloFileUpdate(d *schema.ResourceData, meta interface{}) error {
	// Get arguments
	path := d.Get("path").(string)

	content := generateContent(d, meta)

	// Update the file if a value changes (erase all file content)
	//
	//
	//

	return resourceHelloFileRead(d, meta)
}
