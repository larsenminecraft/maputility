MapUtility = MapUtility or {}

-- Setup

function MapUtility.SetupMap()
	MapUtility.hammerLuaRun = ents.Create( "lua_run" )
	MapUtility.hammerLuaRun:SetName( "hammerluarun" )
	MapUtility.hammerLuaRun:Spawn()

	for k, v in pairs( ents.FindByClass( "func_button" ) ) do
		v:Fire( "AddOutput", "OnPressed hammerluarun:RunPassedCode:hook.Run( 'InternalOnButtonPressed' ):0:-1" )
	end

	for k, v in pairs( ents.FindByClass( "func_rot_button" ) ) do
		v:Fire( "AddOutput", "OnIn hammerluarun:RunPassedCode:hook.Run( 'InternalOnRotButtonIn' ):0:-1" )
		v:Fire( "AddOutput", "OnOut hammerluarun:RunPassedCode:hook.Run( 'InternalOnRotButtonOut' ):0:-1" )
		v:Fire( "AddOutput", "OnPressed hammerluarun:RunPassedCode:hook.Run( 'InternalOnRotButtonPressed' ):0:-1" )
		v:Fire( "AddOutput", "OnUseLocked hammerluarun:RunPassedCode:hook.Run( 'InternalOnRotButtonUseLocked' ):0:-1" ) -- TODO
	end

	for k, v in pairs( ents.FindByClass( "func_rot_button" ) ) do
		v:Fire( "AddOutput", "OnClose hammerluarun:RunPassedCode:hook.Run( 'InternalOnDoorClose' ):0:-1" ) -- TODO
		v:Fire( "AddOutput", "OnOpen hammerluarun:RunPassedCode:hook.Run( 'InternalOnDoorOpen' ):0:-1" ) -- TODO

		v:Fire( "AddOutput", "OnFullyClosed hammerluarun:RunPassedCode:hook.Run( 'InternalOnDoorFullyClose' ):0:-1" ) -- TODO
		v:Fire( "AddOutput", "OnFullyOpen hammerluarun:RunPassedCode:hook.Run( 'InternalOnDoorFullyOpen' ):0:-1" ) -- TODO

		v:Fire( "AddOutput", "OnBlockedClosing hammerluarun:RunPassedCode:hook.Run( 'InternalOnDoorBlockedClosing' ):0:-1" ) -- TODO
		v:Fire( "AddOutput", "OnBlockedOpening hammerluarun:RunPassedCode:hook.Run( 'InternalOnDoorBlockedOpening' ):0:-1" ) -- TODO
		v:Fire( "AddOutput", "OnUnblockedClosing hammerluarun:RunPassedCode:hook.Run( 'InternalOnDoorUnblockedClosing' ):0:-1" ) -- TODO
		v:Fire( "AddOutput", "OnUnblockedOpening hammerluarun:RunPassedCode:hook.Run( 'InternalOnDoorUnblockedOpening' ):0:-1" ) -- TODO

		v:Fire( "AddOutput", "OnLockedUse hammerluarun:RunPassedCode:hook.Run( 'InternalOnDoorLockedUse' ):0:-1" ) -- TODO
	end
end

hook.Add( "InitPostEntity", "MapUtility:InitPostEntity", MapUtility.SetupMap )
hook.Add( "PostCleanupMap", "MapUtility:PostCleanupMap", MapUtility.SetupMap )

-- Hooks

-- func_button
hook.Add( "InternalOnButtonPressed", "MapUtility:InternalOnButtonPressed", function()
	local ply, button = ACTIVATOR, CALLER
	hook.Run("OnButtonPressed", ply, button)
end )

hook.Add( "InternalOnRotButtonIn", "MapUtility:InternalOnRotButtonIn", function()
	local ply, button = ACTIVATOR, CALLER
	-- Ply (can be nil), the button and a bool (true for in et false for out)
	hook.Run("OnRotButtonPressed", ply, button, true)
end )

-- func_rot_button
hook.Add( "InternalOnRotButtonOut", "MapUtility:InternalOnRotButtonOut", function()
	local ply, button = ACTIVATOR, CALLER
	-- Ply (can be nil), the button and a bool (true for in et false for out)
	hook.Run("OnRotButtonPressed", ply, button, false)
end )

hook.Add( "InternalOnRotButtonPressed", "MapUtility:InternalOnRotButtonPressed", function()
	local ply, button = ACTIVATOR, CALLER
	-- Ply (can be nil), the button and a bool (true for in et false for out)
	hook.Run("PreRotButtonPressed", ply, button)
end )

