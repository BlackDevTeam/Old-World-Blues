/**********************Mineral stacking unit console**************************/

/obj/machinery/mineral/stacking_unit_console
	name = "stacking machine console"
	icon = 'icons/obj/machines/mining_machines.dmi'
	icon_state = "console"
	density = 1
	anchored = 1
	var/obj/machinery/mineral/stacking_machine/machine = null
	var/machinedir = SOUTHEAST

/obj/machinery/mineral/stacking_unit_console/initialize()
	. = ..()
	var/area/my_area = get_area(src)
	if(my_area)
		src.machine = locate() in my_area.contents
		if (machine)
			machine.console = src

/obj/machinery/mineral/stacking_unit_console/attack_hand(mob/user)
	add_fingerprint(user)
	interact(user)

/obj/machinery/mineral/stacking_unit_console/interact(mob/user)
	user.set_machine(src)

	var/dat

	dat += text("<h1>Stacking unit console</h1><hr><table>")

	for(var/stacktype in machine.stack_storage)
		if(machine.stack_storage[stacktype] > 0)
			dat += "<tr><td width = 150><b>[capitalize(stacktype)]:</b></td>"
			dat += "<td width = 30>[machine.stack_storage[stacktype]]</td>"
			dat += "<td width = 50><A href='?src=\ref[src];release_stack=[stacktype]'>\[release\]</a></td></tr>"
	dat += "</table><hr>"
	dat += text("<br>Stacking: [machine.stack_amt] <A href='?src=\ref[src];change_stack=1'>\[change\]</a><br><br>")

	user << browse("[dat]", "window=console_stacking_machine")
	onclose(user, "console_stacking_machine")


/obj/machinery/mineral/stacking_unit_console/Topic(href, href_list)
	if(..())
		return 1

	if(href_list["change_stack"])
		var/choice = input("What would you like to set the stack amount to?") as null|anything in list(1,5,10,20,50)
		if(!choice)
			return
		machine.stack_amt = choice

	if(href_list["release_stack"])
		var/material = href_list["release_stack"]
		if(machine.stack_storage[material] > 0)
			create_material_stacks(material, machine.stack_storage[material], get_turf(machine.output))
			machine.stack_storage[href_list["release_stack"]] = 0

	src.add_fingerprint(usr)
	src.updateUsrDialog()

/**********************Mineral stacking unit**************************/

/obj/machinery/mineral/stacking_machine
	name = "stacking machine"
	icon = 'icons/obj/machines/mining_machines.dmi'
	icon_state = "stacker"
	density = 1
	anchored = 1.0
	var/obj/machinery/mineral/stacking_unit_console/console
	var/obj/machinery/mineral/input = null
	var/obj/machinery/mineral/output = null
	var/list/stack_storage[0]
	var/stack_amt = 50 // Amount to stack before releassing

/obj/machinery/mineral/stacking_machine/initialize()
	. = ..()
	for (var/dir in cardinal)
		src.input = locate(/obj/machinery/mineral/input, get_step(src, dir))
		if(src.input) break
	for (var/dir in cardinal)
		src.output = locate(/obj/machinery/mineral/output, get_step(src, dir))
		if(src.output) break

/obj/machinery/mineral/stacking_machine/process()
	var/update = FALSE
	if(src.output && src.input)
		var/turf/T = get_turf(input)
		for(var/obj/item/O in T.contents)
			if(ismaterial(O))
				var/obj/item/stack/material/M = O
				update |= TRUE
				var/material = M.get_material_name()
				if(material in stack_storage)
					stack_storage[material] += M.amount
				else
					stack_storage[material] = M.amount
				qdel(M)
			else
				O.forceMove(output.loc)

	//Output amounts that are past stack_amt.
	for(var/material in stack_storage)
		update |= TRUE
		if(stack_storage[material] >= stack_amt)
			create_material_stacks(material, stack_amt, get_turf(output))
			stack_storage[material] -= stack_amt

	if(update)
		console.updateUsrDialog()
	return

