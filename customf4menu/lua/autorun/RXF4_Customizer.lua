RXF4_Adjust = {} RuleDB = {} function RXF4_Rule_AddTitle(Text) table.insert(RuleDB,{Type="Title",Text=Text}) end function RXF4_Rule_AddText(Text) table.insert(RuleDB,{Type="Text",Text=Text}) end
-- ^ Dont Touch
			
	-- VIPs
		-- VIP Group. ( I think  you need ULX anyway. these group are able to access VIP Shop or VIP Job )
			RXF4_Adjust.VIPGroup = {"owner","superadmin","admin"}

		-- VIP Shop ( if you dont want to make VIP shop, set ' true ' to ' false ' )
			RXF4_Adjust.Main_EnableVIPShop = true 
			
		-- VIP Job ( if you dont want to make VIP Job, set ' true ' to ' false ' )
			RXF4_Adjust.Main_EnableVIPJob = true
			
		
	
	-- Appearance
		-- Main Screen Size
			RXF4_Adjust.Main_Size_X = 0.8 -- 1 Mean 100% fit to your screen. screen will cover your screen. if you want half size. set this to 0.5
			RXF4_Adjust.Main_Size_Y = 0.8 -- 1 Mean 100% fit to your screen. screen will cover your screen. if you want half size. set this to 0.5
		-- Main Screen Main Text.
			RXF4_Adjust.Main_MainText = "Main Menu"
			
			
	-- Menu Panel
		-- HTML Panel
			-- Set home url
				RXF4_Adjust.HTML_URL = "www.google.com"





	-- Custom Rule ( You may know what ' RXFR_Rule_AddTitle ' and ' RXF4_Rule_AddText '  thing does )
		RXF4_Rule_AddTitle("Rule")
		RXF4_Rule_AddText[[ This is Rule 1
							Hmmmmmmm.....
							Dont Kill Ohter!
							Dont Spam!
							Have Fun!]]
		RXF4_Rule_AddTitle("Rule 2")
		RXF4_Rule_AddText[[ RocketMania's Black & Blue Style F4 Menu
							 Available at Coderhire.com
							Thank you!]]