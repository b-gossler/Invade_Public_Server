//TK message
sendTKhintC = {
	if (player getVariable "isZeus") exitWith {};
	params ["_killed"];
	hintC format ["%1, you just teamkilled %2, which is not allowed. You should apologize to %2.", name player, _killed];
};


turretFunction = {
    params ["_heli", "", ""];
	if ( isNil "_heli" ) exitWith {};
	if !( _heli isKindOf "Heli_Transport_01_base_F" ) exitWith {};

	_turretStatus = _heli getVariable ['turretStatus', true];

	if ( _turretStatus ) then{
	    [_heli, ["LMG_Minigun_Transport", [1]]] remoteExecCall ["removeWeaponTurret", 0, false];
		[_heli, ["LMG_Minigun_Transport2", [2]]] remoteExecCall ["removeWeaponTurret", 0, false];
		systemChat "Turrets disabled. Use this action again to enable turrets.";
		_heli setVariable ['turretStatus', false, true];
	} else {
	    [_heli, ["LMG_Minigun_Transport", [1]]] remoteExecCall ["addWeaponTurret", 0, false];
		[_heli, ["LMG_Minigun_Transport2", [2]]] remoteExecCall ["addWeaponTurret", 0, false];
		systemChat "Turrets enabled. Use this action again to disable turrets.";
		_heli setVariable ['turretStatus', true, true];
	};
};

logFnc = {
    params ["_msg"];
    kickedPlayerList pushBack _msg;
};

kickPlayer = {
    if (hasInterface) exitWith {};
	params ["_name"];
	_serverpassword = [] call getServerPassword;
	_serverpassword serverCommand format ["#kick %1",_name];
};

banPlayer = {
    if (hasInterface) exitWith {};
	params ["_name"];
	_serverpassword = [] call getServerPassword;
	_serverpassword serverCommand format ["#exec ban %1",_name];
};