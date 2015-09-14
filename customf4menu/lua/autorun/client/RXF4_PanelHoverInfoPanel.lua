local meta = FindMetaTable("Panel")

local PanelHoverInfoPanel = nil

function meta:CreateHoverInfoPanel()
	if PanelHoverInfoPanel and PanelHoverInfoPanel:IsValid() then
		PanelHoverInfoPanel:Remove()
		PanelHoverInfoPanel = nil
	end
		surface.PlaySound("buttons/lightswitch2.wav")

		PanelHoverInfoPanel = vgui.Create("RX_PanelHoverInfoPanel_Master")
		PanelHoverInfoPanel.Mother = self
		PanelHoverInfoPanel:MakePopup()
		
		return PanelHoverInfoPanel
end




local PANEL = {}

function PANEL:Paint()

end

function PANEL:Init()
	self:SetSize(10,10)
end

function PANEL:SetMother(mother)
	self.Mother = mother
end

function PANEL:Think()
	if self.Mother and self.Mother:IsValid() then
		local X, Y = self.Mother:LocalToScreen( 0, 0 )
		local SX,SY = self.Mother:GetSize()
		local MX, MY = gui.MousePos()
		
		if MX < X or MX > X + SX then
			PanelHoverInfoPanel:Remove()
			PanelHoverInfoPanel = nil
			return
		end
		if MY < Y or MY > Y + SY then
			PanelHoverInfoPanel:Remove()
			PanelHoverInfoPanel = nil
			return
		end
	else
		PanelHoverInfoPanel:Remove()
		PanelHoverInfoPanel = nil
		return
	end
			local x = ScrW()/2
			local y = ScrH()/2
			
					local Pos_X = gui.MouseX() + 5
					local Pos_Y = gui.MouseY() + 3
				
					if (gui.MouseY() + PanelHoverInfoPanel:GetTall() ) > y*2 then
						Pos_Y = gui.MouseY() - PanelHoverInfoPanel:GetTall() - 5
					end
					
					if (gui.MouseX() + PanelHoverInfoPanel:GetWide() ) >= x*2 then
						Pos_X = x*2 - PanelHoverInfoPanel:GetWide()
					end
					PanelHoverInfoPanel:SetPos(Pos_X,Pos_Y)
end

vgui.Register("RX_PanelHoverInfoPanel_Master",PANEL,"DPanel")