/*
author: stanhope
Description: Function that pushes a given vehicle into the RespawnVehiclesArray (scripts/vehicle/vehiclerespawn.sqf) array
*/
if (!isServer) exitWith {}; // GO AWAY PLAYER

params ["_vehicle", "_delay", "_setup", "_init", ["_base", "BASE"]];

_vehicle lock 2;
[_vehicle] spawn AW_fnc_vSetup02;

waitUntil {sleep 1; !isNil "RespawnVehiclesArray"};

sleep 2;
private _toPushBack = [_vehicle, typeOf _vehicle, getPosWorld _vehicle, getDir _vehicle, _delay, nil, _base];
_vehicle lock 0;

RespawnVehiclesArray pushBack _toPushBack;