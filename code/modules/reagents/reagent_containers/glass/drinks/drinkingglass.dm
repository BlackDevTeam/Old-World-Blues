

/obj/item/weapon/reagent_containers/glass/drinks/drinkingglass
	name = "glass"
	desc = "Your standard drinking glass."
	icon_state = "glass_empty"
	amount_per_transfer_from_this = 5
	volume = 30
	isGlass = TRUE
	center_of_mass = list("x"=16, "y"=10)

	on_reagent_change()
		/*if(reagents.reagent_list.len > 1 )
			icon_state = "glass_brown"
			name = "Glass of Hooch"
			desc = "Two or more drinks, mixed together."*/
		/*else if(reagents.reagent_list.len == 1)
			for(var/datum/reagent/R in reagents.reagent_list)
				switch(R.id)*/
		if (reagents.reagent_list.len > 0)
			var/datum/reagent/R = reagents.get_master_reagent()

			if(R.glass_icon_state)
				icon_state = R.glass_icon_state
			else
				icon_state = "glass_brown"

			if(R.glass_name)
				name = R.glass_name
			else
				name = "Glass of.. what?"

			if(R.glass_desc)
				desc = R.glass_desc
			else
				desc = "You can't really tell what this is."

			if(R.glass_center_of_mass)
				center_of_mass = R.glass_center_of_mass
			else
				center_of_mass = list("x"=16, "y"=10)
		else
			icon_state = "glass_empty"
			name = "glass"
			desc = "Your standard drinking glass."
			center_of_mass = list("x"=16, "y"=10)
			return

// for /obj/machinery/vending/sovietsoda
/obj/item/weapon/reagent_containers/glass/drinks/drinkingglass/soda
	preloaded = list("sodawater" = 50)

/obj/item/weapon/reagent_containers/glass/drinks/drinkingglass/cola
	preloaded = list("cola" = 50)

/obj/item/weapon/reagent_containers/glass/drinks/drinkingglass/throw_impact()
	if(isGlass)
		icon_state = "glass_empty"
		..()