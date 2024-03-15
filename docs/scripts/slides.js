import { SfeirThemeInitializer } from '../web_modules/sfeir-school-theme/sfeir-school-theme.mjs';

// One method per module
function schoolSlides() {
  return ['00-school/00-TITLE.md', '00-school/speaker-jna.md','00-school/speaker-mda.md','00-school/speaker-ame.md','00-school/speaker-lbi.md','00-school/speaker-adh.md','00-school/planning.md'];
}

function introSlides() {
  return ['01_intro/00-TITLE.md', '01_intro/01-terraform-hashicorp.md', '01_intro/02-infra-as-code.md'];
}

function premiersPasSlides() {
  return ['02_premiers_pas/00-TITLE.md', '02_premiers_pas/01-installation.md', '02_premiers_pas/02-hcl-language.md', '02_premiers_pas/03-terraform-commands.md', '02_premiers_pas/04-quiz-module-02.md', '02_premiers_pas/05-lab-module-02.md'];
}

function HclBasique() {
  return ['03_hcl_basics/00-TITLE.md', '03_hcl_basics/01-hcl-advanced.md', '03_hcl_basics/02-variables.md', '03_hcl_basics/03-providers.md', '03_hcl_basics/04-resources.md', '03_hcl_basics/05-outputs.md', '03_hcl_basics/06-datasources.md', '03_hcl_basics/07-modules.md', '03_hcl_basics/08-settings.md', '03_hcl_basics/09-quiz-module-03.md', '03_hcl_basics/10-lab-module-03.md'];
}

function HclExtended() {
  return ['04_hcl_extended/00-TITLE.md', '04_hcl_extended/11-hcl-extended.md', '04_hcl_extended/12-loops.md', '04_hcl_extended/13-conditions.md', '04_hcl_extended/14-dynamics.md', '04_hcl_extended/15-quiz-module-04.md', '04_hcl_extended/16-lab-module-04.md'];
}

function configurationSlides() {
  return ['05_configuration/00-TITLE.md', '05_configuration/01-tooling.md', '05_configuration/02-project-structure.md', '05_configuration/03-quiz-module-04.md', '05_configuration/04-lab-module-04.md'];
}

function strategieTestsSlides() {
  return ['06_testing/00-TITLE.md', '06_testing/01-overview.md', '06_testing/02-examples-aws.md', '06_testing/03-quiz-module-05.md', '06_testing/04-lab-module-03.md'];
}

function travailCoopSlides() {
  return ['07_coop/00-TITLE.md', '07_coop/01-modules-dev.md', '07_coop/02-modules-dev-examples-gcp.md', '07_coop/03-state-file.md', '07_coop/04-storing-secrets.md', '07_coop/05-templating.md', '07_coop/06-quiz-module-06.md', '07_coop/07-lab-module-07.md'];
}

function productionSlides() {
  return ['08_production/00-TITLE.md', '08_production/01-production-usage.md', '08_production/02-continuous-delivery.md', '08_production/03-terraform-cloud.md', '08_production/04-provider-dev.md', '08_production/05-best-practices.md', '08_production/06-quiz-module-07.md', '08_production/07-lab-module-07.md', '08_production/08-exam-resources.md'];
}


function formation() {
  return [
    //
    ...schoolSlides(),
    ...introSlides(),
    ...premiersPasSlides(),
    ...HclBasique(),
    ...HclExtended(),
    ...configurationSlides(),
    ...strategieTestsSlides(),
    ...travailCoopSlides(),
    ...productionSlides()
  ].map(slidePath => {
    return {path: slidePath};
  });
}

SfeirThemeInitializer.init(formation);