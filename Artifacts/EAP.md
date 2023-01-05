## A7: Web Resources Specification

The architecture of the web application to develop is documented indicating the catalogue of resources and the properties of each resource, including: references to the graphical interfaces. This page includes the following operations over data: create, read, update, and delete.

### 1. Overview

> Identify and overview the modules that will be part of the application.

| Module | Content|
| ------ | ------ |
| M01: Authentication and Profile | Web resources associated with user authentication and individual profile management. Includes the following system features: login/logout, registration, credential recovery, view and edit personal profile information. |
| M02: User Administration and Static pages | Web resources associated with user management, specifically: view and search users, delete or ban user accounts, view and change user information. Web resources with static content are associated with this module: dashboard, about, contact, services and faq. |
| M03: Store | Web resources associated with store items. Includes the following system features: items list and search, view and edit item details, and delete items  |
| M04: Reviews | Web resources associated with reviews. Includes the following system features: add review, list reviews and delete reviews.|
| M05: Cart | Web resources associated with cart. Includes the following system features: view cart, add to cart and edit cart. |

### 2. Permissions

> Define the permissions used by each module, necessary to access its data and features.  

| Acronym | Name | Description |
| ------ | ------ | ------ |
| PUB | Public | Users without privileges |
| USR | User | Authenticated users |
| OWN | Owner | A specific user|
| ADM | Administrator | User with administrator priviledges|


### 3. OpenAPI Specification

> OpenAPI specification in YAML format to describe the vertical prototype's web resources.

> Link to the `a7_openapi.yaml` file in the group's repository.

[OpenAPI is here](../a7_openapi.yaml)


```yaml
openapi: 3.0.0

info:
 version: '1'
 title: 'LBAW ATGO Web API'
 description: 'Web Resources Specification (A7) for ATGO'

servers:
# Added by API Auto Mocking Plugin
- url: http://lbaw.fe.up.pt
  description: Production server

externalDocs:
 description: Find more info here.
 url: https://web.fe.up.pt/~ssn/wiki/teach/lbaw/medialib/a07

tags:
 - name: 'M01: Authentication and Profile'
 - name: 'M02: User Administration and Static pages'
 - name: 'M03: Store'
 - name: 'M04: Reviews'
 - name: 'M05: Cart'

paths:
 /login:
   get:
     operationId: R101
     summary: 'R101: Login Form'
     description: 'Provide login form. Access: PUB'
     tags:
       - 'M01: Authentication and Profile'
     responses:
       '200':
         description: 'Ok. Show Log-in UI'
   post:
     operationId: R102
     summary: 'R102: Login Action'
     description: 'Processes the login form submission. Access: PUB'
     tags:
       - 'M01: Authentication and Profile'

     requestBody:
       required: true
       content:
         application/x-www-form-urlencoded:
           schema:
             type: object
             properties:
               email:
                 type: string
               password:
                 type: string
             required:
                  - email
                  - password

     responses:
       '302':
         description: 'Redirect after processing the login credentials.'
         headers:
           Location:
             schema:
               type: string
             examples:
               302Success:
                 description: 'Successful authentication. Redirect to product page'
                 value: '/products'
               302Error:
                 description: 'Failed authentication. Redirect to login form.'
                 value: '/login'

 /logout:

   post:
     operationId: R103
     summary: 'R103: Logout Action'
     description: 'Logout the current authenticated user. Access: USR, ADM'
     tags:
       - 'M01: Authentication and Profile'
     responses:
       '302':
         description: 'Redirect after processing logout.'
         headers:
           Location:
             schema:
               type: string
             examples:
               302Success:
                 description: 'Successful logout. Redirect to login form.'
                 value: '/login'

 /register:
   get:
     operationId: R104
     summary: 'R104: Register Form'
     description: 'Provide new user registration form. Access: PUB'
     tags:
       - 'M01: Authentication and Profile'
     responses:
       '200':
         description: 'Ok. Show Sign-Up UI'

   post:
     operationId: R105
     summary: 'R105: Register Action'
     description: 'Processes the new user registration form submission. Access: PUB'
     tags:
       - 'M01: Authentication and Profile'

     requestBody:
       required: true
       content:
         application/x-www-form-urlencoded:
           schema:
             type: object
             properties:
               name:
                 type: string
               email:
                 type: string
               password:
                 type: string
             required:
                                    - name
                                    - email
                                    - password
                                    

     responses:
       '302':
         description: 'Redirect after processing the new user information.'
         headers:
           Location:
             schema:
               type: string
             examples:
               302Success:
                 description: 'Successful authentication. Redirect to products page.'
                 value: '/products/'
               302Failure:
                 description: 'Failed authentication. Redirect to login form.'
                 value: '/login'

 /users/{id}:
   get:
     operationId: R106
     summary: 'R106: View user profile'
     description: 'Show the individual user profile. Access: USR'
     tags:
       - 'M01: Authentication and Profile'

     parameters:
       - in: path
         name: id
         schema:
           type: integer
         required: true

     responses:
       '200':
         description: 'Ok. Show User Profile UI'
 
 /users/{id}/purchaseHistory:
   get:
     operationId: R107
     summary: 'R107: View user purchase history'
     description: 'Show the individual user purchase history. Access: OWN'
     tags:
       - 'M01: Authentication and Profile'
     parameters:
       - in: path
         name: id
         schema:
           type: integer
         required: true
         
     responses:
       '200':
         description: 'Ok. Show User Purchase History UI'

 /search:
   get:
     operationId: R201
     summary: 'R201: Search products API'
     description: 'Searches for products Access: PUB.'

     tags:
       - 'M03: Store'

     parameters:
       - in: query
         name: query
         description: String to use for full-text search
         schema:
           type: string
         required: false
     responses:
       '200':
         description: Success
         content:
           application/json:
             schema:
               type: array
               items:
                 type: object
                 properties:
                   id:
                     type: string
                   name:
                     type: string
                   price:
                     type: string
                   score:
                     type: string
                   description:
                     type: string
                   gender: 
                     type: string
               example:
                 - id: 1
                   name: Nike shoe
                   price: 27.69
                   score: 4
                   PrimaryColor:  Grey
                   SecondaryColor:  Grey
                   sizeEU: 40
 /products/{id}:
   get:
    operationId: R202
    summary: 'R202: View product details'
    description: 'Show the page with the information of a product . Access: PUB'
    tags:
     - 'M03: Store'

    parameters:
     - in: path
       name: id
       schema:
         type: integer
       required: true

    responses:
     '200':
       description: 'Ok. Show Product UI'
     '400':
       description: 'Product not found'

 /products/:
   get:
    operationId: R203
    summary: 'R203: View products'
    description: 'Show the page a list of a products . Access: PUB'
    tags:
     - 'M03: Store'

    responses:
     '200':
       description: 'Ok. Show Product UI'
     '400':
       description: 'Product not found'
       
 /cart:
    get:
     operationId: R401
     summary: 'R401: View cart of the user'
     description: 'Show the page with the cart of a user . Access: OWN'
     tags:
      - 'M05: Cart'

     parameters:
      - in: path
        name: id
        schema:
          type: integer
        required: true

     responses:
      '200':
        description: 'Ok. Show Cart UI'
        
 /cart:
   post:
    operationId: R402
    summary: 'R402: Add product to cart'
    description: 'Adds a chosen quantity of a produt to the cart of a user. Access: OWN'
    tags: 
     - 'M05: Cart'
     
    requestBody:
      required: true
      content:
        application/json:
         schema:
          type: object
          properties:
            id:
              type: integer
            quantity:
              type: integer
      
    responses:
      '200':
       description: 'Sucessfully added the product to the cart'
      '400':
       description: 'The product is not available'
   
   patch: 
    operationId: R403
    summary: 'R403: Change quantity of product in cart'
    description: 'AJAX request. Updates the quantity of a product in the cart of a user. Access: OWN'
    tags:
      - 'M05: Cart'

    requestBody:
      required: true
      content:
        application/json:
          schema:
           type: object
           properties:
            id:
             type: integer 
            quantity:
             type: integer
      
    responses:
      '200':
        description: 'Sucessfully updated item quantity.'
      '404':
        description: 'Product not in the cart'
     
 /checkout:
  get:
   operationId: R404
   summary: 'R404: Checkout Form'
   description: 'Provide checkout form. Access: USR'
   tags:
    - 'M05: Cart'
   responses:
        '200':
         description: 'Ok. Show checkout form'
  post:
    operationId: R405
    summary: 'R405: Checkout'
    description: 'Processes the checkout. Access: OWN'
    tags: 
     - 'M05: Cart'
     
    requestBody:
        required: true
        content:
         application/x-www-form-urlencoded:
          schema:
           type: object
           properties:
             address:
              type: object
              properties:
               street:
                type: string
               postal_code:
                type: string
               city: 
                type: string
               country:
                type: string
           required:
            - address
    responses:
     '302':
      description: 'Redirect after processing checkout form'
      headers:
       Location:
        schema:
         type: string
        examples:
         302Success:
          description: 'Successful checkout. Redirect to home page.'
          value: '/home'
         302Failure:
          description: 'Failed checkout. Redirect to checkout.'
          value: '/checkout'
          
        
 /about:
   get:
    operationId: R501
    summary: 'R501: View About page'
    description: 'Shows the About page. Access: PUB'
    tags: 
     - 'M02: User Administration and Static pages'
     
      
    responses:
      '200':
        description: 'OK. Show About page'
  
 /faq:
   get:
    operationId: R502
    summary: 'R502: View FAQ page'
    description: 'Shows the FAQ page. Access: PUB'
    tags: 
     - 'M02: User Administration and Static pages'
        
    responses:
     '200':
       description: 'OK. Show FAQ page'
         
 /contacts:
   get:
    operationId: R503
    summary: 'R503: View Contacts page'
    description: 'Shows the Contacts page. Access: PUB'
    tags: 
     - 'M02: User Administration and Static pages'
       
        
    responses:
     '200':
       description: 'OK. Show Contacts page'
       
...
```

---


## A8: Vertical prototype

This artifact provides an overview of what features are available on the vertical prototype

### 1. Implemented Features

#### 1.1. Implemented User Stories

> Identify the user stories that were implemented in the prototype.  

| User Story reference | Name                   | Priority                   | Description                   |
| -------------------- | ---------------------- | -------------------------- | ----------------------------- |
|FR.011|Login|High|As a visitor, I want to be able to log in to my account, so that I can use its features.|
|FR.012|Registration|High|As a visitor, I want to be able to register myself, so that I have an account and can have access to more features.|
|FR.101|List viewing|High|As a User, I want to access the website and be prompted with a list of items, so that I can see the highlights from the shop.  |
|FR.103|View product details|High|As a User, I want to select an item and see more information, so that I can be more informed about it.|
|FR.107|Product searching|High|As a User, I want to search for a specific item, so that I can add the exact item I want to my cart.|
|FR.031|Exact match Search|High|As a User, I want to search for an exact item, so that I can find the exact product instantly.|
|FR.032|Full-text Search|High|As a User, I want to be shown a wide selection of results for a single item search.|
|FR.105|Adding products to Shopping cart|High|As a User, I want to add items to my cart, so that I can then buy them.|
|FR.061|About Us|Medium|As a User, I want to be able to see information about the website, so that I can be more informed about it.|
|FR.062|Main Features|Medium|As a User, I want to be prompted to a page to see the main features, so that I know what actions I’m able to perform.|
|FR.063|Contacts|Medium|As a User, I want to see the contacts from the people that developed and maintain the website, so that I can know who they are.|
|FR.205|Checkout|High|As a Authenticated User, I want to check out my cart, so that I can finalize the purchase of my items.|
|FR.021|Viewing profile|High|As a Authenticated User, I want to view my profile, so that I can verify that all my information is correct.|
|FR.022|Editing profile|High|As a Authenticated User, I want to edit my information, so that if any changes in my life occur, I can correct the info on the website.|
|FR.201|View purchase history|High|As a Authenticated User, I want to see my history, so that I can recall what items I have purchased.|
|FR.015|Logout|High|As a Authenticated User, I want to be able to be able to logout of my account, so that others cannot use it without my knowledge.|
|FR.042|Administer user accounts|High|As an Administrator, I want to administer my user’s accounts, so that I can check if they have broken any rules.|
|FR.601|Adding products|Medium|As an Administrator, I want to add an item to the list of available items, so that I can sell it.|
|FR.602|Managing product information|Medium|As an Administrator, I want to manage the information of items, so that I can keep the information current and accurate.|
|FR.041|Administrator accounts|Medium|As an Administrator, I want to have an administrator account so that I can perform my tasks of managing the website.|
|FR.043|Block and unblock User accounts|Medium|As an Administrator, I want to block and unblock my user ‘s accounts, so that if they are breaking any site rules or if they haven’t, I can fix the problem.|
|FR.016|Logout|High|As a Administrator, I want to be able to be able to logout of my account, so that others cannot use it without my knowledge.|

...

#### 1.2. Implemented Web Resources

> Identify the web resources that were implemented in the prototype.  

> Module M01: Module Name  

| Web Resource Reference | URL                            |
| ---------------------- | ------------------------------ |
| M01: Authentication and Profile | [URL to access the web resource](http://lbaw2292.lbaw.fe.up.pt/) |
| M02: User Administration and Static pages | [URL to access the web resource](http://lbaw2292.lbaw.fe.up.pt/profile) (must be logged in as admin) |
| M03: Store| 3, one per category [Shoes](http://lbaw2292.lbaw.fe.up.pt/shoes) [Books](http://lbaw2292.lbaw.fe.up.pt/books) [FunkoPop](http://lbaw2292.lbaw.fe.up.pt/funkoPops) |
| M05: Cart | [URL to access the web resource](http://lbaw2292.lbaw.fe.up.pt/cart)|

...

> Module M02: Module Name  

...

### 2. Prototype

> URL of the prototype plus user credentials necessary to test all features.

lbaw2292.lbaw.fe.up.pt

asuka@mail.com/123123 (Admin account)
shinji@mail.com/123123 (Banned user)
rei@mail.com/123123 (Regular)

> Link to the prototype source code in the group's git repository.  

https://git.fe.up.pt/lbaw/lbaw2223/lbaw2292

---


## Revision history

Changes made to the first submission:
1. Item 1
1. ..

***
GROUP2292, 23/11/2022

* Diogo Nunes, up202007895@fc.up.pt (Editor)
* Diogo Almeida, up202006059@fc.up.pt
* Francisco Nunes,up201908253@fc.up.pt
* Rafael Morgado, up201506449@fc.up.pt