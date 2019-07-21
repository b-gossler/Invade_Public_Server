/*
| Author:
|
|	Quiksilver.
|_____
|
| Description:
|
|	Created: 26/11/2013.
|	Coded for I&A and hosted on allfps.com.au servers.
|	You may use and edit the code.
|	You may not remove any entries from Credits without first removing the relevant author's contributions,
|	or asking permission from the mission authors/contributors.
|	You may not remove the Credits tab, without consent of Ahoy World or allFPS.
| 	Feel free to re-format or make it look better.
|
|	Last edited: 23/04/19 by stanhope
|
|	Edited: Updated changelog
|_____
|
| Usage:
|
|	Search below for the diary entries you would like to edit.
|	DiarySubjects appear in descending order when player map is open.
|	DiaryRecords appear in ascending order when selected.
|_____
|
| Credit:
|
|	Invade & Annex 2.00 was developed by Rarek [ahoyworld.co.uk] with hundreds of hours of work
|	The current version was developed by Quiksilver with hundreds more hours of work.
|
|	Contributors: Razgriz33 [AW], Jester [AW], Kamaradski [AW], David [AW], chucky [allFPS], stanhope [AW].
|
|	Please be respectful and do not remove credit.
|*/

if (!hasInterface) exitWith {};

waitUntil {!isNull player};

player createDiarySubject ["teamspeak", "Teamspeak"];
player createDiarySubject ["faq", "FAQ"];
player createDiarySubject ["changelog", "Change Log"];
player createDiarySubject ["Settings", "Settings"];
player createDiarySubject ["credits", "Credits"];

//-------------------------------------------------- Teamspeak

player createDiaryRecord ["teamspeak",
[
"69th Infantry Division",
"
<br /> Teamspeak IP address:
<br /> 69thid.teamspeak3.com
<br />
<br /> Visitors and guests welcome!
"
]];

//-------------------------------------------------- FAQ

player createDiaryRecord ["faq",
[
"UAVs",
"
<br /> In the Control Tower at base, a UAV Operator can now recycle the UAV crew on one of the computer terminals.
<br /><br />
<br /><font size='16'>Q:</font> Can I use the UAVs?<br />
<br /><font size='16'>A:</font> Yes, however you must be in the UAV Operator role and you must have a UAV Terminal.
<br />
<br /><font size='16'>Q:</font> Why do i get the don't troll hint when using my UAV?<br />
<br /><font size='16'>A:</font> Because our base protection is a bit too eager to stop trolls, until we can come up with a fix for this you'll have to sit somewhere outside of base protection.
<br />
<br /><font size='16'>Q:</font> Why can't I connect to the UAV?<br />
<br /><font size='16'>A:</font> Sometimes the UAVs are still connected to the prior Operators Terminal. If he disconnects or dies, sometimes the Terminal does not delete properly. The only solution at this time is to destroy the UAV, and you yourself must respawn.
"
]];

player createDiaryRecord ["faq",
[
"Squads",
"
<br /><font size='16'>Q:</font> How do I join or create a squad?<br />
<br /><font size='16'>A:</font>
<br /> 1. Press 'U' to open BI Squad Management.
<br /> 2. If you receive a squad invite from another player, hold 'U' to accept it.
<br />
"
]];

player createDiaryRecord ["faq",
[
"Bipod",
"
<br /><font size='16'>Q:</font> How do I deploy bipod or rest my weapon?<br />
<br /><font size='16'>A:</font> Press C (default) to rest your weapon or deploy the bipod.
"
]];

player createDiaryRecord ["faq",
[
"Medics",
"
<br /><font size='16'>Q:</font> Why can't I heal him?<br />
<br /><font size='16'>A:</font> There are three conditions you must pass in order to revive a fallen comrade.
<br /> 1. You must be in a Medic / Paramedic role.
<br /> 2. You must have a Medkit.
<br /> 3. You must have at least one First Aid Kit.
"
]];

player createDiaryRecord ["faq",
[
"Mortars",
"
<br /><font size='16'>Q:</font> Can I use the Mortars?
<br /><font size='16'>A:</font> Yes, However if you are not in the mortar gunner role you will not have acess to the Artillery Computer.<br />
<br /><font size='16'>Q:</font> How do I use the Mortar without the computer?
<br /><font size='16'>A:</font> You have to manually find the target with the sight. Here are some steps to use the mortar.
<br /> 1. Press the F key to select the firing distance.
<br /> 2. If you are in line-of-sight just put the cursor on the target and use the page up and page down keys to change the elevation.
<br /> 3. Fire!<br />
<br /><font size='16'>Here is a YouTube video that can explain in more detail.<br />
<br /> https://www.youtube.com/watch?v=SCCvXfwzeAU
"
]];
player createDiaryRecord ["faq",
[
"Artillery",
"
<br /><font size='16'>Q:</font> Can I use the Artillery in base?
<br /><font size='16'>A:</font> Yes and no<br />
<br /> No you cannot get in them and shoot them yourself<br />
<br /> Yes you can use them by buying arty strikers with your points.
<br /> Points are gained by killing enemies and can be seen by pressing P by default.
"
]];
player createDiaryRecord ["faq",
[
"Rangefinder",
"
<br /><font size='16'>Q:</font> Why doesn't my rangefinder display the range?
<br /><font size='16'>A:</font> Since the Jets DLC update there is a key you have to press to display the range.
<br />You can find this keybind under:
<br />Esc-configure-controls-weapons-lase range
<br />
"
]];

//-------------------------------------------------- Custom settings accessible from the diary
player createDiaryRecord ["Settings",
[
"View Distance",
"
<br/>Click <execute expression = '[] spawn CHVD_fnc_openDialog;'>here</execute> to change your view distance settings.
<br/>Click <executeClose expression = '[] spawn CHVD_fnc_openDialog;'>here</executeClose> to close the map and change your view distance settings.
"
]];
player createDiaryRecord ["Settings", 
[
"Extended Passenger Information HUD",
"
<br/>Click <execute expression = '[] spawn toggleVehicleHUDFunction;'>here</execute> to toggle your extended passenger information HUD.
"
]];
player createDiaryRecord ["Settings",
[
"Toggle Actions",
"
<br/>Click <execute expression = '[""Toggle""] spawn AW_fnc_slingWeapon;'>here</execute> to toggle your sling weapon action.
<br/>Click <execute expression = '
	if (roleDescription player find ""Pilot"" > -1) then {
		[""Toggle""] spawn AW_fnc_helicopterDoors;
	} else {
		systemChat ""This is only available to pilots."";
	};
'>here</execute> to toggle your Ghost Hawk doors action.
"
]];
player createDiaryRecord ["Settings",
[
"Vehicle respawn time",
"
<br/>Click <execute expression = '[[player], requestRespawningVehicles] remoteExec [""spawn"", 2];'>here</execute> to show vehicle respawn time.
"
]];


//-------------------------------------------------- Change Log

player createDiaryRecord ["changelog",
[
"3.00",
"
<br /><font size='16'>- Initial Altis and Tanoa Release</font>
"
]];
player createDiaryRecord ["changelog",
[
"3.00.06",
"
<br />- Includes Changelog for versions 3.00.00 to 3.00.06
<br />
<br />- [Added] Spotters Should now be able to get Ghillies.
<br />- [Added] Some checks in Main AO for which faction is mainFaction.
<br />- [Added][Altis] Expanded Safezone to include hill north of Main Spawn.
<br />- [Fixed] Turret Control.
<br />- [Fixed] Friendly Fire Messages.
<br />- [Fixed] FOB AO's not completing.
<br />- [Fixed] Priority Arty not spawning enemies.
<br />- [Fixed] Enemy heli reinforcements for main AO.
<br />- [Fixed] FOB's not having arsenal and not spawning their Vehicles.
<br />- [Fixed] AI at main AO would trap themselves in their formation and not move.
<br />- [Fixed] script error with earplugs and now add ability to get earplugs from start.
<br />- [Fixed][Altis] Hunter Spawn was spawning Prowlers.
<br />- [Fixed][Tanoa] Enemy Cas spawn on Tanoa.
<br />- [Tweaked] Teleport AddActions should now only appear when FOB has been captured.
<br />- [Updated] Revive.
<br />- [Updated] Mission will end after X amount of AO's.
<br />- [Replaced] TAW VD with CHVD.

"
]];
player createDiaryRecord ["changelog",
[
"3.00.07",
"
<br />- [Added] Added radio sounds to supports.
<br />- [Fixed] Underwater Mission not deleting enemies once done.
<br />- [Fixed] View distance now on only arsenal men.
<br />- [Fixed] Addaction to spawn in hunter/prowler back to Arsenal man.
<br />- [Tweaked] Friendly Fire messages now come from Crossroads.
<br />- [Removed][Tanoa] Removed Yanukka AO.
"
]];
player createDiaryRecord ["changelog",
[
"3.00.08",
"
<br />- [Fixed] Player spamming radio callouts.
<br />- [Tweaked] UAV respawn is now 5 minutes.
<br />- [Tweaked] Arty should now take longer between firing.
<br />- [Tweaked] Rewrote pilot restriction.
"
]];
player createDiaryRecord ["changelog",
[
"3.00.09",
"
<br />- [Fixed] Huge error in the priority arti causing massive rpt spam.
<br />- [Tweaked] Chopper Down message delay reduced.
"
]];
player createDiaryRecord ["changelog",
[
"3.00.10",
"
<br />- [Fixed][Tanoa] AO's not working properly.
<br />- [Fixed][Tanoa] FOB Comms Bravo.
"
]];
player createDiaryRecord ["changelog",
[
"3.1.1",
"
<br />- [Added] Safezone to main base
<br />- [Added] Added Prowlers to the respawn Vehicles
<br />- [Added] TK protection
<br />- [Fixed][Altis] AO's not working properly.
<br />- [Tweaked] Rewrote pilot restriction.
<br />- [Tweaked] UAV and plane repair pad's
"
]];
player createDiaryRecord ["changelog",
[
"3.1.2",
"
<br />- [Added] Prio AA mission
<br />- [Added] Runway light's
<br />- [Added] Refueling option's for smaller helo's
<br />- [Fixed][Altis] AO's not working properly.
<br />- [Tweaked] Derp_revive
<br />- [Tweaked] Moved Vehicle pickup and Blackfish spawn added arsenal to vheicle lift

"
]];
player createDiaryRecord ["changelog",
[
"3.1.3",
"
<br />- [Added] clear vehicle inventory option
<br />- [Added] new side mission
<br />- [Fixed] AOs will no longer enter deadlock
<br />- [Fixed] AA side mission cleanup
<br />- [Fixed] Certain units spawning damaged
<br />- [Fixed][altis] Frini woods bugging out
<br />- [Tweaked] zeus related stuff
<br />- [Tweaked] Under the hood stuff for AO and side missions
"
]];
player createDiaryRecord ["changelog",
[
"3.1.4",
"
<br />- [Added] USS Freedom
<br />- [Added] Blackwasp and UCAV to the Freedom
<br />- [Added] Blackwasp (both versions) and UCAV to side mission rewards
<br />- [Tweaked] Rescue the pilot side mission bleedout timer is now 15 minutes
"
]];
player createDiaryRecord ["changelog",
[
"3.1.5",
"
<br />- [Added] squad XML hint
<br />- [Added] Side mission reward: hemtt mounted praetorian and spartan
<br />- [Added] Side mission reward: Unarmed inf transport xi'an
<br />- [Added] Side mission reward: LAT hellcat
<br />- [Added] Side mission reward: AT, AA and .50 cal offroad
<br />- [Added] Side mission reward: Armed qilin
<br />- [Fixed] UAV rearm pad not working for certain UAVs
<br />- [Fixed] Rewards spawning damaged
<br />- [Fixed] Pawnee camos not displaying correctly
<br />- [Tweaked] Side mission reward spawn rate
"
]];

player createDiaryRecord ["changelog",
[
"3.2.0",
"
<br />- <font size='16'>Initial release malden Invade and Annex</font><br />
<br />- [Added] Random ghosthawk camos
<br />- [Added] Random blackwasp camos
<br />- [Added] AA for the USS freedom
<br />- [Added] Random loadouts for respawning jets
<br />- [Added] Nato or black skins for some FOB vehicles
<br />- [Added] System that prevents unplayable levels of fog
<br />- [Added] Nato or black skins for some side mission rewards
<br />- [Fixed] Typo in earplugs hint
<br />- [Tweaked] Service pad speed
<br />- [Tweaked] UCAV respawn timer
<br />- [Tweaked] Prio AA now spawns 3x AA assets
<br />- [Tweaked] Blackwasp respawn timer and loadout
<br />- [Tweaked] Ammo in AT/AA offroad (side mission reward)
<br />- [Tweaked] Base AA is now a Praetorian 1C (AAA turret)
<br />- [Tweaked] Under the hood stuff for zeus
<br />- [Tweaked] Under the hood stuff for main AO
<br />- [Tweaked] Under the hood stuff for side missions
<br />- [Tweaked] Under the hood stuff for side mission rewards
<br />- [Tweaked] Under the hood stuff for prio AA and arty objective
<br />- [Tweaked] Under the hood stuff for teleporting to the carrier
<br />- [Tweaked][altis][tanoa] Placements of the carrier
<br />- [Tweaked][altis][tanoa] Placements of things on the carrier
<br />- [Removed][altis] Arsenal on the carrier
"
]];

player createDiaryRecord ["changelog",
[
"3.2.1",
"
<br />- [Added] Random Huron camos
<br />- [Added] Billboards advertising AWE
<br />- [Added] Two new ground vehicle rewards
<br />- [Fixed] Destroyed radiotowers now despawn
<br />- [Fixed] Incorrect link appeared when you spawn
<br />- [Fixed] [Malden] Le Port AO bugging out
<br />- [Tweaked] Pilot spawn restricted to pilots
<br />- [Tweaked] Under the hood stuff for Zeus
<br />- [Tweaked] Under the hood stuff for carrier AA
<br />- [Tweaked] Under the hood stuff for side missions
<br />- [Tweaked] Under the hood stuff for prio AA objective
<br />- [Tweaked] Under the hood stuff for blacklisting co-pilots
<br />- [Tweaked][Malden] Moved some stuff around in base
"
]];

player createDiaryRecord ["changelog",
[
"3.2.2",
"
<br />Hotfix
<br />- [Fixed] Prio AA objective bugging out
"
]];

player createDiaryRecord ["changelog",
[
"3.2.3",
"
<br />- [Added] New side mission rewards
<br />- [Added] New side mission, the old Kavala/Pyrgos CQC mission
<br />- [Added][Altis] Vehicle service station at FOB guardian
<br />- [Fixed] Side missions will not spawn on FOBs any more
<br />- [Fixed] Jet service notification displaying the wrong number
<br />- [Tweaked] Side mission rewards spawn rate
"
]];

player createDiaryRecord ["changelog",
[
"3.2.4",
"
<br />- [Added] New priority objective, factory
<br />- [Tweaked] TK messages
<br />- [Tweaked] Under the hood things for zeus
<br />- [Tweaked] Under the hood things for the CQC side mission
<br />- [Tweaked] Verious other under the hood tweaks
<br />- [Fixed][Altis] AOs near FOB guardian bugging out
"
]];

player createDiaryRecord ["changelog",
[
"3.2.5",
"
<br />- [Added] Actual FOB things to the FOBs
<br />- [Tweaked] AO spawn order
<br />- [Tweaked] CQC side mission
<br />- [Tweaked] Protect UN forces side mission
<br />- [Tweaked] Various things for the prio factory mission
<br />- [Tweaked] Multiple under the hood changes to several things
"
]];


player createDiaryRecord ["changelog",
[
"3.2.6",
"
<br />- [Added] New sub-objective: HQ
<br />- [Added] Several new side mission rewards
<br />- [Added] 2 new side missions: militia camp and capture intel
<br />- [Tweaked] Main AO garrisonned infantry
<br />- [Tweaked] The way vehicles spawn in at FOBs
<br />- [Tweaked] General tweaks to several side missions
<br />- [Tweaked] General tweaks to main AO spawn handler
<br />- [Tweaked] Random loadout from the wasp (non-stealth)
<br />- [Tweaked] General tweaks to several behind the screens things
<br />- [Tweaked][Altis] FOB layout
<br />- [Tweaked][Altis] Vehicles that spawn at FOBs
<br />- [Fixed][Altis] AO bugging out
"
]];


player createDiaryRecord ["changelog",
[
"3.2.7",
"
<br />- [Tweaked] Arty firing loop
<br />- [Fixed][Altis] FOB triggers not working as intended
"
]];

player createDiaryRecord ["changelog",
[
"3.2.8",
"
<br />- [Tweaked] General tweaks to several behind the screens things
<br />- [Fixed] Arty not despawning
"
]];

player createDiaryRecord ["changelog",
[
"3.2.9",
"
<br />- [Added] Respawnable transport van at base
<br />- [Added] Side mission reward: service van
<br />- [Tweaked] Arsenal blacklist
<br />- [Tweaked] Tweaked side mission code
<br />- [Tweaked] Random loadouts of vehicles tweaked
<br />- [Tweaked] Tweaked all the priority missions code
<br />- [Tweaked] Various minor tweaks to multiple things
<br />- [Fixed] several behind the screen bugs
<br />- [Fixed] hint spam at militia camp mission
<br />- [Fixed] spelling mistakes in search and rescue mission
"
]];

player createDiaryRecord ["changelog",
[
"3.3.0",
"
<br />- [Added][Malden] service pads to FOBs
<br />- [Added] New side mission: rescue IDAP
<br />- [Added] New side mission: secure asset
<br />- [Added] New sub objective: goalkeeper
<br />- [Added] New sub objective: T-100 section
<br />- [Added] Unflip vehicle option, requires 4 people to use
<br />- [Added] Action that allows pilots to despawn damaged helis in base
<br />- [Added] A function that allows max 3 teamkills. On your 2nd teamkill you will receive a final warning. 10 minutes after a teamkill it will be forgotten and forgiven
<br />- [Tweaked][altis] FOB design
<br />- [Tweaked] Pilot restriction code
<br />- [Tweaked] Various behind the screen tweaks
<br />- [Tweaked] The code for all the prio objectives
<br />- [Tweaked] Air- and ground-vehicle service script
<br />- [Tweaked] No shooting in base hint will display your name
<br />- [Tweaked] Spawn points of FOBs will now get the name of said FOB
<br />- [Tweaked] Various spelling mistakes corrected (and new ones made)
<br />- [Tweaked] Some hints have been replaced by a fancier looking box with text
<br />- [Tweaked] The code for all the side missions (except the secure intel mission)
<br />- [Fixed] Refuel option for engineers
<br />- [Fixed] No shooting in base hint will not show up when controlling UAVs or when using flares
<br />- [Removed] Side mission: secure chopper
<br />- [Removed][altis] Some main AOs that were to close to FOBs
"
]];

player createDiaryRecord ["changelog",
[
"3.3.1",
"
<br />- [Tweaked] Service script, rewrote the rearm section
<br />- [Tweaked] Vehicle unflip action.  Now allows for 4 player or a bobcat
<br />- [Fixed] Side missions not spawning
<br />- [Fixed] Save gear option not showing up
<br />- [Fixed] TK-script displaying wrong messages
<br />- [Fixed] Radio tower completion hint displaying wrong AO name format
<br />- [Fixed] (hopefully) Cache subobjective shouldnt bug out and if it does the AO should still be completable
"
]];

player createDiaryRecord ["changelog",
[
"3.3.2",
"
<br />- [Fixed] (hopefully) Side missions not spawning
"
]];

player createDiaryRecord ["changelog",
[
"3.3.3",
"
<br />- [Fixed] Rearm script getting stuck in a loop when the vehicle has nothing to rearm
<br />- [Fixed] Several side missions not completing
"
]];

player createDiaryRecord ["changelog",
[
"3.3.4",
"
<br />- [Added] Radiotower sub-obj will spawn with minefield
<br />- [Fixed] Side mission objectiver marker not despawning
<br />- [Tweaked] Unflip vehicle action range increased
<br />- [Tweaked] Radiotower jet made more deadly.
<br />- [Tweaked] Jets and UAVs dont have a laser.  They will need to rely on infantry to desigante things.
<br />- [Tweaked] Units spawned by the main AO.  Now: 1x MBT, 2x-4x tigris, 2x-4x APC/IFV, 3x-5x car/MRAP, 8x normal inf group, 3x AA team, 3x AT team, 4x recond squad, max 15 garrisoned buildings in the center of the AO.
"
]];

player createDiaryRecord ["changelog",
[
"3.3.5",
"
<br />-several bug fixes
"
]]; //what an incredibly helpful changelog

player createDiaryRecord ["changelog",
[
"3.3.6",
"
<br />- [Fixed] Error in cache sub-objective
<br />- [Fixed] Side mission doors not opening
<br />- [Fixed] Massive error spam in prio-AA objective
<br />- [Fixed] Side mission rewards not having refuel and flip actions
<br />- [Tweaked] Performance of TK-script increased
<br />- [Tweaked] Minimum required amount of players for prio objective to spawn increased
"
]];

player createDiaryRecord ["changelog",
[
"3.3.7",
"
<br />- [Added] Sling weapon script
<br />- [Added] IandA progress saver
<br />- [Added] Vanilla-based arsenal
<br />- [Added] Ghost hawk door script
<br />- [Added] Automatic server restarter
<br />- [Added] Option to add supplycrates to helis
<br />- [Added] time multiplier for during nighttime
<br />- [Added] Intel mechanic for urban cache sidemission
<br />- [Added] Some checks to prevent some of the script-kids
<br />- [Added] Positive feedback system for prio missions (will prevent no prio mission spawning for prolonged periods of time)
<br />
<br />- [Fixed] Side mission spawning 2 rewards
<br />- [Fixed] Fixed ground service (hopefully)
<br />- [Fixed] Prototype tank side mission cleanup not running
<br />- [Fixed] Cache sub-objective holdaction not working as intended
<br />
<br />- [Tweaked] Arsenal restrictions
<br />- [Tweaked] Init-scripts tweaked
<br />- [Tweaked] FOB-vehicle respawn timers
<br />- [Tweaked] HQ sub objective will now spawn jets
<br />- [Tweaked] Rewrote base AA for more performance
<br />- [Tweaked] Rescue pilot mission (changes for performance)
<br />- [Tweaked] Vehicle respawn script (changes for performance)
<br />- [Tweaked] The same side mission won't spawn 2 times in a row
<br />- [Tweaked] Sub objectives are now sub objectives of the main objective
<br />- [Tweaked] Research side mission won't spawn with documents anymore, only laptops
<br />- [Tweaked] Prio objectives will only spawn when there are at least 15 infantry on the server
<br />- [Tweaked] General tweaks, both for visials and for performance to several scripts/functions/missions
<br />
<br />- [Removed] Derp arsenal
<br />- [Removed] Stomper, 2x prowler and 1 hunter HMG from base vehicle pool
<br />- [Removed] Custom vehicle HUD (the green names on the left side of the screen)
"
]];
player createDiaryRecord ["changelog",
[
"3.3.7.10",
"
<br />- [Added] Tanks DLC vehicles as side mission rewards
<br />- [Added] Update arsenal to include MAAWS for all and medics have access to rifles
<br />- [Added] Update arsenal to include Vorona for AT
<br />- [Added] Update arsenal to include Rifles for medic
<br />
<br />- [Fixed] Arsenal issue present in 3.3.7.09
<br />
<br />- [Tweaked] Restarter code to ensure reliability
<br />
<br />- [Removed] VcomAI code
"
]];
player createDiaryRecord ["changelog",
[
"3.3.8",
"
<br/>- [Tweaked] Arsenal restrictions
<br/>- [Tweaked] FSG and AT re-balance
<br/>- [Added] Copilot seat without aircraft control for everybody
"
]];
player createDiaryRecord ["changelog",
[
"3.3.8.1",
"
<br/>Lukewarm hotfix.
<br/>- You now respawn with your (automatically) saved gear again. Sorry for the inconvenience 3.3.8 caused there.
<br/>- [Added] The extended passenger information HUD has been added to the diary / map settings.
<br/>- [Added] The Sling Weapon and Ghost Hawk doors actions can now be toggled from the diary / map settings too.
<br/>- Some of the invisible things have... changed. Can you feel it too? A few functions are now a few nano- or even milliseconds faster! They are also wearing new makeup.
"
]];

player createDiaryRecord ["changelog",
[
"3.3.9",
"
<br/>- Hotfix for warlods update
"
]];

player createDiaryRecord ["changelog",
[
"3.3.10",
"
<br/>- Fixes to the previous hotfix.
<br/>- Small fixes here and there
"
]];//another incredibly helpful changelog

player createDiaryRecord ["changelog",
[
"3.3.11",
"
<br/>- Security patch.
"
]];

player createDiaryRecord ["changelog",
[
"3.3.12",
"
<br/>- [Added] a new role: rifleman LAT (one in each regular squad)
<br/>- [Updated] the security patch.
<br/>- [Updated] the teamkilling script.
<br/>- [Updated] the default loadouts to fit the above mentioned restrictions
<br/>- [Updated] the units that are spawn by the AO.
<br/>          T-140 and T-140K can now spawn as MBTs as well
<br/>          Nyx (AT, autocannon and AA) can now spawn as IFVs/APCs as well
<br/>- [Updated] the secure asset mission.
<br/>          Added T-140, T-140K, Nyx AT, Nyx AA and Nyx autocannon as potential to secure assets
<br/>- [Updated] the arsenal restrictions.
<br/>          [Added]: ADR-97 SMGs to all roles that already has SMGs available
<br/>          [Added]: LAT capabilites to certain roles (TL, SL, Engineer, Explo Specialist, Rifleman LAT)
<br/>          [Fixed]: FSG teamleader now has access to the same weapons as other TLs as well as the FSG weapons
<br/>          [Removed]: HAT capabilites from FSG (still has LAT and MAT capabilites + static HAT launchers)
<br/>          [Removed]: weapons with OPFOR camouflage if a BLUFOR camouflaged alternative is available (not for all weapons)
<br/>          [Removed]: OPFOR laser desigantors
<br/>- [Fixed] missions spawning too close to FOBs
<br/>- [Fixed] secure intel unit side mission (2nd decoy wasn't spawning)
<br/>- [Removed] one AR slot in each regular squad
"
]];

player createDiaryRecord ["changelog",
[
"3.3.13",
"
<br/>- [Removed] a debug hint
<br/>- [Tweaked] More tweaks to the security patch
<br/>- [Tweaked] the spawn position of priority missions (they'll spawn closer to the AO)
"
]];

player createDiaryRecord ["changelog",
[
"3.3.14",
"
<br/>- [Fixed] bug in prio factory mission
<br/>- [Fixed] bug in militia camp mission
<br/>- [Fixed] bug in side mission rewards code
<br/>- [Fixed] an error that was spamming client side RPTs
<br/>- [Fixed] base AA script incorrectly displaying hints about carrier AA
<br/>- [Tweaked] Small tweaks to the TK script to increase performance
<br/>- [Tweaked] Further increased distance between bases and spawning missions (from 800 to 1500)
<br/>- [Updated][Fixed] and fixes to the security patch
"
]];

player createDiaryRecord ["changelog",
[
"3.3.15",
"
<br/>- [Added] MAAWS mod 1 to the LAT role
<br/>- [Fixed] missions spawning on bases
<br/>- [Fixed] another error that was spamming client side RPTs
"
]];

player createDiaryRecord ["changelog",
[
"3.3.16",
"
Due to a bug that could not be located in 3.3.15 development was rolled back to 3.3.13 from where several fixes were reapplied.  
<br/>- [Fixed] base AA script incorrectly displaying hints about carrier AA
<br/>- [Fixed] missions spawning on base/FOBs
<br/>- [Fixed] security patch
<br/>- [Fixed] small bug with reward vehicles
<br/>- [Updated] TK script
<br/>- [Tweaked] sub objectives for better performance
"
]];

player createDiaryRecord ["changelog",
[
"3.3.17",
"
<br/>- [Added] the MAAWS mod 1 to the LAT role again (fingers crossed that it doesn't break anything)
<br/>- [Fixed] another error that was spamming client side RPTs (again)
<br/>- [Added] Reapplied some fixes to base layout that got undone due to the previous update
"
]];

player createDiaryRecord ["changelog",
[
"3.3.18",
"
<br/>- [Added] Nyx AA to reward vehicles
<br/>- [Added] discord invite link to this diary
<br/>- [Added] flags to non-nato respawning and reward vehicles
<br/>- [Added] camonet, slat cages, ... to reward vehicles (reward will spawn with either camonet or slat cages, not both)
<br/>- [Fixed] error in TK messages
<br/>- [Tweaked] the rules
<br/>- [Tweaked] reward frequency
<br/>- [Tweaked] Disabled VON in command chat
<br/>- [Tweaked] Slight tweak to admin and zeus tools
<br/>- [Tweaked] Slight tweak to pilot restriction code
<br/>- [Tweaked] Slight tweak to base/carrier AA activation code
"
]];

player createDiaryRecord ["changelog",
[
"3.3.19",
"
<br/>- [Added] MB 4D AT/HMG; prowler AT and hunter AT to the reward pool
<br/>- [Fixed] error in TK messages (hopefully for real this time)
<br/>- [Fixed] a debug value that was never changed in the arty mission
<br/>- [Fixed] a bug causing decoys not to spawn in secure intel mission
<br/>- [Tweaked] Further tweaked reward frequency
<br/>- [Tweaked] Loadouts now have the black mags for the black MX
<br/>- [Tweaked] Improved enhanced t-100 reward (added a bit more ammo)
<br/>- [Tweaked] zeus/admin tools for these new rewards and added an extra hint
<br/>- [Tweaked] Eased of gunner seat restrictions, anyone who has access to LATs or above has access to gunner seats of vehicles with launchers now
"
]];

player createDiaryRecord ["changelog",
[
"3.3.20",
"
<br/>- [Added] persistance for vehicle hud preference
<br/>- [Fixed] more errors in TK messages
<br/>- [Fixed] bug in static weapon seat restiction
<br/>- [Fixed] some message related to admin seat restrictions
<br/>- [Tweaked] general code cleanup
"
]];

player createDiaryRecord ["changelog",
[
"3.3.21",
"
<br/>- [Added] some stuff to the admin/zeus tools
<br/>- [Tweaked] more code cleanup
<br/>- [Tweaked] more code optimization
<br/>- [Tweaked] everyone but pilots now have access to the underwater gun
<br/>- [Tweaked] the mission now has a propper ending when the required amount of AOs are captured
<br/>- [Tweaked] ever so slighly increased the chance of molos airfield being the next AO when the AOs are up there
<br/>- [Tweaked] the hint for side missions with friendly forces to differentiate between enemies killing the friendlies and players killing them
<br/>- [Fixed] bug in AI waypoint script
<br/>- [Fixed] bug in secure asset mission
<br/>- [Fixed] bug in ground service script
<br/>- [Fixed] potential bug in arsenal restriction code
<br/>- [Fixed] some spelling mistakes (and probably made some more)
<br/>- [Fixed] (side mission reward) GMG offroad also getting a mortar
<br/>- [Fixed] no goofing in base hint displaying while not shooting in base
<br/>- [Removed] some (a lot of) obsolete code
"
]];

player createDiaryRecord ["changelog",
[
"3.3.22",
"
<br/>- [Added] sensor support for vehicles that support this
<br/>- [Added] some more functionality to the admin and zeus tools
<br/>- [Fixed] bug in admin/zeus tools
<br/>- [Fixed] loading saved loadouts from the arsenal not working (hopefully)
<br/>- [Fixed] protect friendly forces being able to fail and succeed at the same time
<br/>- [Fixed] (hopefully) side mission research data showing an empty notification on completion
<br/>- [Tweaked] base AA a bit
<br/>- [Tweaked] the goalkeeper subobj
<br/>- [Tweaked] base layout a little bit
<br/>- [Tweaked] HQ subobj for performance
<br/>- [Tweaked] how vehicles respawn to avoid abuse
<br/>- [Tweaked] T-100 section subobj to a tank subobj
<br/>- [Tweaked] backend code from main AOs and subobj
<br/>- [Tweaked] some code to (hopefully) increase performance
<br/>- [Tweaked] some stuff to rename the respawn point at main base
<br/>- [Tweaked] init scripts to get a slight increase in performance
<br/>- [Tweaked] code for prio factory mission (for performance and readability)
<br/>- [Tweaked] base and carrier AA, they will now turn their radar off when they go into cooldown
<br/>- [Removed] friendly arty
"
]];

player createDiaryRecord ["changelog",
[
"3.3.23",
"
<br/>- [Added] 15 second delay between prio AA objective spawning and the AA turrets coming online
<br/>- [Fixed] bug in prio AA mission
<br/>- [Fixed] loadouts not reapplying after respawn
<br/>- [Fixed] vehicles sometimes being slightly damaged when respawning
<br/>- [Tweaked] base protection
<br/>- [Tweaked] reward xi'an is now gray and the pylons are removed, not just the ammo
<br/>- [Tweaked] vehicle inventories will now be consistent in what it contains (no CSAT gear etc)
"
]];

player createDiaryRecord ["changelog",
[
"3.3.24",
"
<br/>- [Added] capture progress marker
<br/>- [Added] map action to show how long it'll take for vehicles to respawn
<br/>- [Fixed] vehicles spawning on top of sheds they're supposed to spawn under (hopefully)
<br/>- [Fixed] fail message of secure asset mission incorrectly having the 'sub-objective update' title
<br/>- [Tweaked] reward tarus don't spawn with hex camo but black camo instead.
"
]];

player createDiaryRecord ["changelog",
[
"3.3.25",
"
<br/>- [Fixed] arty not firing
<br/>- [Fixed] whitelist for squad xml
<br/>- [Fixed] bug with secure radar side mission
<br/>- [Fixed] bug that occurs with arsenal sometimes
<br/>- [Fixed] Last stand spawning apex slammer instead of a regular one
<br/>- [Tweaked] security update
<br/>- [Tweaked] main AO spawn function for performance
<br/>- [Tweaked] arsenal restriction code to prevent abuse (from LH5)
<br/>- [Tweaked] air service script so the VTOL doesn't have a 10 minute service + added checks for if the vehicles has already been serviced.
<br/>- [Removed] obsolete code
"
]];

player createDiaryRecord ["changelog",
[
"3.3.26",
"
<br/>- [Added] zeus ping limit
<br/>- [Added] functionalities to the admin tools
<br/>- [Tweaked] base layout slighly
<br/>- [Tweaked] further security updates
<br/>- [Tweaked] heli supply crate can now also be deployed on the ground
<br/>- [Fixed] re-fuel function (hopefully)
"
]];

player createDiaryRecord ["changelog",
[
"3.3.27",
"
<br/>- [Added] admin tool functionality
<br/>- [Added] ghosthawk guns are now locked by default
<br/>- [Fixed] bug in TK script
<br/>- [Fixed] ghosthawk guns not locking
<br/>- [Fixed] militia camp mission action not working properly
<br/>- [Fixed] spotters now have gillies like they're supposed to have
<br/>- [Fixed] vehicles getting more flares than they're supposed to get
<br/>- [Fixed] TK script not detecting people killing themselves correctly
<br/>- [Fixed] bug in admin/zeus tools caused by the previous security patch
<br/>- [Fixed] several things not working due to a change in the latest update
<br/>- [Tweaked] security patch
<br/>- [Tweaked] zeus ping limit code
<br/>- [Tweaked] arsenal restriction code
<br/>- [Tweaked] code cleanup and optimization
<br/>- [Tweaked] no more floating H-barrier in base
<br/>- [Tweaked] Paradrop crate action (time reduced)
<br/>- [Tweaked] vehicle respawn should no longer be able to bug out
<br/>- [Tweaked] statics on reward vehicles can no longer be disassembled
<br/>- [Tweaked] replaced pilot billboard picture so it has a screenshot from arma instead of GTA (thanks LH5)
<br/>- [Tweaked] cache subobj charges planted hint now displays the name of the person who planted the charges
<br/>- [Tweaked] overhauled how enemy jets and helis decide which players to attack.  A word of caution: if you shoot at a jet or heli, it's gonna shoot back.
<br/>- [Removed] obsolete code, functions, ...
<br/>- [Removed] apers mine-dispensers for security reasons
"
]];


//-------------------------------------------------- Credits
player createDiaryRecord ["credits",
[
"I & A 3",
"
<br />Mission authors:
<br />
<br />	- <font size='16'>BACONOP</font>
<br />
<br />
<br />Contributors:
<br />
<br />	- alganthe - Ahoy World (ahoyworld.net)
<br />	- Quicksilver
<br />	- PERO - Ahoy World (ahoyworld.net)
<br />	- Zissou - Ahoy World (ahoyworld.net)
<br />	- Stanhope - Ahoyworld member (ahoyworld.net)
<br />	- Ryko - Ahoyworld (ahoyworld.net)
<br />
<br />With the help of:
<br />
<br />	- Pfc. Christiansen - Ahoy World (ahoyworld.net)
<br />	- <font size='16'>The AhoyWorld community</font>
<br />
<br />Other:
<br />
<br />	Ordinance Script
<br />		- Wolfenswarm
<br />
<br />	CHVD
<br />		- Champ-1
"
]];
