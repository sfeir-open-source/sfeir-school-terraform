<!-- .slide: class="full-center"-->

# Présentation de l’offre pour les entreprises Terraform Cloud

![](./assets/images/g419a1b557d_2_230.png)

Notes:
liste des features sur :
https://www.hashicorp.com/products/terraform/offerings

##==##
<!-- .slide:-->

# Présentation de l’offre pour les entreprises Terraform Cloud

<iframe src="https://drive.google.com/file/d/1EJYtycVmeLKITPD1y2oGp2pQX2TItfVH/preview" width="80%" height="80%"></iframe>

Notes:
liste des features sur :
https://www.hashicorp.com/products/terraform/offerings


##==##
<!-- .slide:-->

# Présentation des offres

**Terraform Cloud** (Business tiers) fournit les fonctionnalités avancées suivantes :
* plateforme multi-tenant SAAS
* Gestion des Workspace, logs d'audit et des variables de manière sécurisée,
* Intégration native avec les mécanismes MFA d'AWS (sans avoir besoin de passer par des outils tiers, tels OKTA)
* Intégration native avec **Hashicorp Sentinel** (Policy as Code)
* Cost Estimation
<br/><br/>

**Terraform Enterprise** :
* **Terraform Cloud**
* Private installation
* Clustering et Haute Disponibilité

##==##
<!-- .slide: -->

# Sentinel

Sentinel est une fonctionalité disponible à partir de **Terraform Cloud** (Team & Governance) qui permet d'imposer des contraintes d'urbanisation (appelées **policies**).

Exemple : interdire toute création d'un security group AWS permettant la sortie du traffic réseau vers internet
```
import "tfplan/v2" as tfplan

security_groups = filter tfplan.resource_changes as _, rc {
	rc.mode is "managed" and
		rc.type is "aws_security_group" and
		rc.actions is not ["delete"]
}

main = rule {
	all security_groups as _, sg {
		all sg.change.after.egress as egress {
			egress.cidr_blocks not contains "0.0.0.0/0"
		}
	}
}
```


##==##

# Cost Estimation

Dans une approche FinOps, il est interessant lors de chaque déploiement d'estimer l'impact de l'opération avant son déploiement.

Cette fonctionalité est disponible dans le package **Terraform Cloud Team & Governance** (AWS, GCP, Azure uniquement)

![center](./assets/images/cost-estimation-run.png)
