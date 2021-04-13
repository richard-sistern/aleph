-- Grant view permission to object definitions on a specfic database
-- covers objects like stored procedures, triggers, functions and indexes

-- GRANT
USE <database>
GO
GRANT VIEW DEFINITION TO <user>

-- REVOKE
USE <database>
GO
REVOKE VIEW DEFINITION TO <user>

-- source: https://www.sqlshack.com/an-overview-of-a-view-definition-permission-in-sql-server/
