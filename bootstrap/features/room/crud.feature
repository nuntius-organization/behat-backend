Feature: Testing CRUD for room.

  @api
  Scenario: Check the nuntius room endpoint.
    Given I create a "room" entity with the settings:
      | title   | privacy | uid |
      | room 1  | 0       | 0   |
      | room 2  | 1       | 1   |
    When I visit "/api/nuntius_rooms"
    Then the json should contain "room 1"
     But the json should not contain "room 2"

  @api @create-users
  Scenario: Check audience accessibility to a room.
    Given I create a "room" entity with the settings:
      | title   | privacy | uid         |
      | room 1  | 0       | users:Clark |
      | room 2  | 1       | users:Louis |
    When I am logging in as "Clark"
     And I visit "/api/nuntius_rooms"
     And the json should contain "room 1"
     And the json should not contain "room 2"
    When I am logging in as "Louis"
     And I visit "/api/nuntius_rooms"
    Then the json should contain "room 1"
     And the json should contain "room 2"

  @api @create-users
  Scenario: Check audience accessibility to a room after adding creating
            audience record.
    Given I create a "room" entity with the settings:
      | title | privacy | uid         |
      | room  | 1       | users:Clark |
    When I am logging in as "Louis"
     And I visit "/api/nuntius_rooms"
     And the json should not contain "room"
    Then I create a "audience room" entity with the settings:
      | room_id   | uid         |
      | room:room | users:Louis |
    And I visit "/api/nuntius_rooms"
    And the json should contain "room"