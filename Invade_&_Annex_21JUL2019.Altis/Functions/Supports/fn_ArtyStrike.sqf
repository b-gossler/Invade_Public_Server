/*
Author: BACONMOP

Example:
_pos = getPos Player;
_unit = arty;
[_unit,_pos] call AW_fnc_artyStrike;

Parameters:
1. Unit that will fire.
2. Target Location.
*/
params ["_arty", "_pos"];
_arty setVehicleAmmo 1;
private _amount = _arty ammo (currentWeapon _arty);
private _shotsFired = floor (random _amount);
if (_shotsFired < 3) then {
	_shotsFired = 3;
};
private _ammo = (getArtilleryAmmo [_arty] select 0);
private _randomPos = [_pos, 5, 15, 0, 0, 0.5, 0, [], (_pos)] call BIS_fnc_findSafePos;
private _redSmoke = "SmokeShellRed" createVehicle [_randomPos select 0, _randomPos select 1, (_randomPos select 2) + 10];
_arty commandArtilleryFire [_pos, _ammo, _shotsFired];