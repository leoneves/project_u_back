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

### How to run in development

First, up the dependencies services:

```bash
make dependencies.start.dev
```

Inside project directory do:

- bundle install
- RAILS_ENV=development bundle e rails db:create
- RAILS_ENV=development bundle e rails db:migrate
- RAILS_ENV=development bundle e rails s -p 8000

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

POST /signup: /api/v1/users/signup
```json
{
  "name": "user 1",
  "email": "user1@gmail.com",
  "password": "123456",
  "password_confirmation": "123456"
}
```

---

POST /login: /api/v1/users/login

---

GET /api/v1/contacts?user_id={user_id}&page={page_number}&name={name}&cpf={cpf}  
possible responses:

200 - ok:
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
