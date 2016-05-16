
TTT_C = TTT_C or {}
TTT_C.Level = TTT_C.Level or {}


TTT_C.MaxXP = 100
TTT_C.MaxLevel = 1000

TTT_C.SaveLevelTime = 30


TTT_C.XPOverTimeTime = 100 // in seconds
TTT_C.MinPlayers = 0
TTT_C.XPOverTimeXP = 5

// Traitor kills Innocent
TTT_C.HeadShotMultiplier = 1.5
TTT_C.TkillsI = 2 // Normal kill
TTT_C.HeadShotTkillsI = TTT_C.TkillsI * TTT_C.HeadShotMultiplier // Headshot // 1.5 x XP of a Normal kill

// Traitor kills Detective
TTT_C.TkillsD = 3 // Normal kill
TTT_C.HeadShotTkillsD = TTT_C.TkillsD * TTT_C.HeadShotMultiplier // Headshot // 1.5 x XP of a Normal kill

// Detective kills Traitor

TTT_C.DkillsT = 2 // Normal kill
TTT_C.HeadShotDkillsT = TTT_C.DkillsT * TTT_C.HeadShotMultiplier // Headshot // 1.5 x XP of a Normal kill

// Innocent kills Traitor
TTT_C.IkillsT = 2 // Normal kill
TTT_C.HeadShotIkillsT = TTT_C.IkillsT * TTT_C.HeadShotMultiplier // Headshot // 1.5 x XP of a Normal kill

