-- First Of All Creating Table Of Vechiles --

CREATE TABLE vehicles (
    vehicle_id INT PRIMARY KEY,
    make VARCHAR(50),
    model VARCHAR(50),
    variant VARCHAR(50),
    price INT,
    engine_cc INT,
    mileage_kmpl FLOAT,
    fuel_type VARCHAR(20)
);

--Insert Values Into Vechiles Table--

INSERT INTO vehicles VALUES
(1, 'Maruti', 'Swift Dzire', 'VXI', 1200000, 1200, 33, 'Petrol'),
(2, 'Honda', 'City', 'ZX', 1400000, 1199, 14, 'Petrol'),
(3, 'Hyundai', 'i20', 'Sportz', 950000, 1197, 22, 'Petrol'),
(4, 'Tata', 'Altroz', 'XZ', 880000, 1199, 23, 'Petrol'),
(5, 'Toyota', 'Glanza', 'G', 970000, 1197, 21, 'Petrol'),
(6, 'Kia', 'Sonet', 'HTK', 1050000, 1200, 19, 'Petrol'),
(7, 'Maruti', 'Baleno', 'Zeta', 980000, 1197, 22, 'Petrol'),
(8, 'Honda', 'Amaze', 'S CVT', 930000, 1199, 18, 'Petrol'),
(9, 'Hyundai', 'Aura', 'SX', 920000, 1197, 21, 'Petrol'),
(10, 'Renault', 'Triber', 'RXZ', 820000, 999, 20, 'Petrol');


-- Create Feautres Table --

CREATE TABLE features (
    feature_id INT PRIMARY KEY,
    vehicle_id INT,
    feature_name VARCHAR(100),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

-- Insert Table Into Features --

INSERT INTO features VALUES
(1, 1, 'ABS'),
(2, 1, 'Airbags'),
(3, 1, 'Reverse Camera'),
(4, 2, 'ABS'),
(5, 2, 'Sunroof'),
(6, 2, 'Cruise Control'),
(7, 3, 'Airbags'),
(8, 3, 'Power Steering'),
(9, 3, 'Touchscreen'),
(10, 4, 'ABS'),
(11, 4, 'Projector Headlamps'),
(12, 4, 'Apple CarPlay'),
(13, 5, 'Touchscreen'),
(14, 5, 'Automatic Climate Control'),
(15, 6, 'Airbags'),
(16, 6, 'ABS'),
(17, 6, 'LED DRLs'),
(18, 7, 'ABS'),
(19, 7, 'Keyless Entry'),
(20, 8, 'Cruise Control'),
(21, 8, 'Push Start'),
(22, 9, 'Touchscreen'),
(23, 9, 'Airbags'),
(24, 10, 'ABS'),
(25, 10, 'Reverse Parking Sensor');


-- Create Fuel Prices Table --

CREATE TABLE fuel_price (
    fuel_type VARCHAR(20) PRIMARY KEY,
    price_per_litre FLOAT
);


-- Insert Values Into Fuel Table--

INSERT INTO fuel_price VALUES 
('Petrol', 105);

-- Create Table customer_reviews

CREATE TABLE customer_reviews (
    review_id INT PRIMARY KEY,
    vehicle_id INT,
    customer_name VARCHAR(100),
    rating INT CHECK (rating BETWEEN 1 AND 5),
    satisfaction_level VARCHAR(50), -- e.g., 'Very Satisfied', 'Neutral'
    comments TEXT,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

-- Insert Values Into Customer Reviews 

INSERT INTO customer_reviews VALUES
(1, 1, 'Ravi Kumar', 5, 'Very Satisfied', 'Great mileage and value for money.'),
(2, 2, 'Pooja Sharma', 4, 'Satisfied', 'Smooth engine but mileage is average.'),
(3, 3, 'Aman Gupta', 3, 'Neutral', 'Average features and slightly overpriced.'),
(4, 1, 'Sneha Yadav', 4, 'Satisfied', 'Good performance for city use.'),
(5, 2, 'Rahul Singh', 2, 'Unsatisfied', 'Expected more features at this price.');

-- Create Maintenance_cost Table 

CREATE TABLE maintenance_cost 


CREATE TABLE maintenance_cost (
    vehicle_id INT PRIMARY KEY,
    annual_cost INT,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);


--Insert Values Into Maintance_Cost

INSERT INTO maintenance_cost (vehicle_id, annual_cost) VALUES
(1, 10000), -- Corolla
(2, 12000), -- Civic
(3, 18000), -- X5
(4, 20000), -- Q7
(5, 8000),  -- Fiesta
(6, 10000); -- Elantra

-- Create Table Resale Value 

CREATE TABLE resale_value (
    vehicle_id INT PRIMARY KEY,
    resale_after_3_years INT,
    resale_after_5_years INT,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);


-- Insert Values Into Resale_Vaalue 

INSERT INTO resale_value (vehicle_id, resale_after_3_years, resale_after_5_years) VALUES
(1, 800000, 600000),  -- Corolla
(2, 950000, 700000),  -- Civic
(3, 4000000, 3000000),-- X5
(4, 4500000, 3200000),-- Q7
(5, 500000, 350000),  -- Fiesta
(6, 700000, 550000);  -- Elantra




-- Now Analysis The Table According To Customer Opinion -- [ Add Some Null Values For Data Looking More Realisticcs)

-- View Full Car Profile 

SELECT 
    v.vehicle_id,
    v.make,
    v.model,
    v.price,
    v.mileage_kmpl,
    mc.annual_cost AS yearly_maintenance,
    rv.resale_after_3_years,
    rv.resale_after_5_years
FROM vehicles v
LEFT JOIN maintenance_cost mc ON v.vehicle_id = mc.vehicle_id
LEFT JOIN resale_value rv ON v.vehicle_id = rv.vehicle_id;


-- [1]  Fuel Cost per 1000 km --

SELECT 
    v.vehicle_id,
    v.make,
    v.model,
    ROUND(1000 / v.mileage_kmpl * fp.price_per_litre, 2) AS fuel_cost_1000km
FROM vehicles v
JOIN fuel_price fp ON v.fuel_type = fp.fuel_type;

-- [2]  Annual Cost of Ownership --

SELECT 
    v.vehicle_id,
    v.make,
    v.model,
    v.price,
    ROUND(15000 / v.mileage_kmpl * fp.price_per_litre, 2) AS annual_fuel_cost,
    (v.price + ROUND(15000 / v.mileage_kmpl * fp.price_per_litre, 2)) AS total_annual_cost
FROM vehicles v
JOIN fuel_price fp ON v.fuel_type = fp.fuel_type;

-- [3]  Feature Score (How many features each vehicle offers)

SELECT 
    v.vehicle_id,
    v.make,
    v.model,
    COUNT(f.feature_id) AS feature_count
FROM vehicles v
LEFT JOIN features f ON v.vehicle_id = f.vehicle_id
GROUP BY v.vehicle_id, v.make, v.model;


--[4] Overall Customer Value Score

SELECT 
    v.make,
    v.model,
    v.price,
    ROUND(15000 / v.mileage_kmpl * fp.price_per_litre, 2) AS annual_fuel_cost,
    COUNT(f.feature_id) AS feature_count,
    ROUND((v.price + 15000 / v.mileage_kmpl * fp.price_per_litre) / NULLIF(COUNT(f.feature_id), 0), 2) AS value_score
FROM vehicles v
JOIN fuel_price fp ON v.fuel_type = fp.fuel_type
LEFT JOIN features f ON v.vehicle_id = f.vehicle_id
GROUP BY v.vehicle_id, v.make, v.model, v.price, v.mileage_kmpl, fp.price_per_litre
ORDER BY value_score ASC; -- Lower score = better value

-- Total Cost of Ownership over 5 Years

SELECT 
    v.vehicle_id,
    v.make,
    v.model,
    v.price,
    mc.annual_cost * 5 AS total_maintenance,
    rv.resale_after_5_years,
    (v.price + (mc.annual_cost * 5) - rv.resale_after_5_years) AS total_cost_of_ownership
FROM vehicles v
JOIN maintenance_cost mc ON v.vehicle_id = mc.vehicle_id
JOIN resale_value rv ON v.vehicle_id = rv.vehicle_id
ORDER BY total_cost_of_ownership;

-- Cost per Kilometer Over 5 Years
--Assume 15,000 km driven per year → 75,000 km in 5 years

SELECT 
    v.make,
    v.model,
    ROUND((v.price + (mc.annual_cost * 5) - rv.resale_after_5_years) / 75000.0, 2) AS cost_per_km
FROM vehicles v
JOIN maintenance_cost mc ON v.vehicle_id = mc.vehicle_id
JOIN resale_value rv ON v.vehicle_id = rv.vehicle_id
ORDER BY cost_per_km;


-- Best Mileage vs Price Trade-Off

SELECT 
    v.make,
    v.model,
    v.price,
    v.mileage_kmpl,
    ROUND(v.mileage_kmpl / v.price, 4) AS mileage_per_rupee
FROM vehicles v
ORDER BY mileage_per_rupee DESC;


-- Compare Two Cars Side by Side

SELECT 
    v.make,
    v.model,
    v.price,
    v.mileage_kmpl,
    mc.annual_cost,
    rv.resale_after_5_years,
    (v.price + mc.annual_cost * 5 - rv.resale_after_5_years) AS total_cost_of_ownership
FROM vehicles v
JOIN maintenance_cost mc ON v.vehicle_id = mc.vehicle_id
JOIN resale_value rv ON v.vehicle_id = rv.vehicle_id
WHERE v.model IN ('Dzire', 'City');

--Value for Money Score
--Create a custom score that balances price, mileage, and resale.

SELECT 
    v.make,
    v.model,
    v.price,
    v.mileage_kmpl,
    rv.resale_after_5_years,
    ROUND(((rv.resale_after_5_years + (v.mileage_kmpl * 1000.0)) / v.price), 2) AS value_score
FROM vehicles v
JOIN resale_value rv ON v.vehicle_id = rv.vehicle_id
ORDER BY value_score DESC;


--Depreciation Rate (Loss in Value)
--How much value does a car lose over 5 years?

SELECT 
    v.make,
    v.model,
    v.price,
    rv.resale_after_5_years,
    ROUND(((v.price - rv.resale_after_5_years) * 100.0 / v.price), 2) AS depreciation_percent
FROM vehicles v
JOIN resale_value rv ON v.vehicle_id = rv.vehicle_id
ORDER BY depreciation_percent;


--Maintenance to Mileage Ratio
--Good for cost-conscious customers.

SELECT 
    v.make,
    v.model,
    mc.annual_cost,
    v.mileage_kmpl,
    ROUND(mc.annual_cost / v.mileage_kmpl, 2) AS maint_to_mileage_ratio
FROM vehicles v
JOIN maintenance_cost mc ON v.vehicle_id = mc.vehicle_id
ORDER BY maint_to_mileage_ratio;


--Custom Report: Cheapest to Own & Fuel Efficient

SELECT 
    v.make,
    v.model,
    v.price,
    v.mileage_kmpl,
    mc.annual_cost,
    rv.resale_after_5_years,
    (v.price + mc.annual_cost * 5 - rv.resale_after_5_years) AS total_cost,
    ROUND((v.price + mc.annual_cost * 5 - rv.resale_after_5_years) / 75000.0, 2) AS cost_per_km
FROM vehicles v
JOIN maintenance_cost mc ON v.vehicle_id = mc.vehicle_id
JOIN resale_value rv ON v.vehicle_id = rv.vehicle_id
WHERE v.mileage_kmpl > 15
ORDER BY total_cost;


--Top 3 Cars Based on Different Metrics
-- Top 3 cars with best mileage

SELECT TOP 3 make, model, mileage_kmpl
FROM vehicles
ORDER BY mileage_kmpl DESC;

---- Top 3 cheapest maintenance

SELECT TOP 3 v.make, v.model, mc.annual_cost
FROM vehicles v
JOIN maintenance_cost mc ON v.vehicle_id = mc.vehicle_id
ORDER BY mc.annual_cost ASC;


-- Top 3 resale value

SELECT TOP 3 v.make, v.model, rv.resale_after_5_years
FROM vehicles v
JOIN resale_value rv ON v.vehicle_id = rv.vehicle_id
ORDER BY rv.resale_after_5_years DESC;

--Ranking All Cars Based on Combined Criteria

SELECT 
    v.make,
    v.model,
    RANK() OVER (ORDER BY mileage_kmpl DESC) AS mileage_rank,
    RANK() OVER (ORDER BY mc.annual_cost ASC) AS maintenance_rank,
    RANK() OVER (ORDER BY rv.resale_after_5_years DESC) AS resale_rank
FROM vehicles v
JOIN maintenance_cost mc ON v.vehicle_id = mc.vehicle_id
JOIN resale_value rv ON v.vehicle_id = rv.vehicle_id;


--Best Cars Under a Budget (e.g., ₹13 Lakh)

SELECT 
    v.make,
    v.model,
    v.price,
    v.mileage_kmpl,
    rv.resale_after_5_years
FROM vehicles v
JOIN resale_value rv ON v.vehicle_id = rv.vehicle_id
WHERE v.price <= 1300000
ORDER BY v.mileage_kmpl DESC;


--Cars Losing the Most Value (High Depreciation)

SELECT 
    v.make,
    v.model,
    v.price,
    rv.resale_after_5_years,
    ROUND(((v.price - rv.resale_after_5_years) * 100.0 / v.price), 2) AS depreciation_percentage
FROM vehicles v
JOIN resale_value rv ON v.vehicle_id = rv.vehicle_id
ORDER BY depreciation_percentage DESC;


--Best Overall Performer (Scoring System)

SELECT
    v.make,
    v.model,
    RANK() OVER (ORDER BY v.mileage_kmpl DESC) AS mileage_rank,
    RANK() OVER (ORDER BY mc.annual_cost ASC) AS maintenance_rank,
    RANK() OVER (ORDER BY rv.resale_after_5_years DESC) AS resale_rank,
    (RANK() OVER (ORDER BY v.mileage_kmpl DESC) +
     RANK() OVER (ORDER BY mc.annual_cost ASC) +
     RANK() OVER (ORDER BY rv.resale_after_5_years DESC)) AS total_score
FROM vehicles v
JOIN maintenance_cost mc ON v.vehicle_id = mc.vehicle_id
JOIN resale_value rv ON v.vehicle_id = rv.vehicle_id
ORDER BY total_score;












