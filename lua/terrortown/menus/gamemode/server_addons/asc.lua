CLGAMEMODESUBMENU.base = "base_gamemodesubmenu"
CLGAMEMODESUBMENU.title = "submenu_addons_asc_title"

function CLGAMEMODESUBMENU:Populate(parent)
	local form = vgui.CreateTTT2Form(parent, "header_addons_tttc")

	form:MakeHelp({
		label = "help_asc_menu"
	})

	//CheckBoxes

	form:MakeCheckBox({
		label = "label_asc_need_corpse",
		serverConvar = "ttt_asc_need_corpse"
	})

	form:MakeCheckBox({
		label = "label_asc_mstack_messages",
		serverConvar = "ttt_asc_mstack_messages"
	})

	form:MakeCheckBox({
		label = "label_asc_chat_messages",
		serverConvar = "ttt_asc_chat_messages"
	})

	form:MakeCheckBox({
		label = "label_asc_allow_key_respawn",
		serverConvar = "ttt_asc_allow_key_respawn"
	})

	form:MakeCheckBox({
		label = "label_asc_use_kill_history",
		serverConvar = "ttt_asc_use_kill_history"
	})

	//Sliders

	form:MakeSlider({
		label = "label_asc_max_revive_time",
		serverConvar = "ttt_asc_max_revive_time",
		min = 0,
		max = 100,
		decimal = 1
	})

	form:MakeSlider({
		label = "label_asc_min_revive_time",
		serverConvar = "ttt_asc_min_revive_time",
		min = 0,
		max = 100,
		decimal = 1
	})

	form:MakeSlider({
		label = "label_asc_start_pct_max",
		serverConvar = "ttt_asc_start_pct_max",
		min = 0,
		max = 100,
		decimal = 0
	})

	form:MakeSlider({
		label = "label_asc_start_pct_min",
		serverConvar = "ttt_asc_start_pct_min",
		min = 0,
		max = 100,
		decimal = 0
	})

	form:MakeSlider({
		label = "label_asc_gain_pct_max",
		serverConvar = "ttt_asc_gain_pct_max",
		min = 0,
		max = 100,
		decimal = 0
	})

	form:MakeSlider({
		label = "label_asc_gain_pct_min",
		serverConvar = "ttt_asc_gain_pct_min",
		min = 0,
		max = 100,
		decimal = 0
	})

	form:MakeSlider({
		label = "label_asc_lose_pct_max",
		serverConvar = "ttt_asc_lose_pct_max",
		min = 0,
		max = 100,
		decimal = 0
	})

	form:MakeSlider({
		label = "label_asc_lose_pct_min",
		serverConvar = "ttt_asc_lose_pct_min",
		min = 0,
		max = 100,
		decimal = 0
	})

	form:MakeSlider({
		label = "label_asc_health_multiplier",
		serverConvar = "ttt_asc_revive_health_multiplier",
		min = 0.01,
		max = 2,
		decimal = 2
	})
end
