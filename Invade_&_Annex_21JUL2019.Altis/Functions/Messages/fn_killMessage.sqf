/*
Author: Unknown

Description: 
	Gets a bunch of params from derp revive about the killer and puts those into a some nice string.  Next print that string in both sidechat and admin channel.

Last edited: 23/02/2019 by stanhope

edited: reworked to fix a few bugs with it hopefully
*/

private ["_simpleTKMessage","_longTKMessage"];

//get params
params ["_killedObj","_sourceObj","_projectile","_instigatorObj"];

//get some additional things for the reporting
private _killedName = name _killedObj;
private _killedVehicle = typeOf (vehicle _killedObj);
private _killedVehicleName = getText( configFile >> "CfgVehicles" >> _killedVehicle >> "DisplayName" );
private _killedUID = getPlayerUID _killedObj;

private _killerName = name _sourceObj;
private _sourceVehicleType = typeOf (vehicle _sourceObj);
private _sourceVehicleName = getText( configFile >> "CfgVehicles" >> _sourceVehicleType >> "DisplayName" );
private _killerUID = getPlayerUID _sourceObj;

private _instigatorName = name _instigatorObj;
private _instigatorObjVehicleType = typeOf (vehicle _instigatorObj);
private _instigatorVehicleName = getText( configFile >> "CfgVehicles" >> _instigatorObjVehicleType >> "DisplayName" );
private _instigatorUID = getPlayerUID _instigatorObj;

//=============First check if the person isn't killing himself==============
if (
	_killedName == _killerName || _killedName == _instigatorName 
	|| _killedObj == _sourceObj || _killedObj == _instigatorObj
	|| _killedUID == _killerUID || _killedUID == _instigatorUID
) exitWith{
	_simpleTKMessage = format["%1 killed himself", _killedName];
	[Quartermaster, _simpleTKMessage] remoteExecCall ["sideChat", 0, false];
	_longTKMessage = format["%1 killed himself with weapon: %2. Vehicle of the TKer: %3",_killedName,_projectile, _sourceVehicleName];
	[Quartermaster, [adminChannelID, _longTKMessage]] remoteExecCall ["customChat", 0, false];
};

//=============Check if it's a zeus TKing
private _zeusUIDs = zeusAdminUIDs + zeusModeratorUIDs + zeusSpartanUIDs;

if (_zeusUIDs find _instigatorUID != -1 || _zeusUIDs find _killerUID != -1 || _sourceObj getVariable "isZeus" || _instigatorObj getVariable "isZeus" || (driver _sourceObj) getVariable "isZeus") exitWith {
	_longTKMessage = format["%1 got killed by zeus: %2 (%3).  Weapon used: %4. Vehicle of TKer: %5 (%6)",_killedName,_killerName,_instigatorName,_projectile, _sourceVehicleName,_instigatorVehicleName];
	[Quartermaster, [adminChannelID, _longTKMessage]] remoteExecCall ["customChat", 0, false];
};

//==================normal case
if (_instigatorName != "Error: No vehicle" && _instigatorName != "Error: No unit") exitWith {

	[_killedName] remoteExecCall ["sendTKhintC", _instigatorObj, false];
	[] remoteExecCall ["playerTKed", _instigatorObj, false];
	
	if ( !(_killerUID in _zeusUIDs)) then {
		_simpleTKMessage = format["%1 teamkilled by %2",_killedName,_instigatorName];
		[Quartermaster, _simpleTKMessage] remoteExecCall ["sideChat", 0, false];
	};
	
	_longTKMessage = format["%1 got killed by: %2.  Weapon used: %3. Vehicle of TKer: %4",_killedName,_instigatorName,_projectile, _instigatorVehicleName];
	[Quartermaster, [adminChannelID, _longTKMessage]] remoteExecCall ["customChat", 0, false];
	
	_arrayMessage = format[
		"TKScript: TKer: %5, vehicle %6 (%7) sourceVehicle: %10, UID: %8, Projectile: %9; TKed: %1, vehicle %2 (%3), UID: %4; ",
		_killedName, _killedVehicleName ,_killedVehicle, _killedUID,
		_killerName,_instigatorVehicleName,_instigatorObjVehicleType, _instigatorUID,
		_projectile, _sourceVehicleType
	];
	
	[_arrayMessage] remoteExecCall ["diag_log", 2];
};

if (_instigatorName == "Error: No vehicle" || _instigatorName == "Error: No unit") exitWith{

	if (_killerName == "Error: No vehicle" || _killerName == "Error: No unit") exitWith {};
		
	[_killedName] remoteExecCall ["sendTKhintC", _sourceObj, false];
	[] remoteExecCall ["playerTKed", _sourceObj, false];
	
	if ( !(_killerUID in _zeusUIDs)) then {
		_simpleTKMessage = format["%1 teamkilled by someone in %2s vehicle",_killedName,_killerName];
		[Quartermaster, _simpleTKMessage] remoteExecCall ["sideChat", 0, false];
	};
	_longTKMessage = format["%1 got killed by: %2.  Weapon used: %3. Vehicle of TKer: %4",_killedName,_killerName,_projectile, _sourceVehicleName];
	[Quartermaster, [adminChannelID, _longTKMessage]] remoteExecCall ["customChat", 0, false];
	
	_arrayMessage = format[
		"TKScript: TKer: %5, vehicle %6 (%7), UID: %8, Projectile: %9; TKed: %1, vehicle %2 (%3), UID: %4; ",
		_killedName, _killedVehicleName ,_killedVehicle, _killedUID,
		_killerName,_sourceVehicleName,_sourceVehicleType, _killerUID,
		_projectile
	];
	
	[_arrayMessage] remoteExecCall ["diag_log", 2];
};
