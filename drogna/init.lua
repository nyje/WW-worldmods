drogna = {}

local shapes={"circle","moon","triangle","square","pentagon","hexagon"}
local colors={"red","orange","yellow","green","blue","indigo"}


local placeblock = function(pos)
    local shape=shapes[ math.random( #shapes)]
    local color=colors[ math.random( #colors)]
    local nodename = "drogna:block_"..color.."_"..shape
    minetest.set_node(pos,{name=nodename})
end

local place = function(pos)
    local shape=shapes[ math.random( #shapes)]
    local color=colors[ math.random( #colors)]
    local nodename = "drogna:"..color.."_"..shape
    local ometa=minetest.get_meta(pos)
    local op2=ometa:get_int("param2")
    minetest.set_node(pos,{name=nodename})
    local nmeta=minetest.get_meta(pos)
    nmeta:set_int("param2",ometa:get_int("param2"))
end


for s,shape in ipairs(shapes) do
    for c,color in ipairs(colors) do
        minetest.register_node("drogna:"..color.."_"..shape, {
            description=c*s.." Drogna ",
            drawtype = "nodebox",
            node_box = {
                type = "wallmounted",
                wall_top    = {-0.4875, 0.4875, -0.4875, 0.4875, 0.5, 0.4875},
                wall_bottom = {-0.4875, -0.5, -0.4875, 0.4875, -0.4875, 0.4875},
                wall_side   = {-0.5, -0.4875, -0.4875, -0.4875, 0.4875, 0.4875},
            },
            paramtype = "light",
            paramtype2="wallmounted",
            sunlight_propagates = true,
            light_source = 14,
            on_punch = place,
            inventory_image = "drogna_"..shape.."_"..color..".png",
            wield_image = "drogna_"..shape.."_"..color..".png",
            tiles = { "drogna_"..shape.."_"..color..".png" },
            groups = {cracky=3, choppy=3, not_in_creative_inventory=1},
            sounds = default.node_sound_glass_defaults(),
        })
        minetest.register_node("drogna:block_"..color.."_"..shape, {
            description=c*s.." Drogna Block",
            paramtype = "light",
            paramtype2 = "facedir",
            place_param2 = 0,
            on_punch = placeblock,
            tiles = { "drogna_block_"..shape.."_"..color..".png" },
            light_source = minetest.LIGHT_MAX,
            inventory_image = "drogna_block_"..shape.."_"..color..".png",
            groups = {snappy=2, cracky=3, choppy=3, not_in_creative_inventory=1},
            sounds = default.node_sound_defaults(),
        })
    end
end

minetest.register_node("drogna:place_block", {
    description="Place Drogna Block",
    tiles = { "drogna_block_circle_yellow.png" },
    light_source = minetest.LIGHT_MAX,
    inventory_image = "drogna_block_circle_yellow.png",
    groups = {snappy=2, cracky=3, choppy=3 },
    sounds = default.node_sound_defaults(),
    on_construct = placeblock
})

minetest.register_node("drogna:place", {
    description="Place Drogna",
    tiles = { "drogna_circle_yellow.png" },
    drawtype = "nodebox",
    node_box = {
        type = "wallmounted",
        wall_top    = {-0.4875, 0.4875, -0.4875, 0.4875, 0.5, 0.4875},
        wall_bottom = {-0.4875, -0.5, -0.4875, 0.4875, -0.4875, 0.4875},
        wall_side   = {-0.5, -0.4875, -0.4875, -0.4875, 0.4875, 0.4875},
    },
    paramtype = "light",
    paramtype2="wallmounted",
    light_source = minetest.LIGHT_MAX,
    inventory_image = "drogna_circle_yellow.png",
    groups = {snappy=2, cracky=3, choppy=3 },
    sounds = default.node_sound_defaults(),
    on_construct = place
})

