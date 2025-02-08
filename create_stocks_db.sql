CREATE TABLE IF NOT EXISTS stocks (
     date      DATE
    ,symbol    TEXT
    ,open      REAL
    ,high      REAL
    ,low       REAL
    ,close     REAL
    ,volume    INTEGER
    ,PRIMARY KEY (date, symbol)
);

CREATE VIEW mature_stocks AS
	WITH final_codes AS (
		SELECT symbol, MIN(date) AS start_date
		FROM stocks
		GROUP BY symbol
		HAVING start_date < '2022-01-01'
		ORDER BY start_date
	)
	SELECT
		 s.date
		,s.symbol
		,s.open
		,s.high
		,s.low
		,s.close
		,s.volume
	FROM 
		stocks s RIGHT JOIN final_codes f ON s.symbol = f.symbol
	WHERE
		s.date >= '2022-01-01' AND s.date <= '2025-02-07'
	ORDER BY
		s.symbol, s.date;