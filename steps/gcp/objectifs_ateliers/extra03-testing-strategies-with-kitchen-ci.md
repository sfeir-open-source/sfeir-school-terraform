# Extra 03 - Tests avec Kitchen-CI et InSpec

Dossiers : `extra03-testing-strategies-with-kitchen-ci/` et `-solution/`

## Attendu

- Outils installés via Bundler (`Gemfile`).
- Zone DNS privée Cloud DNS (`google_dns_managed_zone`), API `dns.googleapis.com` activée par `google_project_service`.
- Variable `gcp_project` et outputs `gcp_project`, `zone_name`.
- `.kitchen.yml` + fixtures, `bundle exec kitchen test` OK.
- Profil InSpec (`inspec-gcp`) vérifiant la zone, puis branché sur Kitchen via `attrs_outputs`.
- Extra : `inspec-iggy` génère des contrôles depuis le state.

## À insister

- Positionnement : ici le test est externe et sur de vraies ressources, contrairement au module 05 (natif, mocké).
- Cycle Kitchen : `create` -> `converge` -> `verify` -> `destroy`.
- Les outputs Terraform servent de contrat entre l'infra et les tests.
- `depends_on` sur l'activation d'API : sans lui, course entre l'activation et la création de la zone.
- `disable_on_destroy = false` : ne pas désactiver l'API du projet partagé.

## Pièges

- Gems Ruby : conflits de versions, `bundle install` long. Préparer l'environnement avant la session.
- Starter : `variables.tf` vide alors que `outputs.tf` référence `var.gcp_project`, l'étudiant doit déclarer la variable.
- Zone privée rattachée au réseau `default` : `network_url` dépend du projet.
- Kitchen et InSpec orientés Chef : écosystème en perte de vitesse, à situer face à Terratest et `terraform test`.
