A_SECOND_CHANCE = A_SECOND_CHANCE or {}
A_SECOND_CHANCE.CVARS = A_SECOND_CHANCE.CVARS or {}

local max_revive_time = CreateConVar("ttt_asc_max_revive_time", "10", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local min_revive_time = CreateConVar("ttt_asc_min_revive_time", "2", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local need_corpse = CreateConVar("ttt_asc_need_corpse", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local max_start_pct = CreateConVar("ttt_asc_start_pct_max", "25", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local min_start_pct = CreateConVar("ttt_asc_start_pct_min", "15", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local max_kill_pct = CreateConVar("ttt_asc_kill_pct_max", "25", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local min_kill_pct = CreateConVar("ttt_asc_kill_pct_min", "15", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local show_mstack_message = CreateConVar("ttt_asc_mstack_chat_message", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})

A_SECOND_CHANCE.CVARS.max_revive_time = max_revive_time:GetInt()
A_SECOND_CHANCE.CVARS.min_revive_time = min_revive_time:GetInt()
A_SECOND_CHANCE.CVARS.need_corpse = need_corpse:GetBool()
A_SECOND_CHANCE.CVARS.max_start_pct = max_start_pct:GetInt()
A_SECOND_CHANCE.CVARS.min_start_pct = min_start_pct:GetInt()
A_SECOND_CHANCE.CVARS.max_kill_pct = max_kill_pct:GetInt()
A_SECOND_CHANCE.CVARS.min_kill_pct = min_kill_pct:GetInt()
A_SECOND_CHANCE.CVARS.show_mstack_message = show_mstack_message:GetBool()

if SERVER then
  cvars.AddChangeCallback("ttt_asc_max_revive_time", function(name, old, new)
    A_SECOND_CHANCE.CVARS.max_revive_time = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_asc_min_revive_time", function(name, old, new)
    A_SECOND_CHANCE.CVARS.min_revive_time = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_asc_need_corpse", function(name, old, new)
    A_SECOND_CHANCE.CVARS.need_corpse = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_asc_start_pct_max", function(name, old, new)
    A_SECOND_CHANCE.CVARS.max_start_pct = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_asc_start_pct_min", function(name, old, new)
    A_SECOND_CHANCE.CVARS.min_start_pct = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_asc_kill_pct_max", function(name, old, new)
    A_SECOND_CHANCE.CVARS.max_kill_pct = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_asc_kill_pct_min", function(name, old, new)
    A_SECOND_CHANCE.CVARS.min_kill_pct = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_asc_mstack_chat_message", function(name, old, new)
    A_SECOND_CHANCE.CVARS.show_mstack_message = tonumber(new)
  end, nil)

  hook.Add("TTTUlxInitCustomCVar", "TTTASCInitCvars", function(name)
    ULib.replicatedWritableCvar("ttt_asc_max_revive_time", "rep_ttt_asc_max_revive_time", GetConVar("ttt_asc_max_revive_time"):GetInt(), true, false, name)
    ULib.replicatedWritableCvar("ttt_asc_min_revive_time", "rep_ttt_asc_min_revive_time", GetConVar("ttt_asc_min_revive_time"):GetInt(), true, false, name)
    ULib.replicatedWritableCvar("ttt_asc_need_corpse", "rep_ttt_asc_need_corpse", GetConVar("ttt_asc_need_corpse"):GetInt(), true, false, name)
    ULib.replicatedWritableCvar("ttt_asc_start_pct_max", "rep_ttt_asc_start_pct_max", GetConVar("ttt_asc_start_pct_max"):GetInt(), true, false, name)
    ULib.replicatedWritableCvar("ttt_asc_start_pct_min", "rep_ttt_asc_start_pct_min", GetConVar("ttt_asc_start_pct_min"):GetInt(), true, false, name)
    ULib.replicatedWritableCvar("ttt_asc_kill_pct_max", "rep_ttt_asc_kill_pct_max", GetConVar("ttt_asc_kill_pct_max"):GetInt(), true, false, name)
    ULib.replicatedWritableCvar("ttt_asc_kill_pct_min", "rep_ttt_asc_kill_pct_min", GetConVar("ttt_asc_kill_pct_min"):GetInt(), true, false, name)
    ULib.replicatedWritableCvar("ttt_asc_mstack_chat_message", "rep_ttt_asc_mstack_chat_message", GetConVar("ttt_asc_mstack_chat_message"):GetInt(), true, false, name)
  end)

end

if CLIENT then

  hook.Add("TTTUlxModifyAddonSettings", "TTTASCModifySettings", function(name)
      local tttrspnl = xlib.makelistlayout{w = 415, h = 300, parent = xgui.null}

      local tttrsclp = vgui.Create("DCollapsibleCategory", tttrspnl)
      tttrsclp:SetSize(390, 190)
      tttrsclp:SetExpanded(1)
      tttrsclp:SetLabel('Second Chance Settings')

      local tttrslst = vgui.Create('DPanelList', tttrsclp)
      tttrslst:SetPos(5, 25)
      tttrslst:SetSize(390, 190)
      tttrslst:SetSpacing(5)
      tttrslst:EnableVerticalScrollbar()

      local slider1 = xlib.makeslider{label = 'ttt_asc_max_revive_time (Def. 10)', repconvar = 'rep_ttt_asc_max_revive_time', min = 0, max = 10000, decimal = 0, parent = tttrslst}
  		tttrslst:AddItem(slider1)

  		local slider2 = xlib.makeslider{label = 'ttt_asc_min_revive_time (Def. 2)', repconvar = 'rep_ttt_asc_min_revive_time', min = 0, max = 10000, decimal = 0, parent = tttrslst}
  		tttrslst:AddItem(slider2)

      local slider3 = xlib.makeslider{label = 'ttt_asc_start_pct_max (Def. 25)', repconvar = 'rep_ttt_asc_start_pct_max', min = 1, max = 100, decimal = 0, parent = tttrslst}
  		tttrslst:AddItem(slider3)

      local slider4 = xlib.makeslider{label = 'ttt_asc_start_pct_min (Def. 15)', repconvar = 'rep_ttt_asc_start_pct_min', min = 1, max = 100, decimal = 0, parent = tttrslst}
      tttrslst:AddItem(slider4)

      local slider5= xlib.makeslider{label = 'ttt_asc_kill_pct_max (Def. 25)', repconvar = 'rep_ttt_asc_kill_pct_max', min = 1, max = 100, decimal = 0, parent = tttrslst}
      tttrslst:AddItem(slider5)

      local slider6 = xlib.makeslider{label = 'ttt_asc_kill_pct_min (Def. 15)', repconvar = 'rep_ttt_asc_kill_pct_min', min = 1, max = 100, decimal = 0, parent = tttrslst}
      tttrslst:AddItem(slider6)



      local checkbox1 = xlib.makecheckbox{label = "ttt_asc_need_corpse (Def. 1)", repconvar = "rep_ttt_asc_need_corpse", parent = tttrslst}
      tttrslst:AddItem(checkbox1)

      local checkbox2 = xlib.makecheckbox{label = "ttt_asc_mstack_chat_message (Def. 1)", repconvar = "rep_ttt_asc_mstack_chat_message", parent = tttrslst}
      tttrslst:AddItem(checkbox2)

      xgui.hookEvent('onProcessModules', nil, tttrspnl.processModules)
  		xgui.addSubModule('Second Chance', tttrspnl, nil, name)
    end)

end
