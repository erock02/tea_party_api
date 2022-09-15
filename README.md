
## Table of Contents
1. [ Overview. ](#overview)
2. [ Versions. ](#versions)
3. [ Schema ](#schema)
4. [ Setup. ](#setup)
5. [ Endpoints ](#endpoints)
6. [ Technologies ](#technologies)

<a name="overview"></a>
## 1. Overview

**TEA PARTY** This is a Rails API that allows users(customers) to create subscriptions for tea.

<a name="versions"></a>
## 2. Versions
- Ruby 2.7.4
- Rails 5.2.8

<a name="schema"></a>
## 3. Schema
<img width="767" alt="Screen Shot 2022-09-15 at 7 56 48 AM" src="https://user-images.githubusercontent.com/95315216/190437450-3d71f992-49b5-4639-9d75-98756d88c466.png">


<a name="setup"></a>
## 4. Setup

1. Fork and Clone the repo: [Github - Tea Party API](https://github.com/erock02/tea_party_api)
2. Install gem packages: `bundle install`
3. Setup the database: `rails db:{drop,create,migrate,seed}`
4. Run test suite locally with `bundle exec rspec`
<br>

<a name="endpoints"></a>
## 5. Endpoints

 ### Subscribe a customer to a tea subscription
*POST*   /api/v1/customers/:customer_id/subscriptions
<br>

<img width="656" alt="Screen Shot 2022-09-14 at 11 43 52 PM" src="https://user-images.githubusercontent.com/95315216/190333929-73fd18b9-18b3-4ae8-b8b7-81289e55365f.png">
<br>

 ### Cancel a customer’s tea subscription
*PATCH* /api/v1/customers/:customer_id/subscriptions/:id
<br>

<img width="622" alt="Screen Shot 2022-09-14 at 11 45 29 PM" src="https://user-images.githubusercontent.com/95315216/190333877-c3cc94ce-d82e-4244-908b-4c1983b5ac6e.png">
<br>

 ### See all of a customer’s subsciptions (active and cancelled)
*GET* /api/v1/customers/:customer_id/subscriptions
<br>

<img width="719" alt="Screen Shot 2022-09-14 at 11 51 25 PM" src="https://user-images.githubusercontent.com/95315216/190334872-3cdaef09-2851-4536-96bc-2e513be054c1.png">

<br>

<a name="technologies"></a>
## 6. Technologies
<img src="https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white" />

<img src="https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white" />
<img src="https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=Postman&logoColor=white"/>
<img src="https://user-images.githubusercontent.com/64919819/113648167-6965f280-9649-11eb-8794-0f1082ae8d1c.png" />
