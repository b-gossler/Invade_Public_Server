/*
	Author: ansin11
	Description: restriction for vehicle gunner seats and static weapons
	
	Last modified by stanhope
	Modified: eased of restrictions a bit + rewrote a bit.
*/

if (player getVariable ["isZeus", false]) exitWith{/*I honestly don't care in which gunner seat a zeus gets, they're big boys I'm sure they won't abuse it.*/};

private _vehicleObject = vehicle player;

if (player == gunner _vehicleObject) then {
	
	private _restrictedVehiclesLightArray = [
		"B_G_Offroad_01_AT_F", //FIA (West) Offroad AT
		"O_G_Offroad_01_AT_F", //FIA (East) Offroad AT
		"I_G_Offroad_01_AT_F", //FIA (Independent) Offroad AT
		"I_C_Offroad_02_AT_F" //Syndikat MB 4WD AT
	];
	private _restrictedVehiclesHeavyArray = [
		"B_LSV_01_AT_F", //NATO Prowler AT
		"B_T_LSV_01_AT_F", //NATO (Pacific) Prowler AT
		"O_LSV_02_AT_F", //CSAT Qilin AT
		"O_T_LSV_02_AT_F" //CSAT (Pacific) Qilin AT
	];
	private _restrictedStaticLaunchersArray = [
		"B_static_AA_F",//NATO Static Titan AA
		"B_static_AT_F",//NATO Static Titan AT
		"B_T_Static_AA_F",//NATO (Pacific) Static Titan AA
		"B_T_Static_AT_F",//NATO (Pacific) Static Titan AT
		"O_static_AA_F",//CSAT Static Titan AA
		"O_static_AT_F",//CSAT Static Titan AT
		"I_static_AA_F",//AAF Static Titan A
		"I_static_AT_F"//AAF Static Titan AT:
	];
	private _restrictedMortarsArray = [
		"B_G_Mortar_01_F",//FIA (West) Mk6 Mortar
		"B_Mortar_01_F",//NATO Mk6 Mortar
		"B_T_Mortar_01_F",//NATO (Pacific) Mk6 Mortar
		"O_Mortar_01_F",//CSAT Mk6 Mortar
		"O_G_Mortar_01_F",//FIA (East) Mk6 Mortar
		"I_Mortar_01_F",//AAF Mk6 Mortar
		"I_G_Mortar_01_F"//FIA (Independent) Mk6 Mortar
	];
	
	private _playerAllowedIn = ((roleDescription player find "Leader" > -1) || (roleDescription player find "AT" > -1) || (roleDescription player find "Engineer" > -1) || (roleDescription player find "Explosive" > -1) || (roleDescription player find "FSG" > -1));
	
	if (typeOf _vehicleObject in _restrictedVehiclesHeavyArray || typeOf _vehicleObject in _restrictedVehiclesLightArray) exitWith {
		private _weaponName = "";
		
		switch (typeOf _vehicleObject) do {
			case "B_LSV_01_AT_F";
			case "B_T_LSV_01_AT_F": {
				_weaponName = "missiles_titan_static";
			};
			case "O_LSV_02_AT_F";
			case "O_T_LSV_02_AT_F": {
				_weaponName = "missiles_Vorona";
			};
			default {
				_weaponName = "launcher_SPG9";
			};
		};
		
		if (_playerAllowedIn) then {
			[_vehicleObject, _weaponName] remoteExec ["addWeaponGlobal", 0, false];
		} else {
			hintC "Your role does not have access to the weapon in this seat.";
			[_vehicleObject, _weaponName] remoteExec ["removeWeaponGlobal", 0, false];
		};
	};
	
	if ( (typeOf _vehicleObject) in _restrictedStaticLaunchersArray ) exitWith {
		if (!_playerAllowedIn) then {
			hintC "Your role does not have access to this launcher";
			moveOut player;
		};
	};
	
	if ( (typeOf _vehicleObject) in _restrictedMortarsArray ) exitWith {
		if (roleDescription player find "FSG" == -1) then {
			hintC "You need to be a member of the FSG Team to use the Mk6 Mortar.";
			moveOut player;
		};
	};
};