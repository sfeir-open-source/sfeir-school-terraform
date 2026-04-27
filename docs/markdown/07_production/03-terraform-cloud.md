<!-- .slide: class="full-center"-->

# Présentation de l'offre pour les entreprises HCP Terraform

![](./assets/images/g419a1b557d_2_230.png)

Notes:
liste des features sur :
<https://www.hashicorp.com/fr/pricing?tab=terraform>

##==##

# Présentation de l'offre pour les entreprises HCP Terraform

<iframe src="https://drive.google.com/file/d/1EJYtycVmeLKITPD1y2oGp2pQX2TItfVH/preview" width="80%" height="80%"></iframe>

Notes:
liste des features sur :
<https://www.hashicorp.com/fr/pricing?tab=terraform>

##==##

# HCP Terraform — Tiers de pricing (2026)

HCP Terraform utilise un modèle de pricing **basé sur les ressources managées (Managed Resources)**

| Tier | Ressources | Concurrent Runs | Prix | Use case |
|------|-----------|-----------------|------|----------|
| **Free** | 500 max | 1 | Gratuit | Dev personnel, petits labs |
| **Essentials** | Illimitées | 3 | $0.10/ressource/mois | Petites équipes |
| **Standard** | Illimitées | 10 | $0.47/ressource/mois | Gouvernance avancée |
| **Premium** | Illimitées | 200 | $0.99/ressource/mois | Entreprise, SSO avancé, audit logs |

Tous les tiers incluent : remote state, VCS integration, private module registry, Sentinel\*, Cost Estimation\*

<small>\* Free tier limité (Sentinel : 1 policy set / 5 policies).</small>

Notes:
Ancien modèle "Team & Governance" / "Business" remplacé par ce modèle en 2026
Free : Sentinel limité à 1 policy set / 5 policies — Standard+ : illimité
Voir : https://www.hashicorp.com/fr/pricing?tab=terraform

##==##
<!-- .slide: class="with-code-bg-dark"-->

# Sentinel — Policy as Code

Sentinel est disponible dans tous les tiers pour imposer des contraintes d'urbanisation appelées **policies** (Free tier limité à 1 policy set et 5 policies, illimité à partir de Standard).

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

Notes:
Sentinel est une policy language développée par HashiCorp
Permet de valider les plans Terraform AVANT apply
Alternatives : OPA/Rego (aussi supporté dans HCP Terraform)
Voir : https://developer.hashicorp.com/sentinel/docs/terraform

##==##

# Cost Estimation — FinOps

Dans une approche FinOps, il est intéressant lors de chaque déploiement d'estimer l'impact de l'opération avant son déploiement.

Cette fonctionnalité est disponible dans tous les tiers HCP Terraform pour les providers suivants :

- AWS (EC2, RDS, S3, Lambda, ECS, EBS, etc.)
- GCP (Compute, Cloud SQL, Cloud Storage, GKE, etc.)
- Azure (VMs, SQL, Storage, App Service, etc.)

![center](./assets/images/cost-estimation-run.png)

Notes:
Cost Estimation montre le delta entre la config actuelle et la nouvelle config
Très utile pour éviter les surprises budgétaires
Voir : https://developer.hashicorp.com/terraform/cloud-docs/workspaces/cost-estimation

##==##

# Terraform Enterprise

**Terraform Enterprise** = HCP Terraform + features pour déploiement private

- Tout ce que propose HCP Terraform
- Private installation (pas SaaS)
- Clustering et Haute Disponibilité (HA)
- Déploiement on-premise ou air-gapped
- Support dédié HashiCorp

Recommandé pour :
- Contraintes compliance strictes (data residency)
- Air-gapped networks
- Équipes très grandes (HA requise)

Notes:
Terraform Enterprise = version on-prem de HCP Terraform
HashiCorp aussi propose une option auto-hosted de HCP Terraform
Voir : https://www.hashicorp.com/products/terraform

