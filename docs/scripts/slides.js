import { SfeirThemeInitializer } from '../web_modules/sfeir-school-theme/sfeir-school-theme.mjs';

// One method per module
function schoolSlides() {
  return ['00-school/00-TITLE.md', '00-school/speaker-jna.md', '00-school/speaker-mda.md', '00-school/speaker-ame.md', '00-school/speaker-lbi.md', '00-school/speaker-adh.md', '00-school/speaker-gar.md' , '00-school/planning.md'];
}

function introSlides() {
  return ['01_intro/00-TITLE.md', '01_intro/01-terraform-hashicorp.md', '01_intro/02-infra-as-code.md'];
}

function premiersPasSlides() {
  return ['02_premiers_pas/00-TITLE.md', '02_premiers_pas/01-installation.md', '02_premiers_pas/02-hcl-language.md', '02_premiers_pas/03-terraform-commands.md', '02_premiers_pas/04-quiz-module-02.md', '02_premiers_pas/05-lab-module-02.md'];
}

function languageHclSlides() {
  return ['03_hcl/00-TITLE.md', '03_hcl/01-hcl-advanced.md', '03_hcl/02-variables.md', '03_hcl/03-providers.md', '03_hcl/04-resources.md', '03_hcl/05-outputs.md', '03_hcl/06-datasources.md', '03_hcl/07-modules.md', '03_hcl/08-settings.md', '03_hcl/09-quiz-module-03a.md', '03_hcl/10-lab-module-03a.md', '03_hcl/11-hcl-extended.md', '03_hcl/12-loops.md', '03_hcl/13-conditions.md', '03_hcl/14-dynamics.md', '03_hcl/15-quiz-module-03b.md', '03_hcl/16-lab-module-03b.md'];
}

function configurationSlides() {
  return ['04_configuration/00-TITLE.md', '04_configuration/01-tooling.md', '04_configuration/02-project-structure.md', '04_configuration/03-quiz-module-04.md', '04_configuration/04-lab-module-04.md'];
}

function strategieTestsSlides() {
  return ['05_testing/00-TITLE.md', '05_testing/01-overview.md', '05_testing/02-examples-aws.md', '05_testing/03-quiz-module-05.md', '05_testing/04-lab-module-05.md'];
}

function travailCoopSlides() {
  return ['06_coop/00-TITLE.md', '06_coop/01-modules-dev.md', '06_coop/02-modules-dev-examples-gcp.md', '06_coop/03-state-file.md', '06_coop/04-storing-secrets.md', '06_coop/05-templating.md', '06_coop/06-quiz-module-06.md', '06_coop/07-lab-module-07.md'];
}

function productionSlides() {
  return ['07_production/00-TITLE.md', '07_production/01-production-usage.md', '07_production/02-continuous-delivery.md', '07_production/03-terraform-cloud.md', '07_production/04-provider-dev.md', '07_production/05-best-practices.md', '07_production/06-quiz-module-07.md', '07_production/07-lab-module-07.md', '07_production/08-exam-resources.md'];
}


function formation() {
  return [
    //
    ...schoolSlides(),
    ...introSlides(),
    ...premiersPasSlides(),
    ...languageHclSlides(),
    ...configurationSlides(),
    ...strategieTestsSlides(),
    ...travailCoopSlides(),
    ...productionSlides()
  ].map(slidePath => {
    return {path: slidePath};
  });
}

SfeirThemeInitializer.init(formation);
