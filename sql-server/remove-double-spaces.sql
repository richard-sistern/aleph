USE <database>;

-- Function to remove extra spaces
CREATE FUNCTION strip_spaces(@str varchar(8000))
RETURNS varchar(8000) AS
BEGIN
    WHILE CHARINDEX('  ', @str) > 0
        SET @str = REPLACE(@str, '  ', ' ')

    RETURN @str
END;

-- Return sanitised field with double spaces removed
SELECT dbo.strip_spaces(<field>) FROM dbo.<table>;

-- Update field to remove double spaces
UPDATE dbo.<table>
SET <field> = dbo.strip_spaces(<field>)
WHERE <field> LIKE '%  %';
