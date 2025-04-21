# Car_Sales-Analysis-
SQL-based analysis of vehicle cost, mileage, and resale value to identify the best value-for-money car.

# 🚗 Vehicle Data Analysis Using SQL

This project showcases comprehensive SQL-based data modeling and analysis on a hypothetical vehicle dataset. It simulates real-world scenarios such as customer reviews, vehicle features, maintenance costs, resale values, and fuel prices — providing insights for customers and analysts alike.

## 📂 Tables Created

1. **vehicles** – Stores core vehicle details (make, model, price, mileage, etc.)
2. **features** – Lists various features associated with each vehicle
3. **fuel_price** – Maintains fuel price by type (e.g., Petrol)
4. **customer_reviews** – Contains customer feedback, ratings, and satisfaction level
5. **maintenance_cost** – Yearly maintenance cost for each vehicle
6. **resale_value** – Estimated resale values after 3 and 5 years

## 🔍 Analysis Performed

- **Full Vehicle Profiles**
- **Fuel Cost per 1000 km**
- **Annual Cost of Ownership**
- **Feature Count Per Vehicle**
- **Overall Customer Value Score**
- **Total Cost of Ownership (5 Years)**
- **Cost Per Km (Over 5 Years)**
- **Mileage vs Price Trade-Off**
- **Side-by-Side Vehicle Comparison**
- **Value-for-Money Score**
- **Depreciation Rate (5 Years)**
- **Maintenance to Mileage Ratio**

## 🛠 Sample SQL Snippets

```sql
-- Fuel Cost per 1000 km
SELECT 
    v.make,
    v.model,
    ROUND(1000 / v.mileage_kmpl * fp.price_per_litre, 2) AS fuel_cost_1000km
FROM vehicles v
JOIN fuel_price fp ON v.fuel_type = fp.fuel_type;

-- Feature Count
SELECT 
    v.make,
    v.model,
    COUNT(f.feature_id) AS feature_count
FROM vehicles v
LEFT JOIN features f ON v.vehicle_id = f.vehicle_id
GROUP BY v.vehicle_id, v.make, v.model;
📈 Insights Derived
Identify the best value-for-money vehicle based on cost, mileage, and resale.
Determine total cost of ownership for cost-conscious buyers.
Compare cars side-by-side for informed decision-making.
Understand how features and maintenance affect long-term usability.

💡 Future Enhancements
Add insurance cost and loan EMI options
Integrate with visualization tools like Power BI or Tableau
Automate insights via stored procedures or views


