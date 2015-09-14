if CLIENT then
local PANEL = {}

local function VIPCheck()
	local JobCheck = false
	for k,v in pairs(RXF4_Adjust.VIPGroup or {}) do
		if LocalPlayer():GetNWString("usergroup") == v then
			JobCheck = true
		end
	end
			
	if JobCheck == false then
		local txt = "You are not VIP!"
		GAMEMODE:AddNotify(txt, 1, 4)
		surface.PlaySound("buttons/lightswitch2.wav")
		print(txt)
		return false
	else
		return true
	end
end

function RXF4_Open_VIPJobSelector(Parent)
	GAMEMODE.ConnectedPlayersPanel = vgui.Create("RXF4_M_VIPJobSelector",Parent)
	GAMEMODE.ConnectedPlayersPanel:SetSize(Parent:GetWide(),Parent:GetTall())
	return GAMEMODE.ConnectedPlayersPanel
end
function PANEL:Init()

end
function PANEL:Paint()
	surface.SetDrawColor( 0,0,0,100 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	self:DrawBoarder()
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
		draw.SimpleText("Choose Job you want to be ( VIP ONLY )", "SansationOut_S40", 20,20, Color(0,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end
	
	self.PlayerList = vgui.Create("DPanelList", self)
		self.PlayerList:SetPos(10,50)
		self.PlayerList:SetSize(self:GetWide()-20,self:GetTall() - 60)
		self.PlayerList:SetSpacing(3);
		self.PlayerList:SetPadding(0);
		self.PlayerList:EnableVerticalScrollbar(true);
		self.PlayerList:EnableHorizontal(false);
		self.PlayerList:PaintListBarC()
		self.PlayerList.Paint = function(slf)
			surface.SetDrawColor( 0,0,0,50 )
			surface.DrawRect( 0, 0, slf:GetWide(), slf:GetTall() )
		end
		
	self:UpdateList()
end

function PANEL:UpdateList()
	self.PlayerList:Clear()
	local List = self.PlayerList
		local function AddIcon(Model, name, description, Weapons, command, special, specialcommand)
			local JTB = {}
			for a,b in pairs(RPExtraTeams) do
				if b.name == name then
					JTB = b
				end
			end
			
			local BGP = vgui.Create("RXF4_DSWButton")
			BGP:SetSize(List:GetWide(),70)
			BGP:SetBoarderColor(Color(0,0,0,0))
			BGP.PaintOverlay = function(slf)
				surface.SetDrawColor( 0,180,255,10 )
				surface.DrawRect( 1, slf:GetTall()-1, slf:GetWide()-2, 1 )
				draw.SimpleText(name, "SansationOut_S30", 80,-3, Color(0,200,255,255))
				draw.SimpleText("Salary : " .. JTB.salary, "SansationOut_S20", 90,25, Color(0,120,255,255))
				draw.SimpleText("Max : " .. JTB.max, "SansationOut_S20", 90,45, Color(0,120,255,255))
			end
			
			local icon = vgui.Create("ModelImage",BGP)
			icon:SetSize(BGP:GetTall(),BGP:GetTall())
			local IconModel = Model
			if type(Model) == "table" then
				IconModel = Model[math.random(#Model)]
			end
			icon:SetModel(IconModel)
					icon.OnCursorEntered = function(slf) 
						slf.Hover = true 
						local IP = slf:CreateHoverInfoPanel()
						IP:SetSize(550,270)
						IP.Paint = function(slf)
							surface.SetDrawColor( 0,0,0,200 )
							surface.DrawRect( 0, 0, slf:GetWide(), slf:GetTall() )
							slf:DrawBoarder()
							
							draw.SimpleText(name, "SansationOut_S30", 10,5, Color(0,200,255,255))
						end
						local LABEL = vgui.Create("DLabel",IP)
						LABEL:SetText(description)
						LABEL:SizeToContents()
						LABEL:SetPos(10,40)
						
						local PMD = vgui.Create( "Login_PlayerModelDrawer", IP )
							PMD:SetPos( IP:GetWide() - IP:GetTall()/1.3, 0)
							PMD:SetSize( IP:GetTall()/1.2, IP:GetTall()*1.15 )
							PMD:SetUp()
							PMD.PMEntity:SetModel(IconModel)
					end
					
			local SButton = vgui.Create( "RXF4_DSWButton",BGP)
				SButton:SetPos(BGP:GetWide()-180,BGP:GetTall()-45)
				SButton:SetSize( 150 , 40 )
				SButton:SetTexts( "Choose" )
				SButton:SetHoverAnim(1)
				SButton:SetExitAnim(1)
				SButton:SetClickAnim(1)
				SButton.Click = function()
					if !VIPCheck() then return end
					
					local function DoChatCommand(frame)
						if special then
							local menu = DermaMenu()
							menu:AddOption("Vote" , function() RunConsoleCommand("darkrp","vote" .. command) frame:Close() end)
							menu:AddOption("Do not vote", function() RunConsoleCommand("darkrp",command) frame:Close() end)
							menu:Open()
						else
							RunConsoleCommand("darkrp",command)
							frame:Close()
						end
					end

					if type(Model) == "table" and #Model > 0 then
						local frame = vgui.Create("DFrame")
						frame:SetTitle("Choose model")
						frame:SetVisible(true)
						frame:MakePopup()
						frame.Paint = function(slf)
							surface.SetDrawColor( 0,0,0,200 )
							surface.DrawRect( 0, 0, slf:GetWide(), slf:GetTall() )
							slf:DrawBoarder()
						end
						
						local levels = 1
						local IconsPerLevel = math.floor(ScrW()/64)

						while #Model * (64/levels) > ScrW() do
							levels = levels + 1
						end
						frame:SetSize(math.Min(#Model * 64, IconsPerLevel*64), math.Min(90+(64*(levels-1)), ScrH()))
						frame:Center()

						local CurLevel = 1
						for k,v in pairs(Model) do
							local icon = vgui.Create("SpawnIcon", frame)
							if (k-IconsPerLevel*(CurLevel-1)) > IconsPerLevel then
								CurLevel = CurLevel + 1
							end
							icon:SetPos((k-1-(CurLevel-1)*IconsPerLevel) * 64, 25+(64*(CurLevel-1)))
							icon:SetModel(v)
							icon:SetSize(64, 64)
							icon:SetToolTip()
							icon.DoClick = function()
								RunConsoleCommand("rp_playermodel", v)
								RunConsoleCommand("_rp_ChosenModel", v)
								DoChatCommand(frame)
							end
						end
					else
						if special then
							local menu = DermaMenu()
							menu:AddOption("Vote", function() RunConsoleCommand("darkrp","vote"..command) end)
							menu:AddOption("Do not vote", function() RunConsoleCommand("darkrp",command) end)
							menu:Open()
						else
							RunConsoleCommand("darkrp",command)
						end
					end
				end
				self.PlayerList:AddItem(BGP)
		end
	
		for k,v in ipairs(RPExtraTeams) do
			if LocalPlayer():Team() ~= k and GAMEMODE:CustomObjFitsMap(v) then
				local nodude = true
				if !v.VIPOnly then nodude = false end
				if v.admin == 1 and not LocalPlayer():IsAdmin() then
					nodude = false
				end
				if v.admin > 1 and not LocalPlayer():IsSuperAdmin() then
					nodude = false
				end
				if v.customCheck and not v.customCheck(LocalPlayer()) then
					nodude = false
				end

				if (type(v.NeedToChangeFrom) == "number" and LocalPlayer():Team() ~= v.NeedToChangeFrom) or (type(v.NeedToChangeFrom) == "table" and not table.HasValue(v.NeedToChangeFrom, LocalPlayer():Team())) then
					nodude = false
				end

				if nodude then
					local weps = "no extra weapons"
					if #v.weapons > 0 then
						weps = table.concat(v.weapons, "\n")
					end
					if (not v.RequiresVote and v.vote) or (v.RequiresVote and v.RequiresVote(LocalPlayer(), k)) then
						local condition = ((v.admin == 0 and LocalPlayer():IsAdmin()) or (v.admin == 1 and LocalPlayer():IsSuperAdmin()) or LocalPlayer().DarkRPVars["Priv"..v.command])
						if not v.model or not v.name or not v.description or not v.command then chat.AddText(Color(255,0,0,255), "Incorrect team! Fix your shared.lua!") return end
						AddIcon(v.model, v.name, v.description, weps, v.command, condition, v.command)
					else
						if not v.model or not v.name or not v.description or not v.command then chat.AddText(Color(255,0,0,255), "Incorrect team! Fix your shared.lua!") return end
						AddIcon(v.model, v.name, v.description, weps, v.command)
					end
				end
			end
		end
	
	
end
vgui.Register("RXF4_M_VIPJobSelector",PANEL,"DFrame")

end