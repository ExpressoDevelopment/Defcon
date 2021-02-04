if ( SERVER ) then
	util.AddNetworkString( "DefconChange" )


	hook.Add( "PlayerSay", "SetDefcon", function( ply, text )
		local playerInput = string.Explode( " ", text )

		if ( playerInput[1] == "!defcon" ) then

			if tonumber(playerInput[2]) then

				local defconvalue = tonumber(playerInput[2])

				if ( defconvalue >= 0 and defconvalue <= 5 ) then

					if ply:IsAdmin() then 

						SetGlobalInt("Defcon System", defconvalue )

						ulx.fancyLogAdmin( ply, "#A set the current defcon to #s ", "DEFCON "..defconvalue )

						net.Start("DefconChange")
						net.WriteUInt(defconvalue,16)
						net.Broadcast()

					end

				end

			end

		end

	end )
	net.Receive("DefconChange",function(_, ply)
		if ply.usingconsole then
			defconn = net.ReadUInt(16)
			c_defconn = GetGlobalInt("Defcon System" )
			if c_defconn ~= defconn then
				SetGlobalInt("Defcon System", defconn )
				net.Start("DefconChange")
				net.WriteUInt(defconn,16)
				net.Broadcast()
			end
		else
			ulx.asay(a, "[ALERT] Player " .. ply:Nick() .. " (" .. ply:SteamID() .. ") illegally tried to change defcon (keep an eye on them)")
		end
		
	end)
else
	local function defconsystem()
		surface.SetDrawColor( Color( 25, 25, 25, 250 ) )
		surface.DrawRect( 10, 10, 250, 75 )
		local defcon = GetGlobalInt("Defcon System", 5)
		if defcon == 5 then 
			draw.DrawText( "DEFCON V", "Trebuchet24", 250/2+5, 75/4+5, Color( 55, 255, 0, 255 ), TEXT_ALIGN_CENTER )
			draw.DrawText( "Weapons Away", "Trebuchet24", 250/2+5, 75/1.7+5, Color( 55, 255, 0, 255 ), TEXT_ALIGN_CENTER )
		elseif defcon == 4 then
			draw.DrawText( "DEFCON IV", "Trebuchet24", 250/2+5, 75/4+5, Color( 255, 234, 0, 255 ), TEXT_ALIGN_CENTER )
			draw.DrawText( "Weapons On Safety", "Trebuchet24", 250/2+5, 75/1.7+5, Color( 255, 234, 0, 255 ), TEXT_ALIGN_CENTER )
		elseif defcon == 3 then
			draw.DrawText( "DEFCON III", "Trebuchet24", 250/2+5, 75/4+5, Color( 255, 153, 0, 255 ), TEXT_ALIGN_CENTER )
			draw.DrawText( "Weapons Off Safety", "Trebuchet24", 250/2+5, 75/1.7+5, Color( 255, 153, 0, 255 ), TEXT_ALIGN_CENTER )
		elseif defcon == 2 then
			draw.DrawText( "DEFCON II", "Trebuchet24", 250/2+5, 75/4+5, Color( 255, 81, 0, 255 ), TEXT_ALIGN_CENTER )
			draw.DrawText( "Full Ship Lockdown", "Trebuchet24", 250/2+5, 75/1.7+5, Color( 255, 81, 0, 255 ), TEXT_ALIGN_CENTER )
		elseif defcon == 1 then
			draw.DrawText( "DEFCON I", "Trebuchet24", 250/2+5, 75/4+5, Color( 255, 0, 0, 255 ), TEXT_ALIGN_CENTER )
			draw.DrawText( "Abandon Ship", "Trebuchet24", 250/2+5, 75/1.7+5, Color( 255, 0, 0, 255 ), TEXT_ALIGN_CENTER )
		else end
	end

	hook.Add( "HUDPaint", "HUDDEFCON", defconsystem )

	net.Receive("DefconChange",function()
			defconn = net.ReadUInt(16)
			timer.Simple(0.5,function()
				if defconn == 5 then 
					ULib.csay(LocalPlayer(),"DEFCON "..defconn.." is now in effect!",Color( 55, 255, 0, 255 ),2,0.5)
					surface.PlaySound( "buttons/blip1.wav" )
				elseif defconn == 4 then
					ULib.csay(LocalPlayer(),"DEFCON "..defconn.." is now in effect!",Color( 255, 234, 0, 255 ),2,0.5)
					surface.PlaySound( "ambient/alarms/warningbell1.wav" ) 
				elseif defconn == 3 then
					ULib.csay(LocalPlayer(),"DEFCON "..defconn.." is now in effect!",Color( 255, 153, 0, 255 ),2,0.5)
					surface.PlaySound( "npc/overwatch/radiovoice/attention.wav" )
				elseif defconn == 2 then
					ULib.csay(LocalPlayer(),"DEFCON "..defconn.." is now in effect!",Color( 255, 81, 0, 255 ),2,0.5)
					defcon2alert = CreateSound(game.GetWorld(), "ambient/alarms/apc_alarm_loop1.wav")
					defcon2alert:Play()
					timer.Simple( 15, function() defcon2alert:Stop() end)				
					--surface.PlaySound( "ambient/alarms/apc_alarm_loop1.wav" )
				elseif defconn == 1 then
					ULib.csay(LocalPlayer(),"DEFCON "..defconn.." is now in effect!",Color( 255, 0, 0, 255 ),2,0.5)
					defcon1alert = CreateSound(game.GetWorld(), "ambient/alarms/siren.wav")
					defcon1alert:Play()
					timer.Simple( 15, function() defcon1alert:Stop() end)	
					--surface.PlaySound( "ambient/alarms/siren.wav" )
				else end
			end)
	end)
end