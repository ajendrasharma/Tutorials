# 📘 **Sakila Database Schema**

The **Sakila Database** is a sample database designed to simulate a DVD rental store. It contains various tables, views, stored procedures, functions, and triggers to demonstrate MySQL features. Below is a detailed breakdown of all the components of the Sakila database.

----------

## **1. Tables**

The Sakila database contains **16 tables**, which represent different entities involved in the DVD rental business.

### **1.1 `actor` Table**

-   **Description**: Stores information about actors.
-   **Columns**:
    -   `actor_id`: Primary key (unique identifier).
    -   `first_name`: Actor’s first name.
    -   `last_name`: Actor’s last name.
    -   `last_update`: Timestamp of the last update.

### **1.2 `address` Table**

-   **Description**: Contains address details for customers, staff, and stores.
-   **Columns**:
    -   `address_id`: Primary key.
    -   `address`, `address2`: Address lines.
    -   `district`: Region or district.
    -   `city_id`: Foreign key to the `city` table.
    -   `postal_code`: ZIP or postal code.
    -   `phone`: Contact number.
    -   `last_update`: Timestamp of the last update.

### **1.3 `category` Table**

-   **Description**: Lists movie categories (e.g., Action, Comedy).
-   **Columns**:
    -   `category_id`: Primary key.
    -   `name`: Category name.
    -   `last_update`: Timestamp of the last update.

### **1.4 `city` Table**

-   **Description**: Stores city names.
-   **Columns**:
    -   `city_id`: Primary key.
    -   `city`: City name.
    -   `country_id`: Foreign key to the `country` table.
    -   `last_update`: Timestamp of the last update.

### **1.5 `country` Table**

-   **Description**: Contains country names.
-   **Columns**:
    -   `country_id`: Primary key.
    -   `country`: Country name.
    -   `last_update`: Timestamp of the last update.

### **1.6 `customer` Table**

-   **Description**: Stores customer information.
-   **Columns**:
    -   `customer_id`: Primary key.
    -   `store_id`: Foreign key to the `store` table.
    -   `first_name`, `last_name`: Customer’s name.
    -   `email`: Email address.
    -   `address_id`: Foreign key to the `address` table.
    -   `active`: Indicates if the customer is active.
    -   `create_date`: Date the customer was added.
    -   `last_update`: Timestamp of the last update.

### **1.7 `film` Table**

-   **Description**: Contains movie details.
-   **Columns**:
    -   `film_id`: Primary key.
    -   `title`: Film title.
    -   `description`: Short description.
    -   `release_year`: Release year.
    -   `language_id`: Foreign key to the `language` table.
    -   `rental_duration`: Rental period (days).
    -   `rental_rate`: Rental cost.
    -   `length`: Film duration (minutes).
    -   `replacement_cost`: Cost if the film is lost/damaged.
    -   `rating`: Film rating (G, PG, PG-13, R, NC-17).
    -   `special_features`: Features (Trailers, Commentaries, etc.).
    -   `last_update`: Timestamp of the last update.

### **1.8 `film_actor` Table**

-   **Description**: Junction table for films and actors (many-to-many relationship).
-   **Columns**:
    -   `actor_id`: Foreign key to the `actor` table.
    -   `film_id`: Foreign key to the `film` table.
    -   `last_update`: Timestamp of the last update.

### **1.9 `film_category` Table**

-   **Description**: Links films to categories (many-to-many relationship).
-   **Columns**:
    -   `film_id`: Foreign key to the `film` table.
    -   `category_id`: Foreign key to the `category` table.
    -   `last_update`: Timestamp of the last update.

### **1.10 `film_text` Table**

-   **Description**: For full-text search of film titles and descriptions.
-   **Columns**:
    -   `film_id`: Primary key.
    -   `title`: Film title.
    -   `description`: Film description.

### **1.11 `inventory` Table**

-   **Description**: Represents physical copies of films in stores.
-   **Columns**:
    -   `inventory_id`: Primary key.
    -   `film_id`: Foreign key to the `film` table.
    -   `store_id`: Foreign key to the `store` table.
    -   `last_update`: Timestamp of the last update.

### **1.12 `language` Table**

-   **Description**: Stores film languages.
-   **Columns**:
    -   `language_id`: Primary key.
    -   `name`: Language name.
    -   `last_update`: Timestamp of the last update.

### **1.13 `payment` Table**

-   **Description**: Records payments made by customers.
-   **Columns**:
    -   `payment_id`: Primary key.
    -   `customer_id`: Foreign key to the `customer` table.
    -   `staff_id`: Foreign key to the `staff` table.
    -   `rental_id`: Foreign key to the `rental` table.
    -   `amount`: Payment amount.
    -   `payment_date`: Date of payment.
    -   `last_update`: Timestamp of the last update.

### **1.14 `rental` Table**

-   **Description**: Tracks film rentals.
-   **Columns**:
    -   `rental_id`: Primary key.
    -   `rental_date`: Date of rental.
    -   `inventory_id`: Foreign key to the `inventory` table.
    -   `customer_id`: Foreign key to the `customer` table.
    -   `return_date`: Date of return.
    -   `staff_id`: Foreign key to the `staff` table.
    -   `last_update`: Timestamp of the last update.

### **1.15 `staff` Table**

-   **Description**: Contains staff member information.
-   **Columns**:
    -   `staff_id`: Primary key.
    -   `first_name`, `last_name`: Staff member’s name.
    -   `address_id`: Foreign key to the `address` table.
    -   `email`: Staff email.
    -   `store_id`: Foreign key to the `store` table.
    -   `active`: Staff activity status.
    -   `username`: Login username.
    -   `password`: Login password (hashed).
    -   `last_update`: Timestamp of the last update.

### **1.16 `store` Table**

-   **Description**: Stores information about each store.
-   **Columns**:
    -   `store_id`: Primary key.
    -   `manager_staff_id`: Foreign key to the `staff` table.
    -   `address_id`: Foreign key to the `address` table.
    -   `last_update`: Timestamp of the last update.

----------

## **2. Views**

Views in the Sakila database provide simplified ways to query complex datasets.

1.  **`actor_info`**: Lists actors and the films they’ve performed in.
2.  **`customer_list`**: Combines customer details with their addresses.
3.  **`film_list`**: Lists films with categories and actors.
4.  **`nicer_but_slower_film_list`**: Similar to `film_list` but with formatted actor names.
5.  **`sales_by_film_category`**: Aggregates sales by film category.
6.  **`sales_by_store`**: Aggregates sales by store.
7.  **`staff_list`**: Lists staff members with store and address details.

----------

## **3. Stored Procedures**

1.  **`film_in_stock`**: Checks if a film is in stock.
2.  **`film_not_in_stock`**: Checks if a film is not in stock.
3.  **`rewards_report`**: Generates a report of top customers for the past month.

----------

## **4. Stored Functions**

1.  **`get_customer_balance`**: Calculates the current balance for a customer.
2.  **`inventory_held_by_customer`**: Returns the customer currently holding an inventory item.
3.  **`inventory_in_stock`**: Checks if an inventory item is in stock.

----------

## **5. Triggers**

1.  **`customer_create_date`**: Sets `create_date` when a new customer is added.
2.  **`payment_date`**: Sets `payment_date` when a payment is made.
3.  **`rental_date`**: Sets `rental_date` when a rental is created.
4.  **`ins_film`**: Synchronizes `film` and `film_text` tables on insert.
5.  **`upd_film`**: Synchronizes `film` and `film_text` tables on update.
6.  **`del_film`**: Synchronizes `film` and `film_text` tables on delete.

----------

# 📊 **Grouping Tables and Views by Record type**

To better understand the **Sakila Database** schema, we can organize the tables and views into logical groups based on their roles and purposes within the DVD rental system. The key categories are:

1.  **Movie Information**
2.  **Customer Information**
3.  **Business Operations**
4.  **Staff and Store Management**
5.  **Supporting Information**

Let's break it down:

----------

## 🎬 **1. Movie Information**

These tables and views contain details about movies, actors, categories, and inventory.

### **Tables**

**Table**

**Description**

**`film`**

Stores detailed information about each film (title, description, etc.).

**`film_actor`**

Junction table linking films and actors (many-to-many relationship).

**`film_category`**

Junction table linking films and categories (many-to-many relationship).

**`actor`**

Stores information about actors.

**`category`**

Contains categories for films (e.g., Action, Comedy).

**`film_text`**

Provides full-text search capability for film titles and descriptions.

**`inventory`**

Represents physical copies of films available in stores.

**`language`**

Lists available languages for films.

### **Views**

**View**

**Description**

**`film_list`**

Lists films with categories and actor details.

**`nicer_but_slower_film_list`**

A formatted version of `film_list` with capitalized actor names.

**`actor_info`**

Lists actors and the films they have performed in.

----------

## 👤 **2. Customer Information**

These tables and views manage customer data and their transactions.

### **Tables**

**Table**

**Description**

**`customer`**

Stores customer information (name, email, store affiliation).

**`address`**

Contains address details for customers.

**`city`**

Stores city names linked to addresses.

**`country`**

Stores country names linked to cities.

**`rental`**

Tracks rentals made by customers.

**`payment`**

Records payments made by customers.

### **Views**

**View**

**Description**

**`customer_list`**

Combines customer details with their addresses.

----------

## 💼 **3. Business Operations**

These tables and views support business transactions, including rentals, payments, and sales summaries.

### **Tables**

**Table**

**Description**

**`rental`**

Records information about film rentals (rental date, return date).

**`payment`**

Tracks payments for rentals.

### **Views**

**View**

**Description**

**`sales_by_film_category`**

Provides total sales broken down by film category.

**`sales_by_store`**

Provides total sales broken down by store.

### **Stored Procedures**

**Stored Procedure**

**Description**

**`film_in_stock`**

Checks if a film is in stock at a specific store.

**`film_not_in_stock`**

Checks if a film is not in stock at a specific store.

**`rewards_report`**

Generates a report of top customers for the past month.

### **Stored Functions**

**Function**

**Description**

**`get_customer_balance`**

Calculates the current balance for a customer.

**`inventory_in_stock`**

Checks if an inventory item is in stock.

**`inventory_held_by_customer`**

Returns the customer currently holding an inventory item.

----------

## 🏢 **4. Staff and Store Management**

These tables and views manage information about staff members and store locations.

### **Tables**

**Table**

**Description**

**`staff`**

Stores staff member details (name, email, login info).

**`store`**

Contains store locations and their managers.

**`address`**

Contains address details for staff and stores.

### **Views**

**View**

**Description**

**`staff_list`**

Lists staff members with their store and address details.

----------

## 🛠️ **5. Supporting Information**

These tables provide supporting details such as addresses, cities, countries, and languages.

### **Tables**

**Table**

**Description**

**`address`**

Stores address details used by customers, staff, and stores.

**`city`**

Contains city information linked to addresses.

**`country`**

Contains country information linked to cities.

**`language`**

Lists available languages for films.

----------

## **Triggers**

Triggers help maintain data consistency and automate actions.

**Trigger**

**Description**

**`customer_create_date`**

Sets the `create_date` when a new customer is added.

**`payment_date`**

Sets the `payment_date` when a payment is made.

**`rental_date`**

Sets the `rental_date` when a new rental is added.

**`ins_film`**

Synchronizes `film` and `film_text` tables on insert.

**`upd_film`**

Synchronizes `film` and `film_text` tables on update.

**`del_film`**

Synchronizes `film` and `film_text` tables on delete.

----------

# 📊 **Summary of Groupings**

**Category**

**Tables**

**Views**

**Movie Information**

`film`, `film_actor`, `film_category`, `actor`, `category`, `film_text`, `inventory`, `language`

`film_list`, `nicer_but_slower_film_list`, `actor_info`

**Customer Information**

`customer`, `address`, `city`, `country`, `rental`, `payment`

`customer_list`

**Business Operations**

`rental`, `payment`

`sales_by_film_category`, `sales_by_store`

**Staff & Store Mgmt.**

`staff`, `store`, `address`

`staff_list`

**Supporting Info**

`address`, `city`, `country`, `language`