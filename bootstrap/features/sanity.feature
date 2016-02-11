Feature: Testing the basic endpoint

  @api
  Scenario: Going to /api and verify we have the right endpoint.
    Given I visit "/api"

  @api
  Scenario: Check the nuntius room endpoint.
    Given I create a "room" entity with the settings:
      | title   | privacy | uid |
      | room 1  | 0       | 0   |
      | room 2  | 1       | 1   |
     When I visit "/api/nuntius_rooms"
     Then the json should contain "room 1"
      But the json should not contain "room 2"