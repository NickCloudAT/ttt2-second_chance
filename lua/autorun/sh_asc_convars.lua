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
A_SECOND_CHANCE.CVARS.min_reive_time = min_revive_time:GetInt()
A_SECOND_CHANCE.CVARS.need_corpse = need_corpse:GetBool()
A_SECOND_CHANCE.CVARS.max_start_pct = max_start_pct:GetInt()
A_SECOND_CHANCE.CVARS.min_start_pct = min_start_pct:GetInt()
A_SECOND_CHANCE.CVARS.max_kill_pct = max_kill_pct:GetInt()
A_SECOND_CHANCE.CVARS.min_kill_pct = min_kill_pct:GetInt()
A_SECOND_CHANCE.CVARS.show_mstack_message = show_mstack_message:GetBool()
