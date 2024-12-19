# 🎬 **Movie-Related Queries**

## 📝 **1. Simple Queries**

### **1.1 Retrieve All Films**

```sql
SELECT * FROM film;

```

### **1.2 Retrieve Specific Columns for Films**

Retrieve the **film title**, **release year**, and **rental rate**:

```sql
SELECT title, release_year, rental_rate FROM film;

```

### **1.3 Retrieve Films with a Specific Rating**

Get all films with a rating of **'PG-13'**:

```sql
SELECT title, rating FROM film WHERE rating = 'PG-13';

```

----------

## 🔢 **2. Aggregate Queries**

### **2.1 Count Total Number of Films**

```sql
SELECT COUNT(*) AS total_films FROM film;

```

### **2.2 Find the Average Rental Rate**

```sql
SELECT AVG(rental_rate) AS average_rental_rate FROM film;

```

### **2.3 Find the Longest and Shortest Film Durations**

```sql
SELECT 
    MAX(length) AS longest_film,
    MIN(length) AS shortest_film
FROM film;

```

### **2.4 Count Films by Rating**

```sql
SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating;

```

----------

## 🔍 **3. Search Using `LIKE`**

# 🔍 **Quick Notes on the Use of `LIKE` in SQL**

The **`LIKE`** operator in SQL is used to **search for a specified pattern** within a column. It is commonly used in `WHERE` clauses to perform **pattern matching** with text data.

----------

## 📌 **Syntax**

```sql
SELECT column1, column2
FROM table_name
WHERE column_name LIKE 'pattern';

```

----------

## 📝 **Wildcards in `LIKE`**

The `LIKE` operator supports two main **wildcards** for pattern matching:

*  **`%` (Percent Sign)**:
    
    -   Represents **zero or more characters**.
    -   Useful for matching substrings.
    
    **Examples**:
    
    -   `LIKE 'A%'` → Matches values that start with **'A'** (e.g., 'Apple', 'Amazon').
    -   `LIKE '%son'` → Matches values that end with **'son'** (e.g., 'Johnson', 'Watson').
    -   `LIKE '%book%'` → Matches values containing **'book'** anywhere (e.g., 'Notebook', 'Bookstore').
*  **`_` (Underscore)**:
    
    -   Represents a **single character**.
    -   Useful for matching specific character positions.
    
    **Examples**:
    
    -   `LIKE 'A_'` → Matches values with **'A'** followed by any single character (e.g., 'An', 'At').
    -   `LIKE '_at'` → Matches values that have any character followed by **'at'** (e.g., 'Cat', 'Hat').

----------
### 1. **Find Names Starting with 'J'**

```sql
SELECT first_name FROM customer WHERE first_name LIKE 'J%';

```

### 2. **Find Films Containing 'LOVE'**

```sql
SELECT title FROM film WHERE title LIKE '%LOVE%';

```

### 3. **Find Cities Ending with 'TON'**

```sql
SELECT city FROM city WHERE city LIKE '%TON';

```

### 4. **Find Names with 'A' as the Second Character**

```sql
SELECT first_name FROM customer WHERE first_name LIKE '_A%';

```

### 5. **Find Films with Exactly Four-Letter Titles**

```sql
SELECT title FROM film WHERE title LIKE '____';

```

----------

## ⚠️ **Considerations When Using `LIKE`**

1.  **Case Sensitivity**:
    
    -   In **MySQL**, `LIKE` is **case-insensitive** by default for `CHAR` and `VARCHAR` types.
    -   To make it case-sensitive, use the **`BINARY`** keyword:
        
        ```sql
        SELECT first_name FROM customer WHERE first_name LIKE BINARY 'J%';
        
        ```
        
### **3.1 Find Films with 'LOVE' in the Title**

```sql
SELECT title FROM film WHERE title LIKE '%LOVE%';

```

### **3.2 Find Films Starting with 'A'**

```sql
SELECT title FROM film WHERE title LIKE 'A%';

```

### **3.3 Find Films with Titles Containing Numbers**

```sql
SELECT title FROM film WHERE title REGEXP '[0-9]';

```
### 3.4  **Performance**:
    
    -   Using `LIKE` with the **`%`** wildcard at the beginning of the pattern (e.g., `'%pattern'`) can negatively impact performance because it prevents the use of indexes.
3.  **Escape Characters**:
    
    -   If the search pattern includes wildcards (`%` or `_`), use the **`ESCAPE`** clause to treat them as literal characters.
        
        ```sql
        SELECT title FROM film WHERE title LIKE '100\% Pure' ESCAPE '\\';
        
        ```
----------

## 📊 **4. Ordering Queries**

### **4.1 List Films Ordered by Title Ascending**

```sql
SELECT title, release_year FROM film ORDER BY title ASC;

```

### **4.2 List Top 10 Longest Films**

```sql
SELECT title, length FROM film ORDER BY length DESC LIMIT 10;

```

### **4.3 List Films Ordered by Rental Rate and Title**

```sql
SELECT title, rental_rate FROM film ORDER BY rental_rate DESC, title ASC;

```

----------

# 🔗 **5. Joins**

## 🔹 **5.1 INNER JOIN**

### **Definition**:

An **INNER JOIN** returns only the rows where there is a match in both tables.

### **Example 1: List Films and Their Categories**

```sql
SELECT 
    film.title, 
    category.name AS category
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id;

```

### **Example 2: List Films and Their Actors**

```sql
SELECT 
    film.title, 
    CONCAT(actor.first_name, ' ', actor.last_name) AS actor_name
FROM film
INNER JOIN film_actor ON film.film_id = film_actor.film_id
INNER JOIN actor ON film_actor.actor_id = actor.actor_id;

```

----------

## 🔹 **5.2 LEFT JOIN**

### **Definition**:

A **LEFT JOIN** returns all rows from the **left table** and the matching rows from the **right table**. If there is no match, `NULL` values are returned for the right table's columns.

### **Example: List All Films and Their Categories (Including Films with No Categories)**

```sql
SELECT 
    film.title, 
    category.name AS category
FROM film
LEFT JOIN film_category ON film.film_id = film_category.film_id
LEFT JOIN category ON film_category.category_id = category.category_id;

```

**Explanation**:  
This query returns all films, even if they do not have an associated category.

----------

## 🔹 **5.3 RIGHT JOIN**

### **Definition**:

A **RIGHT JOIN** returns all rows from the **right table** and the matching rows from the **left table**. If there is no match, `NULL` values are returned for the left table's columns.

### **Example: List All Categories and Their Films (Including Categories with No Films)**

```sql
SELECT 
    film.title, 
    category.name AS category
FROM film
RIGHT JOIN film_category ON film.film_id = film_category.film_id
RIGHT JOIN category ON film_category.category_id = category.category_id;

```

**Explanation**:  
This query returns all categories, even if they do not have any associated films.

----------

## 🔹 **5.4 FULL OUTER JOIN**

### **Definition**:

A **FULL OUTER JOIN** returns all rows when there is a match in either the **left table** or the **right table**. If there is no match, `NULL` values are returned for missing columns.

### **Note**:

MySQL does not support **FULL OUTER JOIN** natively. However, you can achieve the same result by combining a **LEFT JOIN** and a **RIGHT JOIN** using a **`UNION`**.

### **Example: List All Films and Categories (Including Those Without Matches)**

```sql
SELECT 
    film.title, 
    category.name AS category
FROM film
LEFT JOIN film_category ON film.film_id = film_category.film_id
LEFT JOIN category ON film_category.category_id = category.category_id

UNION

SELECT 
    film.title, 
    category.name AS category
FROM film
RIGHT JOIN film_category ON film.film_id = film_category.film_id
RIGHT JOIN category ON film_category.category_id = category.category_id;

```

----------

## 🔹 **5.5 CROSS JOIN**

### **Definition**:

A **CROSS JOIN** returns the Cartesian product of two tables (every row in the first table combined with every row in the second table).

### **Example: List All Possible Combinations of Films and Categories**

```sql
SELECT 
    film.title, 
    category.name AS category
FROM film
CROSS JOIN category;

```

**Explanation**:  
This query returns every possible combination of films and categories. If there are 1,000 films and 16 categories, the result will have 16,000 rows.

----------

## 🔹 **5.6 Combining Different Joins**

### **Example: List Films, Categories, and Actors with LEFT JOIN**

Include all films, even if they do not have categories or actors:

```sql
SELECT 
    film.title,
    category.name AS category,
    CONCAT(actor.first_name, ' ', actor.last_name) AS actor_name
FROM film
LEFT JOIN film_category ON film.film_id = film_category.film_id
LEFT JOIN category ON film_category.category_id = category.category_id
LEFT JOIN film_actor ON film.film_id = film_actor.film_id
LEFT JOIN actor ON film_actor.actor_id = actor.actor_id;


----------

## 🔍 **6. Subqueries**

### **6.1 Find Films with the Highest Rental Rate**

```sql
SELECT title, rental_rate
FROM film
WHERE rental_rate = (SELECT MAX(rental_rate) FROM film);

```

### **6.2 Find Films Rented by a Specific Customer**

Get the films rented by **customer 'MARY SMITH'**:

```sql
SELECT title
FROM film
WHERE film_id IN (
    SELECT inventory.film_id
    FROM rental
    JOIN customer ON rental.customer_id = customer.customer_id
    JOIN inventory ON rental.inventory_id = inventory.inventory_id
    WHERE customer.first_name = 'MARY' AND customer.last_name = 'SMITH'
);

```

### **6.3 Find Categories with More Than 50 Films**

```sql
SELECT name AS category
FROM category
WHERE category_id IN (
    SELECT category_id
    FROM film_category
    GROUP BY category_id
    HAVING COUNT(film_id) > 50
);

```

----------

## 📈 **7. Combining Aggregates, Joins, and Subqueries**

### **7.1 Find the Top 5 Categories with the Most Films**

```sql
SELECT 
    category.name AS category, 
    COUNT(film_category.film_id) AS film_count
FROM category
JOIN film_category ON category.category_id = film_category.category_id
GROUP BY category.name
ORDER BY film_count DESC
LIMIT 5;

```

### **7.2 List Actors Who Have Acted in the Most Films**

```sql
SELECT 
    CONCAT(actor.first_name, ' ', actor.last_name) AS actor_name,
    COUNT(film_actor.film_id) AS film_count
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id, actor_name
ORDER BY film_count DESC
LIMIT 5;

```

### **7.3 Find the Average Rental Rate for Each Category**

```sql
SELECT 
    category.name AS category,
    AVG(film.rental_rate) AS avg_rental_rate
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name
ORDER BY avg_rental_rate DESC;

```

----------

# ✅ **Summary**

These queries demonstrate various MySQL techniques using the **Sakila Database**:

1.  **Simple Queries** for basic retrieval.
2.  **Aggregate Queries** for calculations like `COUNT`, `AVG`, `MAX`, `MIN`.
3.  **Search Queries** using `LIKE` and `REGEXP`.
4.  **Ordering** results with `ORDER BY`.
5.  **Joins** to combine data from multiple tables.
6.  **Subqueries** to perform complex filtering and retrieval.