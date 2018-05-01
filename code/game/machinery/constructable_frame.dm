//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:31

//Circuit boards are in /code/game/objects/items/weapons/circuitboards/machinery/

/obj/machinery/constructable_frame //Made into a seperate type to make future revisions easier.
	name = "machine frame"
	icon = 'icons/obj/stock_parts.dmi'
	icon_state = "box_0"
	density = 1
	anchored = 1
	use_power = 0
	var/list/components = null
	var/list/req_components = null
	var/list/req_component_names = null
	var/state = 1

/obj/machinery/constructable_frame/proc/update_desc()
	var/D
	if(req_components)
		var/list/component_list = new
		for(var/I in req_components)
			if(req_components[I] > 0)
				component_list += "[num2text(req_components[I])] [req_component_names[I]]"
		D = "Requires [english_list(component_list)]."
	desc = D

/obj/machinery/constructable_frame/machine_frame/attackby(obj/item/P as obj, mob/user as mob)
	if(P.crit_fail)
		user << SPAN_WARN("This part is faulty, you cannot add this to the machine!")
		return
	switch(state)
		if(1)
			if(istype(P, /obj/item/stack/cable_coil))
				var/obj/item/stack/cable_coil/C = P
				if (C.get_amount() < 5)
					user << SPAN_WARN("You need five lengths of cable to add them to the frame.")
					return
				playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
				user << SPAN_NOTE("You start to add cables to the frame.")
				if(do_after(user, 20) && state == 1)
					if(C.use(5))
						user << SPAN_NOTE("You add cables to the frame.")
						state = 2
						icon_state = "box_1"
			else
				if(istype(P, /obj/item/weapon/wrench))
					playsound(src.loc, 'sound/items/Ratchet.ogg', 75, 1)
					user << SPAN_NOTE("You dismantle the frame.")
					new /obj/item/stack/material/steel(src.loc, 5)
					qdel(src)
		if(2)
			if(istype(P, /obj/item/weapon/circuitboard))
				var/obj/item/weapon/circuitboard/B = P
				if(B.board_type == "machine")
					playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
					user << SPAN_NOTE("You add the circuit board to the frame.")
					circuit = P
					user.drop_from_inventory(P, src)
					icon_state = "box_2"
					state = 3
					components = list()
					req_components = circuit.req_components.Copy()
					for(var/A in circuit.req_components)
						req_components[A] = circuit.req_components[A]
					req_component_names = circuit.req_components.Copy()
					for(var/A in req_components)
						var/obj/ct = PoolOrNew(A, null) // have to quickly instantiate it get name
						req_component_names[A] = ct.name
					update_desc()
					user << desc
				else
					user << SPAN_WARN("This frame does not accept circuit boards of this type!")
			else
				if(istype(P, /obj/item/weapon/wirecutters))
					playsound(src.loc, 'sound/items/Wirecutter.ogg', 50, 1)
					user << SPAN_NOTE("You remove the cables.")
					state = 1
					icon_state = "box_0"
					var/obj/item/stack/cable_coil/A = new /obj/item/stack/cable_coil( src.loc )
					A.amount = 5

		if(3)
			if(istype(P, /obj/item/weapon/crowbar))
				playsound(src.loc, 'sound/items/Crowbar.ogg', 50, 1)
				state = 2
				circuit.loc = src.loc
				circuit = null
				if(components.len == 0)
					user << SPAN_WARN("You remove the circuit board.")
				else
					user << SPAN_NOTE("You remove the circuit board and other components.")
					for(var/obj/item/weapon/W in components)
						W.loc = src.loc
				desc = initial(desc)
				req_components = null
				components = null
				icon_state = "box_1"
			else
				if(istype(P, /obj/item/weapon/screwdriver))
					var/component_check = 1
					for(var/R in req_components)
						if(req_components[R] > 0)
							component_check = 0
							break
					if(component_check)
						playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
						var/obj/machinery/new_machine = new src.circuit.build_path(src.loc, src.dir)
						qdel(new_machine.circuit)
						new_machine.circuit = circuit

						if(new_machine.component_parts)
							new_machine.component_parts.Cut()
						else
							new_machine.component_parts = list()

						src.circuit.construct(new_machine)

						new_machine.component_parts += circuit
						circuit.loc = null

						for(var/obj/O in src)
							new_machine.component_parts += O
							O.loc = null

						new_machine.RefreshParts()
						qdel(src)
				else
					if(istype(P, /obj/item))
						for(var/I in req_components)
							if(istype(P, I) && (req_components[I] > 0))
								playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
								if(istype(P, /obj/item/stack/cable_coil))
									var/obj/item/stack/cable_coil/CP = P
									if(CP.get_amount() > 1)
										// amount of cable to take, idealy amount required,
										// but limited by amount provided
										var/camt = min(CP.amount, req_components[I])
										var/obj/item/stack/cable_coil/CC = new /obj/item/stack/cable_coil(src)
										CC.amount = camt
										CC.update_icon()
										CP.use(camt)
										components += CC
										req_components[I] -= camt
										update_desc()
										break
								user.drop_from_inventory(P, src)
								components += P
								req_components[I]--
								update_desc()
								break
						user << desc
						if(P && P.loc != src && !istype(P, /obj/item/stack/cable_coil))
							user << SPAN_WARN("You cannot add that component to the machine!")
