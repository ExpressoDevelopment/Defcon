AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("Open_Defcon_Menu")
util.AddNetworkString("Close_Defcon_Menu")

function ENT:Initialize()
	
	self:SetModel("models/kingpommes/starwars/venator/bridge_console1.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()

	if ( phys:IsValid() ) then

		phys:Wake()

	end

end

function ENT:Use( activator )

	if ( activator:IsPlayer() and activator:IsValid() ) then
		
		net.Start("Open_Defcon_Menu")
		net.Send( activator )
		activator.usingconsole = true

	end

end

net.Receive("Close_Defcon_Menu",function(_, ply)
	
	ply.usingconsole = false
	
end)