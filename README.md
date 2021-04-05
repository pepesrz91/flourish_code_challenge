
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

## Relational Database Diagram

the following diagram shows each of the table attributes and relationships that were used in the API Models

![Computer Science (1) (1)](https://user-images.githubusercontent.com/19577959/113541152-4551d500-95a7-11eb-8e36-a7cc2544c089.jpg)


## Heroku

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

Add the <mark>token</mark> string and send in Authentication Header prefixed with <marker>Bearer</marker> followed by a space
like the following example:

```json
{
  "Authentication" : "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.xgqa8Ok2teY00lQnlMCUgz2qv0J5uwNR4HpY_se9Pi8"
}
```

### POST api/v1/user_events

This is the main endpoint it will respond to the following events
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

The response of each event will return the reward_manager record which is responsible of managing the user's points, 
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
GET /api/v1/rewards

This endpoint only need the JWT token passed into Authentication header when doing the request.
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

GET /api/v1/user/redeems
This endpoint need a reward_id property to be sent into the request to be sent into the request. 
With the JWT the user id is available so that is the reason a /api/v1/:user_id/reedems was not used, but it could be the case
or the expected functionality to use that endpoint to redeem a user reward in a more agnositc matter. 

```json
{
  "reward_id": 1
}
```

## Other Notes
TDD was used during the entire project, there is still various tests that can be applied.
JWT approach was used 