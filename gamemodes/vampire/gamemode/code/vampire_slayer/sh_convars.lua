
CONVARS = {}
CONVARS.knockdown_time = CreateConVar("vs_vampire_knockdown_time", "3", FCVAR_ARCHIVE + FCVAR_REPLICATED + FCVAR_NOTIFY, "How long vampires stay on the ground when knocked down.", 0.1, 100)
CONVARS.knockdown_ragdoll = CreateConVar("vs_vampire_knockdown_ragdoll", "1", FCVAR_ARCHIVE + FCVAR_REPLICATED + FCVAR_NOTIFY, "Whether vampires ragdoll when they're knocked down. DO NOT CHANGE MID-GAME!", 0, 1)
CONVARS.knockdown_health = CreateConVar("vs_vampire_resurrect_health", "30", FCVAR_ARCHIVE + FCVAR_REPLICATED + FCVAR_NOTIFY, "How much health vampires have when they get up.", 2, 100)
CONVARS.corpse_health = CreateConVar("vs_corpse_blood", "100", FCVAR_ARCHIVE + FCVAR_REPLICATED + FCVAR_NOTIFY, "How much health vampires can leech off of slayer corpses.", 0, 10000)
CONVARS.slurp_amount = CreateConVar("vs_corpse_slurp_amount", "4", FCVAR_ARCHIVE + FCVAR_REPLICATED + FCVAR_NOTIFY, "How much blood vampires can slurp at once.", 1, 10000)
CONVARS.slurp_cooldown = CreateConVar("vs_corpse_slurp_cooldown", "0.2", FCVAR_ARCHIVE + FCVAR_REPLICATED + FCVAR_NOTIFY, "Time to wait between blood slurps.", 0.1, 10000)
CONVARS.round_time = CreateConVar("vs_round_time", 180, FCVAR_REPLICATED + FCVAR_NOTIFY, "Length of a round, in seconds.")
CONVARS.post_round_time = CreateConVar("vs_post_round_time", 10, FCVAR_REPLICATED + FCVAR_NOTIFY, "Time in between rounds.")
CONVARS.player_class_1 = CreateConVar("vs_playerclass_1", 1, FCVAR_USERINFO, "Preferred class for Vampire team.", 1, 4)
CONVARS.player_class_2 = CreateConVar("vs_playerclass_2", 1, FCVAR_USERINFO, "Preferred class for Slayer team.", 1, 4)
CONVARS.bullet_sparks = CreateConVar("vs_bullet_sparks", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED + FCVAR_NOTIFY, "Bullet impact sparks. 0 = off. n = spark multiplier", 0, 100)
CONVARS.bullet_smoke = CreateConVar("vs_bullet_smoke", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED + FCVAR_NOTIFY, "Bullet impact smoke. 0 = off. n = smoke multiplier", 0, 100)
CONVARS.ctc_enabled = CreateConVar("vs_ctc_enabled", 0, FCVAR_ARCHIVE + FCVAR_REPLICATED + FCVAR_NOTIFY, "Whether Capture the Crucifix gamemode is enabled.", 0, 1)
CONVARS.ctc_respawn_time = CreateConVar("vs_ctc_respawn_time", 7, FCVAR_ARCHIVE + FCVAR_REPLICATED + FCVAR_NOTIFY, "Respawn timer for Capture the Crucifix gamemode.", 0, 999)
CONVARS.ctc_capture_limit = CreateConVar("vs_ctc_capture_limit", 3, FCVAR_ARCHIVE + FCVAR_REPLICATED + FCVAR_NOTIFY, "Max captures for Capture the Crucifix gamemode. 0 = Only end when time expires.", 0, 999)
CONVARS.ctc_round_time = CreateConVar("vs_ctc_round_time", 600, FCVAR_ARCHIVE + FCVAR_REPLICATED + FCVAR_NOTIFY, "Length of a Capture the Crucifix round, in seconds.", 1, 999)
CONVARS.ctc_return_time = CreateConVar("vs_ctc_return_time", 10, FCVAR_ARCHIVE + FCVAR_REPLICATED + FCVAR_NOTIFY, "Time it takes before a dropped Crucifix returns, in seconds.", 0, 999)
CONVARS.draw_holstered = CreateConVar("vs_draw_holstered", 1, FCVAR_ARCHIVE, "Whether holstered weapons should be shown on player models.", 0, 1)
CONVARS.lower_ironsights = CreateConVar("vs_lower_ironsights", 0, FCVAR_ARCHIVE, "Lower guns when aiming down sights.", 0, 1)
CONVARS.ammo_drops = CreateConVar("vs_ammo_drops", 1, FCVAR_ARCHIVE + FCVAR_REPLICATED + FCVAR_NOTIFY, "Slayers drop ammo pickups on death.", 0, 1)
CONVARS.gibs_lifetime = CreateConVar("vs_gibs_lifetime", 20, FCVAR_ARCHIVE + FCVAR_REPLICATED + FCVAR_NOTIFY, "Lifetime of vampire gibs, in seconds.", 0, 9999)
CONVARS.max_corpses = CreateConVar("vs_max_corpses", 20, FCVAR_ARCHIVE + FCVAR_REPLICATED + FCVAR_NOTIFY, "Max slayer corpses in the map at one time.", 0, 100)