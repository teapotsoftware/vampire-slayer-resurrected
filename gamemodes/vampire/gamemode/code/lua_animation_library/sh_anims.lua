
RegisterLuaAnimation('fallover', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_Pelvis'] = {
					RU = 1.5,
					MU = -35,
					MF = 6,
					RF = -90
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RR = 32,
					RF = 32
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RR = -32,
					RF = -32
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RU = -10
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RU = -10
				}
			},
			FrameRate = 3
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_Pelvis'] = {
					RU = 1.5,
					MU = -35,
					MF = 6,
					RF = -90
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RR = 32,
					RF = 32
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RR = -32,
					RF = -32
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RU = -10
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RU = -10
				}
			},
			FrameRate = 1
		}
	},
	RestartFrame = 2,
	Type = TYPE_SEQUENCE
})

RegisterLuaAnimation('baseball_slide', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_Calf'] = {
					RU = 112
				},
				['ValveBiped.Bip01_R_Thigh'] = {
					RU = -80,
					RR = 48,
					RF = 80
				},
				['ValveBiped.Bip01_Neck1'] = {
					RU = -16
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RF = -32
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -48,
					RR = 32,
					RF = 32
				},
				['ValveBiped.Bip01_L_Thigh'] = {
					RU = -80
				},
				['ValveBiped.Bip01_Pelvis'] = {
					MU = -31
				},
				['ValveBiped.Bip01_Spine'] = {
					RU = -32
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = -48
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RU = 64,
					RR = -48
				}
			},
			FrameRate = 5
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_R_Calf'] = {
					RU = 112
				},
				['ValveBiped.Bip01_R_Thigh'] = {
					RU = -80,
					RR = 48,
					RF = 80
				},
				['ValveBiped.Bip01_Neck1'] = {
					RU = -16
				},
				['ValveBiped.Bip01_L_Clavicle'] = {
					RF = -32
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -48,
					RR = 32,
					RF = 32
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
					RU = 64,
					RR = -48
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RU = -48
				},
				['ValveBiped.Bip01_Spine'] = {
					RU = -32
				},
				['ValveBiped.Bip01_L_Thigh'] = {
					RU = -80
				},
				['ValveBiped.Bip01_Pelvis'] = {
					MU = -31
				}
			},
			FrameRate = 1
		}
	},
	RestartFrame = 2,
	Type = TYPE_SEQUENCE
})

RegisterLuaAnimation('molotov_light', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -32,
					RR = -16
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RR = 16,
					RF = -48
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
				},
				['ValveBiped.Bip01_R_UpperArm'] = {
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -32,
					RR = 32
				}
			},
			FrameRate = 1
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = 0,
					RR = 0
				},
				['ValveBiped.Bip01_R_Forearm'] = {
					RR = 0,
					RF = 0
				},
				['ValveBiped.Bip01_R_Clavicle'] = {
				},
				['ValveBiped.Bip01_R_UpperArm'] = {
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = 0,
					RR = 0
				}
			},
			FrameRate = 1
		},
	},
	Type = TYPE_GESTURE
})

RegisterLuaAnimation('cross_prayer', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -96,
					RR = -31.701039775665,
					RF = 23.92
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = 48,
					RR = 31.255442673187,
					RF = -35.76
				}
			},
			FrameRate = 2.5
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -96,
					RR = -31.701039775665,
					RF = 23.92
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = 48,
					RR = 31.255442673187,
					RF = -35.76
				}
			},
			FrameRate = 0.3125
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
				},
				['ValveBiped.Bip01_L_Forearm'] = {
				}
			},
			FrameRate = 2.5
		}
	},
	Type = TYPE_GESTURE
})
