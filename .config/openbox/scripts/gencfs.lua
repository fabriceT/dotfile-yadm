#!/usr/bin/lua

--[[
   Copyright (C) 2013 Fabrice THIROUX <fabrice.thiroux@free.fr>

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU Lesser General Public License as published
   by the Free Software Foundation; version 3.0 only.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
   MA 02110-1301, USA.
]]--

--[[ Config file sample - named ~/config/encfs.tab (see end of script)

[encfs_name]
dir=/home/user/directory_encrypted
mount=/home/users/mounted_encfs_dir

]]--

local lgi = require 'lgi'
local GLib = lgi.GLib

local mounts = {}

-- program used for asking for password
local askpass_program = "/usr/lib/seahorse/seahorse-ssh-askpass"


function expand_path(s)
	return string.gsub(s, "~/", os.getenv("HOME").."/")
end


function check_directory(path)
	local d = expand_path(path)
	return GLib.file_test(d, GLib.FileTest.IS_DIR)
end


local encfs = {
	is_mounted = function (dir)
		local d = expand_path(dir)

		for l in io.lines("/etc/mtab") do
			if string.match(l, d) then
				return true
			end
		end
		return false
	end,

	mount = function (source, destination)
		if not check_directory (source) then
			return
		end

		if not check_directory (destination) then
			-- wrong flags?!
			--GLib.mkdir_with_parents (expand_path(destination), 0700)
			os.execute("mkdir -p ".. destination)
		end

		os.execute(string.format("encfs %s %s --extpass=%s", source, destination, askpass_program))
	end,

	umount = function (destination)
		os.execute("fusermount -u ".. destination)
		os.execute("rmdir " .. destination)
	end
}


function display_menu()
	print '<?xml version="1.0" encoding="UTF-8" ?>'
	print "<openbox_pipe_menu>"
	for i in pairs(mounts) do
		if check_directory(mounts[i].dir) then
			if encfs.is_mounted(mounts[i].mountpoint) then
				print("<item label=\"" .. mounts[i].name .. " (umount) \">")
				print("  <action name=\"Execute\"><execute>lua "..arg[0].." umount "..i.."</execute></action>")
			else
				print("<item label=\"" .. mounts[i].name .. " (mount)\">")
				print("  <action name=\"Execute\"><execute>lua "..arg[0].." mount "..i.."</execute></action>")
			end
			print("</item>")
		end
	end
	print "</openbox_pipe_menu>"
end


function take_action(option, index)
	if mounts[index].dir and mounts[index].mountpoint then
		if option == "mount" then
			encfs.mount(mounts[index].dir, mounts[index].mountpoint)
		else
			if option == "umount" then
				encfs.umount(mounts[index].mountpoint)
			end
		end
	end
end


function read_config(filename)
	local config_file = expand_path(filename)
	local kf = GLib.KeyFile.new()
	kf:load_from_file(config_file, GLib.KeyFileFlags.NONE)
	local groups = kf:get_groups()
	for i=1,#groups do
		local o = {}
		o.name=groups[i]
		o.dir=kf:get_string(groups[i],"dir")
		o.mountpoint=kf:get_string(groups[i],"mount")
		table.insert(mounts,o)
	end
end

read_config("~/.config/encfs.tab")

if #arg == 2 then
	take_action (arg[1], tonumber(arg[2]))
else
	display_menu()
end

