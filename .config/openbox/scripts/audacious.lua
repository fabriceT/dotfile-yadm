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

--~ Display song informations with audacious DBUS client, audtool.

function audtool(command)
	local handle = io.popen("audtool ".. command)
	local content = handle:read("*l")
	handle:close()
	return content
end

-- remove XML entities from name
function xml_entities (name)
	local r
	r = string.gsub(name, '%&', "&amp;")
	r = string.gsub(r, '%<', "&lt;")
	r = string.gsub(r, '%>', "&gt;")
	r = string.gsub(r, '%"', "&quote;")
	return r
end

print ([[<?xml version="1.0" encoding="UTF-8" ?>
<openbox_pipe_menu xmlns="http://openbox.org/"
   	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   	xsi:schemaLocation="http://openbox.org/
   	file:///usr/share/openbox/menu.xsd">]])

current_song = audtool("current-song")

if current_song ~= nil and current_song ~= "No song playing." then
	local position = audtool ("current-song-output-length")
	local length = audtool ("current-song-length")
	print("  <separator label=\"" .. xml_entities (current_song) .."\"/>")
	print("  <item label=\"" .. audtool ("playback-status") .. " - "..position .. "/" .. length .."\">")
	print("    <action name=\"Execute\"><execute>audtool playback-playpause</execute></action>")
	print("  </item>")
	print("  <item label=\"&#9197; _Next\"><action name=\"Execute\"><execute>audtool playlist-advance</execute></action></item>")
	print("  <item label=\"&#9198; _Previous\"><action name=\"Execute\"><execute>audtool playlist-reverse</execute></action></item>")
else
	print("  <item label=\"Not running, click to launch\"><action name=\"Execute\"><execute>audacious</execute></action></item>")
end

print("</openbox_pipe_menu>")
