/obj/item/storage/box/bloodpacks
	name = "blood packs bags"
	desc = "This box contains blood packs."
	icon_state = "sterile"
	preloaded = list(
		/obj/item/weapon/reagent_containers/blood/empty = 7
	)


/obj/item/weapon/reagent_containers/blood
	name = "BloodPack"
	desc = "Contains blood used for transfusion."
	icon = 'icons/obj/bloodpack.dmi'
	icon_state = "empty"
	volume = 200
	center_of_mass = list("x"=16, "y"=16)

	var/blood_type = null

/obj/item/weapon/reagent_containers/blood/initialize()
	. = ..()
	if(blood_type != null)
		name = "BloodPack [blood_type]"
		reagents.add_reagent("blood", 200, list("donor"=null,"viruses"=null,"blood_DNA"=null,"blood_type"=blood_type,"resistances"=null,"trace_chem"=null))
		update_icon()

/obj/item/weapon/reagent_containers/blood/on_reagent_change()
	update_icon()

/obj/item/weapon/reagent_containers/blood/update_icon()
	update_name()
	var/percent = round((reagents.total_volume / volume) * 100)
	switch(percent)
		if(0 to 9)
			icon_state = "empty"
		if(10 to 50)
			icon_state = "half"
		if(51 to INFINITY)
			icon_state = "full"

/obj/item/weapon/reagent_containers/blood/proc/update_name()
	var/list/data = reagents.get_data("blood")
	if(data)
		blood_type = data["blood_type"]
		name = "BloodPack [blood_type]"
		desc = "Contains blood used for transfusion."
		return
	name = "Empty BloodPack"
	desc = "Seems pretty useless... Maybe if there were a way to fill it?"

/obj/item/weapon/reagent_containers/blood/afterattack(var/obj/target, var/mob/user, var/flag)
	if(!flag)
		return
	..()

	if(user.a_intent == I_HELP)
		if(standard_feed_mob(user, target))
			return

/obj/item/weapon/reagent_containers/blood/standard_feed_mob(var/mob/user, var/mob/living/carbon/human/target)
	if(!istype(target) || target.species.reagent_tag != IS_VAMPIRE)
		return
	..()


/obj/item/weapon/reagent_containers/blood/APlus
	blood_type = "A+"

/obj/item/weapon/reagent_containers/blood/AMinus
	blood_type = "A-"

/obj/item/weapon/reagent_containers/blood/BPlus
	blood_type = "B+"

/obj/item/weapon/reagent_containers/blood/BMinus
	blood_type = "B-"

/obj/item/weapon/reagent_containers/blood/OPlus
	blood_type = "O+"

/obj/item/weapon/reagent_containers/blood/OMinus
	blood_type = "O-"

/obj/item/weapon/reagent_containers/blood/empty
	name = "Empty BloodPack"
	desc = "Seems pretty useless... Maybe if there were a way to fill it?"
	icon_state = "empty"