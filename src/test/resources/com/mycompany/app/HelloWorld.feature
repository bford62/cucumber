Feature: First Hello World

  @firsth @hello @XT-93
  Scenario Outline: First Hello World
    Given I have "<task>" task
    And Step from "<scenario>" in "<file>" feature file
    When I attempt to solve it
    But The attempt is not solved
    Then I surely succeed
    Examples:
      | task  | scenario     | file          |
      | first | First Hello | First Feature |