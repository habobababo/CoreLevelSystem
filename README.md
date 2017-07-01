
CoreLevelSystem
===============

****Requirements****<br>
for CoreLevelSystem you need [database_c](https://github.com/habobababo/database_c)<br>


# <i class="icon-file"></i> Developer documentation
-------------
<i class="icon-th-list">Serverside hooks:
>

<i class="icon-user">Clientside hooks:
>

<i class="icon-user"><i class="icon-th-list">Shared hooks:

>**C_PlayerLevelUP** Calls after levelup, returns PLAYER and LEVEL<br>

<i class="icon-th-list">Serverside functions:
>**ply:C_SaveLevel()** saves LEVEL of PLAYER<br>
**ply:C_LevelUp()** levels PLAYER up <br>
**ply:C_AddXP(xp)** adds <xp> to PLAYER<br>
**ply:C_SetLevel(level)** sets LEVEL <level> of PLAYER<br>
**ply:C_SetXP(xp)** sets XP <xp> of PLAYER<br>
**ply:C_ResetPlayer()** resets the PLAYER to 0<br>


<i class="icon-user">Clientside functions:
>

<i class="icon-user"><i class="icon-th-list">Shared functions:

>**ply:C_GetLevel()** returns LEVEL of PLAYER<br>
**ply:C_GetXP()** returns XP of PLAYER<br>
**ply:C_XPLeft()** returns missing XP to levelup



----------
# <i class="icon-pencil"></i> Configuration
----------
Configuration is @ [levelsystem/lua/autorun/config.lua](https://github.com/habobababo/CoreLevelSystem/blob/master/levelsystem/lua/autorun/config.lua)

>C_Level.MaxXP = 100<br>
C_Level.MaxLevel = 1000<br>
C_Level.SaveLevelTime = 30<br>
C_Level.XPOverTimeTime = 100 // in seconds<br>
C_Level.MinPlayers = 0<br>
C_Level.XPOverTimeXP = 5<br>

----------
powered by ![cc](http://37.228.134.43/files/files/logos/Logo/128x128_grey.png) [Core-Community.de](http://core-community.de/)