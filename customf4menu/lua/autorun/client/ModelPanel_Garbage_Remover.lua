GarbageRemoveDelay = CurTime()
-- Fucking DModelPanel! 
-- but, eventualy, i won

GData = GData or {}
function GR_AddModel(ent,panel)
	GData[ent] = panel
end
hook.Add("Think","ModelPanel Garbage Remover",function()
	if GarbageRemoveDelay > CurTime() then return end
	GarbageRemoveDelay = CurTime() + 10
	for k,v in pairs(GData) do
		if k and k:IsValid() and v and !v:IsValid() then
			k:Remove()
		end
	end
end)