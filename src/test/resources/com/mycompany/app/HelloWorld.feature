Feature: karate 'hello world' example

  @hello @XT-93
  Scenario: create and retrieve a cat
    Given url 'http://myhost.com/v1/cats'
    And request { name: 'Billie' }
    When method post
    Then status fail
    And match response == { id: '#notnull', name: 'Billie' }

    Given path response.id
    When method get
    Then status pass

  