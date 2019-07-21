/*
Author:	BACONMOP
Edited by:
    S0zi0p4th
    Ryko
    Stanhope
    LostBullet
    McKillen

Description:	Things that may run on the server.
*/

enableSaving false;
enableEnvironment false;

//temp define this function so in case a client calls it nothing breaks
initiateZeusByUID = {[] spawn {sleep 3; [] spawn initiateZeusByUID;};};

jetCounter = 0;
jetspawnpos = 0;

for [ {_i = 0;}, {_i < count(paramsArray);}, {_i = _i + 1;} ] do {
	call compile format
	[
		"PARAMS_%1 = %2",
		(configName ((missionConfigFile >> "Params") select _i)),
		(paramsArray select _i)
	];
};

//some params
AW_PARAM_MainEnemyFaction = "MainEnemyFaction" call BIS_fnc_getParamValue;
AW_PARAM_SecondaryEnemyFaction = "SecondaryEnemyFaction" call BIS_fnc_getParamValue;
[] call AW_fnc_factionDefine;

//let's start this baby up
missionsMinimumSpawnDistance = 1500;
[] spawn {
	execVM "Local\localInit.sqf";	                                    //defines map specific stuff on server
	execVM "scripts\vehicle\VehicleRespawn.sqf";                        //vehicle respawn server script
	sleep 4;
	mainObjScript = [] execVM "Missions\Main\Main_Machine.sqf";			// Main Aos
	waitUntil {sleep 0.1; !isNil "BaseArray"};
	waitUntil {sleep 0.1; !isNil "mainAOUnits"};
	waitUntil {sleep 0.1; !isNil "currentAO"};
	prioObjScript = [] execVM "Missions\Priority\MissionControl.sqf";	// Priority Missions
	sideObjScript = [] execVM "Missions\Side\MissionControl.sqf";		// Side Missions
	sleep 3;
	execVM "scripts\misc\cleanup.sqf";									// cleanup
	execVM "scripts\misc\zeusupdater.sqf";								// zeus updater
};

//BIS Dynamic Groups:
["Initialize"] call BIS_fnc_dynamicGroups;

requestSquadList = {
	private _returnVal = [];
	if (! isNil "allowedSquads") then {_returnVal = allowedSquads;};
	_returnVal
};

//Server functions
serverRestart = {
	_serverpassword = [] call getServerPassword;
	_serverpassword serverCommand "#shutdown"; 
};

missionRestart = {
	_serverpassword = [] call getServerPassword;
	_serverpassword serverCommand "#restart"; 
};

delayedFunction = {
    params ["_sleepTime", "_function", "_params"];
    sleep _sleepTime;
    _params spawn _function;
};

kickedPlayerList = [];

//======================Zeus Modules
zeusModules = [zeus_1, zeus_2, zeus_3, zeus_4, zeus_5, zeus_6, zeus_7, zeus_8, zeus_9, zeus_10, zeus_11, zeus_12, zeus_13, zeus_14, zeus_15, zeus_16, zeus_17, zeus_18, zeus_19, zeus_20, zeus_21, zeus_22, zeus_23, zeus_24, zeus_25, zeus_26, zeus_27, zeus_28, zeus_29, zeus_30, zeus_31, zeus_32, zeus_33, zeus_34, zeus_35, zeus_36, zeus_37, zeus_38, zeus_39, zeus_40, zeus_41, zeus_42, zeus_43, zeus_44, zeus_45 ];

// get local Zeus info
#include "\arma3_readme.txt";

//======================Zeus access and welcome message:
initiateZeusByUID = {
	params ["_player"];
	private _uid = getPlayerUID _player;

	if !( isNil {_player getVariable 'zeusModule'} ) then {
	    unassignCurator (zeusModules select (_player getVariable 'zeusModule'));
	};
	_player setVariable ["zeusModule", nil];
	_player setVariable ["isAdmin", false, true];
    _player setVariable ["isZeus", false, true];

	private _zeusUIDs = zeusAdminUIDs + zeusModeratorUIDs + zeusSpartanUIDs;
	private _zeusModuleNumber = _zeusUIDs find _uid;
	
	if ( _zeusModuleNumber == -1 ) exitWith {
	[parseText format ["<t align='center' font='PuristaBold' ><t size='1.6'>%1</t><br />
        <t size='1.2'>Welcome %2</t><br /><t size='0.8' font='PuristaMedium'>Ensure you are familiar with our server rules:<br /> www.ahoyworld.net/index/rules</t>", "INVADE AND ANNEX", name _player],
        true, nil, 12, 0.3, 0.3
    ] remoteExec ["BIS_fnc_textTiles", _player]; };
	
	if ( (zeusModeratorUIDs find _uid) > -1 ) exitWith{
	[parseText format ["<br /><t align='center' font='PuristaBold' ><t size='1.6'>%1</t><br />
        <t size='1.2'>Welcome %2</t>", "AWE MODERATOR: ZEUS NOT ASSIGNED", name _player],
        true, nil, 12, 0.3, 0.3
    ] remoteExec ["BIS_fnc_textTiles", _player]; };
	
	private _zeusModule = zeusModules select _zeusModuleNumber;
	unassignCurator _zeusModule;
	_player assignCurator _zeusModule;
	_player setVariable ["zeusModule", _zeusModuleNumber];
	[_zeusModule,[-1,-2,0]] call BIS_fnc_setCuratorVisionModes;
	adminChannelID radioChannelAdd [_player];

	if ( (zeusAdminUIDs find _uid) > -1 ) exitWith{
	    _player setVariable ["isAdmin", true, true];
		_player setVariable ["isZeus", true, true];
		diag_log format ['Zeus (admin) assigned on %1', name _player];
		[parseText format ["<br /><t align='center' font='PuristaBold' ><t size='1.6'>%1</t><br /> 
            <t size='1.2'>Welcome %2</t>", "ZEUS (PUBLIC MOD) ASSIGNED", name _player], true, nil, 12, 0.3, 0.3
        ] remoteExec ["BIS_fnc_textTiles", _player];
	};
	
	if ( (zeusSpartanUIDs find _uid) > -1 ) exitWith{
	    _player setVariable ["isZeus", true, true];
		diag_log format ['Zeus (spartan) assigned on %1', name _player];
		[parseText format ["<br /><t align='center' font='PuristaBold' ><t size='1.6'>%1</t><br /> 
            <t size='1.2'>Welcome %2</t>", "ZEUS (SPARTAN) ASSIGNED", name _player], true, nil, 12, 0.3, 0.3
        ] remoteExec ["BIS_fnc_textTiles", _player];
	};
};

addMissionEventHandler ["HandleDisconnect", {
		params ["_unit", "", "", "_name"];
		if !( isNil {_unit getVariable 'zeusModule'} ) then{	
			_zeus = _unit getVariable 'zeusModule';
			unassignCurator (zeusModules select _zeus);
		};
		if ("derp_revive" in (getMissionConfigValue "respawnTemplates")) then {
			_unit setVariable ["derp_revive_downed", false, true];
		};
		false
	}
];

[] spawn {
       zeus_1 addEventHandler ["CuratorPinged", {
            params ["_curator", "_unit"];

			private _pingTime = _unit getVariable ["zeusPingTime", 0];
			if (_pingTime == round(time)) exitWith {};
			_unit setVariable ["zeusPingTime", round(time)];
			
            private _curatorFound = allPlayers findIf {_x getVariable ["isZeus", false]};
            if ( _curatorFound == -1 ) exitWith {
                "Zeus is not online at the moment. If you have an urgent matter, notify admins on discord with the !admin command." remoteExecCall ["hint", _unit];
            };

            private _pingLimit = _unit getVariable ["zeusPingLimit", 0];
            _pingLimit = _pingLimit + 1;
            if (_pingLimit > 10) then {
                ["ZEUS PINGED", "You exceeded the maximum amount of times you're allowed to ping zeus."] remoteExecCall ["hintC", _unit];
                [_unit] remoteExecCall ["forceRespawn", _unit];
            } else {
                ["ZEUS PINGED", "Zeus has been made aware of your request. Your ping has been transmitted, and further pings will produce this hint."] remoteExecCall ["hintC", _unit];
            };

            _unit setVariable ["zeusPingLimit", _pingLimit];
            [ _unit ] spawn {
                sleep 60;
                params ["_unit"];
                private _pingLimit = _unit getVariable ["zeusPingLimit", 0];
                _pingLimit = _pingLimit - 1;
                if (_pingLimit > 0) then {
                    _unit setVariable ["zeusPingLimit", _pingLimit];
                };
            };

            private _msg = format ['Zeus was pinged by: %1', _name];
            [Quartermaster, [adminChannelID, _msg]] remoteExecCall ["customChat", getAssignedCuratorUnit _curator, false];

            true
        }];
};
