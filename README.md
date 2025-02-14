# Project U

This is a project to manage a contact list.
These are the features for the project:
- The user is able to:
  - he can subscribe himself to use the platform
  - recover your password throughout his email
  - login and logout
  - manage your contact list
  - search addresses as a helper while subscribes contacts  
  - delete his account

* To run this project correctly you need to load two environment variables: 
  * GOOGLE_API_KEY = your google api key 
  * JWT_SECRET_KEY = a key to create jwt tokens

### How to run in development

First, up the dependencies services:

```bash
make dependencies.start.dev
```

Inside project directory do:

- bundle install
- RAILS_ENV=development bundle e rails db:create
- RAILS_ENV=development bundle e rails db:migrate
- GOOGLE_API_KEY=change_it JWT_SECRET_KEY=change_it RAILS_ENV=development bundle e rails s -p 8000

### How to run tests

First, up the dependencies services:

```bash
make dependencies.start.test
```

Then inside backend project directory do:

- bundle install
- RAILS_ENV=test bundle e rails db:create
- RAILS_ENV=test rails db:migrate
- bundle e rspec

### To run Lints for this project

- make rubocop

### Api

Registers User  
POST /signup: /api/v1/users/signup  
Body:  
```json
{
  "name": "user 1",
  "email": "user1@gmail.com",
  "password": "123456",
  "password_confirmation": "123456"
}
```
possible responses:  

200 - OK
```json
{
  "id": "3f0cae27-359a-4ee9-b736-eced9141c711",
  "name": "user 1",
  "email": "user1@gmail.com",
  "created_at": "2024-07-07T20:39:48.123Z",
  "updated_at": "2024-07-07T20:39:48.123Z"
}
```
---

Login  
POST /login: /api/v1/users/login  
Body:  
```json
{
    "user": {
        "email": "user1@gmail.com",
        "password": "123456"
    }
}
```
possible responses:  

200 - OK  
headers { authorization: ' Bearer token' }

401 - Unauthorized
```json
{
    "error": "Invalid Email or password."
}
```

---

Requests for reset password  
POST /api/v1/users/password  
Body:  
```json
{
    "user": {
        "email": "user1@gmail.com"
    }
}
```

possible responses:

200 - OK
```json
{
    "message": "Request successful"
}
```

404 - Not Found

---

Update Password  
PUT api/v1/users/password  
Body:  
```json
{
    "user": {
        "reset_password_token": "token_that_has_been_sent_by_email",
        "password": "new-password",
        "password_confirmation": "new-password"
      }
}
```
possible responses:  

200 - OK

404 - Not Found

---

Get All Contacts  
GET /api/v1/contacts?user_id={user_id}&page={page_number}&name={name}&cpf={cpf}  
header: { Authorization:  Bearer token_Bearer }  
possible responses:  

200 - OK:
```json
[
    {
        "id": "ab511532-6a30-4880-bb0f-46da8f292707",
        "name": "Leo",
        "cpf": "08842231190",
        "phone": "21999999999",
        "user_id": "792be5a7-21d6-4f84-b1e9-a5bd707ff0db",
        "address": {
            "id": "5b70e150-2749-4625-bb2a-6a654c811385",
            "cep": "58470-090",
            "latitude": "12.0",
            "longitude": "54.0",
            "address": "Rua caxias",
            "uf": "RJ",
            "address_complement": null,
            "contact_id": "ab511532-6a30-4880-bb0f-46da8f292707"
        }
    }
]
```

204 - no content

---

Create Contact  
POST /api/v1/contacts  
header: { Authorization:  Bearer token_Bearer }  
Body:  
```json
  {
  "name": "john",
  "cpf": "24113470065",
  "phone": "21994587125",
  "address": {
    "cep": "20202020",
    "latitude": -22.9156933,
    "longitude": -43.2243139,
    "address": "rua lucio",
    "uf": "rj"
  }
}
```

possible responses:

201 - Created
```json
{
    "name": "john",
    "cpf": "24113470065",
    "phone": "21994587125",
    "address": {
        "cep": "20202020",
        "latitude": -22.9156933,
        "longitude": -43.2243139,
        "address": "rua lucio",
        "uf": "rj"
    }
}
```

422 - Unprocessable Content
```json
  {
    "filed_name": [ "message1", "message2" ]
  }
```

---

Get Possible addresses for auto-complete  
GET /api/v1/addresses/search?uf={state}&city={city}&street={street_name}  
header: { Authorization:  Bearer token_Bearer }  
possible responses:

200 - OK
```json
[
    {
        "cep": "21625-290",
        "logradouro": "Rua Lúcio de Gouveia",
        "complemento": "",
        "unidade": "",
        "bairro": "Parque Anchieta",
        "localidade": "Rio de Janeiro",
        "uf": "RJ",
        "ibge": "3304557",
        "gia": "",
        "ddd": "21",
        "siafi": "6001"
    },
    {
        "cep": "21235-535",
        "logradouro": "Rua Lúcio de Araújo",
        "complemento": "",
        "unidade": "",
        "bairro": "Irajá",
        "localidade": "Rio de Janeiro",
        "uf": "RJ",
        "ibge": "3304557",
        "gia": "",
        "ddd": "21",
        "siafi": "6001"
    }
]
```

---

Get google maps position  
GET /api/v1/addresses/position?address={complete address with space or not}  
example of adress: rua mariz e barros 155, rio de janeiro, rj - brasil  
header: { Authorization:  Bearer token_Bearer }  
possible responses:  

200 - OK
```json
[
    {
        "complete_address": "R. Lúcio de Mendonça, 15 - Maracanã, Rio de Janeiro - RJ, 20270-040, Brasil",
        "latitude": -22.9165171,
        "longitude": -43.22333440000001
    }
]
```

---

Delete user  
DELETE /api/v1/users/{user_id}  
header: { Authorization:  Bearer token_Bearer }  
possible responses:  

204 - No Content

---

Update contacts  
PATCH /api/v1/contacts/{contact_id}  
header: { Authorization:  Bearer token_Bearer }  
possible responses:  

200 - OK / returns only the data that was changed  

```json
{
    "phone": "2199303030"
}
```

---
Delete Contact  
DELETE /api/v1/contacts/{contact_id}  
header: { Authorization:  Bearer token_Bearer }    
possible responses:  

204 - No Content

404 - Not Found


