minetest.register_alias("tnt:tnt", "air")

minetest.register_chatcommand("ping", {
    privs = {server = true},
    params = "",
    description = "Get ip & ping of players",
    func = function(player_name, param)
		for i, player in pairs(minetest.get_connected_players()) do
			local name = player:get_player_name()
			if name then
				local ping = minetest.get_player_information(name).avg_rtt / 2
				ping = math.floor(ping * 1000)
				minetest.chat_send_player(player_name, "     "..name.." IP:"..minetest.get_player_information(name).address.."  Ping: "..ping.."ms")
			end
		end
	end
})

minetest.register_chatcommand("wit", {
    privs = {server = true},
    params = "",
    description = "Get itemstring of wielded item",
    func = function(player_name, param)
	local player = minetest.get_player_by_name(player_name)
	minetest.chat_send_player(player_name, player:get_wielded_item():to_string())
	return
    end
})

minetest.register_chatcommand("eday", {
    privs = {settime = true},
    params = "<player_name>",
    description = "Eternal Day (It never gets dark.)",
    func = function(player_name, param)
        minetest.set_timeofday(0.5)
        minetest.setting_set("time_speed","0")
    end
})

-- minetest.register_chatcommand("info", {
--     params = "<player_name>",
--     description = "Get network information of player",
--     privs = {server = true},
--     func = function(player_name, param)
--     	if not param then
--     	    minetest.chat_send_player(player_name, "Player " .. param .. " was not found")
--             return
--         end
--         playerInfo = minetest.get_player_information(param)
--         minetest.chat_send_player(player_name, param ..
--             " - IP address - " .. playerInfo["address"])
--         minetest.chat_send_player(player_name, param ..
--             " - Avg rtt - " .. playerInfo["avg_rtt"])
--         minetest.chat_send_player(player_name, param ..
--             " - Connection uptime (seconds) - " .. playerInfo["connection_uptime"])
--         return
--     end
-- })

rainbow={}
rainbow.config={}
rainbow.modpath = minetest.get_modpath("rainbow")

-- stairsplus:register_alias_force_all("moreblocks", "obsidian", "rainbow", "stone_black")
-- stairsplus:register_alias_force_all("moreblocks", "goldblock", "rainbow", "clayblock_gold")
-- stairsplus:register_alias_force_all("moreblocks", "steelblock", "rainbow", "clayblock_white")
-- stairsplus:register_alias_force_all("moreblocks", "copperblock", "rainbow", "clayblock_orange")
-- stairsplus:register_alias_force_all("moreblocks", "bronzeblock", "rainbow", "clayblock_orange")
-- stairsplus:register_alias_force_all("moreblocks", "diamondblock", "rainbow", "clayblock_cyan")
-- stairsplus:register_alias_force_all("moreblocks", "meselamp", "rainbow", "lightblock_gold")
-- stairsplus:register_alias_force_all("moreblocks", "mese", "rainbow", "stoneblock_yellow")



rainbow.colours = {
	{"white",      "White",      "#ffffffc0",   "rainbow:daisies",              {50,50},4},
	{"cyan",       "Cyan",       "#00ffffc0",   "rainbow:tulip",                {75,90},5},
	{"magenta",    "Magenta",    "#ff00ffc0",   "rainbow:dianthus",             {45,80},6},
	{"yellow",     "Yellow",     "#ffff00c0",   "rainbow:dandelion",            {10,75},7},
	{"black",      "Black",      "#000000c0",   "default:coal_lump",            {65,65},8},
	{"red",        "Red",        "#ff0000c0",   "rainbow:mushroom_red",         {35,60},9},
	{"green",      "Green",      "#5a8041c0",   "rainbow:junglegrass",          {95,50},10},
	{"blue",       "Blue",       "#0000ffc0",   "rainbow:geranium",             {49,49},11},
	{"pink",       "Pink",       "#ff9090c0",   "rainbow:rose",                 {20,50},12},
	{"brown",      "Brown",      "#a78c45c0",   "rainbow:mushroom_brown",       {65,35},13},
	{"lightgreen", "Light Green","#b5ff81c0",   "rainbow:greenery",             {35,35},14},
	{"violet",     "Violet",     "#900090c0",   "rainbow:violet",               {75,20},15},
	{"grey",       "Grey",       "#909090c0",   "rainbow:",                     {50,50},16},
	{"orange",     "Orange",     "#ff8401c0",   "rainbow:orangeflower",         {20,25},17},
	{"darkgrey",   "Dark Grey",  "#303030c0",   "rainbow:cookieflower",         {90,30},18},
	{"darkbrown",  "Dark Brown", "#5C4033c0",   "",                             {68,38},19},
	{"darkred",    "Dark Red",   "#800000c0",   "",                             {68,38},19},
	{"gold",       "Gold",       "#ffd700c0",   "",                             {68,38},19},
	{"lightblue",  "Light Blue", "#0091ffc0",   "caverealms:glow_gem",          {68,38},19},
	{"darkyellow",  "Dark Yellow", "#ffc30ec0",   "",                           {68,38},19},
	{"darkorange",  "Dark Orange", "#ff5d00c0",   "",                           {68,38},19},
	{"sand",        "Sand",       "#c2c260c0",   "",                           {68,38},19},
    }


rainbow.dirts={}
rainbow.stones={}
rainbow.leaves={}
rainbow.clut={}
for _, row in ipairs(rainbow.colours) do
    rainbow.clut[row[1]]={row[2],row[3],row[4],row[5]}
    table.insert(rainbow.dirts, "rainbow:dirt_"..row[1])
    table.insert(rainbow.stones, "rainbow:stone_"..row[1])
    table.insert(rainbow.stones, "rainbow:cobble_"..row[1])
    table.insert(rainbow.leaves, "rainbow:leaves_"..row[1])
end

function rainbow.grow_papyrus(pos, node)
	pos.y = pos.y - 1
	if not minetest.find_node_near(pos, 3, {"group:water"}) then
		return
	end
	pos.y = pos.y + 1
	local height = 0
	while node.name == "rainbow:papyrus" and height < 8 do
		height = height + 1
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if height == 4 or node.name ~= "air" then
		return
	end
	if minetest.get_node_light(pos) < 13 then
		return
	end
	minetest.set_node(pos, {name = "rainbow:papyrus"})
	return true
end

minetest.register_abm({
	label = "Grow papyrus",
	nodenames = {"rainbow:papyrus"},
	--neighbors = {"group:dirt"},
	interval = 28,
	chance = 35,
	action = function(...)
		rainbow.grow_papyrus(...)
	end
})

function rainbow.dig_up(pos, node, digger)
	if digger == nil then return end
	local np = {x = pos.x, y = pos.y + 1, z = pos.z}
	local nn = minetest.get_node(np)
	if nn.name == node.name then
		minetest.node_dig(np, nn, digger)
	end
end

rainbow.nhide = function(nodename)
    if minetest.registered_nodes[nodename] then
        local groupz = minetest.registered_nodes[nodename].groups
        groupz.not_in_creative_inventory=1
        minetest.override_item(nodename, {
            groups=groupz
        })
    end
end

local nhide = rainbow.nhide


--minetest.register_alias("wool:white", "rainbow:wool_white")


--minetest.register_alias("default:papyrus","rainbow:papyrus")

dofile(rainbow.modpath .. "/nodes.lua")
dofile(rainbow.modpath .. "/mapgen.lua")
dofile(rainbow.modpath .. "/bucket.lua")

WATER_ALPHA = minetest.registered_nodes["rainbow:white_water_source"].alpha
WATER_VISC = minetest.registered_nodes["rainbow:white_water_source"].liquid_viscosity

for node,_ in pairs(minetest.registered_nodes) do
    if node:find("default:") then
        if not node:find("bronze") and
           not node:find("copper") and
           not node:find("steel") and
           not node:find("tin") and
           not node:find("gold") and
           not node:find("mese") and
           not node:find("diamond") and
           not node:find("obsidian") and
           not node:find("book") and
           not node:find("torch") and
           not node:find("lump") and
           not node:find("ladder") and
           not node:find("shovel") and
           not node:find("sign") and
           not node:find("chest") and
           not node:find("axe") and
           not node:find("pick") and
           not node:find("sword") and
           not node:find("furnace") then
           --print("smelly "..node)
           nhide(node)
        end
        if node:find("stone_with") then
           nhide(node)
        end
    end
    if node:find("doors") then
        if node:find("gate") then
           nhide(node)
        end
    end
    if node:find("walls") then
        nhide(node)
    end
--     if node:find("moreblocks") and (not node:find("saw")) then
--         nhide(node)
--     end
--     if node:find("fence") and not node:find("white") then
--         nhide(node)
--     end
end

-- minetest.register_craft({
-- 	output = 'default:furnace',
-- 	recipe = {
-- 		{'group:cobble', 'group:cobble', 'group:cobble'},
-- 		{'group:cobble', '', 'group:cobble'},
-- 		{'group:cobble', 'group:cobble', 'group:cobble'},
-- 	}
-- })





--
-- nhide("doors:gate_acacia_wood_closed")
-- nhide("doors:gate_aspen_wood_closed")
-- nhide("doors:gate_junglewood_closed")
-- nhide("doors:gate_pine_wood_closed")
-- nhide("doors:gate_wood_closed")
--
-- nhide("default:dirt")
-- nhide("default:dirt_with_snow")
-- nhide("default:dirt_with_grass")
-- nhide("default:dirt_with_dry_grass")
-- nhide("default:desert_sand")
-- nhide("default:desert_sandstone")
-- nhide("default:desert_sandstone_block")
-- nhide("default:desert_sandstone_brick")
-- nhide("default:sand")
-- nhide("default:meselamp")
-- nhide("default:stone")
-- nhide("default:sandstone")
-- nhide("default:desert_stone")
-- nhide("default:stone_block")
-- nhide("default:sandstone_block")
-- nhide("default:desert_stone_block")
-- nhide("default:stone_with_coal")
-- nhide("default:stone_with_iron")
-- nhide("default:stone_with_diamond")
-- nhide("default:stone_with_gold")
-- nhide("default:stone_with_mese")
-- nhide("default:stone_with_copper")
-- nhide("default:stonebrick")
-- nhide("default:sandstonebrick")
-- nhide("default:desert_stonebrick")
-- nhide("default:acacia_bush_leaves")
-- nhide("default:acacia_bush_stem")
-- nhide("default:acacia_leaves")
-- nhide("default:acacia_tree")
-- nhide("default:acacia_wood")
-- nhide("default:acacia_sapling")
-- nhide("default:jungleleaves")
-- nhide("default:jungletree")
-- nhide("default:junglewood")
-- nhide("default:junglesapling")
-- nhide("default:aspen_leaves")
-- nhide("default:aspen_tree")
-- nhide("default:aspen_sapling")
-- nhide("default:aspen_wood")
-- nhide("default:bush_leaves")
-- nhide("default:bush_stem")
-- nhide("default:cactus")
-- nhide("default:clay")
-- nhide("default:clay_lump")
-- nhide("default:desert_cobble")
-- nhide("default:coral_orange")
-- nhide("default:coral_brown")
-- nhide("default:coral_skeleton")
-- nhide("default:gravel")
-- nhide("default:ice")
-- nhide("default:junglegrass")
-- nhide("default:grass_1")
-- nhide("default:desert_sand")
-- nhide("default:dry_grass_1")
-- nhide("default:glass")
-- nhide("default:leaves")
-- nhide("default:mossycobble")
-- nhide("default:pine_needles")
-- nhide("default:pine_sapling")
-- nhide("default:pine_tree")
-- nhide("default:pine_wood")
-- nhide("default:sapling")
-- nhide("default:lava_source")
-- nhide("default:water_source")
-- nhide("default:river_water_source")
-- nhide("default:wood")
-- nhide("default:tree")
-- nhide("default:snow")
-- nhide("default:snowblock")
-- nhide("default:silver_sand")
-- nhide("default:silver_sandstone")
-- nhide("default:silver_sandstone_block")
-- nhide("default:silver_sandstone_brick")
-- nhide("default:papyrus")
-- nhide("default:apple")
-- nhide("default:diamond")
-- nhide("default:dry_shrub")
-- nhide("default:desert_sand")


