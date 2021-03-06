/datum/antagonist/changeling
	id = ROLE_CHANGELING
	role_text = "Changeling"
	role_text_plural = "Changelings"
	bantype = "changeling"
	feedback_tag = "changeling_objective"
	restricted_jobs = list("AI", "Cyborg")
	protected_jobs = list("Security Officer", "Warden", "Detective", "Head of Security", "Captain")
	welcome_text = "Use say \":g message\" to communicate with your fellow changelings. Remember: you get all of their absorbed DNA if you absorb them."
	flags = ANTAG_SUSPICIOUS | ANTAG_RANDSPAWN | ANTAG_VOTABLE
	antaghud_indicator = "hudchangeling"

/datum/antagonist/changeling/can_become_antag(var/datum/mind/player, var/ignore_role)
	if(player.current && ishuman(player.current))
		if(player.current.isSynthetic())
			return FALSE
	return ..()

/datum/antagonist/changeling/get_special_objective_text(var/datum/mind/player)
	return "<br><b>Changeling ID:</b> [player.changeling.changelingID].<br><b>Genomes Absorbed:</b> [player.changeling.absorbedcount]"

/datum/antagonist/changeling/update_antag_mob(var/datum/mind/player)
	..()
	player.current.make_changeling()

/datum/antagonist/changeling/create_objectives(var/datum/mind/changeling)
	if(!..())
		return

	//OBJECTIVES - Always absorb 5 genomes, plus random traitor objectives.
	//If they have two objectives as well as absorb, they must survive rather than escape
	//No escape alone because changelings aren't suited for it and it'd probably just lead to rampant robusting
	//If it seems like they'd be able to do it in play, add a 10% chance to have to escape alone

	new /datum/objective/absorb (changeling)
	new /datum/objective/assassinate (changeling)
	new /datum/objective/steal (changeling)

	switch(rand(1,100))
		if(1 to 80)
			if(!(locate(/datum/objective/escape) in changeling.objectives))
				new /datum/objective/escape (changeling)
		else
			if(!(locate(/datum/objective/survive) in changeling.objectives))
				new /datum/objective/survive (changeling)

/datum/antagonist/changeling/remove_antagonist(var/datum/mind/player, var/show_message, var/implanted)
	player.current.remove_changeling_powers()
	player.current.verbs -= /datum/changeling/proc/EvolutionMenu
	player.current.remove_language("Changeling")
	..()
