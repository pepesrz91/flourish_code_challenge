
# README

## Flourish Reward Engine Code Challenge

To properly run the project, please double check that you have the following versions installed:

**Ruby: 3.0.0** 

**Rails: 6.1.3**

**Bundle: 2.2.13**

#### Run the following commands to install the project libraries correctly:

```bash
$ bundle install && bundle update
```
#### Run the following commands to seed the data base for development
```bash
$  rake db:create && rake db:migrate && rake db:seed
```

#### If proyect was set up correctly the following command should run passing tests
```bash
$ rails test
```

#### Starting up server
```bash
$ rails server
```

## Relational Database Diagram

the following diagram shows each of the table attributes and relationships that were used in the API Models

![Computer Science (2)](https://user-images.githubusercontent.com/19577959/113645199-0cb80700-964c-11eb-94f5-06ebdfd8cc99.jpg)

# Heroku

The application is available at Heroku in the following link:
https://cherry-crumble-54213.herokuapp.com/

# Endpoints

To try out the enpoints in an easier matter consider using [Postman](https://www.postman.com/).
The application has the following endpoints available:

### POST /login 

To use this endpoint please send the following object in JSON body
```json
{
  "username": "dummyuser",
  "password": "DummyPassword"
}
```
The endpoint will response with the following:
```json
{
  "user": {
    "id": 1,
    "username": "dummyuser",
    "password_digest": "$2a$12$K87l3m9wCul8n0P0GyZtjuYcJYe9WlM1xDEGSLzbpWfdJRBUjm1Xe",
    "name": "Dummy",
    "created_at": "2021-04-05T03:36:27.835Z",
    "updated_at": "2021-04-05T03:36:27.835Z",
    "bank_id": 1
  },
  "token": "eyJhbGciOiJIUzI1NiJ9.....z2qv0J5uwNR4HpY_se9Pi8"
}
```
**IMPORTANT: You must use the return token in Authentication on the request headers for the following enpoints**

Add the token string prefixed with **Bearer** in the Authorization header like the following example:

```json
{
  "Authentication" : "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.xgqa8Ok2teY00lQnlMCUgz2qv0J5uwNR4HpY_se9Pi8"
}
```

### POST /api/v1/user_events

This is the main endpoint. it will respond to the following events:
* UserAuthenticated
* UserPaidBill
* UserMadeDepositIntoSavingsAccount

The body that the endpoint expects is the following:
```json
{
  "type": "UserPaidBill", 
  "amount": 300
}
```
**Notice: **amount** is required only in UserPaidBill and UserMadeDepositIntoSavingsAccount** 

The response of each event will return the **reward_manager** record which is responsible of managing the user's points, 
streaks and badges.

The response will look something like the following:
```json
{
    "data": {
        "reward_manager": {
            "login_streak": 1,
            "id": 1,
            "points": 2000,
            "badges": [],
            "created_at": "2021-04-05T03:36:27.921Z",
            "updated_at": "2021-04-05T06:10:08.739Z",
            "user_id": 1
        },
        "message": "UserAuthenticated event handled successfully"
    }
}
```
### GET /api/v1/rewards

This endpoint only needs the JWT token passed into Authentication header when doing the request.
It will return the available rewards for the authenticated user.

```json
{
"data":{
    "message":"Available rewards",
    "available_rewards":[
        {
        "id":1,
        "name":"2 Movie Tickets",
        "price":1500,
        "created_at":"2021-04-05T03:36:27.172Z",
        "updated_at":"2021-04-05T03:36:27.172Z",
        "bank_id":1
        },
        {
        "id":2,
        "name":"Free Massage",
        "price":1000,
        "created_at":"2021-04-05T03:36:27.212Z",
        "updated_at":"2021-04-05T03:36:27.212Z",
        "bank_id":1
        }
      ]
    }
}

```

### POST /api/v1/user/redeems
This endpoint needs a **reward_id** property to be sent into the request to be sent into the request. 
With the JWT the user id is available so that is the reason a /api/v1/:user_id/reedems was not used, but it could be the case
or the expected functionality to use that endpoint to redeem a user reward in a more agnostic matter. 

```json
{
  "reward_id": 1
}
```
The response will be the following:
```json
"data": {
        "message": "Reward redeemed!",
        "reward_manager": {
            "points": 0,
            "id": 1,
            "login_streak": 1,
            "badges": [],
            "created_at": "2021-04-05T03:36:27.921Z",
            "updated_at": "2021-04-05T14:40:00.703Z",
            "user_id": 1
        },
        "user_redeemed_reward": {
            "id": 2,
            "name": "Free Massage",
            "price": 1000,
            "created_at": "2021-04-05T03:36:27.212Z",
            "updated_at": "2021-04-05T03:36:27.212Z",
            "bank_id": 1
        }
    }
```

## Other Notes
* TDD was used during the entire project, there is still various tests that can be applied. (There is never enough testing)
* JWT approach was used because of the security context there must be with regards the banking system
* Badges: The rule when a user saved money and received 1000 points if its current savings balance was over 100 
  was transformed into a badge that can only be one once. The reason behind this is that if a user makes even small deposits 
  he will be winning everytime 1000 points, which probably cause issues in the long run.
* The Badge mentioned above is won using a FakeApi which is declared very explicitly in the code because a better approach
  must be implemented. The FakeApi will return an array of bank accounts based if the user id is even or odd. There is
  one test that is currently failing due to this arbitration, just to keep note. 
  

  
## Available users with passwords

#### User 1
username: dummyuser

password: DummyPassword

#### User 2
username: jessica2021

password: CoolestPassword

#### User 3
username: pedro2021

password: CoolestPassword

#### User 4
username: pepesrz

password: SuperSecurePassword

## Future Improvements

* Integration testing.
* Better Api mocks for development, testing and production environments.
* For a more advanced event driven architecture an implementation of [Rails Event Store](https://railseventstore.org/)
  would be a interesting approach for the exercise.
* Better Ruby implementation: Some functions are a little to large with regards ruby code conventions, so doing refactor
  will improve the readability of the code. 
