//////Exile implants will allow you to use the station gate, but not return home. This will allow security to exile badguys/for badguys to exile their kill targets////////


/obj/item/weapon/implanter/exile
	name = "implanter-exile"
	start_with = /obj/item/weapon/implant/exile

/obj/item/weapon/implant/exile
	name = "exile"
	desc = "Prevents you from returning from away missions"

	get_data()
		var/dat = {"
<b>Implant Specifications:</b><BR>
<b>Name:</b> Nanotrasen Employee Exile Implant<BR>
<b>Implant Details:</b> The onboard gateway system has been modified to reject entry by individuals containing this implant<BR>"}
		return dat

/obj/item/weapon/implantcase/exile
	name = "Glass Case- 'Exile'"
	desc = "A case containing an exile implant."
	icon = 'icons/obj/items.dmi'
	icon_state = "implantcase-r"
	imp = /obj/item/weapon/implant/exile


/obj/structure/closet/secure_closet/exile
	name = "Exile Implants"
	req_access = list(access_hos)

/obj/structure/closet/secure_closet/exile/willContatin()
	return list(
		/obj/item/weapon/implanter/exile = 1,
		/obj/item/weapon/implantcase/exile = 5
	)