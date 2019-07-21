/*
author: McKillen

description: spawns an HQ sub-obj

Last modified: 16/11/2017 by stanhope
Modified: /
*/
jetCounter = 0;
publicVariable "jetCounter";

private _flatPos = [getMarkerPos currentAO, 10, PARAMS_AOSize, 5, 0, 0.1, 0, [], [0,0,0]] call BIS_fnc_findSafePos;
private _roughPos =[((_flatPos select 0) - 200) + (random 400),((_flatPos select 1) - 200) + (random 400),0];

//adds in a HQ building and adds an event handler to the officer inside it
private _HqBuilding = "Land_Cargo_HQ_V1_F" createVehicle _flatPos;

private _HQpos = _HqBuilding buildingPos -1;
private _officerPos = _HQpos select 0;
_HQpos = _HQpos - [_officerPos];


private _garrisongroup = createGroup east;
_garrisongroup setGroupIdGlobal [format ['AO-subobjgroup']];
private _officer = _garrisongroup createUnit ["O_officer_F", _officerPos, [], 0, "CAN_COLLIDE"];

_officer disableAI "PATH";
removeAllWeapons _officer;
_officer addMagazine "6Rnd_45ACP_Cylinder";
_officer addWeapon "hgun_Pistol_heavy_02_F";
_officer addMagazine "6Rnd_45ACP_Cylinder";
_officer addMagazine "6Rnd_45ACP_Cylinder";

_officer addEventHandler ["Killed",
    {
        params ["_unit","","_killer"];
        _name = name _killer;
		if (_name == "Error: No vehicle") then{
			_name = "someone";
		};
		_aoName = (missionConfigFile >> "Main_Aos" >> "AOs" >> currentAO >> "name") call BIS_fnc_getCfgData;
        _targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>Complete</t><br/>____________________<br/>Good job everyone, %2 neutralised the officer. OPFOR should find it harder to co-ordinate their attacks in %1.",_aoName,_name];
        [_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];
    }
];

{ _x setMarkerPos _roughPos; } forEach ["radioMarker","radioCircle"];
"radioMarker" setMarkerText "Sub-Objective: HQ Building";
_targetStartText = format["<t align='center' size='2.2'>Sub-Objective</t><br/><t size='1.5' align='center' color='#FFCF11'>HQ Building</t><br/>____________________<br/>OPFOR have set up an HQ building in the AO. Inside is an officer, neutralise him using any force necessary<br/><br/>"];
[_targetStartText] remoteExec ["AW_fnc_globalHint",0,false];

[west,["SubAoTask","MainAoTask"],["OPFOR have set up an HQ building in the AO. Inside is an officer, neutralise him using any force necessary","HQ Building","radioMarker"],(getMarkerPos "radioMarker"),"Created",0,true,"destroy",true] call BIS_fnc_taskCreate;
private _infunits = ["O_Soldier_LAT_F", "O_soldier_M_F", "O_Soldier_TL_F", "O_Soldier_AR_F", "O_Soldier_GL_F", "O_Soldier_F", "O_Soldier_F", "O_Soldier_F"];

private _Garrisonpos = count _HQpos;
for "_i" from 1 to _Garrisonpos do {
    _unitpos = selectRandom _HQpos ;
    _HQpos = _HQpos - [_unitpos];
    _unittype = selectRandom _infunits;
    _unit = _garrisongroup createUnit [_unittype, _unitpos, [], 0, "CAN_COLLIDE"];
    _unit disableAI "PATH";
    sleep 0.1;
};
{_x addCuratorEditableObjects [units _garrisongroup, false];} forEach allCurators;

[_officer]spawn {
    params ["_officer"];
    sleep (30 + (random 60));
    while {(alive _officer)} do {
        if (jetCounter < 3) then {
            [] spawn AW_fnc_airfieldJet;
        };
       sleep (720 + (random 480));
    };
};

mainAOUnits = mainAOUnits + units _garrisongroup + [_HqBuilding];

waitUntil {sleep 3; !alive _officer};

["SubAoTask", "Succeeded",true] call BIS_fnc_taskSetState;
sleep 5;

if (isNil "_HqBuilding") then {
    private _bld = (nearestObject [_roughPos, "Land_Cargo_HQ_V1_ruins_F"]);
    if (!isNil "_bld") then {
        mainAOUnits = mainAOUnits + [_bld];
    };
};

["SubAoTask",west] call bis_fnc_deleteTask;
{ _x setMarkerPos [-10000,-10000,-10000]; } forEach ["radioMarker","radioCircle"];