if not CLIENT then return end

net.Receive("ttt_asc_chance_change", function()
  MSTACK:AddColoredImagedMessage(LANG.GetParamTranslation("item_a_second_chance_chance_change", {chance = tostring(LocalPlayer():TTT2NETGetUInt("ttt_asc_chance", 0))}), nil, Material("vgui/ttt/perks/hud_asc_ttt2.png"), "Second Chance")
  chat.PlaySound()
end)

net.Receive("ttt_asc_show_reason", function()
  local corpseKey = bind.Find("ttt_asc_respawn_corpse") == KEY_NONE and "NONE" or string.upper(input.GetKeyName(bind.Find("ttt_asc_respawn_corpse")))
  local spawnKey = bind.Find("ttt_asc_respawn_spawn") == KEY_NONE and "NONE"or string.upper(input.GetKeyName(bind.Find("ttt_asc_respawn_spawn")))

  LocalPlayer():SetRevivalReason("ttt_asc_revive_keys", {keycorpse = corpseKey, keyspawn = spawnKey})
end)

bind.Register("ttt_asc_respawn_corpse", function()
  if not LocalPlayer():TTT2NETGetBool("ttt_asc_respawning_allowkey", false) then return end
  net.Start("ttt_asc_key_respawn")
  net.WriteBool(true)
  net.SendToServer()
end)

bind.Register("ttt_asc_respawn_spawn", function()
  if not LocalPlayer():TTT2NETGetBool("ttt_asc_respawning_allowkey", false) then return end
  net.Start("ttt_asc_key_respawn")
  net.WriteBool(false)
  net.SendToServer()
end)

bind.AddSettingsBinding("ttt_asc_respawn_corpse", "ASC - Respawn at corpse", "Items", KEY_R)
bind.AddSettingsBinding("ttt_asc_respawn_spawn", "ASC - Respawn at spawn", "Items", KEY_SPACE)
