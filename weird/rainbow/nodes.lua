local get_color = function(nodename)
    if minetest.registered_nodes[nodename].groups.colourable ~= nil then
        local nametable = string.split(nodename, "_")
        for i,v in ipairs(nametable) do
            if rainbow.clut[v]~=nil then
                    return v
            end
        end
    end
    return nil
end

rainbow.get_color = get_color

local box	= {-0.5,-0.5,-0.5,0.5,-0.45,0.5}




rainbow.register_fence = function(name, def)
    minetest.register_craft({
        output = name .. " 4",
        recipe = {
            { def.material, 'group:stick', def.material },
            { def.material, 'group:stick', def.material },
        }
    })

    local fence_texture = "default_fence_overlay.png^" .. def.texture ..
            "^default_fence_overlay.png^[makealpha:255,126,126"
    -- Allow almost everything to be overridden
    local default_fields = {
        paramtype = "light",
        drawtype = "nodebox",
        node_box = {
            type = "connected",
            fixed = {{-1/8, -1/2, -1/8, 1/8, 1/2, 1/8}},
            -- connect_top =
            -- connect_bottom =
            connect_front = {{-1/16,3/16,-1/2,1/16,5/16,-1/8},
                {-1/16,-5/16,-1/2,1/16,-3/16,-1/8}},
            connect_left = {{-1/2,3/16,-1/16,-1/8,5/16,1/16},
                {-1/2,-5/16,-1/16,-1/8,-3/16,1/16}},
            connect_back = {{-1/16,3/16,1/8,1/16,5/16,1/2},
                {-1/16,-5/16,1/8,1/16,-3/16,1/2}},
            connect_right = {{1/8,3/16,-1/16,1/2,5/16,1/16},
                {1/8,-5/16,-1/16,1/2,-3/16,1/16}},
        },
        connects_to = {"group:fence", "group:wood", "group:tree", "group:wall"},
        inventory_image = fence_texture,
        wield_image = fence_texture,
        tiles = {def.texture},
        groups = {},
        sunlight_propagates = true,
        is_ground_content = false,
    }
    for k, v in pairs(default_fields) do
        if def[k] == nil then
            def[k] = v
        end
    end

    -- Always add to the fence group, even if no group provided
    def.groups.fence = 1
    if string.find(name,"rainbow:") and name~="rainbow:fence_white" then
        def.groups.not_in_creative_inventory = 1
    end
    def.groups.colourable = 1
    def.groups.cracky = 3
    def.groups.crumbly = 3
    def.groups.snappy = 3
    def.texture = nil
    def.material = nil

    minetest.register_node(name, def)
end


rainbow.add_pillar = function(node,row)
    local pname = string.split(node.name, ":")[2]
    local pcol = get_color(node.name)

    local uta = false
    if string.find(pname,'cool') then
        uta=true
    end
    local cgroups = node.groups

    if pcol=="white" then
        cgroups.not_in_creative_inventory=nil
    end

    minetest.register_node("rainbow:column_bottom_"..pname, {
        drawtype = "nodebox",
        description = "Colorable "..node.description.." Column Base",
        tiles = node.tiles,
        use_texture_alpha = uta,
        groups = cgroups,
        sounds = default.node_sound_stone_defaults(),
        light_source = node.light_source,
        paramtype = "light",
        paramtype2 = "facedir",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.500000,-0.500000,-0.500000,0.500000,-0.375000,0.500000},
                {-0.375000,-0.375000,-0.375000,0.375000,-0.125000,0.375000},
                {-0.250000,-0.125000,-0.250000,0.250000,0.500000,0.250000},
            },
        },
    })

    minetest.register_node("rainbow:column_top_"..pname, {
        drawtype = "nodebox",
        description = "Colorable "..node.description.." Column Top",
        tiles = node.tiles,
        use_texture_alpha = uta,
        groups = cgroups,
        sounds = default.node_sound_stone_defaults(),
        light_source = node.light_source,
        paramtype = "light",
        paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            {-0.500000,0.312500,-0.500000,0.500000,0.500000,0.500000},
            {-0.375000,0.062500,-0.375000,0.375000,0.312500,0.375000},
            {-0.250000,-0.500000,-0.250000,0.250000,0.062500,0.250000},
        },
    },
    })

    minetest.register_node("rainbow:column_middle_"..pname, {
        drawtype = "nodebox",
        description = "Colorable "..node.description.." Column Middle",
        tiles = node.tiles,
        use_texture_alpha = uta,
        groups = cgroups,
        sounds = default.node_sound_stone_defaults(),
        light_source = node.light_source,
        paramtype = "light",
        paramtype2 = "facedir",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.250000,-0.500000,-0.250000,0.250000,0.500000,0.250000},
            },
        },
    })
end

local pillar_craft = function(gr,mat)
    minetest.register_craft({
        output = 'rainbow:column_top_'..mat..'_white 4',
        recipe = {
            {'group:'..gr,'group:'..gr,'group:'..gr},
            {'','group:'..gr,''},
        }
    })
    minetest.register_craft({
        output = 'rainbow:column_middle_'..mat..'_white 3',
        recipe = {
            {'','group:'..gr,''},
            {'','group:'..gr,''},
            {'','group:'..gr,''},
        }
    })
    minetest.register_craft({
        output = 'rainbow:column_top_'..mat..'_white 5',
        recipe = {
            {'','group:'..gr,''},
            {'','group:'..gr,''},
            {'group:'..gr,'group:'..gr,'group:'..gr},
        }
    })
end
pillar_craft("wood","wood")
pillar_craft("stone","stone")
pillar_craft("ccobble","cobble")
pillar_craft("stonebrick","stonebrick")
pillar_craft("lightblock","lightblock")
pillar_craft("clay","clay")
pillar_craft("coolglass","coolglass")
pillar_craft("coral","coral")




rainbow.add_node = function(a,b,c,d,e)
    local nodename = "rainbow:"..a.."_" .. c[1]


    if string.find(a,":") then
        nodename = a.."_" .. c[1]
    end
    local node = e
    local tiles={}
    if e.ctiles then
        tiles = e.ctiles
    else
        local k = ""
        local v = ""
        for k,v in pairs(e.tiles) do
            table.insert(tiles, v .. "^[colorize:" .. c[3] )
        end
    end

    if e.wield_image then node.wield_image=e.wield_image.."^[colorize:"..c[3] end
    if e.inventory_image then node.inventory_image=e.inventory_image.."^[colorize:"..c[3] end
    node.groups[a] = 1
    node.groups.colourable = 1
    node.description = "Colourable "..c[2].." "..b
    if c[1]~="white" then
        node.groups.not_in_creative_inventory = 1
    end
    node.tiles = tiles
	node.on_place = minetest.rotate_node,
    minetest.register_node( nodename, node)
    minetest.register_craft({
        type = "shapeless",
        output = nodename,
        recipe = { "group:"..a, "rainbow:dye_"..c[1] }
    })
    if string.find(d,"saw") then
        stairsplus:register_all("rainbow", a.."_"..c[1], nodename, node)
    end
    if string.find(d,"col") then
        rainbow.add_pillar(node,c)
    end
end

local add_node = rainbow.add_node

local add_ore_node = function(a,b,c,d,e,f)
    e.groups.colourable = 1
    e.groups[a] = 1
    e.groups.not_in_creative_inventory = 1
    --minetest.register_alias("rainbow:"..a.."_" .. c[1],"rainbow:stone_"..c[1])
    local ls
    if a=="coalore" and c[1]=="black" then
        ls = 4
    end
    minetest.register_node("rainbow:"..a.."_" .. c[1], {
        description = "Colourable "..c[2].." "..b,
        tiles = {e.tiles[1].."^[colorize:"..c[3].."^"..f},
        groups = e.groups,
        light_source = ls,
        drop = d,
     })
end

local recolor = function(nodename,color)
    local nametable = string.split(nodename, "_")
    local resname=nametable[1]
    for i,v in ipairs(nametable) do
        if i>1 then
            if rainbow.clut[v]~=nil then
                resname=resname.."_"..color
            else
                resname=resname.."_"..v
            end
        end
    end
    return resname
end


local orelist={ ["copper"]={"default","C8800D","copper"},
                ["gold"]={"default","FFFF00","gold"},
                ["iron"]={"default","A95230","steel"},
                ["tin"]={"default","909090","tin"},
                ["mithril"]={"moreores","0000F0","mithril"},
                ["silver"]={"moreores","BBBBBB","silver"}
              }


for ore,nfo in pairs(orelist) do
    minetest.register_craftitem("rainbow:"..ore.."_pellets", {
        description = "Coarse ground "..ore.. " dust, Needs further grinding" ,
        inventory_image = "rainbow_ground.png^[colorize:#"..nfo[2]..":180",
    })
    minetest.register_craft({
        type = "cooking",
        output = nfo[1]..":"..nfo[3].."_ingot",
        recipe = "rainbow:"..ore.."_pellets",
    })
    minetest.register_craftitem("rainbow:"..ore.."_dust", {
        description = "Fine ground "..ore.. " dust, ready for extraction" ,
        inventory_image = "rainbow_dust.png^[colorize:#"..nfo[2]..":180",
    })
    minetest.register_craft({
        type = "cooking",
        output = nfo[1]..":"..nfo[3].."_ingot 2",
        recipe = "rainbow:"..ore.."_dust",
    })
end

local fgroups

for _, row in ipairs(rainbow.colours) do
    if row[1]~="white" then
        fgroups = {choppy = 3, oddly_breakable_by_hand = 2, colourable=1, not_in_creative_inventory = 1}
    else
        fgroups = {choppy = 3, oddly_breakable_by_hand = 2, colourable=1}
    end

    local ffgroups=fgroups
    ffgroups.brick = 1
    ffgroups.colourable = 1
    minetest.register_node("rainbow:fancybrick_"..row[1], {
        description = row[2].." Fancy Brick",
        tiles = {"plain_render.png^[colorize:"..row[3].."^(rainbow_brick.png^[opacity:80)^rainbow_mortar.png"},
        is_ground_content = false,
        groups = ffgroups,
        sounds = default.node_sound_stone_defaults(),
     })
    minetest.register_craft({
        type = "shapeless",
        output = "rainbow:fancybrick_"..row[1],
        recipe = { "group:brick", "rainbow:dye_"..row[1] }
    })
    stairsplus:register_all("rainbow", "fancybrick_"..row[1], "rainbow:fancybrick_"..row[1], minetest.registered_nodes["rainbow:fancybrick_"..row[1]])

    local walpha = tonumber( row[3]:sub(8,9), 16)
    local wred = tonumber( row[3]:sub(2,3), 16)
    local wgreen = tonumber( row[3]:sub(4,5), 16)
    local wblue = tonumber( row[3]:sub(6,7), 16)
    --print( row[3].." is a:"..walpha.." r:"..wred.." g:"..wgreen.." b:"..wblue )

    minetest.register_node("rainbow:"..row[1].."_water_source", {
        description = row[2].." Water Source",
        drawtype = "liquid",
        tiles = {
            {
                name = "default_water_source_animated.png^[colorize:"..row[3],
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 2.0,
                },
            },
        },
        special_tiles = {
            {
                name = "default_river_water_source_animated.png^[colorize:"..row[3],
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 2.0,
                },
                backface_culling = false,
            },
        },        alpha = 160,
        paramtype = "light",
        walkable = false,
        pointable = false,
        diggable = false,
        buildable_to = true,
        is_ground_content = false,
        light_source = default.LIGHT_MAX,
        drop = "",
        drowning = 1,
        liquidtype = "source",
        liquid_alternative_flowing = "rainbow:"..row[1].."_water_flowing",
        liquid_alternative_source = "rainbow:"..row[1].."_water_source",
        liquid_viscosity = 1,
        post_effect_color = {a = walpha, r = wred, g = wgreen, b = wblue},
        groups = {water = 3, liquid = 3, puts_out_fire = 1, cools_lava = 1, colourable = 1, not_in_creative_inventory = 1} ,
        --groups = {water = 3, liquid = 3, puts_out_fire = 1, cools_lava = 1, colourable = 1} ,
        sounds = default.node_sound_water_defaults(),
    })

    minetest.register_node("rainbow:"..row[1].."_water_flowing", {
        description = "Flowing "..row[2].." Water",
        drawtype = "flowingliquid",
        tiles = {"default_water.png^[colorize:"..row[3]},
        special_tiles = {
            {
                name = "default_river_water_flowing_animated.png^[colorize:"..row[3],
                backface_culling = false,
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 0.8,
                },
            },
            {
                name = "default_river_water_flowing_animated.png^[colorize:"..row[3],
                backface_culling = true,
                animation = {
                    type = "vertical_frames",
                    aspect_w = 16,
                    aspect_h = 16,
                    length = 0.8,
                },
            },
        },
        alpha = 160,
        paramtype = "light",
        paramtype2 = "flowingliquid",
        walkable = false,
        pointable = false,
        diggable = false,
        buildable_to = true,
        is_ground_content = false,
        drop = "",
        light_source = default.LIGHT_MAX,
        drowning = 1,
        liquidtype = "flowing",
        liquid_alternative_flowing = "rainbow:"..row[1].."_water_flowing",
        liquid_alternative_source = "rainbow:"..row[1].."_water_source",
        liquid_viscosity = 1,
        post_effect_color = {a = walpha, r = wred, g = wgreen, b = wblue},
        groups = {water = 3, liquid = 3, puts_out_fire = 1,
        not_in_creative_inventory = 1, cools_lava = 1},
        sounds = default.node_sound_water_defaults(),
    })

    minetest.register_craft({
        type = "shapeless",
        output = "rainbow:"..row[1].."_water_source",
        recipe = { "group:water", "rainbow:dye_"..row[1] }
    })

    add_ore_node("coalore", "Coal Ore",row,"default:coal_lump",{
        tiles={"plain_stone.png"},
        groups={cracky = 3},
        sounds = default.node_sound_stone_defaults(),
        }, "default_mineral_coal.png")
    add_ore_node("ironore", "Iron Ore",row,'default:iron_lump',{
    	tiles = {"plain_stone.png"},
    	groups = {cracky = 2},
    	sounds = default.node_sound_stone_defaults(),
        }, "default_mineral_iron.png")
    add_ore_node("tinore", "Tin Ore",row,'default:tin_lump',{
    	tiles = {"plain_stone.png"},
    	groups = {cracky = 2},
    	sounds = default.node_sound_stone_defaults(),
        }, "default_mineral_tin.png")
    add_ore_node("copperore", "Copper Ore",row,'default:copper_lump',{
    	tiles = {"plain_stone.png"},
    	groups = {cracky = 2},
    	sounds = default.node_sound_stone_defaults(),
        }, "default_mineral_copper.png")
    add_ore_node("silverore", "Silver Ore",row,'moreores:silver_lump',{
    	tiles = {"plain_stone.png"},
    	groups = {cracky = 2},
    	sounds = default.node_sound_stone_defaults(),
        }, "moreores_mineral_silver.png")
    add_ore_node("meseore", "Mese Ore",row,'default:mese_crystal',{
    	tiles = {"plain_stone.png"},
    	groups = {cracky = 2},
    	sounds = default.node_sound_stone_defaults(),
        }, "default_mineral_mese.png")
    add_ore_node("goldore","Gold Ore",row,"default:gold_lump",{
    	tiles = {"plain_stone.png"},
    	groups = {cracky = 2},
    	sounds = default.node_sound_stone_defaults(),
        }, "default_mineral_gold.png")
    add_ore_node("diamondore","Diamond Ore",row, "default:diamond",{
    	tiles = {"plain_stone.png"},
    	groups = {cracky = 1},
    	sounds = default.node_sound_stone_defaults(),
        }, "default_mineral_diamond.png")
    add_ore_node("mithrilore","Mithril Ore",row, "moreores:mithril_lump",{
    	tiles = {"plain_stone.png"},
    	groups = {cracky = 1},
    	sounds = default.node_sound_stone_defaults(),
        }, "moreores_mineral_mithril.png")
    add_node("tree", "Tree", row, "saw", {
    	tiles = {"plain_tree_top.png", "plain_tree_top.png", "plain_tree.png"},
    	paramtype2 = "facedir",
    	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2 },
        sounds = default.node_sound_wood_defaults(),
        on_place = minetest.rotate_node
    })

	rainbow.register_fence("rainbow:fence_"..row[1], {
		description = row[2].." Fence",
		texture = "plain_wood.png^[colorize:"..row[3],
		inventory_image = "default_fence_overlay.png^plain_wood.png^[colorize:"..row[3].."^default_fence_overlay.png^[makealpha:255,126,126",
		wield_image = "default_fence_overlay.png^plain_wood.png^[colorize:"..row[3].."^default_fence_overlay.png^[makealpha:255,126,126",
		material = "rainbow:wood_"..row[1],
		sounds = default.node_sound_wood_defaults()
	})

    -- cute little dye.bottles
    minetest.register_craftitem("rainbow:dye_"..row[1], {
        inventory_image = "rainbow_dye_"..row[1]..".png",
        description = row[2] .. " Dye",
        on_place = function(stk, player, pointed)
                        if pointed.type == "node" then
                            local pos = minetest.get_pointed_thing_position(pointed, false)
                            local col = string.split(stk:get_name(), "_")[2]
                            local node= minetest.get_node(pos)
                            if minetest.registered_nodes[node.name].groups["colourable"] == 1 then
                                if player~=nil then
                                    local pname=player:get_player_name()
                                    if minetest.is_protected(pos, pname) then
                                        minetest.record_protection_violation(pos, pname)
                                        return
                                    end
                                end
                                minetest.set_node(pos, {name=recolor(node.name,col),param2=node.param2})
                            end
                        end
                        return nil
                    end
    })
    if type(row[4]) ~= "table" then
        minetest.register_craft({
            type = "shapeless",
            output = "rainbow:dye_".. row[1],
            recipe = { row[4] },
        })
    else
        minetest.register_craft({
            type = "shapeless",
            output = "rainbow:dye_".. row[1],
            recipe = { "rainbow:"..row[4][1], "rainbow:"..row[4][2] }
        })
    end

    add_node("dirt","Dirt", row, "",  {
        tiles = {"plain_dirt.png"},
        soil = {
                base = "rainbow:dirt_"..row[1],
                dry = "rainbow:soil_"..row[1],
                wet = "rainbow:soil_wet_"..row[1]
            },
        drop = {
            items = {
                { items = {"rainbow:dirt_"..row[1]}},
                { items = {'bonemeal:bone'}, rarity = 10 },
                { items = {'crops:potato'}, rarity = 500 }
            }
        },
        groups = {dirt = 1, crumbly = 3, soil = 1},
        sounds = default.node_sound_dirt_defaults(),
    })



	add_node("curtain","Curtain", row, "", {
		walkable = false,
		tiles = {"plain_wool.png"},
		inventory_image = "plain_wool.png^xdecor_curtain_open_overlay.png^[makealpha:255,126,126",
		wield_image = "plain_wool.png",
		drawtype = "signlike",
		paramtype2 = "wallmounted",
		groups = {crumbly=3, colourable=1},
		selection_box = {type="wallmounted"},
		on_rightclick = function(pos, node, _, itemstack)
			minetest.set_node(pos, {name="rainbow:curtain_open_"..row[1], param2=node.param2})
			return itemstack
		end
	})


    add_node("cushion","Cushion", row, "",{
        tiles = {"plain_cushion.png"},
        groups = {snappy=3, flammable=3, fall_damage_add_percent=-50},
        drawtype = "nodebox",
        paramtype2 = "facedir",
        on_place = minetest.rotate_node,
        node_box = xdecor.nodebox.slab_y(0.5),
        can_dig = xdecor.sit_dig,
        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
            pos.y = pos.y + 0  -- Sitting position
            xdecor.sit(pos, node, clicker, pointed_thing)
            return itemstack
        end
    })

    minetest.register_craft({
        type = "shapeless",
        output = "rainbow:cushion_"..row[1],
        recipe = { "group:cushion", "rainbow:dye_"..row[1] }
    })

	add_node("curtain_open","Open Curtain", row, "", {
		tiles = {"plain_wool.png^xdecor_curtain_open_overlay.png^[makealpha:255,126,126"},
		drawtype = "signlike",
		paramtype2 = "wallmounted",
		walkable = false,
		groups = {crumbly=3, not_in_creative_inventory=1,colourable=1},
		selection_box = {type="wallmounted"},
		drop = "rainbow:curtain_"..row[1],
		on_rightclick = function(pos, node, _, itemstack)
			minetest.set_node(pos, {name="rainbow:curtain_"..row[1], param2=node.param2})
			return itemstack
		end
	})

    minetest.register_craft({
        type = "shapeless",
        output = "rainbow:curtain_"..row[1].." 4",
        recipe = { "rainbow:wool_"..row[1]}
    })

    add_node("soil","Soil", row, "", {
        tiles = {"plain_dirt.png^farming_soil.png", "plain_dirt.png"},
        drop = "rainbow:dirt_"..row[1],
        groups = {crumbly=3, not_in_creative_inventory=1, soil=2, grassland = 1, field = 1},
        sounds = default.node_sound_dirt_defaults(),
        soil = {
            base = "rainbow:dirt_"..row[1],
            dry = "rainbow:soil_"..row[1],
            wet = "rainbow:soil_wet_"..row[1]
        }
    })

    add_node("soil_wet","Wet Soil",row,"", {
        tiles = {"plain_dirt.png^farming_soil_wet.png", "plain_dirt.png^farming_soil_wet_side.png"},
        drop = "rainbow:dirt_"..row[1],
        groups = {crumbly=3, not_in_creative_inventory=1, soil=3, wet = 1, grassland = 1, field = 1},
        sounds = default.node_sound_dirt_defaults(),
        soil = {
            base = "rainbow:dirt_"..row[1],
            dry = "rainbow:soil_"..row[1],
            wet = "rainbow:soil_wet_"..row[1]
        }
    })

    add_node("grass1", "Grass", row, "", {
        drawtype = "plantlike",
        waving = 1,
        tiles = {"plain_grass_1.png"},
        inventory_image = "plain_grass_3.png",
        wield_image = "plain_grass_3.png",
        paramtype = "light",
        sunlight_propagates = true,
        walkable = false,
        buildable_to = true,
        drop = {},
        groups = {snappy = 3, flora = 1, attached_node = 1, grass=1, flammable = 1},
        sounds = default.node_sound_leaves_defaults(),
        selection_box = {
            type = "fixed",
            fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -5 / 16, 6 / 16},
        },
        on_place = function(itemstack, placer, pointed_thing)
            -- place a random grass node
            local stack = ItemStack("rainbow:grass" .. math.random(1,5).."_"..row[1])
            local ret = minetest.item_place(stack, placer, pointed_thing)
            return ItemStack("rainbow:grass1_"..row[1].." "..
                itemstack:get_count() - (1 - ret:get_count()))
        end,
    })
    for i = 2, 5 do
        add_node("grass" .. i, "Grass", row, "", {
            drawtype = "plantlike",
            waving = 1,
            tiles = {"plain_grass_" .. i .. ".png"},
            inventory_image = "plain_grass_" .. i .. ".png",
            wield_image = "plain_grass_" .. i .. ".png",
            paramtype = "light",
            sunlight_propagates = true,
            walkable = false,
            buildable_to = true,
            drop = {
                max_items = 1,
                items = {
                    {
                        -- player will get sapling with 1/20 chance
                        items = {'farming:seed_wheat'},
                        rarity = 10,
                    },
                    {
                        -- player will get leaves only if he get no saplings,
                        -- this is because max_items is 1
                        items = {'farming:seed_cotton'},
                        rarity = 10,
                    }
                    }},
            groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1, flammable = 1, not_in_creative_inventory = 1},
            sounds = default.node_sound_leaves_defaults(),
            selection_box = {
                type = "fixed",
                fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -3 / 16, 6 / 16},
            },
        })
    end

    add_node("leaves", "Leaves", row, "", {
        drawtype = "allfaces_optional",
        waving = 1,
        tiles = {"plain_leaves.png"},
        paramtype = "light",
        is_ground_content = false,
        groups = {snappy = 3, leafdecay = 3, flammable = 2},
        drop = {
            max_items = 1,
            items = {
                {
                    items = {'rainbow:leaves_'..row[1]},
                }
            }
        },
        sounds = default.node_sound_leaves_defaults(),
        --after_place_node = default.after_place_leaves,
    })

    minetest.register_craft({
        output = 'rainbow:wood_'..row[1]..' 4',
        recipe = {
            {'rainbow:tree_'..row[1]},
        }
    })

    add_node("wood", "Wood", row, "sawcol",  {
        paramtype2 = "facedir",
        place_param2 = 0,
        tiles = {"plain_wood.png"},
        is_ground_content = false,
        groups = {wood = 1,choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
        sounds = default.node_sound_wood_defaults(),
    })

    add_node("stone", "Stone", row, "sawcol",  {
        tiles = {"plain_stone.png"},
        groups = {cracky = 3, stone = 1},
        --drop = 'rainbow:cobble_'..row[1],
        legacy_mineral = true,
        sounds = default.node_sound_stone_defaults(),
    })
--     add_node("hardstone", "Hard Stone", row, "saw",  {
--         tiles = {"plain_stone.png"},
--         groups = {cracky = 2, stone = 1},
--         drop = 'rainbow:cobble_'..row[1],
--         legacy_mineral = true,
--         sounds = default.node_sound_stone_defaults(),
--     })
--     add_node("deepstone", "Deep Stone", row, "saw",  {
--         tiles = {"plain_stone.png"},
--         groups = {cracky = 1, stone = 1},
--         drop = 'rainbow:cobble_'..row[1],
--         legacy_mineral = true,
--         sounds = default.node_sound_stone_defaults(),
--     })
    add_node("sand","Sand", row, "",  {
        tiles = {"plain_sand.png"},
        groups = {crumbly = 3, sand = 1, dirt = 1},
        sounds = default.node_sound_sand_defaults(),
    })

    add_node("cobble", "Cobble", row, "saw",  {
        tiles = {"plain_cobble.png"},
        is_ground_content = false,
        groups = {cracky=3, cobble=1, stone=1,ccobble=1},
        sounds = default.node_sound_stone_defaults(),
    })

    minetest.register_craft({
        type = "cooking",
        output = "rainbow:stone_"..row[1],
        recipe = "rainbow:cobble_"..row[1],
    })

    minetest.register_craft({
        output = 'rainbow:cobble_'..row[1]..' 4',
        recipe = {
            {'rainbow:stone_'..row[1]},
        }
    })

    add_node("stonebrick", "Stone Brick", row, "sawcol",  {
        paramtype2 = "facedir",
        place_param2 = 0,
        tiles = {"plain_stone_brick.png"},
        is_ground_content = false,
        groups = {stonebrick=1,cracky = 2, stone = 1},
        sounds = default.node_sound_stone_defaults(),
    })

    add_node("stoneblock", "Stone Block", row, "saw",  {
        ctiles = {"plain_stone.png^[colorize:"..row[3].."^(mask_tile.png^[opacity:130)"},
        --ctiles = {"plain_stone.png^[colorize:"..row[3].."^(mask_tile.png^[opacity:50)"},
        is_ground_content = false,
        groups = {cracky = 2, stone = 1},
        sounds = default.node_sound_stone_defaults(),
    })

    add_node("clayblock", "Clay Block", row, "saw",  {
        ctiles = {"plain_stuff.png^[colorize:"..row[3].."^(mask_tile.png^[opacity:130)"},
        --ctiles = {"plain_stone.png^[colorize:"..row[3].."^(mask_tile.png^[opacity:50)"},
        is_ground_content = false,
        groups = {cracky = 2, stone = 1},
        sounds = default.node_sound_dirt_defaults(),
    })
    minetest.register_craft({
        output = 'rainbow:clayblock_'..row[1]..' 4',
        recipe = {
            {'rainbow:clay_'..row[1],'rainbow:clay_'..row[1]},
            {'rainbow:clay_'..row[1],'rainbow:clay_'..row[1]},
        }
    })

    add_node("check", "Checker", row, "saw",  {
        ctiles = {"plain_tile.png^[colorize:"..row[3].."^(plain_tile.png^[opacity:128)"},
        --ctiles = {"plain_stone.png^[colorize:"..row[3].."^(mask_tile.png^[opacity:50)"},
        is_ground_content = false,
        groups = {cracky = 2, stone = 1},
        sounds = default.node_sound_stone_defaults(),
    })

    add_node("tile", "Tile", row, "saw",  {
        ctiles = {"plain_dirt.png^[colorize:"..row[3].."^(mask_checker.png^[opacity:128)"},
        --ctiles = {"plain_stone.png^[colorize:"..row[3].."^(mask_tile.png^[opacity:50)"},
        is_ground_content = false,
        groups = {cracky = 2, stone = 1},
        sounds = default.node_sound_stone_defaults(),
    })

    add_node("wool","Wool", row, "saw",  {
        tiles = {"plain_wool.png"},
        is_ground_content = false,
        groups = {wool=1, snappy = 2, choppy = 2, oddly_breakable_by_hand = 3,flammable = 3},
        sounds = default.node_sound_defaults(),
    })

	add_node("render","Render", row, "saw", {
		tiles = {"plain_render.png^(plain_dirt.png^[opacity:60)"},
		is_ground_content = false,
		sounds = default.node_sound_defaults(),
		groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 3},
	})

 	add_node("lightblock","LightBlock", row, "sawcol", {
 		ctiles = {"plain_render.png^(plain_dirt.png^[opacity:60)^[colorize:"..row[3].."^(mask_tile.png^[opacity:30)"},
 		is_ground_content = false,
		light_source= default.LIGHT_MAX,
		sounds = default.node_sound_glass_defaults(),
 		groups = {lightblock=1,snappy = 2, choppy = 2, oddly_breakable_by_hand = 3},
 	})

    add_node("clay", "Clay", row, "sawcol",  {
        tiles = {"plain_stuff.png"},
        groups = {crumbly = 3,clay=1},
        sounds = default.node_sound_dirt_defaults(),
    })

    minetest.register_craft({
        output = 'default:clay_lump 4',
        recipe = {
            {'rainbow:clay_'..row[1]},
        }
    })
    add_node("cheeseblock", "Cheese Block", row, "saw",  {
        tiles = {"plain_cheese.png"},
        is_ground_content = false,
        on_use = minetest.item_eat(10),
        groups = {crumbly = 3, food = 5},
        sounds = default.node_sound_dirt_defaults()
    })

    add_node("gravel", "Gravel", row, "", {
        tiles = {"default_gravel.png"},
        groups = {crumbly = 2, gravel = 1},
        sounds = default.node_sound_gravel_defaults(),
        drop = {
            max_items = 1,
            items = {
                {items = {'default:flint'}, rarity = 16},
                {items = {'rainbow:gravel_'..row[1]}}
            }
        }
    })

    add_node("snow", "Snow", row, "", {
        tiles = {"default_snow.png"},
        inventory_image = "default_snowball.png",
        wield_image = "default_snowball.png",
        paramtype = "light",
        buildable_to = true,
        floodable = true,
        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
            },
        },
        groups = {crumbly = 3, falling_node = 1, puts_out_fire = 1, snowy = 1},
        sounds = default.node_sound_dirt_defaults({
            footstep = {name = "default_snow_footstep", gain = 0.15},
            dug = {name = "default_snow_footstep", gain = 0.2},
            dig = {name = "default_snow_footstep", gain = 0.2}
        }),
        on_construct = function(pos)
            pos.y = pos.y - 1
            if minetest.registered_nodes[minetest.get_node(pos).name].groups["dirt"] == 1 then
                minetest.set_node(pos, {name = "rainbow:dirt_"..row[1]})
            end
        end,
    })

    add_node("snowblock", "Snow Block", row, "saw", {
        tiles = {"default_snow.png"},
        groups = {crumbly = 3, puts_out_fire = 1, cools_lava = 1, snowy = 1},
        sounds = default.node_sound_dirt_defaults({
            footstep = {name = "default_snow_footstep", gain = 0.15},
            dug = {name = "default_snow_footstep", gain = 0.2},
            dig = {name = "default_snow_footstep", gain = 0.2}
        }),
        on_construct = function(pos)
            pos.y = pos.y - 1
            if minetest.registered_nodes[minetest.get_node(pos).name].groups["dirt"] == 1 then
                minetest.set_node(pos, {name = "rainbow:dirt_"..row[1]})
            end
        end,
    })

    add_node("ice", "Ice", row, "saw", {
        tiles = {"default_ice.png"},
        is_ground_content = false,
        paramtype = "light",
        groups = {cracky = 3, puts_out_fire = 1, cools_lava = 1},
        sounds = default.node_sound_glass_defaults(),
    })

    add_node("glass", "Glass", row, "saw",{
        drawtype = "glasslike_framed_optional",
        tiles = {"default_glass.png"},
        paramtype = "light",
        sunlight_propagates = true,
        is_ground_content = false,
        groups = {glass=1,cracky = 3, oddly_breakable_by_hand = 3},
        sounds = default.node_sound_glass_defaults(),
    })
    minetest.register_craft({
        output = 'rainbow:coolglass_'..row[1],
        recipe = {
            {'rainbow:glass_'..row[1]},
        }
    })


    add_node("lightglass", "Light Glass", row, "saw",{
        drawtype = "glasslike_framed_optional",
        tiles = {"default_glass.png"},
        paramtype = "light",
        light_source= default.LIGHT_MAX,
        sunlight_propagates = true,
        is_ground_content = false,
        groups = {glass=2, cracky = 3, oddly_breakable_by_hand = 3},
        sounds = default.node_sound_glass_defaults(),
    })
    minetest.register_craft({
        output = 'rainbow:lightglass_'..row[1],
        recipe = {
            {'rainbow:lightcoolglass_'..row[1]},
        }
    })

    add_node("coolglass", "Cool Glass", row, "sawcol",{
        tiles = {"plain_coolglass.png"},
        paramtype = "light",
        drawtype = "glasslike",
        sunlight_propagates = true,
        use_texture_alpha = true,
        is_ground_content = false,
        groups = {coolglass=1,glass=1,cracky = 3, oddly_breakable_by_hand = 3},
        sounds = default.node_sound_glass_defaults(),
    })

    minetest.register_craft({
        output = 'rainbow:coolglass_'..row[1],
        recipe = {
            {'rainbow:glass_'..row[1]},
        }
    })

    add_node("coolframedglass", "Cool Framed Glass", row, "saw",{
        tiles = {"plain_coolglass.png^(mask_tile.png^[opacity:160)"},
        paramtype = "light",
        drawtype = "glasslike",
        sunlight_propagates = true,
        use_texture_alpha = true,
        is_ground_content = false,
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = default.node_sound_glass_defaults(),
    })
    minetest.register_craft({
        output = 'rainbow:coolframedglass_'..row[1],
        recipe = {
            {'rainbow:coolglass_'..row[1],'default:steel_ingot'},
        }
    })

    add_node("lightcoolglass", "Light Cool Glass", row, "saw",{
        tiles = {"plain_coolglass.png"},
        paramtype = "light",
        drawtype = "glasslike",
        light_source= default.LIGHT_MAX,
        sunlight_propagates = true,
        use_texture_alpha = true,
        is_ground_content = false,
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = default.node_sound_glass_defaults(),
    })
    minetest.register_craft({
        output = 'rainbow:lightcoolglass_'..row[1],
        recipe = {
            {'rainbow:coolglass_'..row[1],'default:torch'},
        }
    })

    add_node("lightframedcoolglass", "Light Framed Cool Glass", row, "saw",{
        tiles = {"plain_coolglass.png^(mask_tile.png^[opacity:130)"},
        paramtype = "light",
        drawtype = "glasslike",
        light_source= default.LIGHT_MAX,
        sunlight_propagates = true,
        use_texture_alpha = true,
        is_ground_content = false,
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = default.node_sound_glass_defaults(),
    })
    minetest.register_craft({
        output = 'rainbow:lightframedcoolglass_'..row[1],
        recipe = {
            {'rainbow:coolframedglass_'..row[1],'default:torch'},
        }
    })


--     minetest.register_alias("rainbow:cobweb_"..row[1],"default:air")

    add_node("cobweb", "Cobweb", row, "",{
        drawtype = "plantlike",
        tiles = {"xdecor_cobweb.png"},
        liquid_viscosity = 8,
        liquidtype = "source",
        liquid_alternative_flowing = "rainbow:cobweb_"..row[1],
        liquid_alternative_source = "rainbow:cobweb_"..row[1],
        liquid_renewable = false,
        liquid_range = 0,
        walkable = false,
        selection_box = {type = "regular"},
        groups = {snappy=3, liquid=3, flammable=3},
        sounds = default.node_sound_leaves_defaults()
    })


    local ffgroups=fgroups
    ffgroups.restrained = 1
    ffgroups.colourable = 1
    minetest.register_node("rainbow:restrained_"..row[1], {
        description = row[2].." Restrained Render",
        tiles = {"plain_render.png^[colorize:"..row[3].."^(plain_dirt.png^[opacity:15)"},
        is_ground_content = false,
        groups = ffgroups,
        sounds = default.node_sound_stone_defaults(),
     })
    minetest.register_craft({
        type = "shapeless",
        output = "rainbow:restrained_"..row[1],
        recipe = { "group:restrained", "rainbow:dye_"..row[1] }
    })
    minetest.register_craft({
        type = "shapeless",
        output = "rainbow:restrained_"..row[1],
        recipe = { "rainbow:render_"..row[1] }
    })
    stairsplus:register_all("rainbow", "restrained_"..row[1], "rainbow:restrained_"..row[1], minetest.registered_nodes["rainbow:restrained_"..row[1]])


    add_node("coral", "Coral", row, "sawcol", {
        tiles = {"plain_coral.png"},
        paramtype = "light",
        is_ground_content = false,
        groups = {coral=1,crumbly = 3, colorable=1},
        sounds = default.node_sound_dirt_defaults(),
    })

end

minetest.register_craft({
    output = 'rainbow:lightglass_white',
    type='shapeless',
    recipe = { 'group:glass','default:torch'},
})

minetest.register_craft({
    output = 'default:obsidian_shard 9',
    type='shapeless',
    recipe = { 'caverealms:glow_obsidian'},
})

minetest.register_craft({
    output = 'default:obsidian_shard 9',
    type='shapeless',
    recipe = { 'caverealms:glow_obsidian_2'},
})


minetest.register_craft({
    type = "cooking",
    output = 'rainbow:glass_white',
    recipe = 'group:sand'
})


minetest.register_craft({
    output = 'rainbow:lightblock_white',
    type = "shapeless",
    recipe =  {'group:glass', 'group:sand', 'default:torch'},
})


minetest.register_craft({
    output = 'rainbow:stoneblock_white',
    recipe = {
        {'group:stone','group:stone','group:stone'},
        {'group:stone','group:stone','group:stone'},
        {'group:stone','group:stone','group:stone'},
    }
})


minetest.register_craft({
    output = 'rainbow:stonebrick_white 4',
    recipe = {
        {'group:stone','group:stone'},
        {'group:stone','group:stone'},
    }
})



-- minetest.register_node("rainbow:binary", {
--     description = "Benders Binary Block",
-- 	tiles = {"rainbow_binary.png"},
-- 	paramtype = "light",
-- 	paramtype2 = "color",
-- 	palette = "unifieddyes_palette_extended.png",
-- 	on_construct = unifieddyes.on_construct,
-- 	is_ground_content = false,
-- 	light_source= default.LIGHT_MAX,
-- 	sounds = default.node_sound_stone_defaults(),
-- 	groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 3, ud_param2_colorable = 1 },
-- })










local add_plant = function(a, b, c, d)
	-- Common flowers' groups
	d.snappy = 3
	d.flower = 1
	d.flora = 1
	d.attached_node = 1
--    d.not_in_creative_inventory = nil

	minetest.register_node("rainbow:" .. a, {
		description = b,
		drawtype = "plantlike",
		waving = 1,
		tiles = {"plants_" .. a .. ".png"},
		inventory_image = "plants_" .. a .. ".png",
		wield_image = "plants_" .. a .. ".png",
		sunlight_propagates = true,
		paramtype = "light",
		walkable = false,
		buildable_to = true,
		stack_max = 99,
		groups = d,
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = c
		}
	})
end

add_plant("rose", "Rose", {-2 / 16, -0.5, -2 / 16, 2 / 16, 5 / 16, 2 / 16}, {flower = 1, color_pink = 1, flammable = 1})
add_plant("greenery", "Greenery", {-2 / 16, -0.5, -2 / 16, 2 / 16, 5 / 16, 2 / 16}, {color_lightgreen = 1, flammable = 1})
add_plant("orangeflower", "Orange Flower", {-2 / 16, -0.5, -2 / 16, 2 / 16, 5 / 16, 2 / 16}, {flower = 1, color_orange = 1, flammable = 1})
add_plant("cookieflower", "Cookie Flower", {-2 / 16, -0.5, -2 / 16, 2 / 16, 5 / 16, 2 / 16}, {flower = 1, color_darkgrey = 1, flammable = 1})
add_plant("violet", "Violet", {-2 / 16, -0.5, -2 / 16, 2 / 16, 5 / 16, 2 / 16}, {flower = 1, color_violet = 1, flammable = 1})
add_plant("tulip", "Tulip", {-2 / 16, -0.5, -2 / 16, 2 / 16, 3 / 16, 2 / 16}, {flower = 1, color_orange = 1, flammable = 1})
add_plant("dandelion", "Dandelion", {-2 / 16, -0.5, -2 / 16, 2 / 16, 4 / 16, 2 / 16}, {flower = 1, color_yellow = 1, flammable = 1})
add_plant("geranium", "Geranium", {-2 / 16, -0.5, -2 / 16, 2 / 16, 2 / 16, 2 / 16}, {flower = 1, color_blue = 1, flammable = 1})
add_plant("dianthus", "Dianthus", {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}, {flower = 1, color_violet = 1, flammable = 1})
add_plant("daisies", "Dasies", {-5 / 16, -0.5, -5 / 16, 5 / 16, -2 / 16, 5 / 16}, {flower = 1, color_white = 1, flammable = 1})
add_plant("mushroom_red", "Red Mushroom", {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16}, { color_red=1, flammable = 1})
add_plant("mushroom_brown", "Brown Mushroom", {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16}, { color_brown=1, flammable = 1})
add_plant("junglegrass", "Jungle Grass", {-7 / 16, -0.5, -7 / 16, 7 / 16, 1.19, 7 / 16}, {color_green=1, grass = 1, flammable = 1})



-- MUSHROOM

minetest.register_node("rainbow:mushroom_trunk", {
	description = "Mushroom",
	tiles = {
		"mushroom_trunk_top.png",
		"mushroom_trunk_top.png",
		"mushroom_trunk.png"
	},
	groups = {wood=1, food=1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2,not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
    on_use = minetest.item_eat(5),
})
minetest.register_node("rainbow:mushroom", {
	description = "Mushroom Cap",
	tiles = {"mushroom_block.png"},
	groups = {food =1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2,not_in_creative_inventory=1},
	drop = {
		max_items = 1,
		items = {
			--{items = {":mushroom_sapling"}, rarity = 20},
			{items = {"rainbow:mushroom"}}
		}
	},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
    on_use = minetest.item_eat(5),
})
minetest.register_node("rainbow:mushroom_pore", {
	description = "Mushroom Pore",
	tiles = {"mushroom_pore.png"},
	groups = {
		snappy = 3, cracky = 3, choppy = 3, oddly_breakable_by_hand = 3,
		flammable = 2, disable_jump = 1, fall_damage_add_percent = -100,
        not_in_creative_inventory=1, food = 1
	},
	sounds = default.node_sound_dirt_defaults(),
    on_use = minetest.item_eat(5),
})



minetest.register_craft({
	type = "fuel",
	recipe = "rainbow:mushroom",
	burntime = 10,
})

minetest.register_craft({
	type = "fuel",
	recipe = "rainbow:mushroom_pore",
	burntime = 3,
})

--
-- Waterlily
--
minetest.register_node("rainbow:waterlily", {
	description = "Waterlily",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"plants_waterlily.png", "plants_waterlily_bottom.png"},
	inventory_image = "plants_waterlily.png",
	wield_image = "plants_waterlily.png",
	liquids_pointable = true,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	floodable = true,
	groups = {snappy = 3, flower = 1, flammable = 1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	node_placement_prediction = "",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -15 / 32, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-7 / 16, -0.5, -7 / 16, 7 / 16, -15 / 32, 7 / 16}
	},

	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.above
		local node = minetest.get_node(pointed_thing.under).name
		local def = minetest.registered_nodes[node]
		local player_name = placer:get_player_name()

		if def and def.liquidtype == "source" and
				minetest.get_item_group(node, "water") > 0 then
			if not minetest.is_protected(pos, player_name) then
				minetest.set_node(pos, {name = "rainbow:waterlily",
					param2 = math.random(0, 3)})
				if not minetest.setting_getbool("creative_mode") then
					itemstack:take_item()
				end
			else
				minetest.chat_send_player(player_name, "Node is protected")
				minetest.record_protection_violation(pos, player_name)
			end
		end

		return itemstack
	end
})

minetest.register_node("rainbow:papyrus", {
	description = "Papyrus",
	drawtype = "plantlike",
	tiles = {"default_papyrus.png"},
	inventory_image = "default_papyrus.png",
	wield_image = "default_papyrus.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_leaves_defaults(),

	after_dig_node = function(pos, node, metadata, digger)
		rainbow.dig_up(pos, node, digger)
	end,
})

minetest.register_alias("default:papyrus","rainbow:papyrus")


minetest.register_craft({
    output = "default:paper 4",
    recipe = {
        { 'rainbow:papyrus', 'rainbow:papyrus', 'rainbow:papyrus' },
    }
})


minetest.register_craft({
    type = "shapeless",
    output = "default:stick 4",
    recipe = { "group:wood" }
})

    minetest.register_craft({
        output = 'rainbow:render_white',
        recipe = {
            {'default:clay_lump','default:clay_lump','default:clay_lump',},
            {'default:clay_lump','default:clay_lump','default:clay_lump',},
            {'default:clay_lump','default:clay_lump','default:clay_lump',},
        }
    })





minetest.register_node("rainbow:wheel",
    {
        drawtype = "mesh",
        mesh = "wheel.x",
        tiles = {"wheel.png"},
        description = "Ships Wheel",
        groups = {choppy=2, dig_immediate=2},
        diggable = true,
        paramtype="light",
        paramtype2="facedir",
    }
)

minetest.register_craft({
    output = "rainbow:fence_white 4",
    recipe = {
        { "group:wood", 'group:stick', "group:wood" },
        { "group:wood", 'group:stick', "group:wood" },
    }
})

minetest.register_craft({
    output = "vessels:glass_bottle",
    recipe = {
        { "group:glass", '', "group:glass" },
        { "group:glass", '', "group:glass" },
        { "", 'group:glass', "" },
    }
})

minetest.register_craft({
    output = 'rainbow:cushion_white 2',
    recipe = {
        {'farming:cotton','farming:cotton','farming:cotton'},
        {'farming:cotton','farming:cotton','farming:cotton'},
    }
})






minetest.register_craft({
        type = "shapeless",
        output = "rainbow:dye_darkbrown",
        recipe = { "rainbow:dye_brown", "rainbow:dye_black" }
    })

minetest.register_craft({
        type = "shapeless",
        output = "rainbow:dye_darkorange",
        recipe = { "rainbow:dye_orange", "rainbow:dye_black" }
    })

minetest.register_craft({
        type = "shapeless",
        output = "rainbow:dye_darkred",
        recipe = { "rainbow:dye_red", "rainbow:dye_black" }
    })

minetest.register_craft({
        type = "shapeless",
        output = "rainbow:dye_darkyellow",
        recipe = { "rainbow:dye_yellow", "rainbow:dye_black" }
    })

minetest.register_craft({
        type = "shapeless",
        output = "rainbow:dye_gold",
        recipe = { "rainbow:dye_yellow", "rainbow:dye_darkyellow" }
    })

minetest.register_craft({
        type = "shapeless",
        output = "rainbow:dye_lightblue",
        recipe = { "rainbow:dye_white", "rainbow:dye_blue" }
    })

minetest.register_craft({
        type = "shapeless",
        output = "rainbow:dye_sand",
        recipe = { "rainbow:dye_white", "rainbow:dye_brown" }
    })
