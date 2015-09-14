local PANEL = {}
	
function PANEL:Init()
	self.CamPos = Vector(70,0,20)
	self.ViewPos = Vector(0,0,20)
	self.StartTime = 0
end

function PANEL:GetPlayerModel()
	return self.PMEntity:GetModel()
end

function PANEL:Think()
		self.PMEntity:SetAngles( Angle( 0, CurTime()*-20 , 0 ) )
		self.PMEntity:SetPos( Vector( 0, 0 ,  math.sin(CurTime())*3 ) )
end

function PANEL:Paint()
		local x, y = self:LocalToScreen( 0, 0 )
		local w, h = self:GetSize()
		
		cam.Start3D( self.CamPos, (self.ViewPos - self.CamPos):Angle(), 70, x, y, w, h, 5, 4096 )
			render.SetBlend( self:GetAlpha()/255 )
				self.PMEntity:SetSequence( self.PMEntity:LookupSequence( "menu_walk" ) )
				self.PMEntity:SetCycle(CurTime())
				self.PMEntity:DrawModel()
			render.SetBlend( 1 )
		cam.End3D()
end

function PANEL:SetUp()
	self.ModelIndex = 1
	self.PMEntity = ClientsideModel( "models/player/group01/female_01.mdl", RENDER_GROUP_OPAQUE_ENTITY )
	self.PMEntity:SetPos(Vector(0,0,0))
	self.PMEntity:SetNoDraw( true )
	GR_AddModel(self.PMEntity,self)
	self.StartTime = CurTime()
			
end

	


vgui.Register("Login_PlayerModelDrawer",PANEL,"DPanel")