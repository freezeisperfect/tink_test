SELECT pilots.pilot_id, pilots.name, pilots.age, pilots.rank, pilots.education_level
	FROM pilots JOIN 
		(SELECT second_pilot_id
			FROM flights
		WHERE destination = 'Шереметьево' AND MONTH(flight_dt) = 8 AND YEAR(flight_dt) = 2021
		GROUP BY second_pilot_id
		HAVING count(second_pilot_id) >= 3) sec_sher_pilots
	ON sec_sher_pilots.second_pilot_id = pilots.pilot_id