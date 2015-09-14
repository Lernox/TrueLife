function LoadWebsitePanel()
	
	BG_HEADTEXT:SetText( "Site Web" )
	BG_HEADTEXT:SizeToContents()

	WEBSITE_MAIN = vgui.Create( "Panel", BG_MAIN )
	WEBSITE_MAIN:SetSize( BG_MAIN:GetWide(), BG_MAIN:GetTall() )
	
	local WEBSITE_WINDOW = vgui.Create( "Panel", WEBSITE_MAIN )
	WEBSITE_WINDOW:SetSize( BG_MAIN:GetWide() - 56, BG_MAIN:GetTall() - 50 )
	WEBSITE_WINDOW:SetPos( -400, 25 )
	WEBSITE_WINDOW.Paint = function( self, w, h )
		draw.RoundedBox( 2, 0, 0, w, h, Color( 239, 239, 239 ) )
		draw.RoundedBox( 2, 1, 1, w - 2, h - 2, Color( 255, 255, 255 ) )
		
		draw.SimpleText( "Site Web", "RP_SubFontThick", 24, 20, Color( 190, 190, 190 ) )
		
		surface.SetDrawColor( Color( 242, 242, 242 ) )
		surface.DrawLine( 24, 44, 182 - 26, 44 )
	end
	
	local WEBSITE_HTML = vgui.Create( "HTML", WEBSITE_WINDOW )
	WEBSITE_HTML:SetPos( 28, 54 )
	WEBSITE_HTML:SetSize( WEBSITE_WINDOW:GetWide() - 56, WEBSITE_WINDOW:GetTall() - 64 )
	WEBSITE_HTML:OpenURL( ELITE.WebsiteURL )
	
	WEBSITE_WINDOW:MoveTo( 28, 25, 0.2, 0, 0.2 )
	
end