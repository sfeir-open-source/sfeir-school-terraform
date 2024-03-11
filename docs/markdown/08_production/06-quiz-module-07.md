<!-- .slide: -->

# QUIZZ

<br/>

*Question* : Lors de l’utilisation de terraform taint, que se passe-t-il pour les ressources qui dépendent de la ressource à recréer ?

<br/>

1. Elles sont recréées
2. Elles sont modifiées
3. Cela dépend des attributs de la dépendance (recréées ou modifiées)
4. Rien


##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Lors de l’utilisation de terraform taint, que se passe-t-il pour les ressources qui dépendent de la ressource à recréer ?

<br/>

1. Elles sont recréées
2. Elles sont modifiées
3. **Cela dépend des attributs de la dépendance (recréées ou modifiées)**
4. Rien

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Quelle réponse est une alternative aux workspace ?

<br/>

1. Supprimer le terraform.tfstate local puis redéployer dans le bon environnement
2. Utiliser des buckets ou des préfixes différents
3. Ne pas utiliser de remote backend
4. Utiliser Terraform Cloud


##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Quelle réponse est une alternative aux workspace ?

<br/>

1. Supprimer le terraform.tfstate local puis redéployer dans le bon environnement
2. **Utiliser des buckets ou des préfixes différents**<br/>
<span style="color:green">Oui à condition d’effacer le dossier .terraform entre chaque run<span>
3. Ne pas utiliser de remote backend
4. **Utiliser Terraform Cloud**<br/>
<span style="color:green">Terraform Cloud connecte le VCS à son propre mécanisme de CD, il n’est plus nécessaire de créer un pipeline de CD.</span>


##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Une nouvelle fonctionnalité est disponible chez mon Cloud Provider mais pas dans mon provider Terraform, quelles sont mes solutions ?

<br/>

1. Modifier le provider officiel
2. Créer mon propre provider
3. Contribuer


##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Une nouvelle fonctionnalité est disponible chez mon Cloud Provider mais pas dans mon provider Terraform, quelles sont mes solutions ?

<br/>

1. Modifier le provider officiel
2. **Créer mon propre provider**
3. **Contribuer**

<span style="color:green">Il est important de ne pas diverger de l’upstream car les provider terraform évoluent quotidiennement</span>
