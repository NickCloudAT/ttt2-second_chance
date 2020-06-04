if SERVER then
  AddCSLuaFile()

  resource.AddFile("vgui/ttt/icon_asc.vmt")
  resource.AddFile("vgui/ttt/perks/hud_asc_ttt2.png")
end

ITEM.hud = Material("vgui/ttt/perks/hud_asc_ttt2.png")
ITEM.EquipMenuData = {
  type = "item_passive",
  name = "item_a_second_chance",
  desc = "item_a_second_chance_desc",
}
ITEM.material = "vgui/ttt/icon_asc"
ITEM.corpseDesc = "item_a_second_chance_corpse_desc"
ITEM.CanBuy = {ROLE_TRAITOR, ROLE_DETECTIVE}

if SERVER then

  function ITEM:Bought(ply)
    local chance = math.random(A_SECOND_CHANCE.CVARS.min_start_pct, A_SECOND_CHANCE.CVARS.max_start_pct)

    ply:TTT2NETSetUInt("ttt_asc_chance", chance, 8)
    A_SECOND_CHANCE:ChanceChanged(ply)
  end

  function ITEM:Reset(ply)
    ply:TTT2NETSetUInt("ttt_asc_chance", 0, 8)
  end

else

  function ITEM:DrawInfo()
    return LocalPlayer():TTT2NETGetUInt("ttt_asc_chance", 0)
  end

end
