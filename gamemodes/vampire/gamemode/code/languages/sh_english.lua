LANG = LANG or {}
local KEY = "en"
LANG[KEY] = {}

------------------------------------------------------------------------------------------------------
-- MISC ----------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

LANG[KEY].waiting_for_players = "WAITING FOR PLAYERS"
LANG[KEY].overtime = "OVERTIME"
LANG[KEY].change_team_wait = "Please wait %i more seconds before changing team."
LANG[KEY].you_will_spawn_as = "You will spawn as %s."

LANG[KEY].select_team = "SELECT YOUR TEAM"
LANG[KEY].team_slayer = "SLAYER"
LANG[KEY].team_vampire = "VAMPIRE"
LANG[KEY].auto_assign = "AUTO ASSIGN"

LANG[KEY].select_class = "SELECT YOUR CLASS"
LANG[KEY].class_random = "RANDOM"

LANG[KEY].vampires_win = "VAMPIRES WIN"
LANG[KEY].slayers_win = "SLAYERS WIN"
LANG[KEY].round_draw = "ROUND DRAW"

LANG[KEY].hud_faith = "FAITH"
LANG[KEY].hud_cloak = "CLOAKED"

LANG[KEY].ctc_vamp_taken = "Vampire cross taken"
LANG[KEY].ctc_vamp_dropped = "Vampire cross dropped"
LANG[KEY].ctc_vamp_returned = "Vampire cross returned"
LANG[KEY].ctc_vamp_captured = "Vampire cross captured"
LANG[KEY].ctc_slay_taken = "Slayer cross taken"
LANG[KEY].ctc_slay_dropped = "Slayer cross dropped"
LANG[KEY].ctc_slay_returned = "Slayer cross returned"
LANG[KEY].ctc_slay_captured = "Slayer cross captured"

------------------------------------------------------------------------------------------------------
-- CLASSES -------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

LANG[KEY].vampire_default_bio = [[Primary fire to swing claws. Secondary fire to leap.
All vampires have unnatural speed and strength.
Press F to toggle nightvision.

SPECIAL ABILITY: ]]

LANG[KEY].class_louis = "LOUIS"
LANG[KEY].class_louis_name = "Louis"
--[[
LANG[KEY].class_louis_bio = [[Louis is a distant relative of Dracula and as such, is a very traditional vampire.
He sports a fine set of fangs and isn’t afraid to use them. Louis has lived for a very long time and can be very cunning and difficult to see, until it’s too late, of course!]]
LANG[KEY].class_louis_bio = LANG[KEY].vampire_default_bio .. [[Detect nearby slayers through walls.]]

LANG[KEY].class_edgar = "EDGAR"
LANG[KEY].class_edgar_name = "Edgar"
--[[
LANG[KEY].class_edgar_bio = [[Edgar is a vampire and a gentleman.
He was born in Scotland in 1851 and has a weak spot for human hearts. When he is not fighting slayers, Edgar likes to go to the cinema.]]
LANG[KEY].class_edgar_bio = LANG[KEY].vampire_default_bio .. [[Crouching will make you harder to see.]]

LANG[KEY].class_nina = "NINA"
LANG[KEY].class_nina_name = "Nina"
--[[
LANG[KEY].class_nina_bio = [[Female and deadly, Nina is a vampire to be very wary of. She often catches many less experienced slayers by surprise!
Nina is a music fan and often hangs around nightclubs and various other seedy dives.]]
LANG[KEY].class_nina_bio = LANG[KEY].vampire_default_bio .. [[Sunlight immunity.
(WHEN OVERCAST: Gain health when exposed to the sky.)]]

LANG[KEY].class_butler = "BUTLER"
LANG[KEY].class_butler_name = "Butler"
LANG[KEY].class_butler_bio = LANG[KEY].vampire_default_bio .. [[None yet (give me ideas pls).]]

LANG[KEY].class_fatherd = "FATHER D"
LANG[KEY].class_fatherd_name = "Father D"
--[[
LANG[KEY].class_fatherd_bio = [[As the name implies, Father D works for the Church. Trained as a preacher, he now specialises in slaying vampires in the name of the lord. Father D prefers a shotgun and stake combo.
Some people think the D stands for “Death” while others think it stands for “Dave”.
Quote: “I kick ass for the Lord!”]]
LANG[KEY].class_fatherd_bio = [[STAKE + CRUCIFIX
Primary fire to stab with stake. Secondary fire to pray, which
protects you from damage for a few seconds.

DOUBLE-BARREL SHOTGUN
Has two barrels, which can be shot in quick succession.

PUMP SHOTGUN
Standard pump shotgun. Slightly more accurate than the double-
barrel shotgun.]]

LANG[KEY].class_molly = "MOLLY"
LANG[KEY].class_molly_name = "Molly"
--[[
LANG[KEY].class_molly_bio = [[Molly is a debutaunt and her rich family background allow her to persue her most dangerous past-time, vampire slaying.
Molly is a skilled sniper and prefers to slay Vampires using her stake-firing crossbow from as far away from the wretched creatures as humanly possible!
Quote: “Vampire slaying is my life, and theirs hopefully!”]]
LANG[KEY].class_molly_bio = [[STAKE + PISTOL
Primary fire to stab with stake. Secondary fire to shoot pistol.

SMG
Fully-automatic, capable secondary. Not very effective at range,
but great when close.

STAKE CROSSBOW
Fires high-velocity stakes that can kill vampires from a distance.
Hold secondary fire to zoom in.]]

LANG[KEY].class_8ball = "EIGHTBALL"
LANG[KEY].class_8ball_name = "Eightball"
--[[
LANG[KEY].class_8ball_bio = [[Not much is known about Eightball.]]
LANG[KEY].class_8ball_bio = [[POOL CUE
Primary fire to stab. Secondary fire to knock vampires away. Has
longer range than normal stakes.

THUNDER-5 SHOTGUN
Buckshot revolver with a large spread.

WINCHESTER 1873
Hold secondary fire for greater accuracy and damage, at the cost
of fire rate.]]

LANG[KEY].class_sarge = "BULLDOG"
LANG[KEY].class_sarge_name = "Bulldog"
LANG[KEY].class_sarge_bio = [[SILVER DAGGER
Silver-plated knife that can slay vampires. Primary fire to slash.
Secondary fire to stab, which has shorter range but hurts more.

FRAG GRENADE
Five deadly grenades. They don't seem very holy.

M60 MACHINE GUN
Slow-firing machine gun with 100 bullets per magazine.]]

------------------------------------------------------------------------------------------------------
-- MAPS ----------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

LANG[KEY].overcast_notice = "OVERCAST: Vampires will not take sunlight damage."

-- LANG[KEY].default_map_desc = [[oOoOoOo there are some spoOOoOoky vampires!!!]]
LANG[KEY].default_map_desc = [[The area has become overrun by vampires. The Vampire Slayers have
been called to deal with them.]]

LANG[KEY].map_gm_construct_night_name = "Construct (Night)"
LANG[KEY].map_gm_construct_night_desc = [[The rumors were true. There are dark, evil creatures
lurking in the depths of Construct.]]

LANG[KEY].map_de_chateau_name = "Chateau"
LANG[KEY].map_de_chateau_desc = [[Lord Williams sends his regards.]]

LANG[KEY].map_cs_office_name = "Office"
LANG[KEY].map_cs_office_desc = [[Reports of strange behavior among the employees at Office 52375
have circulated local news for over six weeks. Their pale gray
skin, thirst for blood, and obsession with poorly-written teen
romance suggest the culprit: an infestation of vampires. The
task falls upon the Vampire Slayers to reclaim the complex and
restore it to its previous state of paper production.]]
