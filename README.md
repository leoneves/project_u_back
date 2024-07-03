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
