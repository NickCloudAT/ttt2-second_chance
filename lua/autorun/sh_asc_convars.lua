A_SECOND_CHANCE = A_SECOND_CHANCE or {}
A_SECOND_CHANCE.CVARS = A_SECOND_CHANCE.CVARS or {}

local max_revive_time = CreateConVar("ttt_asc_max_revive_time", "10", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local min_revive_time = CreateConVar("ttt_asc_min_revive_time", "2", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local need_corpse = CreateConVar("ttt_asc_need_corpse", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local max_start_pct = CreateConVar("ttt_asc_start_pct_max", "25", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local min_start_pct = CreateConVar("ttt_asc_start_pct_min", "15", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local max_gain_pct = CreateConVar("ttt_asc_gain_pct_max", "25", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local min_gain_pct = CreateConVar("ttt_asc_gain_pct_min", "15", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local max_lose_pct = CreateConVar("ttt_asc_lose_pct_max", "25", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local min_lose_pct = CreateConVar("ttt_asc_lose_pct_min", "15", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local revive_health_pct = CreateConVar("ttt_asc_revive_health_multiplier", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local show_mstack_messages = CreateConVar("ttt_asc_mstack_messages", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local show_chat_messages = CreateConVar("ttt_asc_chat_messages", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local allow_key_respawn = CreateConVar("ttt_asc_allow_key_respawn", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local use_kill_history = CreateConVar("ttt_asc_use_kill_history", "0", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})

A_SECOND_CHANCE.CVARS.max_revive_time = max_revive_time:GetFloat()
A_SECOND_CHANCE.CVARS.min_revive_time = min_revive_time:GetFloat()
A_SECOND_CHANCE.CVARS.need_corpse = need_corpse:GetBool()
A_SECOND_CHANCE.CVARS.max_start_pct = max_start_pct:GetInt()
A_SECOND_CHANCE.CVARS.min_start_pct = min_start_pct:GetInt()
A_SECOND_CHANCE.CVARS.max_gain_pct = max_gain_pct:GetInt()
A_SECOND_CHANCE.CVARS.min_gain_pct = min_gain_pct:GetInt()
A_SECOND_CHANCE.CVARS.max_lose_pct = max_lose_pct:GetInt()
A_SECOND_CHANCE.CVARS.min_lose_pct = min_lose_pct:GetInt()
A_SECOND_CHANCE.CVARS.revive_health_pct = revive_health_pct:GetFloat()
A_SECOND_CHANCE.CVARS.show_mstack_messages = show_mstack_messages:GetBool()
A_SECOND_CHANCE.CVARS.show_chat_messages = show_chat_messages:GetBool()
A_SECOND_CHANCE.CVARS.allow_key_respawn = allow_key_respawn:GetBool()
A_SECOND_CHANCE.CVARS.use_kill_history = use_kill_history:GetBool()

if SERVER then
  cvars.AddChangeCallback("ttt_asc_max_revive_time", function(name, old, new)
    A_SECOND_CHANCE.CVARS.max_revive_time = util.StringToType(new, "float")
  end, nil)

  cvars.AddChangeCallback("ttt_asc_min_revive_time", function(name, old, new)
    A_SECOND_CHANCE.CVARS.min_revive_time = util.StringToType(new, "float")
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

  cvars.AddChangeCallback("ttt_asc_gain_pct_max", function(name, old, new)
    A_SECOND_CHANCE.CVARS.max_gain_pct = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_asc_gain_pct_min", function(name, old, new)
    A_SECOND_CHANCE.CVARS.min_gain_pct = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_asc_lose_pct_max", function(name, old, new)
    A_SECOND_CHANCE.CVARS.max_lose_pct = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_asc_lose_pct_min", function(name, old, new)
    A_SECOND_CHANCE.CVARS.min_lose_pct = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_asc_revive_health_multiplier", function(name, old, new)
	A_SECOND_CHANCE.CVARS.revive_health_pct = util.StringToType(new, "float")
  end, nil)

  cvars.AddChangeCallback("ttt_asc_mstack_messages", function(name, old, new)
    A_SECOND_CHANCE.CVARS.show_mstack_messages = util.StringToType(new, "bool")
  end, nil)

  cvars.AddChangeCallback("ttt_asc_chat_messages", function(name, old, new)
    A_SECOND_CHANCE.CVARS.show_chat_messages = util.StringToType(new, "bool")
  end, nil)

  cvars.AddChangeCallback("ttt_asc_allow_key_respawn", function(name, old, new)
    A_SECOND_CHANCE.CVARS.allow_key_respawn = util.StringToType(new, "bool")
  end, nil)

  cvars.AddChangeCallback("ttt_asc_use_kill_history", function(name, old, new)
    A_SECOND_CHANCE.CVARS.use_kill_history = util.StringToType(new, "bool")
  end, nil)
end
