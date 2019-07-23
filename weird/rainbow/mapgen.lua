



minetest.register_alias_force("mapgen_stone", "rainbow:stone_grey")
minetest.register_alias_force("mapgen_dirt", "rainbow:dirt_brown")
minetest.register_alias_force("mapgen_dirt_with_grass", "rainbow:dirt_green")
minetest.register_alias_force("mapgen_sand", "rainbow:sand_sand")
minetest.register_alias_force("mapgen_water_source", "rainbow:blue_water_source")
minetest.register_alias_force("mapgen_river_water_source", "rainbow:lightblue_water_source")
minetest.register_alias_force("mapgen_lava_source", "default:lava_source")
minetest.register_alias_force("mapgen_gravel", "rainbow:gravel_grey")
minetest.register_alias_force("mapgen_desert_stone", "rainbow:stone_darkred")
minetest.register_alias_force("mapgen_desert_sand", "rainbow:sand_red")
minetest.register_alias_force("mapgen_dirt_with_snow", "rainbow:dirt_white")
minetest.register_alias_force("mapgen_snowblock", "rainbow:snowblock_white")
minetest.register_alias_force("mapgen_snow", "rainbow:snow_white")
minetest.register_alias_force("mapgen_ice", "rainbow:ice_lightblue")
minetest.register_alias_force("mapgen_sandstone", "rainbow:stone_sand")

-- Flora

minetest.register_alias_force("mapgen_tree", "default:tree")
minetest.register_alias_force("mapgen_leaves", "default:leaves")
minetest.register_alias_force("mapgen_apple", "default:apple")
minetest.register_alias_force("mapgen_jungletree", "default:jungletree")
minetest.register_alias_force("mapgen_jungleleaves", "default:jungleleaves")
minetest.register_alias_force("mapgen_junglegrass", "default:junglegrass")
minetest.register_alias_force("mapgen_pine_tree", "default:pine_tree")
minetest.register_alias_force("mapgen_pine_needles", "default:pine_needles")

-- Dungeons

minetest.register_alias_force("mapgen_cobble", "rainbow:cobble_grey")
minetest.register_alias_force("mapgen_stair_cobble", "rainbow:stair_cobble_grey")
minetest.register_alias_force("mapgen_mossycobble", "rainbow:stair_cobble_greye")
-- minetest.register_alias_force("mapgen_stair_desert_stone", "stairs:stair_desert_stone")
-- minetest.register_alias_force("mapgen_sandstonebrick", "rainbow:stair_cobble_grey")
-- minetest.register_alias_force("mapgen_stair_sandstone_block", "stairs:stair_sandstone_block")


minetest.register_alias_force("default:dirt","rainbow:dirt_darkbrown")
minetest.register_alias_force("default:dirt_with_grass","rainbow:dirt_green")
minetest.register_alias_force("default:desert_sand","rainbow:sand_brown")
minetest.register_alias_force("default:stone","rainbow:stone_grey")
minetest.register_alias_force("default:cobble","rainbow:cobble_grey")



local woods = { ['wood']='darkbrown',
                ['junglewood']='black',
                ['pine_wood']='sand',
                ['acacia_wood']='darkred',
                ['aspen_wood']='white' }


for i,o in pairs(woods) do
    minetest.register_alias_force("default:"..i,"rainbow:wood_"..o)
    minetest.register_alias_force("default:fence_"..i,"rainbow:fence_"..o)
    minetest.register_alias_force("stairs:slab_"..i,"rainbow:slab_wood_"..o)
    minetest.register_alias_force("stairs:stair_"..i,"rainbow:stair_wood_"..o)
    minetest.register_alias_force("stairs:stair_outer_"..i,"rainbow:stair_wood_"..o.."_outer")
    minetest.register_alias_force("stairs:stair_inner_"..i,"rainbow:stair_wood_"..o.."_inner")
end
--
local trees = { ['tree']='darkbrown',
                ['jungletree']='black',
                ['pine_tree']='sand',
                ['acacia_tree']='darkred',
                ['aspen_tree']='white' }
for i,o in pairs(trees) do
    minetest.register_alias_force("default:"..i,"rainbow:tree_"..o)
    minetest.register_alias_force("stairs:slab_"..i,"rainbow:slab_tree_"..o)
    minetest.register_alias_force("stairs:stair_"..i,"rainbow:stair_tree_"..o)
    minetest.register_alias_force("stairs:stair_outer_"..i,"rainbow:stair_tree_"..o.."_outer")
    minetest.register_alias_force("stairs:stair_inner_"..i,"rainbow:stair_tree_"..o.."_inner")
end

local leaves = { ['leaves']='green',
                ['jungleleaves']='black',
                ['pine_needles']='sand',
                ['acacia_leaves']='darkred',
                ['aspen_leaves']='white' }
for i,o in pairs(leaves) do
    minetest.register_alias_force("default:"..i,"rainbow:leaves_"..o)
end

minetest.register_alias_force("default:sapling","default:stick")
minetest.register_alias_force("default:junglesapling","default:stick")
minetest.register_alias_force("default:emergent_jungles_apling","default:stick")
minetest.register_alias_force("default:pine_sapling","default:stick")
minetest.register_alias_force("default:acacia_sapling","default:stick")
minetest.register_alias_force("default:aspen_sapling","default:stick")
minetest.register_alias_force("default:bush_sapling","default:stick")
minetest.register_alias_force("default:acacia_bush_sapling","default:stick")
minetest.register_alias_force("default:pine_bush_sapling","default:stick")

minetest.register_alias_force("default:water_source","rainbow:blue_water_source")
minetest.register_alias_force("default:water_flowing","rainbow:blue_water_flowing")
minetest.register_alias_force("default:river_water_source","rainbow:lightblue_water_source")
minetest.register_alias_force("default:river_water_flowing","rainbow:lightblue_water_flowing")


minetest.clear_registered_ores()
dofile(rainbow.modpath .. "/ores.lua")

minetest.clear_registered_biomes()
dofile(rainbow.modpath .. "/biomes.lua")

minetest.clear_registered_decorations()
dofile(rainbow.modpath .. "/decorations.lua")

