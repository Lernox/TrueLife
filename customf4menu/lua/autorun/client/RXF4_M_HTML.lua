if CLIENT then
local PANEL = {}

function RXF4_Open_HTML(Parent,URL)
	GAMEMODE.ConnectedPlayersPanel = vgui.Create("RXF4_M_HTML",Parent)
	GAMEMODE.ConnectedPlayersPanel.URL = URL
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

	self.HTMLP = vgui.Create("HTML", self)
		self.HTMLP:SetPos(10,45)
		self.HTMLP:SetSize(self:GetWide()-20,self:GetTall() - 20)
		self.HTMLP:OpenURL(self.URL)
		
        local Controls = vgui.Create('DHTMLControls',self)
        Controls:SetPos(10,10)
        Controls:SetSize(self.HTMLP:GetWide(),35)
        Controls.HomeURL = self.URL
        Controls:SetHTML(self.HTMLP)
		Controls.BackButton:SetVisible( false )
		Controls.ForwardButton:SetVisible( false )
end

vgui.Register("RXF4_M_HTML", PANEL, "DFrame")

end -- client end