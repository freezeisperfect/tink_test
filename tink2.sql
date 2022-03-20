SELECT pilots.pilot_id, pilots.name, pilots.age, pilots.rank, pilots.education_level
	FROM pilots JOIN
		(SELECT first_pilot_id as pil_id
			FROM flights
		WHERE quantity >= 30 
		AND plane_id IN (SELECT plane_id FROM planes WHERE cargo_flg != 1)
		UNION
		SELECT second_pilot_id as pil_id
			FROM flights
		WHERE quantity >= 30 
		AND plane_id IN (SELECT plane_id FROM planes WHERE cargo_flg != 1)) pass_pilots
	ON pilots.pilot_id = pass_pilots.pil_id
	WHERE pilots.age >= 45