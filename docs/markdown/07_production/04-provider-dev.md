<!-- .slide: -->

# Développement et utilisation de providers communautaires

<br>

Il est possible de développer ses propres providers en Golang

- Étendre le périmètre aux applications de l’entreprise
- Aider la communauté à supporter d’avantage de produit

##==##

# Développement et utilisation de providers communautaires

https://www.terraform.io/docs/extend/writing-custom-providers.html

<br>

- provider.go : Implémente *func Provider(version string) func() *schema.Provider\*<br>
  Définit les attributs du provider, initialise les connections si nécessaire, vérifie les identifiants.

- resource*name.go : Implément \_func resourceName() \*schema.Resource*<br>
  Définit la structure et les appels APIs à effectuer pour créer l’objet sur le provider

- data_source_name.go : Un data source est une ressource qui n’implémente qu’une fonction READ

##==##

# Développement et utilisation de providers communautaires

## DeepDive du provider Google

Magic-modules de Google est un projet qui consiste à générer automatiquement les ressources Terraform, inspec et ansible depuis le contrat d’API des ressources Google Cloud

<br>

=> https://github.com/GoogleCloudPlatform/magic-modules

<br>

=> https://github.com/terraform-providers/terraform-provider-google
