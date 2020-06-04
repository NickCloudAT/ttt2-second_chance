if not CLIENT then return end

net.Receive("ttt_asc_chance_change", function()
  MSTACK:AddColoredImagedMessage("Your chance is now " .. tostring(ply:TTT2NETGetUInt("ttt_asc_chance", 0)) .. "%", nil, "vgui/ttt/perks/hud_asc_ttt2.png")
end)
