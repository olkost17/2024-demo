WITH
  -- Step 1: Get the distinct status changes for each request, in chronological order.
  -- This is equivalent to your 'Sorted' and the 'Table.Distinct' inside your grouping.
  DistinctStatusChanges
  AS (
    SELECT
      MATERIAL_REQUEST_ID,
      NEW_STATUS,
      DATE_TIME,
      -- Assign a row number to each status change for a given request
      ROW_NUMBER() OVER (
        PARTITION BY
          MATERIAL_REQUEST_ID
        ORDER BY
          DATE_TIME
      ) AS rn
    FROM
      -- Use a subquery to de-duplicate rows with the exact same status and timestamp
      (
        SELECT DISTINCT
          MATERIAL_REQUEST_ID,
          NEW_STATUS,
          DATE_TIME,
          [Date], -- Assuming you have these columns in LogData
          SortOrder
        FROM
          LogData
      ) AS DistinctLogs
  ),
  -- Step 2: Create the 'ValidUntil' column by looking at the next status change.
  -- This is the SQL equivalent of your complex 'List.Skip' and table reconstruction.
  StatusWithTimeline
  AS (
    SELECT
      MATERIAL_REQUEST_ID,
      NEW_STATUS,
      DATE_TIME,
      [Date],
      SortOrder,
      -- Use the LEAD window function to get the DATE_TIME from the *next* row
      -- for the same MATERIAL_REQUEST_ID.
      LEAD(DATE_TIME, 1, '2099-12-31 23:59:59') OVER (
        PARTITION BY
          MATERIAL_REQUEST_ID
        ORDER BY
          DATE_TIME
      ) AS ValidUntil
    FROM
      DistinctStatusChanges
  )
-- Step 3: Final calculations, equivalent to your last steps.
SELECT
  MATERIAL_REQUEST_ID,
  NEW_STATUS,
  DATE_TIME,
  [Date],
  SortOrder,
  ValidUntil,
  -- Calculate duration in days (as a decimal)
  CAST(
    DATEDIFF(
      ss,
      DATE_TIME,
      -- Use GETDATE() for current items, otherwise use ValidUntil
      CASE
        WHEN ValidUntil > GETDATE() THEN GETDATE()
        ELSE ValidUntil
      END
    ) AS FLOAT
  ) / 86400.0 AS DaysInStatus,
  -- Add the 'is_current' flag
  CASE
    WHEN ValidUntil > '2098-12-31' THEN 'Current'
    ELSE 'Historical'
  END AS is_current
FROM
  StatusWithTimeline
ORDER BY
  MATERIAL_REQUEST_ID,
  DATE_TIME;


------------------------------------------------------------------------------------------

WITH
  -- 1. Identify the first chronological occurrence of each status for each request.
  FilteredLogs
  AS (
    SELECT
      MATERIAL_REQUEST_ID,
      NEW_STATUS,
      DATE_TIME,
      -- For each request and status, number the entries by time. 
      -- The earliest one will get a 'StatusInstance' of 1.
      ROW_NUMBER() OVER (
        PARTITION BY
          MATERIAL_REQUEST_ID,
          NEW_STATUS
        ORDER BY
          DATE_TIME ASC
      ) AS StatusInstance
    FROM
      QM_STARLIMS_DATA.dbo.MAT_REQ_FLOW_LOG
    WHERE
      DATE_TIME >= DATEFROMPARTS(YEAR(GETDATE()) - 1, 1, 1)
  ),
  -- 2. Build the timeline using ONLY the first occurrences.
  StatusWithTimeline
  AS (
    SELECT
      MATERIAL_REQUEST_ID,
      NEW_STATUS,
      DATE_TIME,
      -- Use LEAD to get the start time of the *next* status.
      LEAD(DATE_TIME, 1, '2099-12-31 23:59:59') OVER (
        PARTITION BY
          MATERIAL_REQUEST_ID
        ORDER BY
          DATE_TIME
      ) AS ValidUntil
    FROM
      FilteredLogs
    WHERE
      StatusInstance = 1 -- This is the crucial filter that removes the extra rows.
  )
-- 3. Final calculations and formatting.
SELECT
  MATERIAL_REQUEST_ID,
  NEW_STATUS,
  DATE_TIME,
  ValidUntil,
  CAST(
    DATEDIFF(
      ss,
      DATE_TIME,
      CASE
        WHEN ValidUntil > GETDATE() THEN GETDATE()
        ELSE ValidUntil
      END
    ) AS FLOAT
  ) / 86400.0 AS DaysInStatus,
  CASE
    WHEN ValidUntil > '2098-12-31' THEN 'Current'
    ELSE 'Historical'
  END AS is_current
FROM
  StatusWithTimeline
ORDER BY
  MATERIAL_REQUEST_ID,
  DATE_TIME;  


  ------------------------------------------------------------------------

WITH
  -- 1. Identify the first chronological occurrence of each status for each request.
  FilteredLogs
  AS (
    SELECT
      MATERIAL_REQUEST_ID,
      NEW_STATUS,
      PREVIOUS_STATUS, -- Added this column
      USRNAM,          -- Added this column
      DATE_TIME,
      -- For each request and status, number the entries by time. 
      -- The earliest one will get a 'StatusInstance' of 1.
      ROW_NUMBER() OVER (
        PARTITION BY
          MATERIAL_REQUEST_ID,
          NEW_STATUS
        ORDER BY
          DATE_TIME ASC
      ) AS StatusInstance
    FROM
      QM_STARLIMS_DATA.dbo.MAT_REQ_FLOW_LOG
    WHERE
      DATE_TIME >= DATEFROMPARTS(YEAR(GETDATE()) - 1, 1, 1)
  ),
  -- 2. Build the timeline using ONLY the first occurrences.
  StatusWithTimeline
  AS (
    SELECT
      MATERIAL_REQUEST_ID,
      NEW_STATUS,
      PREVIOUS_STATUS, -- Carry this column forward
      USRNAM,          -- Carry this column forward
      DATE_TIME,
      -- Use LEAD to get the start time of the *next* status.
      LEAD(DATE_TIME, 1, '2099-12-31 23:59:59') OVER (
        PARTITION BY
          MATERIAL_REQUEST_ID
        ORDER BY
          DATE_TIME
      ) AS ValidUntil
    FROM
      FilteredLogs
    WHERE
      StatusInstance = 1 -- This is the crucial filter that removes the extra rows.
  )
-- 3. Final calculations and formatting.
SELECT
  MATERIAL_REQUEST_ID,
  NEW_STATUS,
  PREVIOUS_STATUS, -- Added to the final output
  USRNAM,          -- Added to the final output
  DATE_TIME,
  ValidUntil,
  CAST(
    DATEDIFF(
      ss,
      DATE_TIME,
      CASE
        WHEN ValidUntil > GETDATE() THEN GETDATE()
        ELSE ValidUntil
      END
    ) AS FLOAT
  ) / 86400.0 AS DaysInStatus,
  CASE
    WHEN ValidUntil > '2098-12-31' THEN 'Current'
    ELSE 'Historical'
  END AS is_current
FROM
  StatusWithTimeline
ORDER BY
  MATERIAL_REQUEST_ID,
  DATE_TIME;  