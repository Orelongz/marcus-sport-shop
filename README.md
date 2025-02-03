## Bicycle Shop

## Table of Contents
- [Build Instructions](#build-instructions)
- [Data model](#data-model)
- [Main user actions](#main-user-actions)
- [Product page](#product-page)
- [Add to cart action](#add-to-cart-action)
- [Administrative workflows](#administrative-workflows)
  - [New product creation](#new-product-creation)
  - [Adding a new part choice](#adding-a-new-part-choice)
  - [Setting prices](#setting-prices)

You're tasked with building a website that allows Marcus, a bicycle shop owner, to sell his bicycles.

Marcus owns a growing business and now wants to sell online. He also tells you that bicycles are his main product, but if the business continues to grow, he will surely start selling other sports-related items such as skis, surfboards, roller skates, etc. It would be a nice bonus if the same website allowed him to sell those things as well.

What makes Marcus's business successful is that customers can fully customize their bicycles. They can select many different options for the various parts of the bicycle. Here is an incomplete list of all the parts and their possible choices, to give an example:

* Frame type: Full-suspension, diamond, step-through
* Frame finish: Matte, shiny
* Wheels: Road wheels, mountain wheels, fat bike wheels
* Rim color: Red, black, blue
* Chain: Single-speed chain, 8-speed chain

On top of that, Marcus points out that some combinations are prohibited because they are not possible in reality. For example:
* If you select "mountain wheels," then the only frame available is the full-suspension.
* If you select "fat bike wheels," then the red rim color is unavailable because the manufacturer doesn't provide it.

Additionally, Marcus sometimes doesn't have all possible variations of each part in stock, so he wants to be able to mark them as "temporarily out of stock" to avoid receiving orders he can't fulfill.

Finally, Marcus explains how to calculate the price that you should present to the customer after customizing a bicycle. Normally, this price is calculated by adding up the individual prices of each selected part. For example:

* Full suspension = 130 EUR
* Shiny frame = 30 EUR
* Road wheels = 80 EUR
* Rim color blue = 20 EUR
* Chain: Single-speed chain = 43 EUR
* Total price: 130 + 30 + 80 + 20 + 43 = 303 EUR

However, the price of some options might depend on others. For instance, the frame finish is applied over the whole bicycle, so the more area to cover, the more expensive it gets. Because of that, the matte finish over a full-suspension frame costs 50 EUR, while applied over a diamond frame it costs 35 EUR.

These kinds of variations can always happen, and they might depend on any of the other choices, so Marcus asks you to consider this, as otherwise, he would be losing money.
_______________________________________________________

Code Exercise Overview:

This code exercise consists of defining a software architecture that could satisfy the requirements described above. In particular:

1. Data model: What data model would best support this application? Can you describe it? Include table specifications (or documents if it's a non-relational database) with fields, their associations, and the meaning of each entity. 
2. Main user actions: Explain the main actions users would take on this e-commerce website in detail. 
3. Product page: This is a read operation, performed when displaying a product page for the customer to purchase. How would you present this UI? How would you calculate which options are available? How would you calculate the price depending on the customer's selections?
4. Add to cart action: Once the customer makes their selection, there should be an "add to cart" button. What happens when the customer clicks this button? What is persisted in the database?
5. Administrative workflows: Describe the main workflows for Marcus to manage his store.
* New product creation: What information is required to create a new product? How does the database change? 
* Adding a new part choice: How can Marcus introduce a new rim color? Describe the UI and how the database changes. 
* Setting prices: How can Marcus change the price of a specific part or specify particular pricing for combinations of choices? How does the UI and database handle this?

We expect you to provide the core model of the solution: a set of classes/functions/modules in the language of your choice that describe the main relationships between entities, along with any supporting materials (database schemas, diagrams, etc.). Please keep it lightweight—no need to use web frameworks or provide a finished solution. The goal is to see how you model and code the domain logic.


## Build Instructions

- Clone repository using
```bash
git clone
```

### Backend Instructions
```bash
# install ruby dependencies
bundle install
# create, migrate and seed the database
rails db:setup
# start the rails server on port 8080
rails s -p 8080
```

### Frontend Instructions
```bash
# change directory into the client folder
cd client/
# install node dependencies
npm install
# start the nextjs dev server
npm run dev
```

## Code Exercise Overview

## Data Model:
The graphical representation of the data model can be seen [here](https://dbdiagram.io/d/67a0175a263d6cf9a0c9c446). A list of the models are;
- **ProductType** (e.g Bicycle, Ski, etc)
- **Product** (e,g Specialized Roubaix SL8 Road Bike)
- **ProductAccessoryType** (a join table - was not used here but would be useful for improvements)
- **AccessoryType** (e.g Frame finish, Wheel)
- **Accessory** (e.g Full-suspension)
- **ComplementaryAccessoryConstraint** (this holds the details of items that cannot be selected together)
- **ComplementaryAccessoryPrice** (This holds the details of items that the prices change when selected with another item)
- **Cart** (a user has a cart)
- **CartItem** (represents the items in a users cart)
- **AccessoryCartItem** (This contains the accessories within a cart item)
- **User**: Authenticated users that have registered on the website

## Main user actions
There are 2 main users of this website.
1. The customers:
The customers are the primary users of the website and their main actions include;

- **Homepage**:
Viewing the list of products available. This can be seen by navigating to the homepage (http://localhost:8000). This page contains a list of all the products that are listed by the admin user that are currently in stock.

- **Product Detail Page**:
They can also view the details of each product by going to the product details page (http://localhost:8000/products/1). Here they get to see the price of the product and it's description

- **Selection of accessories**:
Because Marcus sells custom built bicycles, customers could decide to add additional accessories to their purchase by selection upgrades to buy in addition to the specific product / bicycle

- **Adding items to their cart**:
After selections has been made, users can add items selected to their cart to be purchased later

2. The Admin User(s)
The Admin user here is Marcus and he owns the product. He holds a managerial role and has an admin dashboard where he can manage the store by
- adding products
- accessory types
- adding accessories
- making price changes, e.t.c


## Product page
The product page shows a combination of;
- The product (a bicycle)
- Accessories to be selected
- The description fo the product and price details also

The price of a product is found on the products table, and from the specification, it is not suseptible to regualar changes. The price of accessories are also saved on the accessories table, however, they could differ based on configurations set by Marcus. 

In a case where an accessory has a record on the `ComplementaryAccessoryPrices` table, the price of the complementary accessory changes and there is also a description to know why this price change happened.

Likewise, in a case where an accessory has a record on the `ComplementaryAccessoryConstraints` table, the corresponding complementary accessories are removed from the page and the user sees and explaination as to why these accessories where removed from the page.

## Add to cart action
When a customer clicks the `Add to Cart` button, the details of the selected product (bicycle) and the selected accessories are sent to the backend and the user is redirected to the homepage.

The payload sent to the backend looks like;
```ruby
{
  cart_item: {
    product_id: 4,
    accessory_ids: [1,5,7]
  }
}
```

On the backend, we;
- create a cart for the user if none is available
  - For guest users, a cart is created and the cart_id is stored in the session as `session[:cart_id]`.
  - Whenever the user registers on the website, we assign the cart within the session to the user
- validate that there are no conflicting accessories (i.e the accessories to be saved are not violating the ComplementaryAccessoryConstraints table)
- the product_id is saved on the `CartItem` table.
- The accessory items are then saved in the `AccessoryCartItem` table

## Administrative workflows
The admin workflow for Marcus was built with [Active Admin](https://activeadmin.info/). For Marcus to perform any actions, he need to login with his administrative email and password at http://localhost:8080/admin/login.

### New product creation
To create a new product, Marcus;
- visits http://localhost:8080/admin/products
- clicks on the `New product` button on the top right corner of the screen
- Fills in the product details
- Clicks on the `Create Product` button to create the product

### Adding a new part choice
To add a new parts choice, Marcus;
- visits http://localhost:8080/admin/accessories
- clicks on the `New Accessory` button on the top right corner of the screen
- Fills in the Accessory details
- Clicks on the `Create Accessory` button to create the product

### Setting prices
To change the price of a part, Marcus;
- visits http://localhost:8080/admin/accessories
- Filters or searches for the part in the list
- Clicks the Edit link on the right hand side of the record
- Changes the price to the new price
- Clicks on `Update Accessory`

To add pricing in relation to another part, Marcus;
- visits http://localhost:8080/admin/accessories
- Searches for the primary part that influences the price of the other
- Clicks on `Add new Complementary accessory price`
- puts in the price
- Selects the complementing accessory (the accessory with the price change)
- Clicks on `Update Accessory`

To add restrictions in relation to another part, Marcus;
- visits http://localhost:8080/admin/accessories
- Searches for the primary part that influences the price of the other
- Clicks on `Add new Complementary accessory constraint`
- Selects the complementing accessory (the other accessory that cannot be selected together)
- Clicks on `Update Accessory`
