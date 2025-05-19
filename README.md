# DataAnalytics-Assessment

## Overview
This repository contains SQL solutions for a SQL Proficiency Assessment involving customer transaction analysis across multiple database tables.

---

## Questions & Explanations

### Q1. High-Value Customers with Multiple Products
**Goal:** Identify customers with both funded savings and investment plans, sorted by total deposits.

**Approach:** Joined savings and plans tables with user data and filtered based on conditions, aggregating deposit sums.

---

### Q2. Transaction Frequency Analysis
**Goal:** Segment customers based on average monthly transaction frequency.

**Approach:** Used CTEs to calculate monthly counts, average per customer, and frequency classification using `CASE`.

---

### Q3. Account Inactivity Alert
**Goal:** Flag accounts with no transactions in over 1 year.

**Approach:** Pulled last transaction date per account, then calculated the days of inactivity using `CURRENT_DATE`.

---

### Q4. Customer Lifetime Value Estimation
**Goal:** Estimate CLV using transaction volume and account tenure.

**Approach:** Computed tenure in months, joined with total and average transaction values, and calculated a simplified CLV formula.

---

## Challenges

- **Currency in Kobo:** All amounts were in Kobo and required conversion to Naira.
- **Handling Inactivity:** Ensured accounts with no transactions didn’t cause null errors.
- **Edge Cases:** Guarded against divide-by-zero for tenure = 0 in CLV.

---

## Repository Structure

