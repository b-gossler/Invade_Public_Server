/*
author: stanhope, AW community member.
description: code for jets/helis to engage players

Last modified: 5/06/2019 by stanhope
Modified: initial release

params:
0: _jet : vehicle that will be doing the engagement
1: _lowerCounter: lower the global jetCounter when the _jet dies
2: _loiterPos: pos around which the _jet will loiter if it isn't engaging
3: _loiterRadius: radius of the above mentioned loiter
4: _searchRadius: radius in which the jet will search for targets;
*/
params ["_jet", ["_lowerCounter", true], ["_loiterPos", getMarkerPos currentAO],
            ["_loiterRadius", (PARAMS_AOSize*1.5)], ["_searchRadius", (PARAMS_AOSize*2.5)]];

if (isNil "_jet") exitWith {};
private _jetGrp = group (driver _jet);
_jet setVariable ["_loiterPos", _loiterPos];
_jet setVariable ["_loiterRadius", _loiterRadius];

_jet engineOn true;
_jet lock 2;
_jet allowCrewInImmobile true;
_jet setVehicleRadar 1;
_jet setVehicleReceiveRemoteTargets true;
_jet setVehicleReportRemoteTargets true;
_jet setBehaviour "COMBAT";
_jet setCombatMode "RED";
_jet allowFleeing 0;

private _removeAllWaypointsCode = {
    params ["_jet"];
    private _jetGrp = group (driver _jet);

    while {(count (waypoints _jetGrp)) > 0} do{
        deleteWaypoint ((waypoints _jetGrp) select 0);
    };
};
_jet setVariable ["_removeAllWaypointsCode", _removeAllWaypointsCode];

private _loiterwWaypointCode = {
    params ["_jet"];
    private _jetGrp = group (driver _jet);

    private _jetWp = _jetGrp addWaypoint [(_jet getVariable "_loiterPos"),0];
	_jetWp setWaypointType "LOITER";
	_jetWp setWaypointLoiterRadius (_jet getVariable "_loiterRadius");
	_jet flyInHeight (250 + random 250);
	_jet limitSpeed 375;
};
_jet setVariable ["_loiterwWaypointCode", _loiterwWaypointCode];

//EH to make the jet attack stuff that shoots at it
_jet addEventHandler ["IncomingMissile", {
    _this spawn {
        params ["_jet", "", "_shootingVehicle"];

        if (!isDamageAllowed _shootingVehicle) exitWith {};
        if (_jet getVariable ["isEngagingShooter", false]) exitWith {};
        _jet setVariable ["isEngagingShooter", true];

        private _removeAllWaypointsCode = _jet getVariable "_removeAllWaypointsCode";
        [_jet] call _removeAllWaypointsCode;
         private _jetGrp = (group(driver _jet));

        private _attackWP = _jetGrp addWaypoint [getPos _shootingVehicle, -1];

        //if the jet knows about the thing shooting at it engage it.  Otherwise search for it.
        if (_jet knowsAbout _shootingVehicle >= 2) then {
            _attackWP setWaypointType "DESTROY";
            _attackWP waypointAttachObject _shootingVehicle;
            _jetGrp reveal [_shootingVehicle,4];
        } else {
            _attackWP setWaypointType "SAD";
            _attackWP setWaypointPosition [((getPos _shootingVehicle) getPos [(50 + random 100), random 360]) , -1];
        };
        _attackWP setWaypointBehaviour "COMBAT";
        _attackWP setWaypointCombatMode "RED";
        _jet limitSpeed 1000;

        private _timer = 0;
        waitUntil {sleep 5; _timer = _timer + 5; !(alive _jet) || !(alive _shootingVehicle) || _timer > (120 + random(120))};

        if (alive _jet) then {
            _jet setVariable ["isEngagingShooter", false];
            private _loiterwWaypointCode = _jet getVariable "_loiterwWaypointCode";
            [_jet] call _loiterwWaypointCode;
        };
	};
}];

(driver _jet) addEventHandler ["GetOutMan", {
	_this spawn {
	    params ["_unit"];
	    while {alive _unit} do {
	        _unit setDamage (damage _unit + 0.05);
	        sleep 0.2;
	    };
	};
}];

private _entitiesToTarget = [];
switch (true) do {
    case ((_jet isKindOf "Helicopter") || ((typeOf _jet) find "VTOL" != -1)): {
        _entitiesToTarget = ["Helicopter", "Tank", "Ship", "Car", "StaticWeapon", "Man"];
    };
    case (_jet isKindOf "Plane"): {
        _entitiesToTarget = ["Plane", "Helicopter", "Tank", "Ship", "Car", "StaticWeapon"];
    };
    default {
        _entitiesToTarget = ["Plane", "Helicopter", "Tank", "Ship", "Car", "StaticWeapon", "Man"];
    };
};

[_jet] call _removeAllWaypointsCode;
[_jet] call _loiterwWaypointCode;

//main attack loop
while {alive _jet} do {

	//Find someone or something to attack
	private _accepted = false;
	private _target = objNull;

	while {!_accepted} do {
	    if (!alive _jet) exitWith {};
		private _targetList = (_loiterPos) nearEntities [_entitiesToTarget, _searchRadius];
        private _acceptedTargets = [];

        {
            switch (true) do {
                case (!alive _x);
                case (side _x != west);
                case (((east knowsAbout _x) < 2) && ((independent knowsAbout _x) < 2));
                case (!(isPlayer (driver _x)) && !(isPlayer (gunner _x)) && !(isPlayer (commander _x))): {
                    /*Don't add it to the list*/
                };
                default {
                    _acceptedTargets pushBackUnique _x;
                };
            };
            sleep 0.1;
        } forEach _targetList;

		if ( (count _acceptedTargets) > 0) then {
            private _targIndex = -1;
            {
                private _targType = _x;
                _targIndex = _acceptedTargets findIf {_x isKindOf _targType};
                if (_targIndex != -1) exitWith {
                    _target = _acceptedTargets select _targIndex;
                    _accepted = true;
                };
                sleep 0.1;
            } forEach _entitiesToTarget;
		} else {
			sleep 5;
		};

        waitUntil {sleep 1; !(_jet getVariable ["isEngagingShooter", false])};
	};

	if (!alive _jet) exitWith {};

	[_jet] call _removeAllWaypointsCode;
	_jetGrp reveal [_target,4];

	//Attack the target:
	private _laser = "LaserTargetW" createVehicle (getPos _target);
	_laser attachTo [_target,[0,0,0]];
	_jet doTarget _target;

	private _attackWP = _jetGrp addWaypoint [getPos _target, -1];
    _attackWP setWaypointType "DESTROY";
    _attackWP waypointAttachObject _target;
    _attackWP setWaypointBehaviour "COMBAT";
    _attackWP setWaypointCombatMode "RED";
    _attackWP setWaypointTimeout [120, 240, 300];
    _jet limitSpeed 1000;

	//Let him continiue attacking for the duration of the timeout or until the target or the jet is dead
	private _timer = 0;
	waitUntil {_timer = _timer + 5; sleep 5; !(alive _jet) || !(alive _target) || _timer > (120 + random(120)) || _jet getVariable ["isEngagingShooter", false]};
	waitUntil {sleep 1; !(_jet getVariable ["isEngagingShooter", false])};

	//delete the current waipoints of the jet and the laser:
	deleteVehicle _laser;
	if (!alive _jet) exitWith {};

	[_jet] call _removeAllWaypointsCode;

	//let him loiter for 2 minutes then attack the next thing
	[_jet] call _loiterwWaypointCode;
	
	sleep 120;
	waitUntil {sleep 1; !(_jet getVariable ["isEngagingShooter", false])};
};

if (_lowerCounter) then {
    jetCounter = jetCounter - 1;
    publicVariableServer "jetCounter";
};