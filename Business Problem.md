### Business Problem: Chocolate Sales Performance Analysis and Optimization

The company specializes in the production and distribution of chocolates across various regions. With 13 months of sales and shipment data, the goal is to identify actionable insights to improve sales, optimize costs, and enhance operational efficiency. Due to limited historical data, year-over-year (YoY) comparisons are not feasible, but Month-over-Month (MoM) and Quarter-over-Quarter (QoQ) trends will provide valuable insights for short-term performance monitoring.

---

### Objectives for the Dashboards

#### **1. Sales Performance Analysis**
- **Objective**: Analyze overall sales trends across different products, regions, and salespeople.
- **Key Metrics**:
  - Total Sales
  - MoM and QoQ growth in sales
  - Top-performing products and regions
  - Sales contribution by salespeople
- **Questions to Address**:
  - Which products are generating the most revenue?
  - How do sales vary across different regions?
  - Which salesperson contributes the most to total sales?

---

#### **2. Cost and Profitability Analysis**
- **Objective**: Understand the cost structure and profitability of shipments.
- **Key Metrics**:
  - Total Costs (based on boxes shipped and cost per box)
  - Total Profits (Sales - Costs)
  - Profit Margins (%) at product and regional levels
- **Questions to Address**:
  - Which regions/products have the highest profit margins?
  - Are there specific products or shipments that are operating at a loss?

---

#### **3. Shipment Volume and Efficiency**
- **Objective**: Evaluate shipment performance to identify bottlenecks and inefficiencies.
- **Key Metrics**:
  - Total Boxes Shipped
  - Shipment Status (Delivered vs Pending)
  - Low-volume shipments (e.g., <50 boxes)
- **Questions to Address**:
  - Are there regions/products with consistent low-volume shipments?
  - How does shipment performance vary across time (e.g., months, quarters)?

---

#### **4. Month-over-Month (MoM) and Quarter-over-Quarter (QoQ) Trends**
- **Objective**: Track short-term sales growth and identify seasonal trends.
- **Key Metrics**:
  - MoM growth rate in Sales, Profit, and Shipments
  - QoQ growth rate in Sales, Profit, and Shipments
- **Questions to Address**:
  - Which months or quarters show the highest growth in sales or shipments?
  - Are there seasonal patterns in product demand?

---

#### **5. Regional and Product-Level Insights**
- **Objective**: Drill down into performance by region and product categories.
- **Key Metrics**:
  - Sales, Cost, Profit, and Shipments by Region and Product
  - Regional and product-wise contribution to total sales
- **Questions to Address**:
  - Which regions/products are underperforming?
  - Are there specific regions or products with high costs but low profits?

---

#### **6. Operational and Strategic Decision Support**
- **Objective**: Provide actionable insights for improving operational efficiency and strategic planning.
- **Key Metrics**:
  - Shipment turnaround times (if data available)
  - Profitability of salespeople
  - Cost vs Revenue by product and region
- **Questions to Address**:
  - How can low-performing products or regions be improved?
  - Are there opportunities to optimize costs and increase profitability?

---

### Business Problem Statement

The company wants to achieve sustainable growth by optimizing sales performance, reducing costs, and enhancing profitability. The dashboards will provide insights into:
1. Product and regional performance to identify strengths and weaknesses.
2. Shipment efficiency and bottlenecks to improve logistics.
3. Short-term sales trends (MoM, QoQ) to adapt strategies dynamically.


---

## **1. Sales Performance Analysis**

#### **DAX Measures**
1. **Total Sales**:
   ```DAX
   Total Sales = SUM(Fact_Shipments[Amount])
   ```

2. **Total Boxes Shipped**:
   ```DAX
   Total Boxes = SUM(Fact_Shipments[Boxes])
   ```

3. **Average Sales per Box**:
   ```DAX
   Avg Sales per Box = DIVIDE([Total Sales], [Total Boxes])
   ```

4. **Sales by Region**:
   ```DAX
   Sales by Region = 
   SUMMARIZE(
       Dim_Geography,
       Dim_Geography[Region],
       "Region Sales", SUM(Fact_Shipments[Amount])
   )
   ```

5. **Top Products by Sales**:
   ```DAX
   Top Products = 
   TOPN(
       5,
       SUMMARIZE(
           Dim_Products,
           Dim_Products[Product],
           "Product Sales", SUM(Fact_Shipments[Amount])
       ),
       [Product Sales], DESC
   )
   ```

---

### **2. Cost and Profitability Analysis**

#### **DAX Measures**
1. **Total Cost**:
   ```DAX
   Total Cost = 
   SUMX(
       Fact_Shipments,
       Fact_Shipments[Boxes] * RELATED(Dim_Products[Cost_per_box])
   )
   ```

2. **Total Profit**:
   ```DAX
   Total Profit = [Total Sales] - [Total Cost]
   ```

3. **Profit Margin (%)**:
   ```DAX
   Profit Margin = DIVIDE([Total Profit], [Total Sales]) * 100
   ```

4. **Cost by Region**:
   ```DAX
   Cost by Region = 
   SUMMARIZE(
       Dim_Geography,
       Dim_Geography[Region],
       "Total Cost", [Total Cost]
   )
   ```

---

### **3. Shipment Volume and Efficiency**

#### **DAX Measures**
1. **Total Shipments (Boxes)**:
   ```DAX
   Total Shipments = SUM(Fact_Shipments[Boxes])
   ```

2. **Low Volume Shipments (<50 Boxes)**:
   ```DAX
   Low Volume Shipments = 
   CALCULATE(
       COUNT(Fact_Shipments[ShipmentID]),
       Fact_Shipments[Boxes] < 50
   )
   ```

3. **Pending Shipments**:
   ```DAX
   Pending Shipments = 
   CALCULATE(
       COUNT(Fact_Shipments[ShipmentID]),
       Fact_Shipments[Order_Status] = "Pending"
   )
   ```

---

### **4. Month-over-Month (MoM) and Quarter-over-Quarter (QoQ) Trends**

#### **DAX Measures**
1. **MoM Sales Growth**:
   ```DAX
   MoM Sales Growth = 
   DIVIDE(
       [Total Sales] - CALCULATE([Total Sales], PREVIOUSMONTH(Dim_Calendar[cal_date])),
       CALCULATE([Total Sales], PREVIOUSMONTH(Dim_Calendar[cal_date]))
   )
   ```

2. **QoQ Sales Growth**:
   ```DAX
   QoQ Sales Growth = 
   DIVIDE(
       [Total Sales] - CALCULATE([Total Sales], PREVIOUSQUARTER(Dim_Calendar[cal_date])),
       CALCULATE([Total Sales], PREVIOUSQUARTER(Dim_Calendar[cal_date]))
   )
   ```

3. **Cumulative Sales**:
   ```DAX
   Cumulative Sales = 
   CALCULATE(
       [Total Sales],
       DATESYTD(Dim_Calendar[cal_date])
   )
   ```

---

### **5. Regional and Product-Level Insights**

#### **DAX Measures**
1. **Sales by Product and Region**:
   ```DAX
   Sales by Product and Region = 
   SUMMARIZE(
       Fact_Shipments,
       Dim_Products[Product],
       Dim_Geography[Region],
       "Total Sales", [Total Sales]
   )
   ```

2. **Profit by Product**:
   ```DAX
   Profit by Product = 
   SUMMARIZE(
       Dim_Products,
       Dim_Products[Product],
       "Total Profit", [Total Profit]
   )
   ```

---

### **6. Visualizations in Power BI**

#### **Sales Analysis**
- **Bar Chart**: Sales by Product.
- **Map or Bar Chart**: Sales by Region.
- **KPI Cards**: Total Sales, Total Profit, Total Boxes Shipped.

#### **Profitability Analysis**
- **Clustered Bar Chart**: Total Sales, Costs, and Profits by Product or Region.
- **Pie Chart**: Profit Margin (%) by Region or Product.

#### **Shipment Analysis**
- **Bar Chart**: Low-volume shipments (<50 Boxes) by Region or Product.
- **Table**: Shipment details with Pending and Delivered status.

#### **Time Intelligence**
- **Line Chart**: Total Sales over time with MoM or QoQ growth rates.
- **KPI Cards**: MoM Sales Growth (%), QoQ Sales Growth (%).

---

### Next Steps
1. **Define Relationships**:
   - Fact_Shipments → Dim_Products, Dim_Geography, Dim_Salesperson, Dim_Calendar.
2. **Load the above DAX measures into Power BI**.
3. **Build dashboards with visuals** using slicers for interactivity.
