Feature: customer submit project idea
    As a customer
    So that the class can work on my idea
    I want to submit my project idea

Background: on customer project submit page
    Given I am in the project submit page
    
Scenario:
    When I input my project title: "Awesome Project"
    And I input my project content: "Not really so awesome."
    And I press "Submit Project"
    Then I should be in the project details page
    And I should see "Awesome Project"
    And I should see "Not really so awesome."