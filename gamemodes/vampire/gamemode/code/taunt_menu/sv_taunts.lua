
-- WIP player taunts
-- Should make these dependent on player class instead of model

PlayerModelRadialTaunts = {
	["default"] = {
		joke = {
			"vo/npc/barney/ba_ohyeah.wav",
			"vo/npc/barney/ba_yell.wav",
			"vo/npc/barney/ba_danger02.wav",
		},
		scream = {
			"vo/npc/barney/ba_ohshit03.wav",
		},
		danger = {
			"vo/npc/barney/ba_lookout.wav",
			"vo/npc/barney/ba_getdown.wav",
			"vo/npc/barney/ba_getaway.wav",
		},
		laugh = {
			"vo/npc/barney/ba_laugh01.wav",
			"vo/npc/barney/ba_laugh02.wav",
			"vo/npc/barney/ba_laugh03.wav",
			"vo/npc/barney/ba_laugh04.wav",
		},
	},
	["models/player/alyx.mdl"] = {
		joke = {
			"vo/novaprospekt/al_enoughbs01.wav",
			"vo/npc/alyx/brutal02.wav",
			"vo/eli_lab/al_ugh.wav",
		},
		scream = {
			"vo/npc/alyx/uggh02.wav",
		},
		danger = {
			"vo/npc/alyx/lookout01.wav",
			"vo/npc/alyx/lookout03.wav",
			"vo/npc/alyx/watchout01.wav",
			"vo/npc/alyx/watchout03.wav",
		},
		laugh = {
			"vo/eli_lab/al_laugh01.wav",
			"vo/eli_lab/al_laugh02.wav",
		},
	},
	["models/player/monk.mdl"] = {
		joke = {
			"vo/ravenholm/aimforhead.wav",
			"vo/ravenholm/shotgun_hush.wav",
			"vo/ravenholm/monk_mourn01.wav",
			"vo/ravenholm/pyre_anotherlife.wav",
		},
		scream = {
			"vo/ravenholm/monk_death07.wav",
		},
		danger = {
			"vo/ravenholm/monk_danger01.wav",
			"vo/ravenholm/monk_danger02.wav",
			"vo/ravenholm/monk_danger03.wav",
		},
		laugh = {
			"vo/ravenholm/madlaugh01.wav",
			"vo/ravenholm/madlaugh02.wav",
			"vo/ravenholm/madlaugh03.wav",
			"vo/ravenholm/madlaugh04.wav",
		},
	},
	["models/player/leet.mdl"] = {
		joke = {
			"bot/aw_hell.wav",
			"bot/come_out_and_fight_like_a_man.wav",
			"bot/come_out_wherever_you_are.wav",
			"bot/come_to_papa.wav",
			"bot/do_not_mess_with_me.wav",
			"bot/great.wav",
			"bot/i_am_dangerous.wav",
			"bot/i_am_on_fire.wav",
			"bot/i_got_more_where_that_came_from.wav",
			"bot/its_a_party.wav",
			"bot/owned.wav",
			"bot/tag_them_and_bag_them.wav",
			"bot/yea_baby.wav",
			"bot/yesss.wav",
		},
		scream = {
			"bot/aah.wav",
			"bot/hey.wav",
			"bot/stop_it.wav",
		},
		danger = {
			"bot/help.wav",
			"bot/i_heard_them.wav",
			"bot/i_hear_something.wav",
			"bot/target_spotted.wav",
			"bot/uh_oh.wav",
			"bot/yikes.wav",
		},
		laugh = {
			"bot/whoo.wav",
			"bot/whoo2.wav",
		},
	},
	["models/player/kleiner.mdl"] = {
		joke = {
			-- "npc/zombie/zombie_voice_idle1.wav",
			"vampire_slayer/vo/vampire_taunt_01.wav",
			"vampire_slayer/vo/vampire_taunt_02.wav",
			"vampire_slayer/vo/vampire_taunt_03.wav",
			"vampire_slayer/vo/vampire_taunt_04.wav",
		},
		scream = {
			"npc/zombie_poison/pz_pain1.wav",
			"npc/zombie_poison/pz_pain2.wav",
			"npc/zombie_poison/pz_pain3.wav",
		},
		danger = {
			-- "npc/zombie/zombie_pain1.wav",
			-- "npc/zombie/zombie_pain2.wav",
			-- "npc/zombie/zombie_pain3.wav",
			"vampire_slayer/vo/vampire_danger_01.wav",
		},
		laugh = {
			"vampire_slayer/vo/vampire_laugh_01.wav",
			"vampire_slayer/vo/vampire_laugh_02.wav",
			"vampire_slayer/vo/vampire_laugh_03.wav",
			"vampire_slayer/vo/vampire_laugh_04.wav",
		},
	}
}
PlayerModelRadialTaunts["models/player/breen.mdl"] = PlayerModelRadialTaunts["models/player/kleiner.mdl"]
PlayerModelRadialTaunts["models/player/gman_high.mdl"] = PlayerModelRadialTaunts["models/player/kleiner.mdl"]
PlayerModelRadialTaunts["models/player/p2_chell.mdl"] = PlayerModelRadialTaunts["models/player/kleiner.mdl"]
PlayerModelRadialTaunts["models/player/guerilla.mdl"] = PlayerModelRadialTaunts["models/player/leet.mdl"]

function RadialTaunt(ply, taunt)
	if not taunt or not IsValid(ply) or not ply:IsPlayer() then return end
	local key = ply:GetModel()
	if not PlayerModelRadialTaunts[key] then key = "default" end
	local taunts = PlayerModelRadialTaunts[key][taunt]
	if not taunts then return end
	if not ply.NextRadialTaunt then ply.NextRadialTaunt = 0 end
	if CurTime() > ply.NextRadialTaunt then
		local wav = taunts[math.random(#taunts)]
		ply.NextRadialTaunt = CurTime() + SoundDuration(wav)
		if ply.CurEmitSound then
			ply:StopSound(ply.CurEmitSound)
		end
		ply.CurEmitSound = wav
		ply:EmitSound(wav)
	end
end

concommand.Add("radialtaunt", function(ply, cmd, args)
	RadialTaunt(ply, args[1])
end)
