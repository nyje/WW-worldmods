
local S = mobs.intllib


-- Tree Monster (or Tree Gollum) by PilzAdam

mobs:register_mob("mobs_monster:tree_monster", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	attack_animals = true,
	--specific_attack = {"player", "mobs_animal:chicken"},
	reach = 2,
	damage = 2,
	hp_min = 7,
	hp_max = 33,
	armor = 100,
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.8, 0.4},
	visual = "mesh",
	mesh = "mobs_tree_monster.b3d",
	textures = {
		{"mobs_tree_monster.png"},
		{"mobs_tree_monster2.png"},
	},
	blood_texture = "default_wood.png",
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_treemonster",
	},
	walk_velocity = 1,
	run_velocity = 3,
	jump = true,
	view_range = 15,
	drops = {
		{name = "default:sapling", chance = 3, min = 1, max = 2},
		{name = "default:junglesapling", chance = 3, min = 1, max = 2},
		{name = "default:apple", chance = 2, min = 1, max=3},
	},
	water_damage = 0,
	lava_damage = 0,
	light_damage = 2,
	fall_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 24,
		walk_start = 25,
		walk_end = 47,
		run_start = 48,
		run_end = 62,
		punch_start = 48,
		punch_end = 62,
	},
})


mobs:spawn({
	name = "mobs_monster:tree_monster",
	nodes = rainbow.leaves,
	max_light = 7,
	chance = 7000,
	min_height = 0,
	day_toggle = false,
})


--mobs:register_egg("mobs_monster:tree_monster", S("Tree Monster"), "default_tree_top.png", 1)


mobs:alias_mob("mobs:tree_monster", "mobs_monster:tree_monster") -- compatibility
