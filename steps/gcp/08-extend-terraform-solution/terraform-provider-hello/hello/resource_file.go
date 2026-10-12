package hello

import (
	"fmt"
	"log"
	"os"
	"regexp"

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
			"path": {
				Type:     schema.TypeString,
				Required: true,
				ForceNew: true,
			},
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
	if err := os.WriteFile(path, []byte(content), 0644); err != nil {
		return err
	}

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

	// Delete resource
	if err := os.Remove(path); err != nil && !os.IsNotExist(err) {
		return err
	}

	//Remove tfstate
	d.SetId("")
	log.Printf("[DEBUG] %s: Deletion of hello complete", resourceHelloFileIDString(d))
	return nil
}

func resourceHelloFileRead(d *schema.ResourceData, meta interface{}) error {
	log.Printf("[DEBUG] %s: Reading hello file", resourceHelloFileIDString(d))

	// Get arguments
	path := d.Get("path").(string)

	// Read resource
	content, err := os.ReadFile(path)
	if os.IsNotExist(err) {
		// File deleted outside of Terraform: remove it from the state to recreate it
		d.SetId("")
		return nil
	}
	if err != nil {
		return err
	}

	//Set all HelloFile object properties in the tfstate
	re := regexp.MustCompile(`^Hello (\w+)`)
	name := re.FindStringSubmatch(string(content))
	if name == nil {
		return fmt.Errorf("unexpected content in %s", path)
	}
	d.Set("name", name[1])

	log.Printf("[DEBUG] %s: Completed reading hello file", resourceHelloFileIDString(d))
	return nil
}

func resourceHelloFileUpdate(d *schema.ResourceData, meta interface{}) error {
	// Get arguments
	path := d.Get("path").(string)

	// Update content
	content := generateContent(d, meta)

	if err := os.WriteFile(path, []byte(content), 0644); err != nil {
		return err
	}

	return resourceHelloFileRead(d, meta)
}
