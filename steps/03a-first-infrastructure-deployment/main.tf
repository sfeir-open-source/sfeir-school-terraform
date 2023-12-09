resource "google_compute_instance" "tf_instance" {
  // Add properties to create a compute engine instance
}

/* Uncomment when instance is correctly deployed
*
* resource "google_compute_firewall" "allow-iap" {
*   // Create a firewall rule to allow traffic from "35.235.240.0/20" on all ports
*
*   lifecycle {
*     create_before_destroy = true
*   }
* }
*/
