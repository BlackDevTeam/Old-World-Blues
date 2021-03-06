/obj/item/weapon/gun/launcher/rocket
	name = "rocket launcher"
	desc = "MAGGOT."
	icon_state = "rocket"
	item_state = "rocket"
	w_class = ITEM_SIZE_HUGE
	throw_speed = 2
	throw_range = 10
	force = 5.0
	flags =  CONDUCT
	slot_flags = 0
	origin_tech = list(TECH(T_COMBAT) = 8, TECH(T_MATERIAL) = 5)
	fire_sound = 'sound/effects/bang.ogg'

	release_force = 15
	throw_distance = 30
	var/max_rockets = 1
	var/list/rockets = new/list()

/obj/item/weapon/gun/launcher/rocket/examine(mob/user, return_dist=1)
	.=..()
	if(.<=2)
		user << SPAN_NOTE("[rockets.len] / [max_rockets] rockets.")

/obj/item/weapon/gun/launcher/rocket/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/ammo_casing/rocket))
		if(rockets.len < max_rockets)
			user.drop_from_inventory(I, src)
			rockets += I
			user << SPAN_NOTE("You put the rocket in [src].")
			user << SPAN_NOTE("[rockets.len] / [max_rockets] rockets.")
		else
			usr << "\red [src] cannot hold more rockets."

/obj/item/weapon/gun/launcher/rocket/consume_next_projectile()
	if(rockets.len)
		var/obj/item/ammo_casing/rocket/I = rockets[1]
		var/obj/item/missile/M = new (src)
		M.primed = 1
		rockets -= I
		return M
	return null

/obj/item/weapon/gun/launcher/rocket/handle_post_fire(mob/user, atom/target)
	log_game("[key_name_admin(user)] used a rocket launcher ([src.name]) at [target].", target)
	..()
