WITH savings_last_tx AS (
    SELECT 
        owner_id,
        MAX(transaction_date) AS last_transaction_date
    FROM savings_savingsaccount
    WHERE transaction_date IS NOT NULL
    GROUP BY owner_id
),
all_accounts AS (
    SELECT 
        p.id AS plan_id,
        p.owner_id,
        CASE 
            WHEN p.is_regular_savings = 1 THEN 'Savings'
            WHEN p.is_a_fund = 1 THEN 'Investment'
            ELSE NULL
        END AS type
    FROM plans_plan p
    WHERE p.is_regular_savings = 1 OR p.is_a_fund = 1
)
SELECT 
    a.plan_id,
    a.owner_id,
    a.type,
    COALESCE(s.last_transaction_date, 'N/A') AS last_transaction_date,
    DATEDIFF(CURDATE(), s.last_transaction_date) AS inactivity_days
FROM all_accounts a
LEFT JOIN savings_last_tx s ON a.owner_id = s.owner_id
WHERE s.last_transaction_date IS NULL OR DATEDIFF(CURDATE(), s.last_transaction_date) > 365
ORDER BY inactivity_days DESC;
