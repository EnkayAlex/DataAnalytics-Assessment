WITH customer_monthly_activity AS (
    SELECT 
        s.owner_id,
        COUNT(*) AS total_transactions,
        TIMESTAMPDIFF(MONTH, MIN(s.transaction_date), MAX(s.transaction_date)) + 1 AS months_active
    FROM savings_savingsaccount s
    WHERE s.transaction_date IS NOT NULL
    GROUP BY s.owner_id
),
categorized_customers AS (
    SELECT 
        c.owner_id,
        ROUND(c.total_transactions / c.months_active, 2) AS avg_tx_per_month,
        CASE
            WHEN c.total_transactions / c.months_active >= 10 THEN 'High Frequency'
            WHEN c.total_transactions / c.months_active BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM customer_monthly_activity c
)
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_tx_per_month), 2) AS avg_transactions_per_month
FROM categorized_customers
GROUP BY frequency_category
ORDER BY FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');
