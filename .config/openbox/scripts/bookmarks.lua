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

local bookmarks=os.getenv("HOME").."/.gtk-bookmarks"
local filemanager = "pcmanfm"
local line

-- simple vérification
if bookmarks == nil then
	os.exit(1)
end

function print_bookmark (name, location)
	print("<item label=\"" .. name.. "\">")
	print("  <action name=\"Execute\"><execute>" .. filemanager .. " " .. location .."</execute></action>")
	print("</item>")
end

print ([[<?xml version="1.0" encoding="UTF-8" ?>
<openbox_pipe_menu xmlns="http://openbox.org/"
    	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    	xsi:schemaLocation="http://openbox.org/
    	file:///usr/share/openbox/menu.xsd">]])

print_bookmark ("Home", "~")
for line in io.lines(bookmarks) do
	local name, location
	for location, name in string.gmatch(line, "([^%s]+) (.+)") do
		print_bookmark  (name, location)
  end
end
print("</openbox_pipe_menu>")
