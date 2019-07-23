--= Biomes
rainbow.high_biomes={"high"}

local add_biome = function(a, b, c, d, e, f, g, h, i, j, k, l, m, n, o)
	minetest.register_biome({
		name = a,
		node_dust = b,
		node_top = c,
		depth_top = d,
		node_filler = e,
		depth_filler = f,
		node_stone = g,

		node_water_top = h,
		depth_water_top = i,
		node_water = j,
		node_river_water = k,

		y_min = l,
		y_max = m,
		heat_point = n,
		humidity_point = o,
	})
end

add_biome("high",
            "rainbow:snow_white","rainbow:dirt_white",3,"rainbow:clay_white",10,"rainbow:stone_white",
            "rainbow:ice_white",2,"default:water_source","rainbow:ice_white",
            61,31000,50,50)
add_biome("low",
            "rainbow:stone_black", "rainbow:stone_black", 1, "rainbow:stone_black",1, "rainbow:stone_black",
            nil,nil,"rainbow:black_water_source","rainbow:black_water_source",
            -31000,-32,50,50)

for _, row in ipairs(rainbow.colours) do
    if (row[1]~="white") and (row[1]~="grey") then
        table.insert(rainbow.high_biomes,row[1].."_high")
        add_biome(row[1].."_high",
                    "rainbow:snow_white","rainbow:dirt_"..row[1],1,"rainbow:clay_"..row[1],1,"rainbow:stone_"..row[1],
                    nil,nil,"rainbow:"..row[1].."_water_source","rainbow:"..row[1].."_water_source",
                    51,101,row[5][1],row[5][2])
        if row[1]=="yellow" then
            add_biome(row[1],
                        nil,"rainbow:sand_"..row[1],1,"rainbow:clay_"..row[1],1,"rainbow:stone_"..row[1],
                        nil,nil,"rainbow:"..row[1].."_water_source","rainbow:"..row[1].."_water_source",
                        3,60,row[5][1],row[5][2])
        else
            add_biome(row[1],
                        nil,"rainbow:dirt_"..row[1],1,"rainbow:clay_"..row[1],1,"rainbow:stone_"..row[1],
                        nil,nil,"rainbow:"..row[1].."_water_source","rainbow:"..row[1].."_water_source",
                        3,60,row[5][1],row[5][2])
        end
        add_biome(row[1].."_low",
                    nil,"rainbow:sand_"..row[1],1,"rainbow:clay_"..row[1],1,"rainbow:stone_"..row[1],
                    nil,nil,"rainbow:"..row[1].."_water_source","rainbow:"..row[1].."_water_source",
                    -31,2,row[5][1],row[5][2])
    end
end


