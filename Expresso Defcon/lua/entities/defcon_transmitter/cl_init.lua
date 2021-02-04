include("shared.lua")

surface.CreateFont("DefconTitle", {
	font = "Arial",
	size = 50,
	weight = 500000000,
})

local function Draw3DText( pos, ang, scale, text, flipview )
	if ( flipview ) then
		ang:RotateAroundAxis( Vector( 0, 0, 2 ), 180)
	end
	cam.Start3D2D(pos, ang, scale)
		draw.DrawText( text, "DefconTitle", 0, 0, Color( 20, 20, 20), TEXT_ALIGN_CENTER )
	cam.End3D2D()
end

function ENT:Draw(  )
	
	self:DrawModel()

	local text = "DCON-T | Defcon Transmitter"

	local mins, maxs = self:GetModelBounds()
	local pos = self:GetPos() + Vector(0, 0, maxs.z + 20)

	local ang = self:GetAngles() + Angle( 0, 90, 90)

	Draw3DText( pos, ang, 0.1, text, false)

	Draw3DText( pos, ang, 0.1, text, true)
end

net.Receive("Open_Defcon_Menu", function( _, ply )
	if ( LocalPlayer():IsPlayer() and LocalPlayer():IsValid() ) then

		local Defcon_Frame = vgui.Create( "DFrame" )
		Defcon_Frame:SetSize( 640, 320 )
		Defcon_Frame:SetTitle( "Defcon System" )
		Defcon_Frame:SetVisible( true )
		Defcon_Frame:SetDraggable( false )
		Defcon_Frame:Center()
		Defcon_Frame:ShowCloseButton( false )
		Defcon_Frame:MakePopup()
		Defcon_Frame.Paint = function( self, w, h )
			draw.RoundedBox( 20, 0, 0, w, h, Color( 20, 20, 20, 255 ) ) -- Draw a blue button
		end

		local Defcon_Close_Button = vgui.Create( "DButton", Defcon_Frame )
		Defcon_Close_Button:SetText( "X" )
		Defcon_Close_Button:SetTextColor( Color( 0, 0, 0 ) )
		Defcon_Close_Button:SetPos( 615, 5 )
		Defcon_Close_Button:SetSize( 20, 20 )
		Defcon_Close_Button.Paint = function( self, w, h )
			draw.RoundedBox( 20, 0, 0, w, h, Color( 200, 100, 100, 155 ) ) -- Draw a blue button
		end
		Defcon_Close_Button.DoClick = function()
			Defcon_Frame:Close()
			LocalPlayer():ConCommand( "say /comms [DCON-T] Signing out.." )

			net.Start("Close_Defcon_Menu")
			net.SendToServer()

		end

		local Defcon_5Button = vgui.Create( "DButton", Defcon_Frame )
		Defcon_5Button:SetText( "Set Defcon 5" )
		Defcon_5Button:SetTextColor( Color( 0, 0, 0 ) )
		Defcon_5Button:SetPos( 60, 50 )
		Defcon_5Button:SetSize( 90, 90 )
		Defcon_5Button:Hide()
		Defcon_5Button.Paint = function( self, w, h )
			draw.RoundedBox( 20, 0, 0, w, h, Color( 55, 255, 0, 155 ) ) -- Draw a blue button
		end
		Defcon_5Button.DoClick = function()
			net.Start("DefconChange")
			net.WriteUInt(5,16)
			net.SendToServer()
			LocalPlayer():ConCommand( "say /comms [DCON-T] Setting ship to DEFCON V" )
		end

		local Defcon_4Button = vgui.Create( "DButton", Defcon_Frame )
		Defcon_4Button:SetText( "Set Defcon 4" )
		Defcon_4Button:SetTextColor( Color( 0, 0, 0 ) )
		Defcon_4Button:SetPos( 170, 50 )
		Defcon_4Button:SetSize( 90, 90 )
		Defcon_4Button:Hide()
		Defcon_4Button.Paint = function( self, w, h )
			draw.RoundedBox( 20, 0, 0, w, h, Color( 255, 234, 0, 155 ) ) -- Draw a blue button
		end
		Defcon_4Button.DoClick = function()
			net.Start("DefconChange")
			net.WriteUInt(4,16)
			net.SendToServer()
			LocalPlayer():ConCommand( "say /comms [DCON-T] Setting ship to DEFCON IV" )
		end

		local Defcon_3Button = vgui.Create( "DButton", Defcon_Frame )
		Defcon_3Button:SetText( "Set Defcon 3" )
		Defcon_3Button:SetTextColor( Color( 0, 0, 0 ) )
		Defcon_3Button:SetPos( 280, 50 )
		Defcon_3Button:SetSize( 90, 90 )
		Defcon_3Button:Hide()
		Defcon_3Button.Paint = function( self, w, h )
			draw.RoundedBox( 20, 0, 0, w, h, Color( 255, 153, 0, 155 ) ) -- Draw a blue button
		end
		Defcon_3Button.DoClick = function()
			net.Start("DefconChange")
			net.WriteUInt(3,16)
			net.SendToServer()
			LocalPlayer():ConCommand( "say /comms [DCON-T] Setting ship to DEFCON III" )
		end

		local Defcon_2Button = vgui.Create( "DButton", Defcon_Frame )
		Defcon_2Button:SetText( "Set Defcon 2" )
		Defcon_2Button:SetTextColor( Color( 0, 0, 0 ) )
		Defcon_2Button:SetPos( 390, 50 )
		Defcon_2Button:SetSize( 90, 90 )
		Defcon_2Button:Hide()
		Defcon_2Button.Paint = function( self, w, h )
			draw.RoundedBox( 20, 0, 0, w, h, Color( 255, 81, 0, 155 ) ) -- Draw a blue button
		end
		Defcon_2Button.DoClick = function()
			net.Start("DefconChange")
			net.WriteUInt(2,16)
			net.SendToServer()
			LocalPlayer():ConCommand( "say /comms [DCON-T] Setting ship to DEFCON II" )
		end

		local Defcon_1Button = vgui.Create( "DButton", Defcon_Frame )
		Defcon_1Button:SetText( "Set Defcon 1" )
		Defcon_1Button:SetTextColor( Color( 0, 0, 0 ) )
		Defcon_1Button:SetPos( 500, 50 )
		Defcon_1Button:SetSize( 90, 90 )
		Defcon_1Button:Hide()
		Defcon_1Button.Paint = function( self, w, h )
			draw.RoundedBox( 20, 0, 0, w, h, Color( 255, 0, 0, 155 ) ) -- Draw a blue button
		end
		Defcon_1Button.DoClick = function()
			net.Start("DefconChange")
			net.WriteUInt(1,16)
			net.SendToServer()
			LocalPlayer():ConCommand( "say /comms [DCON-T] Setting ship to DEFCON I" )
		end
		local Signin_Buttion = vgui.Create( "DButton", Defcon_Frame )
		Signin_Buttion:SetText( "Signin to DCON-T" )
		Signin_Buttion:SetTextColor( Color( 0, 0, 0 ) )
		Signin_Buttion:SetPos( 25, 70 )
		Signin_Buttion:SetSize( 590, 180 )
		Signin_Buttion.Paint = function( self, w, h )
			draw.RoundedBox( 5, 0, 0, w, h, Color( 255, 255, 255, 155 ) ) -- Draw a blue button
		end
		local Signout_Buttion = vgui.Create( "DButton", Defcon_Frame )
		Signout_Buttion:SetText( "Sign out of DCON-T" )
		Signout_Buttion:SetTextColor( Color( 0, 0, 0 ) )
		Signout_Buttion:SetPos( 25, 180 )
		Signout_Buttion:SetSize( 590, 100 )
		Signout_Buttion:Hide()
		Signout_Buttion.Paint = function( self, w, h )
			draw.RoundedBox( 5, 0, 0, w, h, Color( 255, 255, 255, 155 ) ) -- Draw a blue button
		end
		Signin_Buttion.DoClick = function()
			Defcon_5Button:Show()
			Defcon_4Button:Show()
			Defcon_3Button:Show()
			Defcon_2Button:Show()
			Defcon_1Button:Show()
			Signout_Buttion:Show()
			Signin_Buttion:Hide()
			LocalPlayer():ConCommand( "say /comms [DCON-T] Signing In.." )
		end
		Signout_Buttion.DoClick = function()
			Defcon_Frame:Close()
			LocalPlayer():ConCommand( "say /comms [DCON-T] Signing out.." )
			net.Start("Close_Defcon_Menu")
			net.SendToServer()
		end

	end
end)