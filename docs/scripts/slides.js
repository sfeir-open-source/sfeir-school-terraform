// One method per module
function schoolSlides() {
  return ['00-school/00-TITLE.md', '00-school/speaker-jna.md','00-school/speaker-mda.md','00-school/planning.md'];
}

function introSlides() {
  return ['intro/00-TITLE.md'];
}

function premiersPasSlides() {
  return ['premiers_pas/00-TITLE.md'];
}

function langagesSlides() {
  return ['langages/00-TITLE.md'];
}

function configurationSlides() {
  return ['configuration/00-TITLE.md'];
}

function strategieTestsSlides() {
  return ['strategie_tests/00-TITLE.md'];
}

function travailCoopSlides() {
  return ['travail_coop/00-TITLE.md'];
}

function productionSlides() {
  return ['production/00-TITLE.md'];
}

function formation() {
  return [
    //
    ...schoolSlides(),
    ...introSlides(),
    ...premiersPasSlides(),
    ...langagesSlides(),
    ...configurationSlides(),
    ...strategieTestsSlides(),
    ...travailCoopSlides(),
    ...productionSlides()
  ].map(slidePath => {
    return {path: slidePath};
  });
}

export function usedSlides() {
  return formation();
}
