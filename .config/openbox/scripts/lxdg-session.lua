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

--~ Manage ~/.config/autostart and /etc/xdg/autostart entries.
--~ More or less a lxsession-edit clone.

local lgi = require 'lgi'
local GLib = lgi.GLib
local Gio = lgi.Gio

local de_name = "Openbox"
local config_dir
local desktop_files = {}


function get_desktop_files(dir)
	local directory = Gio.File.new_for_path(dir)
	local enum = directory:enumerate_children(Gio.FILE_ATTRIBUTE_STANDARD_NAME, Gio.FileQueryInfoFlags.NONE)
	while true do
		local info, err = enum:next_file()
		if not info then assert(not err, err) break end
		local name = info:get_name()
		if string.sub(name,-8) == ".desktop" then
			desktop_files[name]=dir
		end
	end
end


function get_desktop_info(filename)
	local kf = GLib.KeyFile()
	kf:load_from_file(filename, 0)

	-- Does our desktop entry must be shown ?
	local onlyshowin =  kf:get_string_list("Desktop Entry", "OnlyShowIn")
	if #onlyshowin > 0 then
		local show = false
		for _,a in pairs(onlyshowin) do
			if de_name == a then
				show = true
			end
		end
		if show == false then
			return
		end
	end

	-- Does our desktop entry must not be hidden ?
	local notshowin =  kf:get_string_list("Desktop Entry", "NotShowIn")
	if #notshowin > 0 then
		for _,a in pairs(notshowin) do
			if de_name == a then
				return
			end
		end
	end

	-- get description from keyfile (comment or fallback to name)
	local description = kf:get_locale_string("Desktop Entry", "Comment")
	if description == nil then
		description = kf:get_locale_string("Desktop Entry", "Name")
	end

	local hidden = kf:get_boolean("Desktop Entry", "Hidden")

	return description, hidden
end


function get_autostart_file()
	for _,dir in pairs(GLib.get_system_config_dirs()) do
		get_desktop_files(dir.."/autostart/")
	end
	get_desktop_files(GLib.get_user_config_dir().."/autostart/")
	table.sort(desktop_files, lt)
end


function get_icon (status)
	if status then
		return "&#x2718;"
	else
		return "&#x2714;"
	end
end


function toggle_autostart (filename)
	local kf = GLib.KeyFile()
	local user_autostart_dir = GLib.get_user_config_dir().."/autostart/"

	if kf:load_from_file(desktop_files[filename] .. filename, 0) then
		-- we do our stuff by toggling 'hidden' value
		local hidden = kf:get_boolean("Desktop Entry", "Hidden")
		if hidden == nil or hidden == false then
			kf:set_boolean("Desktop Entry", "Hidden", true)
		else
			kf:remove_key("Desktop Entry", "Hidden")
		end

		local content = kf:to_data()
		local f = io.open(user_autostart_dir .. filename,"w")
		f:write(content)
		f:close()
	end
end

-------------- main -----------
get_autostart_file ()

if arg[1] then
	toggle_autostart(arg[1])
else
	-- at this point all desktop files are stored in the dictionnary 'desktop_files'.
	-- Since we cannot sort the dictionnary entries, we have to convert it into a table.
	local autostart_entries = {} -- table to store the entries
	for i,k in pairs (desktop_files) do
		local o = {}
		o.name = i
		o.path = k
		table.insert(autostart_entries, o)
	end

	-- sort the table with a simple function
	table.sort(autostart_entries, function (a,b) return (a.name > b.name) end)

	-- now we are ready to go
	print ([[<?xml version="1.0" encoding="UTF-8" ?>
	<openbox_pipe_menu xmlns="http://openbox.org/"
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xsi:schemaLocation="http://openbox.org/
			file:///usr/share/openbox/menu.xsd">
			<separator label="Autostart" />]])
	for _,i in pairs(autostart_entries) do
		local desc, checked  = get_desktop_info (i.path .. i.name)
		if desc then
			print(string.format([[<item label="%s %s">
  <action name="Execute"><execute>lua %s %s</execute></action>
</item>]], get_icon(checked), desc, arg[0], i.name))
		end
	end
	print ('</openbox_pipe_menu>')
end

