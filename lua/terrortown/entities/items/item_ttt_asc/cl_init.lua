if not CLIENT then return end

net.Receive("ttt_asc_chance_change", function()
  MSTACK:AddColoredImagedMessage("Your chance is now " .. tostring(ply:TTT2NETGetUInt("ttt_asc_chance", 0)) .. "%", nil, "vgui/ttt/perks/hud_asc_ttt2.png")
end)

bind.Register("ttt_asc_respawn_corpse", function()
  net.Start("ttt_asc_key_respawn")
  net.WriteBool(true)
  net.SendToServer()
end)

bind.Register("ttt_asc_respawn_spawn", function()
  net.Start("ttt_asc_key_respawn")
  net.WriteBool(false)
  net.SendToServer()
end)

bind.AddSettingsBinding("ttt_asc_respawn_corpse", "A Second Chance - Respawn at corpse", "Items")
bind.AddSettingsBinding("ttt_asc_respawn_spawn", "A Second Chance - Respawn at spawn", "Items")
