/datum/game_mode/uprising
	name = "Revolution & Cult"
	config_tag = "uprising"
	round_description = "Some crewmembers are attempting to start a revolution while a cult plots in the shadows!"
	extended_round_description = "Cultists and revolutionaries spawn in this round."
	required_players = 15
	required_enemies = 3
	end_on_antag_death = 1
	antag_tags = list(ROLE_REVOLUTIONARY, ROLE_LOYALIST, ROLE_CULTIST)
	require_all_templates = 1
	votable = 0