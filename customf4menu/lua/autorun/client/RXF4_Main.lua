function ChangeJobVGUI()
	if !F4Menu or !F4Menu:IsValid() then
		F4Menu = vgui.Create("RXF4_Main")
		F4Menu:SetSize(ScrW()*RXF4_Adjust.Main_Size_X, ScrH()*RXF4_Adjust.Main_Size_Y)
		F4Menu:Center()
		F4Menu:MakePopup()
	else
		F4Menu:Remove()
	end
end

// =============================================== Inventory Main ==============================================================================================
local PANEL = {}

function PANEL:Paint()
	surface.SetDrawColor( 0,0,0,245 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
	self:DrawBoarder(2)
	
	draw.SimpleText(RXF4_Adjust.Main_MainText, "SansationOut_S55", 50,15, Color(255,255,255,255))
		
	surface.SetDrawColor( 255,255,255,180 )
	surface.DrawRect( 50, 70, self:GetWide()-100, 1 )
	
	if input.IsKeyDown(95) then
		if self.ReadyToClose then
			self:Remove()
			return
		end
	else
		if CurTime() - self.CreatedTime > 0.2 then
			self.ReadyToClose = true
		end
	end
end

function PANEL:Init()
	self.CreatedTime = CurTime()
local MainPanel = self
	self:SetTitle(" ")
	self:ShowCloseButton(false)
	self:SetDraggable(false)
			timer.Simple(0,function()
			local SButton = vgui.Create( "RXF4_DSWButton",self )
				SButton:SetPos( self:GetWide()-110 , 10 )
				SButton:SetSize( 100 , 30 )
				SButton:SetTexts( "Close" )
				SButton.Click = function(slf)
					self:Remove()
				end
			end)
			
	local MenuList = vgui.Create( "DPanelList" , self)
	MenuList:SetPos( 20,90 )
	MenuList:SetSize( 220,ScrH()*RXF4_Adjust.Main_Size_Y-150)
	MenuList:SetSpacing(10);
	MenuList:SetPadding(2);
	MenuList:EnableVerticalScrollbar(true);
	MenuList:EnableHorizontal(false);
	MenuList:PaintListBarC();
	MenuList.Paint = function(slf)
	end

	local Menus = {}
		table.insert(Menus,{N="RolePlay",Title = true})
		table.insert(Menus,{M="Jobs",P= function(PN) return RXF4_Open_JobSelector(PN) end,N="Job"})
		table.insert(Menus,{M="Shop",P= function(PN) return RXF4_Open_Shop(PN) end,N="Shop"})
		if RXF4_Adjust.Main_EnableVIPShop then
			table.insert(Menus,{M="V.I.P Shop",P= function(PN) return RXF4_Open_VIPShop(PN) end,N="V.I.P Shop"})
		end
		if RXF4_Adjust.Main_EnableVIPJob then
			table.insert(Menus,{M="V.I.P Jobs",P= function(PN) return RXF4_Open_VIPJobSelector(PN) end,N="V.I.P Job"})
		end
		table.insert(Menus,{Blank = true})
		table.insert(Menus,{N="Server",Title = true})
		table.insert(Menus,{M="Rule",P= function(PN) return RXF4_Open_Rule(PN) end,N="Rule"})
		table.insert(Menus,{M="Site",P= function(PN) return RXF4_Open_HTML(PN,RXF4_Adjust.HTML_URL) end,N="Site"})
		
		
		
		local Widths = 10
		for k,v in pairs(Menus) do
			if v.Blank then
				local Blank = vgui.Create("DPanel")
				Blank:SetSize(MenuList:GetWide(),40)
				Blank.Paint = function(slf) end
				MenuList:AddItem(Blank)
				continue
			end
			if v.Title then
				local Title = vgui.Create("DPanel")
				Title:SetSize(MenuList:GetWide(),25)
				Title.Paint = function(slf) 
					draw.SimpleText(v.N, "SansationOut_S25", 0,0, Color(0,255,255,255))
				end
				MenuList:AddItem(Title)
				continue
			end
			
			local SButton = vgui.Create( "RXF4_DSWButton" )
				SButton:SetSize( MenuList:GetWide() , 40 )
				SButton:SetTexts( v.N )
				SButton:SetHoverAnim(1)
				SButton:SetExitAnim(1)
				SButton:SetClickAnim(1)
				SButton.Click = function(slf)
					MainPanel:UpdateMenu(v.M,v.P)
				end
				SButton.PaintBackGround = function(slf)
					if (self.Menus or "d") == v.M then
						surface.SetDrawColor( 0,150,255,50 )
						surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )
					end
				end
			MenuList:AddItem(SButton)
		end

end

function PANEL:Install()

end

function PANEL:UpdateMenu(ModeName,ExecuteD)
	self.Menus = ModeName
	if self.MenuPanel then
		self.MenuPanel:Remove()
	end
	local P = ExecuteD(self)
		P:SetPos(250,90)
		P:SetSize(self:GetWide()-260,self:GetTall()-110)
		P:Install(true)
		P.ModeName = ModeName
	self.MenuPanel = P
end

vgui.Register("RXF4_Main",PANEL,"DFrame")


timer.Simple(0.7,function() -- Override --
GAMEMODE.ShowSpare2 = ChangeJobVGUI
end)
