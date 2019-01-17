local lgi = require 'lgi'
local GLib = lgi.GLib
local Gio = lgi.Gio


local dir = os.getenv("HOME").."/.screenlayout"

local d = Gio.File.new_for_path(dir)
local enum = d:enumerate_children(Gio.FILE_ATTRIBUTE_STANDARD_NAME, Gio.FileQueryInfoFlags.NONE)
if enum == nil then return end

print '<?xml version="1.0" encoding="UTF-8" ?>'
print "<openbox_pipe_menu>"
while true do
	local info, err = enum:next_file()
	if not info then assert(not err, err) break end
	print("<item label=\"" .. info:get_name().. "\">")
	print("  <action name=\"Execute\"><execute>sh \"" .. dir.. "/" .. info:get_name() .."\"</execute></action>")
	print("</item>")
end
print "</openbox_pipe_menu>"
