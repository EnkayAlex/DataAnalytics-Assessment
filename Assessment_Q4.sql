WITH transaction_summary AS (
    SELECT 
        s.owner_id,
        COUNT(*) AS total_transactions,
        SUM(s.confirmed_amount) / 100 AS total_amount_naira,
        AVG(s.confirmed_amount) / 100 AS avg_transaction_amount
    FROM savings_savingsaccount s
    WHERE s.confirmed_amount > 0
    GROUP BY s.owner_id
),
user_tenure AS (
    SELECT 
        u.id AS customer_id,
        CONCAT(u.first_name, ' ', u.last_name) AS name,
        TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months
    FROM users_customuser u
)
SELECT 
    u.customer_id,
    u.name,
    u.tenure_months,
    t.total_transactions,
    ROUND(
        (t.total_transactions / u.tenure_months) * 12 * (t.avg_transaction_amount * 0.001),
        2
    ) AS estimated_clv
FROM user_tenure u
JOIN transaction_summary t ON u.customer_id = t.owner_id
WHERE u.tenure_months > 0
ORDER BY estimated_clv DESC;
