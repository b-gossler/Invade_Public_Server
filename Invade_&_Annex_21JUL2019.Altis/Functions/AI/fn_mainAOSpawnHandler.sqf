#include "unitDefines.hpp"
/*
Author: alganthe
Description: Handles creating the AI

last edited: 18/8/2017 by stanhope
edited: rewrote most of it, crippeled the params

Return Value: Array of units created

*/
params ["_AOpos", ["_radiusSize", derp_PARAM_AOSize]];

private _spawnedUnits = [];
private _AISkillUnitsArray = [];

//Determine how many units to spawn:
_amountOfPlayers = count allPlayers;
private ["_MBTs","_AAVics","_IFVs","_Cars","_mainInf","_AAinf","_ATinf","_recon","_helis","_jet"];

switch true do {
	case (_amountOfPlayers <= 10):{
		_MBTs = 1;
		_AAVics = 1;
		_IFVs = 1;
		_Cars = 1;
		_mainInf = 3;
		_AAinf = 1;
		_ATinf = 1;
		_recon = 1;
		_helis = 0;
		_jet = false;
	};
	case (_amountOfPlayers > 10 && _amountOfPlayers <= 20):{
		_MBTs = 1;
		_AAVics = (1 + round (random 1));
		_IFVs = (1 + round (random 1));
		_Cars = (1 + round (random 1));
		_mainInf = 5;
		_AAinf = 1;
		_ATinf = 1;
		_recon = 2;
		_helis = 0;
		_jet = false;
	};
	case (_amountOfPlayers > 20 && _amountOfPlayers <= 30):{
		_MBTs = 1;
		_AAVics = (1 + round (random 1));
		_IFVs = (1 + round (random 1));
		_Cars = (1 + round (random 2));
		_mainInf = 5;
		_AAinf = 2;
		_ATinf = 2;
		_recon = 1;
		_helis = 0;
		_jet = selectRandom[true, false, false];
	};
	case (_amountOfPlayers > 30 && _amountOfPlayers <= 40):{
		_MBTs = 1;
		_AAVics = 2;
		_IFVs = 2;
		_Cars = 3;
		_mainInf = 6;
		_AAinf = 2;
		_ATinf = 2;
		_recon = 2;
		_helis = 0;
		_jet = selectRandom[true, false, false];
	};
	case (_amountOfPlayers > 40 && _amountOfPlayers <= 50):{
		_MBTs = 1;
		_AAVics = (2 + round (random 1));
		_IFVs = (2 + round (random 1));
		_Cars = (3 + round (random 1));
		_mainInf = 7;
		_AAinf = 2;
		_ATinf = 2;
		_recon = 3;
		_helis = 1;
		_jet = selectRandom[true, true, false];
	};
	case (_amountOfPlayers > 50):{
		_MBTs = 2;
		_AAVics = (2 + round (random 2));
		_IFVs = (2 + round (random 2));
		_Cars = (3 + round (random 2));
		_mainInf = 8;
		_AAinf = 3;
		_ATinf = 3;
		_recon = 4;
		_helis = 2;
		_jet = true;
	};
};



private ["_randomPos","_grp1"];
///////////////////////////// VEHILCE SPAWN /////////////////////////////////////

//=============MBT:
private _MBTAmount = 1;

private _mbtList = ["O_MBT_02_cannon_F", "O_MBT_02_cannon_F", "O_MBT_04_cannon_F", "O_MBT_04_command_F"];

for "_i" from 1 to _MBTs do {
	_randomPos = [_AOpos, 0, _radiusSize, 5, 0, 0.4, 0, [], _AOpos] call BIS_fnc_findSafePos;
	private _MBT = createVehicle [(selectRandom _mbtList), _randomPos, [], 5, "NONE"];

	_grp1 = createGroup east;
	createVehicleCrew _MBT;
	(crew _MBT) join _grp1;
	_grp1 setGroupIdGlobal [format ['AO-MBT-%1', _MBTAmount]];
	_MBTAmount = _MBTAmount + 1;
	_MBT lock 3;
	_MBT allowCrewInImmobile true;
	[_grp1, _AOpos, _radiusSize] call AW_fnc_taskCircPatrol;

	_spawnedUnits pushBack _MBT;
	{
		_spawnedUnits pushBack _x;
		_AISkillUnitsArray pushBack _x;
	 } forEach (crew _MBT);
	 {_x addCuratorEditableObjects [[_MBT] + crew _MBT, true];} forEach allCurators;
};

//============= AA vehicles
private _AAVicAmount = 1;
for "_i" from 1 to _AAVics do {
	_randomPos = [_AOpos, 0, _radiusSize, 5, 0, 0.4, 0, [], _AOpos] call BIS_fnc_findSafePos;
	private _AAVic = createVehicle ["O_APC_Tracked_02_AA_F", _randomPos, [], 5, "NONE"];
	
	_grp1 = createGroup east;
	createVehicleCrew _AAVic;
	(crew _AAVic) join _grp1;
	_grp1 setGroupIdGlobal [format ['AO-AAVehicle-%1', _AAVicAmount]];
	_AAVicAmount = _AAVicAmount + 1;
	_AAVic lock 3;
	_AAVic allowCrewInImmobile true;
	_AAVic setVehicleRadar 1;
	_AAVic setVehicleReportRemoteTargets false;
	[_grp1, _AOpos, _radiusSize] call AW_fnc_taskCircPatrol;
	
	_spawnedUnits pushBack _AAVic;
	{
		_spawnedUnits pushBack _x;
		_AISkillUnitsArray pushBack _x;
	 } forEach (crew _AAVic);
	 {_x addCuratorEditableObjects [[_AAVic] + crew _AAVic, true];} forEach allCurators;
};

//========== IFV/APCs
private _IFVAmount = 1;
for "_i" from 1 to _IFVs do {

	private _randomPos = [_AOpos, 0, _radiusSize, 5, 0, 0.4, 0, [], _AOpos] call BIS_fnc_findSafePos;
	private _vehicleType = selectRandom ["O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_cannon_F","I_APC_tracked_03_cannon_F", "I_LT_01_AT_F", "I_LT_01_AA_F", "I_LT_01_cannon_F"];
	private _IFV = createVehicle [_vehicleType, _randomPos, [], 5, "NONE"];
	
	private _grp1 = createGroup east;
	private _dummyUnit = "O_Soldier_VR_F" createVehicle [0,0,0];
	createVehicleCrew _IFV;
	(crew _IFV) join _grp1;
	deleteVehicle _dummyUnit;
	_grp1 setGroupIdGlobal [format ['AO-IFV/APC-%1', _IFVAmount]];
	_IFVAmount = _IFVAmount + 1;
	_IFV lock 3;
	_IFV allowCrewInImmobile true;
	_IFV setVehicleRadar 1;
	_IFV setVehicleReportRemoteTargets false;
	[_grp1, _AOpos, _radiusSize] call AW_fnc_taskCircPatrol;
	
	_spawnedUnits pushBack _IFV;
	{
		_spawnedUnits pushBack _x;
		_AISkillUnitsArray pushBack _x;
	 } forEach (crew _IFV);
	 {_x addCuratorEditableObjects [[_IFV] + crew _IFV, true];} forEach allCurators;
};

//==================== MRAP/car
private _CarAmount = 1;
for "_i" from 1 to _Cars do {
	private ["_car", "_turret"];
	_randomPos = [_AOpos, 0, _radiusSize, 5, 0, 0.4, 0, [], _AOpos] call BIS_fnc_findSafePos;
	_vehicleType = selectRandom ["O_MRAP_02_gmg_F","O_MRAP_02_gmg_F","O_MRAP_02_hmg_F","O_MRAP_02_hmg_F","O_MRAP_02_hmg_F","O_LSV_02_armed_F","O_LSV_02_armed_F","O_G_Offroad_01_armed_F","O_Truck_03_transport_F"];
	
	_grp1 = createGroup east;
	switch (_vehicleType) do {
		case "O_Truck_03_transport_F": {
			_turretType = selectRandom ["O_HMG_01_high_F","O_GMG_01_high_F","O_Mortar_01_F","O_static_AA_F","O_static_AT_F"];
			_car = createVehicle [_vehicleType, _randomPos, [], 5, "NONE"];
			_turret = createVehicle [_turretType, _randomPos, [], 5, "NONE"];
			_car setDir 0;
			_turret attachTo [_car,[0,-3.4,0.6]];
			_turret setDir 180;
			createVehicleCrew _car;
			(crew _car) join _grp1;
			createVehicleCrew _turret;
			(crew _turret) join _grp1;
			_turret lock 3;
			_turret allowCrewInImmobile true;
			{_x addCuratorEditableObjects [[_turret], true];} forEach allCurators;
			_spawnedUnits pushBack _turret;
		};
		default {
			_car = createVehicle [_vehicleType, _randomPos, [], 5, "NONE"];
			createVehicleCrew _car;
			(crew _car) join _grp1;
		};
	};
	_grp1 setGroupIdGlobal [format ['AO-MRAP/Car-%1', _CarAmount]];
	_CarAmount = _CarAmount + 1;
	_car lock 3;
	_car allowCrewInImmobile true;
	[_grp1, _AOpos, _radiusSize] call AW_fnc_taskCircPatrol;
	
	_spawnedUnits pushBack _car;
	{
		_spawnedUnits pushBack _x;
		_AISkillUnitsArray pushBack _x;
	 } forEach (units _grp1);
	 {_x addCuratorEditableObjects [[_car] + units _grp1, true];} forEach allCurators;
};

/////////////////////////////// AIR assets ////////////////////////////////
/*Attack helo*/
if (_helis != 0) then {
	private _aircount = 1;
	for "_i" from 1 to _helis do {
		private _randomPos = [_AOpos, 0, _radiusSize, 5, 0, 0.4, 0, [], _AOpos] call BIS_fnc_findSafePos;
		_randomPos = [_randomPos select 0, _randomPos select 1, 100];
		
		_vehicleType = selectRandom ["O_Heli_Attack_02_dynamicLoadout_F", "O_T_VTOL_02_infantry_dynamicLoadout_F",
		"O_Heli_Light_02_dynamicLoadout_F","O_Heli_Light_02_dynamicLoadout_F","O_Heli_Light_02_dynamicLoadout_F","O_Heli_Light_02_dynamicLoadout_F",
		"I_Heli_light_03_dynamicLoadout_F","I_Heli_light_03_dynamicLoadout_F","I_Heli_light_03_dynamicLoadout_F","I_Heli_light_03_dynamicLoadout_F"];
		private _heli = createVehicle [_vehicleType, _randomPos, [], 5, "FLY"];
		
		_grp1 = createGroup east;
		createVehicleCrew _heli;
		(crew _heli) join _grp1;
		_grp1 setGroupIdGlobal [format ['AO-heli-%1', _aircount]];
		_aircount = _aircount + 1;
		_heli lock 3;
		_heli allowCrewInImmobile true;
		_heli flyInHeight 50;
		_heli limitSpeed 150;
		[_heli, false, getMarkerPos currentAO, (PARAMS_AOSize * (0.5 + (random 0.5)))] spawn AW_fnc_enemyAirEngagement;
		
		{
			_spawnedUnits pushBack _x;
			_AISkillUnitsArray pushBack _x;
		 } forEach (units _grp1) + [_heli];
		 {_x addCuratorEditableObjects [[_heli] + (units _grp1), true];} forEach allCurators;
	};
};
/*optional RT jet without RT*/
if (_jet) then {
	[] spawn {
		if (jetCounter < 3) then {
			[] call AW_fnc_airfieldJet;
		};
	};
};

//////////////////////////////// INFANTRY groups /////////////////////////////////
mainAoPatrolDistance = _radiusSize/10;

//================= Main inf force
[_AOpos, _radiusSize, _mainInf] spawn {
    sleep (1 + random 2);
    params ["_AOpos", "_radiusSize", "_mainInf"];
    private _AISkillUnitsArray = [];

    private _MainInfAmount = 1;
    for "_i" from 1 to _mainInf do {
    	private ["_Faction","_normalInfGroup","_infteamPatrol"];
    	_Faction = selectRandom ["OPF_F","OPF_F","OPF_T_F"];
    	if (_Faction == "OPF_F") then {
    		_normalInfGroup = selectRandom ["OIA_InfAssault","OIA_InfSquad","OIA_InfSquad_Weapons","OIA_InfTeam","OIA_GuardSquad","OIA_GuardTeam"];
    		/*OI_reconPatrol OI_reconTeam OI_SniperTeam OIA_InfTeam_AA OIA_InfTeam_AT OIA_ReconSquad OI_ViperTeam OI_support_MG*/
    	} else {
    		_normalInfGroup = selectRandom ["O_T_InfSquad","O_T_InfSquad_Weapons","O_T_InfTeam"];
    		/*O_T_InfTeam_AA O_T_InfTeam_AT O_T_reconPatrol O_T_reconSentry O_T_reconTeam O_T_SniperTeam O_T_ViperTeam O_T_support_MG*/
    	};

    	_randomPos = [_AOpos, 0, _radiusSize, 5, 0, 0.4, 0, [], _AOpos] call BIS_fnc_findSafePos;
    	switch (_normalInfGroup) do {
    		//normal infantry groups
    		case "O_T_InfSquad";
    		case "O_T_InfSquad_Weapons";
    		case "O_T_InfTeam";
    		case "OIA_InfAssault";
    		case "OIA_InfSquad";
    		case "OIA_InfSquad_Weapons";
    		case "OIA_InfTeam": {_infteamPatrol = [_randomPos, east, (configFile >> "CfgGroups" >> "East" >> _Faction >> "Infantry" >> _normalInfGroup)] call BIS_fnc_spawnGroup;};
    		//guard inf
    		case "OIA_GuardTeam";
    		case "OIA_GuardSquad": {_infteamPatrol = [_randomPos, east, (configFile >> "CfgGroups" >> "East" >> _Faction >> "UInfantry" >> _normalInfGroup)] call BIS_fnc_spawnGroup;};
    		default {diag_log "ERROR: fn_mainAOSpawnHandler.sqf: main infantry group spawn.  Group was not recognized"};
    	};
    	mainAoPatrolDistance = mainAoPatrolDistance + 25 + floor(random (75));
    	if (mainAoPatrolDistance > _radiusSize*1.2) then {mainAoPatrolDistance = _radiusSize/10 + 25 + floor(random (75));};
    	[_infteamPatrol, _AOpos, mainAoPatrolDistance] call AW_fnc_taskCircPatrol;
    	_infteamPatrol setGroupIdGlobal [format ['AO-MainInf-%1', _MainInfAmount]];
    	_MainInfAmount = _MainInfAmount + 1;
    	{
    		mainAOUnits pushBack _x;
    		_AISkillUnitsArray pushBack _x;
    	} forEach (units _infteamPatrol);
    	{_x addCuratorEditableObjects [units _infteamPatrol, true];} forEach allCurators;

    	sleep 0.5;
    };

    [_AISkillUnitsArray] call derp_fnc_AISkill;
};

//======================== AA groups
[_AOpos, _radiusSize, _AAinf] spawn {
    sleep (3 + random 2);
    params ["_AOpos", "_radiusSize", "_AAinf"];
    private _AISkillUnitsArray = [];

    private _AAInfAmount = 1;
    for "_x" from 1 to _AAinf do {
    	private ["_Faction","_normalInfGroup","_infteamPatrol"];
    	_Faction = selectRandom ["OPF_F","OPF_F","OPF_T_F"];
    	if (_Faction == "OPF_F") then { _normalInfGroup = "OIA_InfTeam_AA";}
    							 else { _normalInfGroup = "O_T_InfTeam_AA";};

    	_randomPos = [_AOpos, 0, _radiusSize, 5, 0, 0.4, 0, [], _AOpos] call BIS_fnc_findSafePos;
    	_infteamPatrol = [_randomPos, east, (configFile >> "CfgGroups" >> "East" >> _Faction >> "Infantry" >> _normalInfGroup)] call BIS_fnc_spawnGroup;

    	_infteamPatrol setGroupIdGlobal [format ['AO-AAInf-%1', _AAInfAmount]];
    	_AAInfAmount = _AAInfAmount + 1;

    	mainAoPatrolDistance = mainAoPatrolDistance + 25 + floor(random (75));
    	if (mainAoPatrolDistance > _radiusSize*1.2) then {mainAoPatrolDistance = _radiusSize/10 + 25 + floor(random (75));};
    	[_infteamPatrol, _AOpos, mainAoPatrolDistance] call AW_fnc_taskCircPatrol;

    	{
    		mainAOUnits pushBack _x;
    		_AISkillUnitsArray pushBack _x;
    	} forEach (units _infteamPatrol);
    	{_x addCuratorEditableObjects [units _infteamPatrol, true];} forEach allCurators;

    	sleep 0.5;
    };

    [_AISkillUnitsArray] call derp_fnc_AISkill;
};

//============================= AT groups
[_AOpos, _radiusSize, _ATinf] spawn {
    sleep (3 + random 2);
    params ["_AOpos", "_radiusSize", "_ATinf"];
    private _AISkillUnitsArray = [];

    private _ATInfAmount = 1;
    for "_x" from 1 to _ATinf do {
    	private ["_Faction","_normalInfGroup","_infteamPatrol"];
    	_Faction = selectRandom ["OPF_F","OPF_F","OPF_T_F"];
    	if (_Faction == "OPF_F") then { _normalInfGroup = "OIA_InfTeam_AT";}
    							 else { _normalInfGroup = "O_T_InfTeam_AT";};

    	_randomPos = [_AOpos, 0, _radiusSize, 5, 0, 0.4, 0, [], _AOpos] call BIS_fnc_findSafePos;
    	_infteamPatrol = [_randomPos, east, (configFile >> "CfgGroups" >> "East" >> _Faction >> "Infantry" >> _normalInfGroup)] call BIS_fnc_spawnGroup;

    	_infteamPatrol setGroupIdGlobal [format ['AO-ATInf-%1', _ATInfAmount]];
    	_ATInfAmount = _ATInfAmount + 1;

    	mainAoPatrolDistance = mainAoPatrolDistance + 25 + floor(random (75));
    	if (mainAoPatrolDistance > _radiusSize*1.2) then {mainAoPatrolDistance = _radiusSize/10 + 25 + floor(random (75));};
    	[_infteamPatrol, _AOpos, mainAoPatrolDistance] call AW_fnc_taskCircPatrol;

    	{
    		mainAOUnits pushBack _x;
    		_AISkillUnitsArray pushBack _x;
    	} forEach (units _infteamPatrol);
    	{_x addCuratorEditableObjects [units _infteamPatrol, true];} forEach allCurators;

    	sleep 0.5;
    };

    [_AISkillUnitsArray] call derp_fnc_AISkill;
};

//====================== recon units
[_AOpos, _radiusSize, _recon] spawn {
    sleep (4 + random 2);
    params ["_AOpos", "_radiusSize", "_recon"];
    private _AISkillUnitsArray = [];

    private _reconAmount = 1;
    for "_i" from 1 to _recon do {
    	private ["_Faction","_normalInfGroup","_infteamPatrol"];
    	_Faction = selectRandom ["OPF_F","OPF_F","OPF_T_F"];
    	if (_Faction == "OPF_F") then {
    		_normalInfGroup = selectRandom ["OI_reconPatrol","OI_reconTeam","OIA_ReconSquad","OI_ViperTeam","OI_ViperTeam"];
    	} else {
    		_normalInfGroup = selectRandom ["O_T_reconPatrol","O_T_reconTeam","O_T_ViperTeam","O_T_ViperTeam"];
    	};

    	_randomPos = [_AOpos, 0, _radiusSize, 5, 0, 0.4, 0, [], _AOpos] call BIS_fnc_findSafePos;
    	switch (_normalInfGroup) do {
    		case "O_T_ViperTeam";
    		case "OI_ViperTeam": {_infteamPatrol = [_randomPos, east, (configFile >> "CfgGroups" >> "East" >> _Faction >> "SpecOps" >> _normalInfGroup)] call BIS_fnc_spawnGroup;};
    		case "OI_reconPatrol";
    		case "OI_reconTeam";
    		case "O_T_reconPatrol";
    		case "O_T_reconTeam";
    		case "OIA_ReconSquad": {_infteamPatrol = [_randomPos, east, (configFile >> "CfgGroups" >> "East" >> _Faction >> "Infantry" >> _normalInfGroup)] call BIS_fnc_spawnGroup;};
    		default {diag_log "ERROR: fn_mainAOSpawnHandler.sqf: recon infantry group spawn.  Group was not recognized"};
    	};

    	mainAoPatrolDistance = (_radiusSize* 1.1) - random(_radiusSize*0.2);
    	[_infteamPatrol, _AOpos, mainAoPatrolDistance] call AW_fnc_taskCircPatrol;
    	_infteamPatrol setGroupIdGlobal [format ['AO-reconGroup-%1', _reconAmount]];
    	_reconAmount = _reconAmount + 1;
    	{
    		mainAOUnits pushBack _x;
    		_AISkillUnitsArray pushBack _x;
    	} forEach (units _infteamPatrol);
    	{_x addCuratorEditableObjects [units _infteamPatrol, true];} forEach allCurators;

    	sleep 0.5;
    };

    [_AISkillUnitsArray] call derp_fnc_AISkill;
};

//=================Garrison inf===========================
[_AOpos, _radiusSize] spawn {
    sleep (5 + random 2);
    params ["_AOpos", "_radiusSize"];
    private _AISkillUnitsArray = [];
    
    private _milBuildingsarray = nearestObjects [_AOpos, ["house","building"], _radiusSize*0.5];
    private _milBuildingCount = count _milBuildingsarray;
    private _garrisongroupamount = 0;
    if (_milBuildingCount > 0) then{
    
    	if (_milBuildingCount > 15) then{_milBuildingCount = 15;};
    
    	for "_i" from 1 to _milBuildingCount do {
    		private _infBuilding = selectRandom _milBuildingsarray;
    		_milBuildingsarray = _milBuildingsarray - [_infBuilding];
    		private _infbuildingpos = _infBuilding buildingPos -1;
    		private _buildingposcount = count _infbuildingpos;
    		if (_buildingposcount > 12 ) then {_buildingposcount = 12};
    		
    		_garrisongroupamount = _garrisongroupamount + 1;
    		private _garrisongroup = createGroup east;
    		_garrisongroup setGroupIdGlobal [format ['AO-GarrisonInf-%1', _garrisongroupamount]];
    		
    		if (_buildingposcount > 0) then{
    			for "_i" from 1 to _buildingposcount do {
    				private _unitpos = selectRandom _infbuildingpos;
    				_infbuildingpos = _infbuildingpos - [_unitpos];
    				private _unitArray = (missionConfigFile >> "unitList" >> MainFaction >> "units") call BIS_fnc_getCfgData;
    				private _unittype = selectRandom _unitArray;
    				private _unit = _garrisongroup createUnit [_unittype, _unitpos, [], 0, "CAN_COLLIDE"];
    				_unit disableAI "PATH";
    			};
    		};
    		{
    			mainAOUnits pushBack _x;
    			_AISkillUnitsArray pushBack _x;
    		} forEach (units _garrisongroup);
    		{_x addCuratorEditableObjects [units _garrisongroup, true];} forEach allCurators;

    		sleep 0.5;
    	};
    };
    
    [_AISkillUnitsArray] call derp_fnc_AISkill;
};

[_AISkillUnitsArray] spawn {
    params ["_AISkillUnitsArray"];
	[_AISkillUnitsArray] call derp_fnc_AISkill;
};

_spawnedUnits