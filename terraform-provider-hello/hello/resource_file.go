package hello

import (
	"io/ioutil"
	"log"
	"os"
	"regexp"

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
			"path": &schema.Schema{
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
	f, err := os.Create(path)
	if err != nil {
		return err
	}
	defer f.Close()

	_, err = f.Write([]byte(content))
	if err != nil {
		return err
	}

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
	err := os.Remove(path)
	if err != nil {
		return err
	}

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
	content, err := ioutil.ReadFile(path)
	if err != nil {
		return err
	}

	//Set all HelloFile object properties in the tfstate
	re := regexp.MustCompile(`^Hello (\w+)`)
	name := re.FindStringSubmatch(string(content))
	d.Set("name", name[1])

	log.Printf("[DEBUG] %s: Completed reading network block", resourceHelloFileIDString(d))
	return nil
}

func resourceHelloFileUpdate(d *schema.ResourceData, meta interface{}) error {
	// Get arguments
	path := d.Get("path").(string)

	// Update content
	content := generateContent(d, meta)

	f, err := os.OpenFile(path, os.O_WRONLY, 0644)
	if err != nil {
		return err
	}

	f.Truncate(0)
	f.Seek(0, 0)
	_, err = f.Write([]byte(content))
	if err != nil {
		return err
	}

	return nil
}
