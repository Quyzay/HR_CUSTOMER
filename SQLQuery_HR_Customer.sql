
ALTER TABLE YourTable
ALTER COLUMN Joining_Date DATE;

UPDATE YourTable
SET Salary = (
    SELECT AVG(Salary) FROM YourTable WHERE Salary IS NOT NULL
)
WHERE Salary IS NULL;


WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Name ORDER BY Name) AS rn
    FROM YourTable
)
DELETE FROM CTE WHERE rn > 1;

-- 2. Tạo Productivity Group
ALTER TABLE hr_dashboard ADD Productivity_Group VARCHAR(20);
UPDATE hr_dashboard 
SET Productivity_Group = 
    CASE 
        WHEN `Productivity_(%)` < 50 THEN 'Low'
        WHEN `Productivity_(%)` <= 80 THEN 'Medium'
        ELSE 'High'
    END;
