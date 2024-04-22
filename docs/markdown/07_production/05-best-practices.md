<!-- .slide:-->

# Les "Best practices"
Les *Best Pratices* relative à **Terraform** sont plus un condensé provenant de diverses sources telles que le site officiel d'**Hashicorp**, d'**AWS** ou d'**Azure** et recommandent les éléments suivants :
* Structurer la configuration
* Backend S3
* Vérouiller le fichier d'état
* Démarrer Terraform avec l'option -var-file
* Chiffrer les identifiants
* Produire du code humainement lisible
* Extraire les métadatas
* Préférer les chemins de fichiers au bloc *Inline*
* Tagger les ressources
* Limiter le nombre de ressources par déploiment

Notes:
Structurer la configuration à l'aide des fichiers main.tf (pour les appels de modules), variables.tf et outputs.tf.
Backend S3, vérouillage du fichier d'état et Produire du code humainement lisible afin de ne rien stocker en local et faciliter la collaboration entre équipes.
Démarrer Terraform avec l'option -var-file afin de détacher les variables.
Chiffrer les identifiants afin d'élever le niveau de sécurité.
Extraire les metadatas en utilisant "terraform_remote_state" afin que chaque donnée qui puisse être récupérée depuis le provider Cloud soit la plus actuelle possible.
Préférer les chemins de fichiers en les intégrant à l'aide de templates réutilisables et modifiable à la volée.
Tagger les ressources afin de les identifiers le plus facilement possible, dans le cas d'un audit ou pour identifier quelle ressource fait partie de quel projet.
