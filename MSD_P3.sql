--1: Format-wise Summary of Matches and Total Runs 📊

SELECT MATCH_TYPE AS FORMAT,
COUNT(*) AS TOTAL_match,
SUM(Runs) AS RUNS
FROM MSD 
GROUP BY MATCH_TYPE

--2: Year-wise Summary of MS Dhoni's Batting Performance 📅
SELECT 
	EXTRACT(YEAR FROM DATE) AS YEAR,
	SUM(Runs) AS Yearly_Runs,
	COUNT(*) AS Innings_Played
FROM msd
GROUP BY YEAR
ORDER BY YEAR LIMIT 5;

--3. Format & Opposition-Wise Summary Query

SELECT opposition, COUNT(sr_no), match_type, SUM(runs)
FROM MSD
GROUP BY opposition, match_type
ORDER BY match_type DESC;

--4. Format & Opposition-wise Distribution of Half-Centuries and Centuries 🏏

SELECT match_type,opposition,
  COUNT(DISTINCT CASE WHEN runs BETWEEN 50 AND 99 THEN sr_no END) AS half_centuries,
  COUNT(DISTINCT CASE WHEN runs BETWEEN 100 AND 200 THEN sr_no END) AS centuries,
  SUM(CASE WHEN runs >= 50 THEN fours ELSE 0 END) AS total_fours,
  SUM(CASE WHEN runs >= 50 THEN sixes ELSE 0 END) AS total_sixes
FROM msd
WHERE runs BETWEEN 50 AND 200
GROUP BY match_type, opposition
ORDER BY match_type, opposition;


--5. Ground-wise Performance Analysis of MS Dhoni (50+ Scores Only) 🏟️

SELECT
  GROUND,
  COUNT(CASE WHEN Dismissal = 'run out' THEN 1 END) AS run_outs,
  COUNT(CASE WHEN Dismissal = 'caught' THEN 1 END) AS caught,
  COUNT(CASE WHEN Dismissal = 'bowled' THEN 1 END) AS bowled,
  COUNT(CASE WHEN Dismissal = 'lbw' THEN 1 END) AS lbw,
  COUNT(CASE WHEN Dismissal = 'not out' THEN 1 END) AS not_outs,
  AVG(sr) AS avg_strike_rate,
  SUM(runs) AS total_runs,
  SUM(fours) AS total_fours,
  SUM(sixes) AS total_sixes,
  SUM(ball_faced) AS total_balls_faced
FROM msd
GROUP BY GROUND
ORDER BY total_runs DESC;




