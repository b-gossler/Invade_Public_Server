enableSaving false;
execVM "scripts\misc\localChecks.sqf";

//Player TK counter:
amountOfTKs = 0;
TKLimit = 3;

player setVariable ['timeTKd', round (time), false];
playerTKed = {
    if (player getVariable "isZeus") exitWith {};
    if ((player getVariable 'timeTKd' == round(time)) || (roleDescription player find "Pilot" > -1) || (player getVariable "isZeus")) exitWith {};
	
    amountOfTKs = amountOfTKs + 1;
    player setVariable ['timeTKd', round (time), false];
	
    if (amountOfTKs == (TKLimit -1)) exitWith {
        if (player getVariable "isZeus") exitWith {};
        player enableSimulation false;
		titleText ["<t align='center'><t size='1.6' font='PuristaBold'>Simulation has been disabled as a result of excessive teamkilling. </t><br /> <t size='1.2' font='PuristaBold'>This is a final warning.  Respawn to re-enable simulation and make this message disappear.</t><br /><br /><t size='0.9' font='PuristaBold'>If you continue to teamkill AhoyWorld cannot be held responsible for the consequences.</t></t>", "BLACK", 2, true, true];
		[] spawn { 
			waitUntil{!alive player};
			titleFadeOut 0;
			sleep 6000;
			amountOfTKs = amountOfTKs - 1;
		};
	};
    if (amountOfTKs >= TKLimit) exitWith {
        if (player getVariable "isZeus") exitWith {};
		[player, format["Automated server message: %1 will be kicked for teamkilling.", name player]] remoteExecCall ["sideChat", 0, false];
		titleText ["<t align='center'><t size='1.8' font='PuristaBold'>You have exceeded the server limit for teamkills. <br /> You will be kicked shortly.</t><br /> <t size='1.2' font='PuristaBold'>Your unique ID has been logged along with with your name.</t><br/><br /><t size='1.0' font='PuristaBold'>This message will not go away. In 30 seconds or when you open the esc-menu, you will be kicked from the server.</t><br/><br/><t size='0.8' font='PuristaBold'>We reserve the right to ban you for these teamkills. This may happen without any further notice.</t></t>", "BLACK", 2, true, true];
		private _diagLogTxt = format ['TKScript: Player %1 (UID: %2) has been kicked for teamkilling.', name player, getPlayerUID player];
		[_diagLogTxt] remoteExecCall ["diag_log", 2];
		player enableSimulation false;
	
		[_uid] spawn {
			waitUntil {!isNull (findDisplay 49)};
			params ["_uid"];
			[_uid] remoteExec ["kickPlayer", 2];
		};
		[] spawn { sleep 30; [_uid] remoteExec ["kickPlayer", 2]; };
	};
	
	[] spawn {
        sleep 6000;
        amountOfTKs = amountOfTKs - 1;
	};
};

[] execVM "scripts\misc\QS_icons.sqf";			//Icons
[] execVM "scripts\misc\diary.sqf";				//Diary
[] execVM "scripts\misc\earplugs.sqf";			//Earplugs

//spawn & Pilot spawn:
[player, getMarkerPos "BASE", "Main base"] call BIS_fnc_addRespawnPosition;
if (roleDescription player find "Pilot" > -1) then {  
	private ["_spawnpos"];
	_spawnpos = getPosATL PilotSpawnPos;
	[player, _spawnpos, "Pilot spawn"] call BIS_fnc_addRespawnPosition; 	
};

//BIS Dynamic Groups:
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;

//Derp_revive setup:
if ("derp_revive" in (getMissionConfigValue "respawnTemplates")) then {
    if (getMissionConfigValue "derp_revive_everyoneCanRevive" == 0) then {
        if (player getUnitTrait "medic") then {
            call derp_revive_fnc_drawDowned;
        };
    } else {
        call derp_revive_fnc_drawDowned;
    };
    call derp_revive_fnc_handleDamage;
    call derp_revive_fnc_diaryEntries;
    if (getMissionConfigValue "respawnOnStart" == -1) then {
		[player] call derp_revive_fnc_reviveActions;
	};
};

//Player protection
player addRating 10000000;

//Squad URL hint:
private _infoArray = squadParams player;
if (count _infoArray > 0) then {

    private _squadArray = _infoArray select 0;
    private _memberArray = _infoArray select 1;

    private _squadName = _squadArray select 1;
    private _squadEmail = _squadArray select 2;

    private _memberNick = _memberArray select 1;

	if (_squadEmail != "staff@ahoyworld.net") exitWith {};
	
	private _allowedSquads = ["AhoyWorld Core Staff", "AhoyWorld Moderator", "AhoyWorld Moderator", "AW Invade and Annex Developer", "AhoyWorld Enhanced Veteran",
		"AhoyWorld Spartan", "Ahoyworld Member", "AhoyWorld Donator", "Xwatt's Bear Battalion", "Lindi's Ye' Old Geezers","Itsmemario's Pizza Patrol",
		"Solex's Fire and Rescue Squad", "ahoyworld member 2", "ahoyworld field ambassador"];
	
	if (! isNil "requestSquadList") then {
		private _temp = [];
		_temp = [] call requestSquadList;
		if (! isNil "_temp") then {
			if ((count _temp) > 0) then {_allowedSquads = _temp;};	
		};
	};
	
	if !(_squadName in _allowedSquads) exitWith {
		private _text = format["Player %1 (%2) joined with a the ahoyworld staff email in their squad XML (%3). Possible hacking attempt.", name player, getPlayerUID player, _squadName];
		[_text] remoteExec ["diag_log", 2, false];
	};

	private _hint = format["<t align='center' size='2.2' color='#FF0000'>%1<br/></t><t size='1.4' color='#33CCFF'>%2</t><br/>has joined the server. To get involved in the Ahoy World community, register an account at www.AhoyWorld.net and get stuck in!</t><br/>",_squadName, _memberNick];
	[_hint] remoteExec ["AW_fnc_globalHint", 0, false];
};

//Some scroll wheel actions:
["AddAction"] spawn AW_fnc_slingWeapon;

if (roleDescription player find "Pilot" > -1) then {
	["AddAction"] spawn AW_fnc_helicopterDoors;
};

[] spawn {
	waitUntil {sleep 0.1; !isNil "arsenalArray"};
	{
		_x addAction ["Toggle sling weapon action", {["Toggle"] spawn AW_fnc_slingWeapon;}, [], 4, false, true, "", "true", 5];
		
		if (roleDescription player find "Pilot" > -1) then {
			_x addAction ["Toggle Ghost Hawk doors action", {["Toggle"] spawn AW_fnc_helicopterDoors;}, [], 4, false, true, "", "true", 5];
		};
	} forEach arsenalArray;
};


vehicleHUDScript = nil;
if (profileNamespace getVariable ["AW_I&A_3_ExtendedVehicleHud", false]) then {
	vehicleHUDScript = [] execVM "scripts\vehicle\crew\crew.sqf"; 		//Vehicle HUD
};

toggleVehicleHUDFunction = {
	if (isNil "vehicleHUDScript") then {
		vehicleHUDScript = execVM "scripts\vehicle\crew\crew.sqf";
		systemChat "Extended passenger information HUD on.";
		profileNamespace setVariable ["AW_I&A_3_ExtendedVehicleHud", true];
		saveProfileNamespace;
	} else {
		terminate vehicleHUDScript;
		vehicleHUDScript = nil;
		disableSerialization;
		1000 cutRsc ["HudNames", "PLAIN"];
		_ui = uiNamespace getVariable "HudNames";
		_HudNames = _ui displayCtrl 99999;
		_HudNames ctrlSetStructuredText parseText "";
		_HudNames ctrlCommit 0;
		systemChat "Extended passenger information HUD off.";
		profileNamespace setVariable ["AW_I&A_3_ExtendedVehicleHud", nil];
		saveProfileNamespace;
	};
};

//Player safe zone:
[] spawn {
	waitUntil {sleep 0.5; !isNil "BaseArray"};

	player addEventHandler ["FiredMan", {
		params ["_unit", "_weapon", "", "", "", "", "_projectile"];
		private _pos = getPos _projectile;

        private _baseIndex = (BaseArray findIf {_pos distance (getMarkerPos _x) < 1000});

        if (_baseIndex == -1) exitWith {};
        if (_weapon find "CMFlareLauncher" != -1) exitWith {};

        private _base = BaseArray select _baseIndex;

		if ((_pos distance (getMarkerPos _base)) < 300) then {
		    if (player getVariable "isZeus") exitWith {
           		hint "You are shooting in base. Be careful when doing this. Don't abuse it!";
           	};

		    deleteVehicle _projectile;
            hintC format ["%1, don't goof at base. Don't throw, fire or place anything inside the base.", name _unit];
		} else {
		    if (player getVariable "isZeus") exitWith {};
		    [_projectile, getMarkerPos _base] spawn {
		        params ["_proj", "_markerPos"];
		        private _dist = _proj distance _markerPos;
		        private _initialDist =  _dist;
		        while {alive _proj} do {
		            sleep 0.2;
		            _dist = _proj distance _markerPos;
		            if (_dist < 300) exitWith {
		                deleteVehicle _proj;
		            };
		            if ((_dist - _initialDist) > 1000) exitWith {};
		        };
		    };
		};
	}];
};

//Artillery Computer:
if (roleDescription player == "FSG Gunner") then {
	enableEngineArtillery true;
} else {
	enableEngineArtillery false;
};

//EventHandlers for seat restrictions:
player addEventHandler ["GetInMan", {
	[] spawn AW_fnc_restrictedAircraftSeatsCheck;
	[] spawn AW_fnc_restrictedGunnerSeatsCheck;
}];

player addEventHandler ["SeatSwitchedMan", {
	[] spawn AW_fnc_restrictedAircraftSeatsCheck;
	[] spawn AW_fnc_restrictedGunnerSeatsCheck;
}];

//Arsenal:
[] spawn {
	private _arsenalDefinitions_handler = execVM "Scripts\arsenal\ArsenalDefinitions.sqf";
	waitUntil {sleep 0.1; scriptDone _arsenalDefinitions_handler};
	waitUntil {sleep 0.1; ! isNil "arsenalArray"};

	{ 
		[_x] execVM "Scripts\arsenal\ArsenalInitialisation.sqf";
	} forEach arsenalArray;

	player addEventHandler ["InventoryClosed", {
		[] spawn AW_fnc_cleanInventory;
		[] spawn AW_fnc_inventoryInformation;
	}];

	player addEventHandler ["Take", {
		[] spawn AW_fnc_cleanInventory;
		[] spawn AW_fnc_inventoryInformation;
	}];

	//With derp_revive, this EH needs to be added to Functions/revive/fn_switchState.sqf as well.
	inGameUISetEventHandler ["Action", "
		if (_this # 4 == localize 'STR_A3_Arsenal') then {
			[] spawn {
				waitUntil {sleep 0.05; isNull (uiNamespace getVariable 'RSCDisplayArsenal')};
				[] call AW_fnc_cleanInventory;
				[] spawn AW_fnc_inventoryInformation;
				player setVariable ['PlayerLoadout', (getUnitLoadout player)];
			};
		};
		false
	"];
};