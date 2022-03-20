SELECT pilots.pilot_id, pilots.name, pilots.age, pilots.rank, pilots.education_level, top_pilots.flight_count
	FROM pilots JOIN 
		(SELECT pil_id, count(*) AS flight_count 
			FROM
				(SELECT first_pilot_id as pil_id
					FROM flights
				WHERE YEAR(flight_dt) = 2022 AND plane_id IN (SELECT plane_id FROM planes WHERE cargo_flg = 1)
				UNION ALL 
				SELECT second_pilot_id as pil_id
					FROM flights
				WHERE YEAR(flight_dt) = 2022 AND plane_id IN (SELECT plane_id FROM planes WHERE cargo_flg = 1)) cargo_pilots
			GROUP BY cargo_pilots.pil_id
			ORDER BY flight_count desc limit 10) top_pilots
ON pilots.pilot_id = top_pilots.pil_id