
<!-- README.md is generated from README.Rmd. Please edit that file -->

# observatoire

<!-- badges: start -->

[![R build
status](https://forge.thinkr.fr/promotionsante/observatoire/badges/main/pipeline.svg)](https://forge.thinkr.fr/promotionsante/observatoire/-/pipelines)
[![Codecov test
coverage](https://forge.thinkr.fr/promotionsante/observatoire/badges/main/coverage.svg)](https://forge.thinkr.fr/promotionsante/observatoire/commits/main)
<!-- badges: end -->

Ce projet a pour but de rendre accessible et valoriser les données
d’investissement dans la promotion de la santé et de la prévention des
maladies en Suisse est l’objectif de Promotion Santé Suisse. Fournir une
plateforme de cette nature permettra à Promotion Santé Suisse de donner
à voir les actions qu’ils coordonnent.

## Développeur

### Déploiement

L’application est déployée en continue sur le compte
prevention.shinyapps.io appartenant à Promotion Santé Suisse.

- La branche `main` sur
  <https://prevention.shinyapps.io/observatoire-dev/>
- La branche `production` sur
  <https://prevention.shinyapps.io/observatoire/>

### Variables d’Environement

Il est nécessaire de définir deux variables d’environement dans gilab CI
ou dans `~/.Renviron` pour déployer en local.

- `SHINYAPPS_IO_TOKEN`
- `SHINYAPPS_IO_SECRET`

Les valeurs se trouvent dans <https://www.shinyapps.io/admin/#/tokens>.
Il vous faudra ensuite cliquer sur `Show` pour voir les deux variables.

### Debug

Pour déployer l’app manuellement il est possible d’utiliser directement
le script utilisé par gitlab CI `dev/deploy_app.R` dans votre
environement de développement.
