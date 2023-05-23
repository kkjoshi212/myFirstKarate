# Feature: sample karate test script
#   for help, see: https://github.com/karatelabs/karate/wiki/IDE-Support

#   Background:
#     * url 'https://jsonplaceholder.typicode.com'

#   Scenario: get all users and then get the first user by id
#     Given path 'users'
#     When method get
#     Then status 200

#     * def first = response[0]

#     Given path 'users', first.id
#     When method get
#     Then status 200

#   Scenario: create a user and then get it by id
#     * def user =
#       """
#       {
#         "name": "Test User",
#         "username": "testuser",
#         "email": "test@user.com",
#         "address": {
#           "street": "Has No Name",
#           "suite": "Apt. 123",
#           "city": "Electri",
#           "zipcode": "54321-6789"
#         }
#       }
#       """

#     Given url 'https://jsonplaceholder.typicode.com/users'
#     And request user
#     When method post
#     Then status 201

#     * def id = response.id
#     * print 'created id is: ', id

#     Given path id
#     # When method get
#     # Then status 200
#     # And match response contains user
  

Feature:This is the test get User API


Scenario:Get all users
    Given url 'https://reqres.in/api/users'
    When method get
    Then status 200

Scenario Outline: Get users using by page = <pageNo>
    Given url 'https://reqres.in/api/users?page=<pageNo>'
    When method get
    Then status 200
    * match response.page == <pageNo>
    * match response.data[0].id == 1


    Examples: 
    | pageNo |
    | 1 |
    | 2 |
    | 3 |

Scenario Outline: Get users by ID = <IdNo>
    Given url 'https://reqres.in/api/users?id=<IdNo>'
    When method get
    Then status 200
    * match response.data.email == '<emailId>'
    * match response.data.first_name == '<FirstName>'
    * match response.data.last_name == '<LastName>'

    Examples:
    |IdNo|emailId               |FirstName|LastName|
    |1   |george.bluth@reqres.in|George   |Bluth   |
    |2   |janet.weaver@reqres.in|Janet    |Weaver  |
    |3   |emma.wong@reqres.in   |Emma     |Wong    |

Scenario Outline: Update users by ID = <IdNo>
        Given url 'https://reqres.in/api/users/<IdNo>'
        And request
        """ 
            {
                "id" : "<IdNo>",
                "email" : "<emailId>",
                "first_name": "<FirstName>",
                "last_name" : "<LastName>"
            }
        """
        And header Accept = 'application/json'
        When method put
        Then status 200
        * match response.email == '<emailId>'
        * match response.first_name == '<FirstName>'
        * match response.last_name == '<LastName>'
    
        Examples:
        |IdNo|emailId                 |FirstName|LastName|
        |1   |khushboo.joshi@reqres.in|Khushboo |Joshi   |
        |2   |kalpak.joshi@reqres.in  |Kalpak   |Joshi   |
        |3   |aarav.joshi@reqres.in   |Aarav    |Joshi   |

        
    Scenario: Patch user with ID 2
            Given url 'https://reqres.in/api/users/2'
            And request
        """ 
            {
                "id" : "2",
                "email" : "kalpak.joshi@reqres.in",
                "first_name": "The Kalpak",
                "last_name" : "Whose Lastname is Joshi"
            }
        """
        And header Accept = 'application/json'
        When method Patch
        Then status 200
        * match response == "#object"
        * match response.first_name != 'Kalpak'
        * match response.last_name != 'Joshi'




Scenario: Delete user with Id 1
    Given url 'https://reqres.in/api/users/1'
    And header Accept = 'application/json'
     
    When method Delete
    Then status 204
    * match response.first_name == '#null'
    #* match response == {"first_name": "#null"}


Scenario: Register a User
    Given url 'https://reqres.in/api/register'
    And header Accept = 'application/json'
    And request
    """
        {
            "username" = "khushboojoshi"
            "email" = "khushboo.joshi@reqres.in"
            "password" = "abc@12345"
        }
    """
        When method Post
       Then status 200