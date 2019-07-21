//Cut to black while we set things up
cutText ["", "BLACK FADED"];

//player disableConversation true;
//enableSentences false;
//[player, "NoVoice"] remoteExec ["setSpeaker", -2, false];

/*
Arsenal restrictions:
	These items need to be added because the special gear compositions BIS use for their units are not defined in ArsenalDefinitions.sqf.
	This way, the default weapon / backpack the player unit spawns with doesn't get removed by AW_fnc_cleanInventory.
*/
//Get the loadout the player used before death:
if (!isNil {player getVariable "PlayerLoadout"}) then {
	player setUnitLoadout [player getVariable "PlayerLoadout", true];
} else {
	execVM "Scripts\arsenal\unitLoadout.sqf";
};

//Fatigue settings:
if (PARAMS_Fatigue == 1) then {
	player enableFatigue false;
};

//Derp_revive respawn:
if (player getVariable ["derp_revive_downed", false]) then {
	[player, "REVIVED"] call derp_revive_fnc_switchState;
};

//Pilot actions:
if (roleDescription player find "Pilot" > -1) then {
	//UH-80 Turret Control:
	/*if (PARAMS_UH80TurretControl != 0) then {
		inturretloop = false;
		UH80TurretAction = player addAction ["Turret Control",AW_fnc_uh80TurretControl,[],-100,false,false,'','[] call AW_fnc_conditionUH80TurretControl'];
	};*/
	//Despawn damaged helicopters in base:
	player addAction ["<t color='#99ffc6'>Despawn damaged helicopter</t>", {
			_accepted = false;
			{
				_NearBaseLoc = (getPos player) distance (getMarkerPos _x);
				if (_NearBaseLoc < 500) then {_accepted = true;};
			} forEach BaseArray;
			
			if (_accepted) then {
				_vehicle = vehicle player;
				moveOut player;
				deleteVehicle _vehicle;
				[parseText format ["<br /><br /><t align='center' font='PuristaBold' ><t size='1.2'>Helicopter successfully despawned.</t></t>"], true, nil, 4, 0.5, 0.3] spawn BIS_fnc_textTiles;
			} else {
				[parseText format ["<br /><t align='center' font='PuristaBold' ><t size='1.2'>This action is not allowed outside of base.</t><t size='1.0'><br /> Helicopter not despawned</t></t>"], true, nil, 6, 0.5, 0.3] spawn BIS_fnc_textTiles;
			};
		}, [], -100, false, true, "", "
		(player == driver (vehicle player)) && 
		((vehicle player) isKindOf 'Helicopter') && 
		((speed (vehicle player)) < 1) && 
		{count (crew (vehicle player))==1} &&
		( 
			(((vehicle player) getHitPointDamage 'hitEngine') > 0.4) ||
			(((vehicle player) getHitPointDamage 'HitHRotor') > 0.4 )||
			((damage (vehicle player)) > 0.5) ||
			((fuel (vehicle player)) <= 0)
		)
		", 4];
		//Ghost Hawk doors action:
		["Respawn"] spawn AW_fnc_helicopterDoors;
};

//Sling weapon action:
["Respawn"] spawn AW_fnc_slingWeapon;

//Add players to Zeus:
{_x addCuratorEditableObjects [[player], true];} forEach allCurators;

//Clear vehicle inventory action:
player addAction ["<t color='#ff0000'>Clear vehicle inventory</t>", {[] call AW_fnc_clearVehicleInventory}, [], -101, false, true, "", "
	(player == driver vehicle player) &&
	!((vehicle player) == player) && 
	(count itemCargo vehicle player != 0 || 
	count weaponCargo vehicle player != 0 || 
	count magazineCargo vehicle player != 0 || 
	count backpackCargo vehicle player != 0)"];

//disable VON in certain channels
0 enableChannel [false, false];
1 enableChannel [true, true];
2 enableChannel [true, false]; 

//Assign Zeus:
[] spawn {
    sleep 3;
    [player] remoteExecCall ["initiateZeusByUID", 2];
	sleep 2;
	if (player getVariable ["isAdmin", false]) then {execVM "scripts\adminScripts.sqf";};
	if ((player getVariable ["isZeus", false]) && !(player getVariable ["isAdmin", false])) then {execVM "scripts\zeusScripts.sqf";};
	missionNamespace setVariable ['Ares_Allow_Zeus_To_Execute_Code', false];
	
	/*Launch the naughtyCheck*/
	waitUntil {sleep 0.5; !isNil "naughtyCheck"};
	if !(player getVariable ["isZeus", false]) then {
		[] spawn {
			while {alive player} do {
				[] spawn naughtyCheck;
				sleep 30;
			};
		};
	};
};

[] spawn {
    waitUntil {sleep 0.1; ! isNil "whitelistarray"};
    {
        whitelistArray pushBackUnique _x;
    } forEach (weapons player + [backpack player]);
};

//reset the amount of pings someone has
player setVariable ["zeusPingLimit", 0];

//wait 2 seconds before fading back in
sleep 2;
titleCut ["", "BLACK IN", 2];