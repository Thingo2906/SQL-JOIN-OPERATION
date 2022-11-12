--the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
SELECT matchid, player FROM goal WHERE teamid = 'GER';
--Show id, stadium, team1, team2 for just game 1012

SELECT id,stadium,team1,team2 FROM game
where id = '1012'

--Modify it to show the player, teamid, stadium and mdate for every German goal.

SELECT player, teamid, stadium, mdate FROM game JOIN goal
ON game.id=goal.matchid
WHERE goal.teamid = 'GER'

--Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'

SELECT team1, team2, player
FROM game JOIN goal
ON game.id=goal.matchid
WHERE goal.player LIKE 'Mario%'

--The table eteam gives details of every national team including the coach. You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id
--Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10

SELECT player, teamid, coach, gtime
FROM goal join eteam
WHERE goal.teamid=eteam.id
AND gtime <= 10

--To JOIN game with eteam you could use either
--game JOIN eteam ON (team1=eteam.id) or game JOIN eteam ON (team2=eteam.id)
--Notice that because id is a column name in both game and eteam you must specify eteam.id instead of just id
--List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.

SELECT mdate, teamname
from game join eteam
where game.team1=eteam.id
AND coach='Fernando Santos'

-- List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
SELECT player
FROM goal JOIN game
WHERE game.id=goal.matchid
AND stadium='National Stadium, Warsaw'

--The example query shows all goals scored in the Germany-Greece quarterfinal.
--Instead show the name of all players who scored a goal against Germany.

SELECT distinct player
FROM goal JOIN game
ON goal.matchid = game.id
WHERE (team1='GER' OR team2='GER')
AND goal.teamid<>'GER';

--Show teamname and the total number of goals scored.

SELECT teamname,count(*) as goal
FROM eteam JOIN goal
ON eteam.id=goal.teamid
GROUP BY teamname;

--Show the stadium and the number of goals scored in each stadium.

SELECT stadium,count(*)
FROM game JOIN goal
WHERE game.id=goal.matchid
GROUP BY stadium;

--For every match involving 'POL', show the matchid, date and the number of goals scored.

SELECT matchid,mdate,COUNT(*)
FROM game JOIN goal
ON goal.matchid = game.id
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid,mdate;

--For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'

SELECT matchid,mdate,COUNT(gtime)
FROM game INNER JOIN goal
ON goal.matchid = game.id
WHERE goal.teamid = 'GER'
GROUP BY matchid,mdate;