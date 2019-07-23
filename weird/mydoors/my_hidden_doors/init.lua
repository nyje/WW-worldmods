local hdoor_list = {   --Number , Description , default image
	{ "cobble" , "Hidden Cobble Door", "default_cobble"},
	{ "stone" , "Hidden Stone Door", "default_stone"},
	{ "wood", "Hidden Wood Door", "default_wood"},
	{ "brick", "Hidden Brick Door", "default_brick"},
	{ "furnace", "Hidden Furnace Door" , "mydoors_furnace" , "door7"},
	{ "chest", "Hidden Chest Door" , "mydoors_chest" , "door8"},
	{ "bookshelf", "Hidden Bookshelf Door" , "mydoors_bookshelf" , "door9"},
}

--print("[SECRET DOORS]")
for i in ipairs(hdoor_list) do
	local img = hdoor_list[i][1]
	local desc = hdoor_list[i][2]
	local dimg = hdoor_list[i][3]

    if img=="cobble" or img=="stone" or img=="wood" then
        for _, row in ipairs(rainbow.colours) do
            local mgroups
            if row[1]=="white" then
                mgroups = {choppy=2,cracky=2,door=1,colourable=1,not_in_creative_inventory=nil}
            else
                mgroups = {choppy=2,cracky=2,door=1,colourable=1,not_in_creative_inventory=1}
            end
            mgroups[img.."door"]=1
            --print("[SECRET DOORS]"..row[2]..img)
            doors.register_door("my_hidden_doors:"..row[1].."_hidden_door"..img, {
                description ="Colorable "..row[2].." "..desc.." Locked",
                inventory_image = "mydoors_plain_"..img.."_inv.png^[colorize:"..row[3],
                only_placer_can_open = false,
                --tiles = {{ name = "plain_"..img..".png^[colorize:"..row[3], backface_culling = true }},
                groups = mgroups,
                tiles = {{ name = "plain_"..img.."_32.png^[colorize:"..row[3], backface_culling = true }},
                protected = false,
            })
            minetest.register_craft({
                type="shapeless",
                output = "my_hidden_doors:"..row[1].."_hidden_door"..img.." 1",
                recipe = {"my_hidden_doors:hidden_door_grey", "group:"..img, "rainbow:dye_"..row[1]},
            })
            minetest.register_craft({
                type="shapeless",
                output = "my_hidden_doors:"..row[1].."_hidden_door"..img.." 1",
                recipe = {"group:"..img.."door", "rainbow:dye_"..row[1]},
            })
        end
    else
        doors.register_door("my_hidden_doors:hidden_door"..img, {
            description = desc.." Locked",
            inventory_image = "mydoors_"..img.."_inv.png",
            groups = {choppy=2,cracky=2,door=1},
            only_placer_can_open = false,
            tiles = {{ name = "mydoors_"..img..".png", backface_culling = true }},
            protected = false,
        })
    end
end

doors.register_door("my_hidden_doors:hidden_door_grey", {
	description = "Grey Door Locked",
	inventory_image = "mydoors_grey_inv.png",
	groups = {choppy=2,cracky=2,door=1},
	tiles = {{ name = "mydoors_grey.png", backface_culling = true }},
	protected = false,
})
-- Crafts

-- minetest.register_craft({
-- 	output = "my_hidden_doors:hidden_doorcobble 1",
-- 	recipe = {
-- 		{"my_hidden_doors:hidden_door_grey", "default:cobble", ""},
-- 		{"", "", ""},
-- 		{"", "", ""}
-- 	}
-- })
-- minetest.register_craft({
-- 	output = "my_hidden_doors:hidden_doorstone 1",
-- 	recipe = {
-- 		{"my_hidden_doors:hidden_door_grey", "default:stone", ""},
-- 		{"", "", ""},
-- 		{"", "", ""}
-- 	}
-- })
-- minetest.register_craft({
-- 	output = "my_hidden_doors:hidden_doorwood 1",
-- 	recipe = {
-- 		{"my_hidden_doors:hidden_door_grey", "default:wood", ""},
-- 		{"", "", ""},
-- 		{"", "", ""}
-- 	}
-- })
-- minetest.register_craft({
-- 	output = "my_hidden_doors:hidden_doorstone_brick 1",
-- 	recipe = {
-- 		{"my_hidden_doors:hidden_door_grey", "default:stonebrick", ""},
-- 		{"", "", ""},
-- 		{"", "", ""}
-- 	}
-- })
-- minetest.register_craft({
-- 	output = "my_hidden_doors:hidden_doordesert_cobble 1",
-- 	recipe = {
-- 		{"my_hidden_doors:hidden_door_grey", "default:desert_cobble", ""},
-- 		{"", "", ""},
-- 		{"", "", ""}
-- 	}
-- })
minetest.register_craft({
	output = "my_hidden_doors:hidden_doorfurnace 1",
	recipe = {
		{"my_hidden_doors:hidden_door_grey", "default:furnace", ""},
		{"", "", ""},
		{"", "", ""}
	}
})
minetest.register_craft({
	output = "my_hidden_doors:hidden_doorchest 1",
	recipe = {
		{"my_hidden_doors:hidden_door_grey", "default:chest", ""},
		{"", "", ""},
		{"", "", ""}
	}
})
minetest.register_craft({
	output = "my_hidden_doors:hidden_doorbookshelf 1",
	recipe = {
		{"my_hidden_doors:hidden_door_grey", "default:bookshelf", ""},
		{"", "", ""},
		{"", "", ""}
	}
})
minetest.register_craft({
	output = "my_hidden_doors:hidden_doorbrick 1",
	recipe = {
		{"my_hidden_doors:hidden_door_grey", "default:brick", ""},
		{"", "", ""},
		{"", "", ""}
	}
})
minetest.register_craft({
	output = "my_hidden_doors:hidden_door_grey 1",
	recipe = {
		{"my_door_wood:wood_dark_grey", "my_door_wood:wood_dark_grey", ""},
		{"my_door_wood:wood_dark_grey", "my_door_wood:wood_dark_grey", ""},
		{"my_door_wood:wood_dark_grey", "my_door_wood:wood_dark_grey", ""}
	}
})


