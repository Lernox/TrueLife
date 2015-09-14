if CLIENT then



local PANEL = {}

function RXF4_Open_Rule(Parent)
	GAMEMODE.ConnectedPlayersPanel = vgui.Create("RXF4_M_Rule",Parent)
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

	self.ItemList = vgui.Create("DPanelList", self)
		self.ItemList:SetPos(10,10)
		self.ItemList:SetSize(self:GetWide()-20,self:GetTall() - 20)
		self.ItemList:SetSpacing(5);
		self.ItemList:SetPadding(0);
		self.ItemList:EnableVerticalScrollbar(true);
		self.ItemList:EnableHorizontal(false);
		self.ItemList:PaintListBarC()
		self.ItemList.Paint = function(slf)
			surface.SetDrawColor( 0,0,0,50 )
			surface.DrawRect( 0, 0, slf:GetWide(), slf:GetTall() )
		end
		
	self.ItemList:Clear()
	for k,v in pairs(RuleDB) do
		if v.Type == "Title" then
			local BG = vgui.Create("DPanel")
			BG:SetSize(self.ItemList:GetWide(),40)
			BG.Paint = function(slf)
				surface.SetDrawColor( 0,255,255,20 )
				surface.DrawRect( 1, 39, slf:GetWide()-2, 1 )
				draw.SimpleText(v.Text, "SansationOut_S30", 10,20, Color(0,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			end
			self.ItemList:AddItem(BG)
		end
		if v.Type == "Text" then
			local BG = vgui.Create("DLabel")
			BG:SetText(v.Text)
			BG:SetFont("SansationOut_S20")
			BG:SizeToContents()
			self.ItemList:AddItem(BG)
		end
		
	end
end

vgui.Register("RXF4_M_Rule", PANEL, "DFrame")

end -- client end