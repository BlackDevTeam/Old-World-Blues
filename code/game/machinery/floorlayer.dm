/obj/machinery/floorlayer

	name = "automatic floor layer"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "pipe_d"
	density = 1
	var/turf/old_turf
	var/on = 0
	var/obj/item/stack/tile/T
	var/list/mode = list("dismantle"=0,"laying"=0,"collect"=0)

/obj/machinery/floorlayer/initialize()
	T = new/obj/item/stack/tile/steel(src)
	. = ..()

/obj/machinery/floorlayer/Move(new_turf,M_Dir)
	..()

	if(on)
		if(mode["dismantle"])
			dismantleFloor(old_turf)

		if(mode["laying"])
			layFloor(old_turf)

		if(mode["collect"])
			CollectTiles(old_turf)


	old_turf = new_turf

/obj/machinery/floorlayer/attack_hand(mob/user as mob)
	on=!on
	user.visible_message(
		SPAN_NOTE("[user] has [!on?"de":""]activated \the [src]."),
		SPAN_NOTE("You [!on?"de":""]activate \the [src].")
	)
	return

/obj/machinery/floorlayer/attackby(var/obj/item/W as obj, var/mob/user as mob)

	if (istype(W, /obj/item/weapon/wrench))
		var/m = input("Choose work mode", "Mode") as null|anything in mode
		mode[m] = !mode[m]
		var/O = mode[m]
		user.visible_message(
			SPAN_NOTE("[usr] has set \the [src] [m] mode [!O?"off":"on"]."),
			SPAN_NOTE("You set \the [src] [m] mode [!O?"off":"on"].")
		)
		return

	if(istype(W, /obj/item/stack/tile))
		user << SPAN_NOTE("\The [W] successfully loaded.")
		user.drop_from_inventory(W, T)
		TakeTile(T)
		return

	if(istype(W, /obj/item/weapon/crowbar))
		if(!length(contents))
			user << SPAN_NOTE("\The [src] is empty.")
		else
			var/obj/item/stack/tile/E = input("Choose remove tile type.", "Tiles") as null|anything in contents
			if(E)
				user <<  SPAN_NOTE("You remove the [E] from /the [src].")
				E.forceMove(src.loc)
				T = null
		return

	if(istype(W, /obj/item/weapon/screwdriver))
		T = input("Choose tile type.", "Tiles") as null|anything in contents
		return
	..()

/obj/machinery/floorlayer/examine(mob/user)
	. = ..()
	var/amount = T ? "has [T.get_amount()] tiles\s" : "don't has tiles"
	var/dismantle = mode["dismantle"] ? "dismantle is on" : "dismantle is off"
	var/laying = mode["laying"] ? "laying is on" : "laying is off"
	var/collect = mode["collect"] ? "collect is on" : "collect is off"
	user << SPAN_NOTE("\The [src] [amount], [dismantle], [laying], [collect].")

/obj/machinery/floorlayer/proc/reset()
	on=0
	return

/obj/machinery/floorlayer/proc/dismantleFloor(var/turf/new_turf)
	if(istype(new_turf, /turf/simulated/floor))
		var/turf/simulated/floor/T = new_turf
		if(!T.is_plating())
			if(!T.broken && !T.burnt)
				new T.floor_type(T)
			T.make_plating()
	return !new_turf.intact

/obj/machinery/floorlayer/proc/TakeNewStack()
	for(var/obj/item/stack/tile/tile in contents)
		T = tile
		return 1
	return 0

/obj/machinery/floorlayer/proc/SortStacks()
	for(var/obj/item/stack/tile/tile1 in contents)
		for(var/obj/item/stack/tile/tile2 in contents)
			tile2.transfer_to(tile1)

/obj/machinery/floorlayer/proc/layFloor(var/turf/w_turf)
	if(!T)
		if(!TakeNewStack())
			return 0
	w_turf.attackby(T , src)
	return 1

/obj/machinery/floorlayer/proc/TakeTile(var/obj/item/stack/tile/tile)
	if(!T)
		T = tile
	tile.forceMove(src)

	SortStacks()

/obj/machinery/floorlayer/proc/CollectTiles(var/turf/w_turf)
	for(var/obj/item/stack/tile/tile in w_turf)
		TakeTile(tile)
