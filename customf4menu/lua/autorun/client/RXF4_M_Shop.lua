if CLIENT then
local PANEL = {}

function RXF4_Open_Shop(Parent)
	GAMEMODE.ConnectedPlayersPanel = vgui.Create("RXF4_M_Shop",Parent)
	GAMEMODE.ConnectedPlayersPanel:SetSize(Parent:GetWide(),Parent:GetTall())
	return GAMEMODE.ConnectedPlayersPanel
end

function PANEL:Init()
end
function PANEL:Initialize()
end
	
function PANEL:Paint()
end

function PANEL:Install()
	self:SetDraggable(false)
	self:ShowCloseButton(false)
	self:SetTitle(" ")

	self.HasParent = HasParent
	self.TopLabel = vgui.Create( "DPanel" , self)
	self.TopLabel:SetPos(2,2)
	self.TopLabel:SetSize( self:GetWide(),40 )
	self.TopLabel.Paint = function(slf)
			surface.SetDrawColor( 255,255,255,20 )
			surface.DrawRect( 1, 39, slf:GetWide()-2, 1 )
		draw.SimpleText("Shop", "SansationOut_S40", 20,20, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end
	
	self.FilterList = vgui.Create("DPanelList", self)
		self.FilterList:SetPos(10,50)
		self.FilterList:SetSize(150,self:GetTall() - 60)
		self.FilterList:SetSpacing(5);
		self.FilterList:SetPadding(0);
		self.FilterList:EnableVerticalScrollbar(true);
		self.FilterList:EnableHorizontal(true);
		self.FilterList:PaintListBarC()
		self.FilterList.Paint = function(slf)
			surface.SetDrawColor( 0,0,0,50 )
			surface.DrawRect( 0, 0, slf:GetWide(), slf:GetTall() )
		end
		
	local Menus = {}
		table.insert(Menus,{M="ammo",N="Ammos"})
		table.insert(Menus,{M="weapons",N="Weapons"})
		table.insert(Menus,{M="shipment",N="Shipments"})
		table.insert(Menus,{M="entity",N="Entities"})
		table.insert(Menus,{M="vehicle",N="Vehicles"})
		
		for k,v in pairs(Menus) do
			local SButton = vgui.Create( "RXF4_DSWButton" )
				SButton:SetSize( self.FilterList:GetWide() , 30 )
				SButton:SetTexts( v.N )
				SButton.Click = function(slf)
					self:UpdateList(v.M)
				end
			self.FilterList:AddItem(SButton)
		end
	
	self.ItemList = vgui.Create("DPanelList", self)
		self.ItemList:SetPos(170,50)
		self.ItemList:SetSize(self:GetWide()-180,self:GetTall() - 60)
		self.ItemList:SetSpacing(5);
		self.ItemList:SetPadding(0);
		self.ItemList:EnableVerticalScrollbar(true);
		self.ItemList:EnableHorizontal(true);
		self.ItemList:PaintListBarC()
		self.ItemList.Paint = function(slf)
			surface.SetDrawColor( 0,0,0,50 )
			surface.DrawRect( 0, 0, slf:GetWide(), slf:GetTall() )
		end
		
	self:UpdateList()
end

function PANEL:UpdateList(filter)
	filter = filter or "ammo"
	self.CurFilter = filter
	
	self.ItemList:Clear()
	List = self.ItemList
	
	---- Ammo ----
	if filter == "ammo" then
		local function AddAmmoIcon(Model, description, command)
				local BGP = vgui.Create("RXF4_DSWButton")
				BGP:SetSize(List:GetWide()/2-5,70)
				BGP:SetBoarderColor(Color(0,0,0,0))
				BGP.Click = function() command() end
				BGP.PaintOverlay = function(slf)
					surface.SetDrawColor( 0,180,255,10 )
					surface.DrawRect( 1, slf:GetTall()-1, slf:GetWide()-2, 1 )
					draw.SimpleText(description, "SansationOut_S25", 80,-3, Color(0,200,255,255))
				end
				BGP:SetToolTip(description)
				
				local icon = vgui.Create("ModelImage",BGP)
				icon:SetSize(BGP:GetTall(),BGP:GetTall())
				icon:SetModel(Model)
			self.ItemList:AddItem(BGP)
		end
		for k,v in pairs(GAMEMODE.AmmoTypes) do
			if v.VIPOnly then continue end
			if not v.customCheck or v.customCheck(LocalPlayer()) then
				AddAmmoIcon(v.model, DarkRP.getPhrase("buy_a", v.name, GAMEMODE.Config.currency .. v.price), function() RunConsoleCommand("DarkRP", "buyammo", v.ammoType) end )
			end
		end
	end
	---- CustomShipments ----
	if filter == "weapons" then
		local function AddIcon(Model, description, command)
				local BGP = vgui.Create("RXF4_DSWButton")
				BGP:SetSize(List:GetWide()/2-5,70)
				BGP:SetBoarderColor(Color(0,0,0,0))
				BGP.Click = function() command() end
				BGP.PaintOverlay = function(slf)
					surface.SetDrawColor( 0,180,255,10 )
					surface.DrawRect( 1, slf:GetTall()-1, slf:GetWide()-2, 1 )
					draw.SimpleText(description, "SansationOut_S25", 80,-3, Color(0,200,255,255))
				end
				BGP:SetToolTip(description)
				
				local icon = vgui.Create("ModelImage",BGP)
				icon:SetSize(BGP:GetTall(),BGP:GetTall())
				icon:SetModel(Model)
			self.ItemList:AddItem(BGP)
		end
		for k,v in pairs(CustomShipments) do
			if v.VIPOnly then continue end
			if not GAMEMODE:CustomObjFitsMap(v) then continue end
			if (v.seperate and (not GAMEMODE.Config.restrictbuypistol or
				(GAMEMODE.Config.restrictbuypistol and (not v.allowed[1] or table.HasValue(v.allowed, LocalPlayer():Team())))))
				and (not v.customCheck or v.customCheck and v.customCheck(LocalPlayer())) then
				AddIcon(v.model, DarkRP.getPhrase("buy_a", "a "..v.name, GAMEMODE.Config.currency..(v.pricesep or "")), function() RunConsoleCommand("DarkRP", "buy", v.name) end )
			end
		end
	end
	---- CustomShipments B----
	if filter == "shipment" then
		local function AddShipIcon(Model, description, command)
				local BGP = vgui.Create("RXF4_DSWButton")
				BGP:SetSize(List:GetWide()/2-5,70)
				BGP:SetBoarderColor(Color(0,0,0,0))
				BGP.Click = function() command() end
				BGP.PaintOverlay = function(slf)
					surface.SetDrawColor( 0,180,255,10 )
					surface.DrawRect( 1, slf:GetTall()-1, slf:GetWide()-2, 1 )
					draw.SimpleText(description, "SansationOut_S25", 80,-3, Color(0,200,255,255))
				end
				BGP:SetToolTip(description)
				
				local icon = vgui.Create("ModelImage",BGP)
				icon:SetSize(BGP:GetTall(),BGP:GetTall())
				icon:SetModel(Model)
			self.ItemList:AddItem(BGP)
		end
		for k,v in pairs(CustomShipments) do
							if v.VIPOnly then continue end
							if not GAMEMODE:CustomObjFitsMap(v) then continue end
							if not v.noship and table.HasValue(v.allowed, LocalPlayer():Team())
								and (not v.customCheck or (v.customCheck and v.customCheck(LocalPlayer()))) then
								AddShipIcon(v.model, DarkRP.getPhrase("buy_a", "a "..v.name .." shipment", GAMEMODE.Config.currency .. tostring(v.price)), function() RunConsoleCommand("DarkRP", "buyshipment", v.name) end )
							end
		end
	end
	---- Entities ----
	if filter == "entity" then
		local function AddEntIcon(Model, description, command)
				local BGP = vgui.Create("RXF4_DSWButton")
				BGP:SetSize(List:GetWide()/2-5,70)
				BGP:SetBoarderColor(Color(0,0,0,0))
				BGP.Click = function() RunConsoleCommand("DarkRP",command) end
				BGP.PaintOverlay = function(slf)
					surface.SetDrawColor( 0,180,255,10 )
					surface.DrawRect( 1, slf:GetTall()-1, slf:GetWide()-2, 1 )
					draw.SimpleText(description, "SansationOut_S25", 80,-3, Color(0,200,255,255))
				end
				BGP:SetToolTip(description)
				
				local icon = vgui.Create("ModelImage",BGP)
				icon:SetSize(BGP:GetTall(),BGP:GetTall())
				icon:SetModel(Model)
			self.ItemList:AddItem(BGP)
		end
						for k,v in pairs(DarkRPEntities) do
							if v.VIPOnly then continue end
							if not v.allowed or (type(v.allowed) == "table" and table.HasValue(v.allowed, LocalPlayer():Team()))
								and (not v.customCheck or (v.customCheck and v.customCheck(LocalPlayer()))) then
								local cmdname = string.gsub(v.ent, " ", "_")

								AddEntIcon(v.model, "Buy a " .. v.name .." " .. GAMEMODE.Config.currency .. v.price, v.cmd)
							end
						end

						if FoodItems and (GAMEMODE.Config.foodspawn or LocalPlayer():Team() == TEAM_COOK) and LocalPlayer():Team() == TEAM_COOK then
							for k,v in pairs(FoodItems) do
								if v.VIPOnly then continue end
								AddEntIcon(v.model, DarkRP.getPhrase("buy_a", "a "..k, "$15"), v.cmd)
							end
						end
	end
	---- Entities ----
	if filter == "vehicle" then
		local function AddVehicleIcon(Model, skin,description, command)
				local BGP = vgui.Create("RXF4_DSWButton")
				BGP:SetSize(List:GetWide()/2-5,70)
				BGP:SetBoarderColor(Color(0,0,0,0))
				BGP.Click = function() command() end
				BGP.PaintOverlay = function(slf)
					surface.SetDrawColor( 0,180,255,10 )
					surface.DrawRect( 1, slf:GetTall()-1, slf:GetWide()-2, 1 )
					draw.SimpleText(description, "SansationOut_S25", 80,-3, Color(0,200,255,255))
				end
				BGP:SetToolTip(description)
				
				local icon = vgui.Create("SpawnIcon",BGP)
				icon:SetSize(BGP:GetTall(),BGP:GetTall())
				icon:SetModel(Model)
				icon:SetSkin(skin)
			self.ItemList:AddItem(BGP)
		end
					for k,v in pairs(CustomVehicles) do
						if v.VIPOnly then continue end
						if (not v.allowed or table.HasValue(v.allowed, LocalPlayer():Team())) and (not v.customCheck or v.customCheck(LocalPlayer())) then
							local Skin = (DarkRP.getAvailableVehicles and DarkRP.getAvailableVehicles()[v.name] and DarkRP.getAvailableVehicles()[v.name].KeyValues and DarkRP.getAvailableVehicles()[v.name].KeyValues.Skin) or "0"
							AddVehicleIcon(v.model or "models/buggy.mdl", Skin, "Buy a "..v.name.." for "..GAMEMODE.Config.currency..v.price, function() RunConsoleCommand("DarkRP", "buyvehicle", v.name) end )
						end
					end
	end
end
vgui.Register("RXF4_M_Shop", PANEL, "DFrame")

end -- client end