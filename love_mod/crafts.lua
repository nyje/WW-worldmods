
minetest.register_craft({
	output = 'love_mod:heart 7',
	recipe = {
		{"rainbow:wool_red",        "","rainbow:wool_red"},
		{"rainbow:wool_red","rainbow:wool_red","rainbow:wool_red"},
		{""        ,"rainbow:wool_red",""        },
	}
})

minetest.register_craft({
	output = 'love_mod:wand',
	recipe = {
		{"rainbow:wool_red"      ,"default:mese_crystal","rainbow:wool_red"      },
		{""              ,"default:stick"       ,""              },
		{"love_mod:heart","default:diamond"     ,"love_mod:heart"},
	}
})

minetest.register_craft({
	output = 'love_mod:sapling 8',
	recipe = {
		{"default:sapling","default:sapling","default:sapling"},
		{"default:sapling","love_mod:heart" ,"default:sapling"},
		{"default:sapling","default:sapling","default:sapling"},
	}
})

minetest.register_craft({
	output = 'love_mod:wood 4',
	recipe = {
		{'love_mod:tree'},
	}
})

minetest.register_craft({
	output = 'love_mod:wood_heart 4',
	recipe = {
		{'love_mod:tree_heart'},
	}
})

minetest.register_craft({
	output = 'love_mod:glass 8',
	recipe = {
		{"group:glass","group:glass" ,"group:glass"},
		{"group:glass","love_mod:heart","group:glass"},
		{"group:glass","group:glass" ,"group:glass"},
	}
})

minetest.register_craft({
	output = 'love_mod:heart_wall 14',
	recipe = {
		{'love_mod:heart'},
	}
})
