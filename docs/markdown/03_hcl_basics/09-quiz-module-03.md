<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Comment assigner des valeurs aux variables lors de l'exécution d’une action terraform (plan, apply ou destroy) ?

<br/>

1. terraform <action> -var ‘key=value’
2. terraform <action> -var-file ‘path_to_file’
3. export KEY=value; terraform \<action>
4. export TF_VAR_key=value; terraform \<action>
5. en ajoutant un fichier *.auto.tfvars dans le répertoire courant

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Comment assigner des valeurs aux variables lors de l'exécution d’une action terraform (plan, apply ou destroy) ?

<br/>

1. **terraform <action> -var ‘key=value’**
2. **terraform <action> -var-file ‘path_to_file’**
3. export KEY=value; terraform \<action>
4. **export TF_VAR_key=value; terraform \<action>**
5. **en ajoutant un fichier *.auto.tfvars dans le répertoire courant**

Attention, l’ordre des variables à une importance. Les CLI sont toujours prioritaires. En cas de conflit, le dernier argument prévaut (sauf dans le cas d’une map où les clefs différentes sont fusionnées)


Notes:
Values passed within definition files or with -var will take precedence over TF_VAR_ environment variables, as environment variables are considered defaults.

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : A quoi sert la chaîne de caractères qui suit le type d’une ressource ?

<br/>

1. à définir le “display name” de l’objet créé sur la plateforme
2. à identifier la ressource pour la manipuler dans Terraform
3. ce n’est pas encore utilisé
4. à remplacer l’UID de la ressources si elle est définie

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : A quoi sert la chaîne de caractères qui suit le type d’une ressource ?

<br/>

1. à définir le “display name” de l’objet créé sur la plateforme
2. **à identifier la ressource pour la manipuler dans Terraform**
3. ce n’est pas encore utilisé
4. à remplacer l’UID de la ressources si elle est définie


##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Quel est le comportement de Terraform lors du prochain apply si une ressource a été commentée depuis le dernier apply ?

<br/>

1. Rien, il n’y a pas de changement des attributs
2. Terraform va supprimer la ressource
3. Terraform va ignorer la ressource
4. Une erreur à la compilation

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Quel est le comportement de Terraform lors du prochain apply si une ressource a été commentée depuis le dernier apply ?

<br/>

1. Rien, il n’y a pas de changement des attributs
2. **Terraform va supprimer la ressource**
3. Terraform va ignorer la ressource
4. Une erreur à la compilation

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Quelle est la particularité d'une variable de type *object* ?

<br/>

1. Le résultat est toujours ordonné
2. Ce n'est pas la plus utilisée
3. Peut contenir de nombreux types différents

##==##
<!-- .slide: -->

# QUIZZ

<br/>

*Question* : Quelle est la particularité d'une variable de type *object* ?

<br/>

1. Le résultat est toujours ordonné
2. Ce n'est pas la plus utilisée
3. **Peut contenir de nombreux types différents**
