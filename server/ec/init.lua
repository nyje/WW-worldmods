-- External Command (external_cmd) mod by Menche
-- Allows server commands / chat from outside minetest
-- License: LGPL
-- Modified & renamed to ec by N.Garnett

local admin = minetest.setting_get("name")

if admin == nil then
	admin = "SERVER"
end

minetest.register_globalstep(
	function(dtime)
		local f = (io.open(minetest.get_modpath("ec").."/message", "r"))
		if f ~= nil then
			local message = f:read("*line")
			f:close()
			os.remove(minetest.get_modpath("ec").."/message")

			if message ~= nil then
				local cmd, param = string.match(message, "^/([^ ]+) *(.*)")
				if not param then
					param = ""
				end
				local cmd_def = minetest.chatcommands[cmd]
				if cmd_def then
					--minetest.chat_send_all("* "..cmd.." "..param)
					cmd_def.func(admin, param)
                    minetest.log("action","ADMIN "..admin.." does : "..message)
				else
					minetest.chat_send_all(admin.." says : "..message)
                    minetest.log("action","ADMIN "..admin.." says : "..message)
				end
			end
		end
	end
)
