SELECT 
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    COUNT(DISTINCT s.id) AS savings_count,
    COUNT(DISTINCT p.id) AS investment_count,
    ROUND(SUM(s.confirmed_amount) / 100, 2) AS total_deposits
FROM users_customuser u
JOIN savings_savingsaccount s 
    ON u.id = s.owner_id AND s.confirmed_amount > 0
JOIN plans_plan p 
    ON u.id = p.owner_id AND p.is_a_fund = 1
WHERE EXISTS (
    SELECT 1 
    FROM savings_savingsaccount ss 
    WHERE ss.owner_id = u.id AND ss.confirmed_amount > 0
)
AND EXISTS (
    SELECT 1 
    FROM plans_plan pp 
    WHERE pp.owner_id = u.id AND pp.is_a_fund = 1
)
GROUP BY u.id, u.first_name, u.last_name
HAVING savings_count > 0 AND investment_count > 0
ORDER BY total_deposits DESC;
