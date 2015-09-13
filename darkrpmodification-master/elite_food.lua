function LoadFoodPanel()

	BG_HEADTEXT:SetText( "Food" )
	BG_HEADTEXT:SizeToContents()
	
	FOOD_MAIN = vgui.Create( "Panel", BG_MAIN )
	FOOD_MAIN:SetSize( BG_MAIN:GetWide(), BG_MAIN:GetTall() )
	
	local FOOD_WINDOW = vgui.Create( "Panel", FOOD_MAIN )
	FOOD_WINDOW:SetSize( BG_MAIN:GetWide() - 56, BG_MAIN:GetTall() - 50 )
	FOOD_WINDOW:SetPos( -200, 25 )
	FOOD_WINDOW.Paint = function( self, w, h )
		draw.RoundedBox( 2, 0, 0, w, h, Color( 239, 239, 239 ) )
		draw.RoundedBox( 2, 1, 1, w - 2, h - 2, Color( 255, 255, 255 ) )
		
		draw.SimpleText( "FOOD", "RP_SubFontThick", 24, 20, Color( 190, 190, 190 ) )
		
		surface.SetDrawColor( Color( 242, 242, 242 ) )
		surface.DrawLine( 24, 44, w - 26, 44 )
		
		local nothing = true
		
		if FoodItems and (GAMEMODE.Config.foodspawn or LocalPlayer():Team() == TEAM_COOK) and LocalPlayer():Team() == TEAM_COOK then
			nothing = false
		end
		
		for k, v in pairs( FoodItems ) do
			if FoodItems and (GAMEMODE.Config.foodspawn or v.requiresCook == false) and v.requiresCook == false then
				nothing = false
				return
			end
		end
		
		if nothing then
			draw.SimpleText( "NOTHING IS AVAILABLE!", "RP_SubFontThick", FOOD_WINDOW:GetWide() / 2, FOOD_WINDOW:GetTall() / 2, Color( 190, 190, 190 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	end
	
	local FOOD_LIST = vgui.Create( "DPanelList", FOOD_WINDOW )
	FOOD_LIST:SetPos( 24, 44 )
	FOOD_LIST:SetSize( FOOD_WINDOW:GetWide() - 30, FOOD_WINDOW:GetTall() - 54 )
	FOOD_LIST:EnableVerticalScrollbar( true )
	FOOD_LIST:DockPadding( 0, 5, 10, 0 )
	FOOD_LIST.VBar.Paint = function( s, w, h )
		draw.RoundedBox( 4, 3, 13, 8, h-24, Color(0,0,0,70))
	end
	FOOD_LIST.VBar.btnUp.Paint = function( s, w, h ) end
	FOOD_LIST.VBar.btnDown.Paint = function( s, w, h ) end
	FOOD_LIST.VBar.btnGrip.Paint = function( s, w, h )
		draw.RoundedBox( 4, 5, 0, 4, h+22, Color(0,0,0,70))
	end
	
	for k, v in pairs( FoodItems ) do
	
		if FoodItems and (GAMEMODE.Config.foodspawn or LocalPlayer():Team() == TEAM_COOK) and LocalPlayer():Team() == TEAM_COOK then
			print( "cook" )
			show = true
		elseif FoodItems and (GAMEMODE.Config.foodspawn or v.requiresCook == false) and v.requiresCook == false then
			print( "req" )
			show = true
		else
			show = false
		end
	
		if show then
			local foodFrame = vgui.Create( "DPanel" ) -- surface.DrawLine( 24, self:GetTall() - 44, self:GetWide() - 24, self:GetTall() - 44 )
			foodFrame:SetSize( FOOD_LIST:GetWide(), 60 )
			foodFrame.Paint = function( self, w, h )
			
				surface.SetDrawColor( Color( 242, 242, 242 ) )
			
				surface.DrawLine( 0, h - 1, w, h - 1 )
				
				draw.SimpleText( string.upper(v.name), "RP_SubFontThick", 56, 14, Color( 0, 0, 0 ) )
				draw.SimpleText( "PRICE: $"..string.upper(v.price), "RP_SubFontThick", 56, 30, Color( 190, 190, 190 ) )
			end
			foodFrame.OnCursorEntered = function( self )

			end
			foodFrame.OnCursorEntered = function( self )

			end
			
			FOOD_LIST:AddItem( foodFrame )
			
			local foodButton = vgui.Create( "DButton", foodFrame )
			foodButton:SetSize( 90, 35 )
			foodButton:SetPos( foodFrame:GetWide() - 110, (foodFrame:GetTall() / 2) - 17.5 )
			foodButton:SetText( "Buy" )
			foodButton:SetFont( "RP_ButtonFont" )
			foodButton:SetTextColor( Color( 255, 255, 255 ) )
			foodButton.Paint = function( self, w, h )
				draw.RoundedBox( 4, 0, 0, w, h, Color( 239, 239, 243 ) )
				draw.RoundedBox( 4, 1, 1, w - 2, h - 2, Color( 232, 76, 82 ) )
				draw.RoundedBox( 4, 2, 2, w - 4, h - 4, Color( 233, 84, 90 ) )
				
				if self.hover then
					draw.RoundedBox( 4, 1, 1, w - 2, h - 2, Color( 206, 68, 73 ) )
				end
			end
			foodButton.DoClick = function()
				RunConsoleCommand( "say", "/buyfood "..v.name )
			end
			foodButton.OnCursorEntered = function( self )
				self.hover = true
			end
			foodButton.OnCursorExited = function( self )
				self.hover = false
			end
			
			local foodModel = vgui.Create( "SpawnIcon", foodFrame )
			foodModel:SetSize( 52, 52 )
			foodModel:SetPos( 0, 8 )
			foodModel:SetModel( v.model )
		end
		
		
	end
	
	FOOD_WINDOW:MoveTo( 28, 25, 0.2, 0, 0.2 )
	--HOME_STATS:MoveTo( 222, 25, 0.4, 0.2, 0.1 )
	--HOME_INFO:MoveTo( 28, 330, 0.6, 0.2, 0.1 )
end
