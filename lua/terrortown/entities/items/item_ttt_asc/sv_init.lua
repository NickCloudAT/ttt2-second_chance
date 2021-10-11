if not SERVER then return end

util.AddNetworkString("ttt_asc_chance_change")
util.AddNetworkString("ttt_asc_key_respawn")
util.AddNetworkString("ttt_asc_show_reason")

function A_SECOND_CHANCE:ChanceChanged(ply)
  if not IsValid(ply) or not (A_SECOND_CHANCE.CVARS.show_mstack_messages and A_SECOND_CHANCE.CVARS.show_chat_messages) then return end
  net.Start("ttt_asc_chance_change")
  net.WriteBool(A_SECOND_CHANCE.CVARS.show_mstack_messages)
  net.WriteBool(A_SECOND_CHANCE.CVARS.show_chat_messages)
  net.Send(ply)
end

function A_SECOND_CHANCE:ShouldRevive(ply)
  if not IsValid(ply) or not ply:HasEquipmentItem("item_ttt_asc") then return end
  local cur_chance = ply:TTT2NETGetUInt("ttt_asc_chance", 0)

  return math.random(1, 100) <= cur_chance
end

function A_SECOND_CHANCE:HandleDeathVictim(ply, attacker)
  if not IsValid(ply) or not ply:HasEquipmentItem("item_ttt_asc") then return end

  if not A_SECOND_CHANCE:ShouldRevive(ply) then
    if A_SECOND_CHANCE.CVARS.show_mstack_messages then
      LANG.Msg(ply, "item_a_second_chance_no_revive", nil, MSG_MSTACK_PLAIN)
    end

    if A_SECOND_CHANCE.CVARS.show_chat_messages then
      LANG.Msg(ply, "item_a_second_chance_no_revive", nil, MSG_CHAT_PLAIN)
    end

    return
  end

  EPOP:AddMessage({ply}, "item_a_second_chance_popup_title", "item_a_second_chance_popup_subtitle", 5, false)

  A_SECOND_CHANCE:HandleRespawn(ply, A_SECOND_CHANCE.CVARS.max_revive_time, A_SECOND_CHANCE.CVARS.need_corpse, true)

  if not A_SECOND_CHANCE.CVARS.allow_key_respawn then return end

  timer.Simple(A_SECOND_CHANCE.CVARS.min_revive_time, function()
    if not IsValid(ply) then return end
    net.Start("ttt_asc_show_reason")
    net.Send(ply)
    ply:TTT2NETSetBool("ttt_asc_respawning_allowkey", true)
  end)
end

function A_SECOND_CHANCE:HandleDeathAttacker(ply, attacker)
  if not IsValid(attacker) or not attacker:IsPlayer() or ply == attacker or not attacker:HasEquipmentItem("item_ttt_asc") then return end

  local cur_chance = attacker:TTT2NETGetUInt("ttt_asc_chance", 0)
  local new_chance

  if attacker:IsInTeam(ply) then
    new_chance = math.max(1, cur_chance-math.random(A_SECOND_CHANCE.CVARS.min_lose_pct, A_SECOND_CHANCE.CVARS.max_lose_pct))
  else
    new_chance = math.min(99, cur_chance+math.random(A_SECOND_CHANCE.CVARS.min_gain_pct, A_SECOND_CHANCE.CVARS.max_gain_pct))
  end

  attacker:TTT2NETSetUInt("ttt_asc_chance", new_chance, 8)

  A_SECOND_CHANCE:ChanceChanged(attacker)
end

function A_SECOND_CHANCE:HandleKillRecord(ply, attacker)
  if not A_SECOND_CHANCE.CVARS.use_kill_history or not IsValid(attacker) or not attacker:IsPlayer() or ply == attacker or attacker:HasEquipmentItem("item_ttt_asc") or not attacker:IsTerror() or not ply:IsTerror() then return end

  if attacker:IsInTeam(ply) then
    attacker.asc_wrong_kills = attacker.asc_wrong_kills and attacker.asc_wrong_kills+1 or 1
    return
  end

  attacker.asc_right_kills = attacker.asc_right_kills and attacker.asc_right_kills+1 or 1
end

function A_SECOND_CHANCE:HandleRespawn(ply, delay, needCorpse, respawnAtCorpse)
  local spawnEntity = nil
  local spawnPos = nil
  local spawnEyeAngle = nil
  if not respawnAtCorpse then
    spawnPoint = plyspawn.GetRandomSafePlayerSpawnPoint(ply)

    spawnPos = spawnPoint.pos
    spawnEyeAngle = spawnPoint.ang
  end

  ply:Revive(delay,
    function(ply) ply:TTT2NETSetBool("ttt_asc_respawning_allowkey", false) end,
    function(ply)
      return IsValid(ply) and not ply:Alive()
    end,
    needCorpse,
    true,
    function(ply, failMessage) ply:TTT2NETSetBool("ttt_asc_respawning_allowkey", false) LANG.Msg(ply, failMessage, nil, MSG_MSTACK_WARN) end,
    spawnPos,
    spawnEyeAngle
    )
end

function A_SECOND_CHANCE:CancelRevivalProcess(ply)
  ply:CancelRevival(nil, true)
  ply:SendRevivalReason(nil)
end

function A_SECOND_CHANCE:ResetPlayer(ply)
  ply:TTT2NETSetBool("ttt_asc_respawning_allowkey", false)
  ply.asc_right_kills = nil
  ply.asc_wrong_kills = nil
end


hook.Add("DoPlayerDeath", "TTT_ASC_HANDLE_DEATH", function(ply, attacker)
  A_SECOND_CHANCE:HandleDeathVictim(ply, attacker)
  A_SECOND_CHANCE:HandleDeathAttacker(ply, attacker)
  A_SECOND_CHANCE:HandleKillRecord(ply, attacker)
end)


net.Receive("ttt_asc_key_respawn", function(len, ply)
  if not IsValid(ply) or ply:IsTerror() or not ply:TTT2NETGetBool("ttt_asc_respawning_allowkey", false) then return end
  local respawnAtCorpse = net.ReadBool()

  A_SECOND_CHANCE:CancelRevivalProcess(ply)
  A_SECOND_CHANCE:HandleRespawn(ply, 0, A_SECOND_CHANCE.CVARS.need_corpse, respawnAtCorpse)

end)

hook.Add("TTTPrepareRound", "TTT_ASC_RESET_PREP", function()
  for k,v in ipairs(player.GetAll()) do
    A_SECOND_CHANCE:ResetPlayer(v)
  end
end)

hook.Add("TTTBeginRound", "TTT_ASC_RESET_BEGIN", function()
  for k,v in ipairs(player.GetAll()) do
    A_SECOND_CHANCE:ResetPlayer(v)
  end
end)
