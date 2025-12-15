create database amazon_sales;
use amazon_sales;
CREATE TABLE zepto_sales (
    product_name TEXT,
    category VARCHAR(100),
    city VARCHAR(100),
    original_price DECIMAL(10,2),
    current_price DECIMAL(10,2),
    discount DECIMAL(5,2),
    orders INT,
    total_revenue DECIMAL(12,2),
    influencer_active VARCHAR(10)
);
/* select,where,order by*/
SELECT category, SUM(total_revenue) AS total_revenue
FROM zepto_sales
GROUP BY category
ORDER BY total_revenue DESC;

/*inner join,left join*/
SELECT z.product_name, z.city, c.state, z.total_revenue
FROM zepto_sales z
INNER JOIN city_info c
ON z.city = c.city;

SELECT z.product_name, c.state
FROM zepto_sales z
LEFT JOIN city_info c
ON z.city = c.city;
/*subquery*/
SELECT product_name, total_revenue
FROM zepto_sales
WHERE total_revenue >
(
    SELECT AVG(total_revenue)
    FROM zepto_sales
);
/*AGGREGATE FUNCTIONS*/
SELECT
    SUM(total_revenue) AS overall_revenue,
    AVG(current_price) AS avg_selling_price,
    AVG(discount) AS avg_discount
FROM zepto_sales;
/*Create views for analysis*/
CREATE VIEW category_performance AS
SELECT
    category,
    SUM(total_revenue) AS total_revenue,
    SUM(orders) AS total_orders
FROM zepto_sales
GROUP BY category;
SELECT * FROM category_performance;
/*Optimize queries with indexes*/
CREATE INDEX idx_category ON zepto_sales(category);
CREATE INDEX idx_city ON zepto_sales(city);
CREATE INDEX idx_product ON zepto_sales(product_name);
CREATE INDEX idx_revenue ON zepto_sales(total_revenue);


