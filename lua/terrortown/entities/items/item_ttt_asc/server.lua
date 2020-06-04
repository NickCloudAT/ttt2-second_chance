if not SERVER then return end

util.AddNetworkString("ttt_asc_chance_change")

function A_SECOND_CHANCE:ChanceChanged(ply)
  if not IsValid(ply) or not A_SECOND_CHANCE.CVARS.show_mstack_message then return end
  net.Start("ttt_asc_chance_change")
  net.Send(ply)
end

function A_SECOND_CHANCE:ShouldRevive(ply)
  if not IsValid(ply) or not ply:HasEquipmentItem("item_ttt_asc") then return end
  local cur_chance = ply:TTT2NETGetUInt("ttt_asc_chance", 0)

  return math.random(1, 100) <= cur_chance
end

function A_SECOND_CHANCE:HandleDeathVictim(ply, attacker)
  if not IsValid(ply) or not ply:HasEquipmentItem("item_ttt_asc") then return end

  if not A_SECOND_CHANCE:ShouldRevive(ply)
    LANG.Msg(ply, "ttt_asc_no_revive", "No Revive")
    return
  end

  -- HANDLE REVIVE

end

function A_SECOND_CHANCE:HandleDeathAttacker(ply, attacker)
  if not IsValid(attacker) or not attacker:IsPlayer() or not attacker:HasEquipmentItem("item_ttt_asc") then return end

  local cur_chance = attacker:TTT2NETGetUInt("ttt_asc_chance", 0)
  local new_chance

  if attacker:IsInTeam(ply) then
    new_chance = math.max(1, cur_chance-math.random(A_SECOND_CHANCE.CVARS.min_kill_pct, A_SECOND_CHANCE.CVARS.max_kill_pct))
  else
    new_chance = math.min(99, cur_chance+math.random(A_SECOND_CHANCE.CVARS.min_kill_pct, A_SECOND_CHANCE.CVARS.max_kill_pct))
  end

  attacker:TTT2NETSetUInt("ttt_asc_chance", new_chance, 8)

  A_SECOND_CHANCE:ChanceChanged(attacker)

end

function A_SECOND_CHANCE:HandleRespawn(ply)
  ply:Revive(A_SECOND_CHANCE.CVARS.max_revive_time, function(),
    function(),
    true,
    true,
    function()
    )
  ply:SendRevivalReason("Use 'R' to respawn at your Corpse. Use 'Space' to respawn at a random spawn point.")
end

function A_SECOND_CHANCE:CancelRevivalProcess(ply)
  ply:CancelRevival(nil, true)
end


hook.Add("DoPlayerDeath", "TTT_ASC_HANDLE_DEATH", function(ply, attacker)
  A_SECOND_CHANCE:HandleDeathVictim(ply, attacker)
  A_SECOND_CHANCE:HandleDeathAttacker(ply, attacker)
end)
