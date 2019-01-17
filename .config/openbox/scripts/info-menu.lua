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

--~ Display informations about the computer (proxy settings with wget,
--~ Battery status, CPU core speed.
--~ This pipe-menu may not be usable with another computer than my laptop.
--~ It was not intended to be modular; just a small script that went bigger and bigger.

local wgetrc = os.getenv("HOME").."/.wgetrc"
-- État du proxy par défaut
local proxy=true

local day={"Dim.", "Lun.", "Mar.", "Mer.", "Jeu.", "Ven.", "Sam."}

local month={"Janvier","Février", "Mars", "Avril",
		"Mai", "Juin", "Juillet", "Août", "Septembre",
		"Octobre", "Novembre", "Décembre"}


function proxySettings(switch)
	local f
	local lines={}
	local line
	local proxy_line
	local counter=1

	f=io.open (wgetrc,"r")
	if f == nil then return "Erreur" end

	while true do
		line=f:read ()

		if line == nil then break end

		if string.sub (line,1,1) ~="#" and string.len (line) > 0 then
			for k in string.gmatch (line,"use_proxy%s+=%s+(.*)") do
				if k == "off" then proxy=false end
				proxy_line=counter
			end
		end

		if switch then
			lines[counter]=line
			counter=counter+1
		end
	end
	f:close ()

	if switch then
		if proxy_line == nil then
			proxy_line = counter
		end

		if proxy then
			lines[proxy_line]="use_proxy = off"
		else
			lines[proxy_line]="use_proxy = on"
		end

		f=io.open (wgetrc,"w+")
		for _,l in ipairs (lines) do
			if l then f:write (l.."\n") end
		end
		f:close()
	else
		if proxy then
			print ("<item label=\"Proxy &#x2714;\">")
		else
			print ("<item label=\"Proxy &#x2718; \">")
		end
		print ("  <action name=\"Execute\"><execute>lua ".. arg[0] .. " switchproxy</execute></action>")
		print ("</item>")
	end
end

function getBatteryStatus (path)
	local f = io.open (path.."status")
	local eta
	if f ~= nil then
		local status = f:read ()
		f:close ()

		f = io.open (path.."charge_full")
		local charge_full = f:read ()
		f:close ()

		f = io.open (path.."charge_now")
		local charge_now = f:read ()
		f:close ()

		f = io.open (path.."current_now")
		local current_now = f:read ()
		f:close ()


		if status == "Charging" then

			eta = 60 * (charge_full - charge_now) / current_now
			print (string.format(
						"<item label=\"Batt.: %.2f min. &#x2B08; (%.2f%%)\" />",
						eta,
						(charge_now / charge_full) * 100))
		else
			eta = 60 * charge_now / current_now
			local h = math.ceil (eta / 60)
			local m = math.fmod (eta, 60)
			print (string.format(
						"<item label=\"Batt.: %.2f min. &#x2B0A; (%.2f%%)\" />",
						eta,
					(charge_now / charge_full) * 100))
		end
	end
end

function readFrequency (num)
	local f = io.open ("/sys/devices/system/cpu/cpu"..num.."/cpufreq/scaling_cur_freq")
	if f ~= nil then
		local cpufreq_K = f:read ()
		f:close()
		print ("<item label=\"CPU"..num.." Freq.: ".. cpufreq_K / 1000 .." MHz\" />")
	else
		return
	end
end

--[[
  *****f* info/dpms, info
  *  NAME
  *    dmps - switch on or off screen blanking 
  *  SYNOPSIS
  *    function dmps (flag)
  *  INPUTS
  *    flags   - boolean. Set to true to turn on screen blanking. Set to off to turn if off 
  *  RESULT
  *    returns nothing  
  *****
]]  
function dpms (flag)
	local enabled = false
	local f
	local content

	if flag == true then
		os.execute ("xset dpms 0 0 0")
		return
	end

	if flag == false then
		os.execute ("xset dpms 0 0 600")
		return
	end

	os.execute ("xset q > /tmp/xset.tmp")
	f = io.open ("/tmp/xset.tmp", "r")
	content = f:read ("*a")
	f:close ()

	if string.find (content,"Off: 0") then
		print ("<item label=\"DPMS &#x2714;\">")
		print ("  <action name=\"Execute\"><execute>lua ".. arg[0] .. " dpmsoff</execute></action>")
		print ("</item>")
		return
	else
		print ("<item label=\"DPMS &#x2718;\" >")
		print ("  <action name=\"Execute\"><execute>lua ".. arg[0] .. " dpmson</execute></action>")
		print ("</item>")
		return
	end

	print("<item label=\"DPMS Unknown\" />")
end

if arg[1]=="switchproxy" then
	proxySettings (true)
	os.exit ()
elseif arg[1]=="dpmsoff" then
	dpms (false)
	os.exit ()
elseif arg[1]=="dpmson" then
	dpms (true)
	os.exit()
end




print ([[<?xml version="1.0" encoding="UTF-8" ?>
<openbox_pipe_menu xmlns="http://openbox.org/"
    	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    	xsi:schemaLocation="http://openbox.org/
    	file:///usr/share/openbox/menu.xsd">]])
print ("<menu id=\"osmo-both\" />")
print ("<separator />")
print (string.format ("<item label=\"%s, %s %d %s\" />",
			os.date("%Hh%M"),
			day[tonumber(os.date ("%w")+1)],
			os.date("%d"),
			month[tonumber(os.date ("%m"))]))
readFrequency (0)
readFrequency (1)
getBatteryStatus ("/sys/devices/LNXSYSTM:00/device:00/PNP0C0A:00/power_supply/BAT0/")
proxySettings (false)
dpms ()
print ("</openbox_pipe_menu>")

