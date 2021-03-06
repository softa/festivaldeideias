Feature: start a new idea
  In order to
  As a
  I want to start a new idea

  @omniauth_test
  Scenario: when I'm logged in
    Given I'm a logged user
    And I click "Inicie uma ideia"
    Then I should be in "the new idea page"
    Given I fill in "Descreva como quiser, você terá como editar depois." with "O único parâmetro utilizado para o controle dos semáforos da cidade é o tempo..."
    And I fill in "Nomeie sua ideia" with "Semáforos inteligentes"
    And I fill in "Custo de realização" with "1000"
    And I choose "Mobilidade Urbana"
    And I check "Ela será licenciada em Creative Commons Atribuição 3.0 (CC BY 3.0)"
    And I check "Qualquer pessoa poderá compartilhar minha ideia"
    And I check "Qualquer pessoa poderá copiar e modificar minha ideia"
    And I check "Eu li e estou de acordo com o regulamento do Festival de Ideias"
    When I press "Publicar!"
    Then I should be in "the idea's page"

  @omniauth_test
  Scenario: when I'm not logged in
    Given I am in "the homepage"
    And I click "Inicie uma ideia"
    Then I should be in "the login page"
    Given I click "entre com sua conta do Facebook"
    Then I should be in "the new idea page"
    Given I fill in "Descreva como quiser, você terá como editar depois." with "O único parâmetro utilizado para o controle dos semáforos da cidade é o tempo..."
    And I fill in "Nomeie sua ideia" with "Semáforos inteligentes"
    And I fill in "Custo de realização" with "1000"
    And I choose "Mobilidade Urbana"
    And I check "Ela será licenciada em Creative Commons Atribuição 3.0 (CC BY 3.0)"
    And I check "Qualquer pessoa poderá compartilhar minha ideia"
    And I check "Qualquer pessoa poderá copiar e modificar minha ideia"
    And I check "Eu li e estou de acordo com o regulamento do Festival de Ideias"
    When I press "Publicar!"
    Then I should be in "the idea's page"

  @omniauth_test
  Scenario: when I'm troll enough to submit the form empty
    Given I'm a logged user
    And I am in "the new idea page"
    And I check "Ela será licenciada em Creative Commons Atribuição 3.0 (CC BY 3.0) *"
    And I check "Qualquer pessoa poderá compartilhar minha ideia *"
    And I check "Qualquer pessoa poderá copiar e modificar minha ideia *"
    And I check "Eu li e estou de acordo com o regulamento do Festival de Ideias *"
    When I press "Publicar!"
    Then I should see "the description message error"
    And I should see "the title message error"
    And I should see "the category message error"

  @omniauth_test
    Scenario: when I don't really care for ToS's
    Given I'm a logged user
    And I am in "the new idea page"
    And I uncheck "Ela será licenciada em Creative Commons Atribuição 3.0 (CC BY 3.0) *"
    And I uncheck "Qualquer pessoa poderá compartilhar minha ideia *"
    And I uncheck "Qualquer pessoa poderá copiar e modificar minha ideia *"
    And I uncheck "Eu li e estou de acordo com o regulamento do Festival de Ideias *"
    When I press "Publicar!"
    Then I should see "Os termos de compromisso devem ser aceitos"
