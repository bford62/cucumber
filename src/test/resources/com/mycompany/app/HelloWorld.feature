Feature: First Hello World

  @hello @XT-93
  Scenario Outline: First Hello World
    Given I have "<task>" task
    And Step from "<scenario>" in "<file>" feature file
    When I attempt to solve it
    Then I surely succeed
    Examples:
      | task  | scenario     | file          |
      | first | First Hello | First Feature |