params ["_arsenalObject"];

if ("GearRestriction" call BIS_fnc_getParamValue == 0) exitWith {
	["AmmoboxInit", [_arsenalObject, true, {true}]] call BIS_fnc_arsenal;
};

waitUntil {sleep 0.1; !(isNil "generalStaticWeapons")};

private _allowedItemsArray = generalItems + generalMagazines + generalGlasses + generalHeadgear + generalHeadgearHelmets + generalUniforms + generalVests;
private _allowedWeaponsArray = generalPistols + generalSMGs + generalCarbines + generalAssaultRifles + underWaterGun;
private _allowedBackpacksArray = generalBackpacks + generalDroneBackpacks + generalStaticWeapons;
private _allowedMagazinesArray = generalMagazines;

//whitelistArray and blacklistArray for AW_fnc_cleanInventory:
whitelistArray = [];


//JTAC
if ((roleDescription player find "JTAC" > -1)) then {
	_allowedWeaponsArray = _allowedWeaponsArray + restrictedAssaultRiflesUGL;
};

//Squad Leaders, Team Leaders
if ((roleDescription player find "Squad Leader" > -1) || (roleDescription player find "Team Leader" > -1)) then {
	_allowedWeaponsArray = _allowedWeaponsArray + restrictedLAT + restrictedMAT + restrictedAssaultRiflesUGL;
};

//Medics
if (roleDescription player find "Medic" > -1) then {
	_allowedItemsArray = _allowedItemsArray + ["U_C_Paramedic_01_F", "V_Plain_crystal_F"];
};

//Autoriflemen
if (roleDescription player find "Autorifleman" > -1) then {
	_allowedWeaponsArray = generalPistols + restrictedMGs + underWaterGun;
};

if (roleDescription player find "LAT" > -1) then {
	_allowedWeaponsArray =_allowedWeaponsArray + restrictedLAT + restrictedMAT;
};

//Grenadiers
if (roleDescription player find "Grenadier" > -1) then {
	_allowedWeaponsArray = generalPistols + restrictedAssaultRiflesUGL + underWaterGun;
};

//Marksmen
if (roleDescription player find "Marksman" > -1) then {
	_allowedItemsArray = _allowedItemsArray + restrictedOpticsMarksman + restrictedUniformsMarksman;
	_allowedWeaponsArray = generalPistols + restrictedDMRs + underWaterGun;
};

//AT Infantry
if ((roleDescription player find "AT" > -1) && (roleDescription player find "LAT" == -1)) then {
	_allowedWeaponsArray = _allowedWeaponsArray + restrictedLAT + restrictedMAT + restrictedHAT;
};

//Engineer, Explosive Specialists
if ((roleDescription player find "Engineer" > -1) || (roleDescription player find "Explosive" > -1)) then {
	_allowedItemsArray = _allowedItemsArray + restrictedHeadgearEOD + restrictedVestsEOD + ["MineDetector"];
	_allowedMagazinesArray = _allowedMagazinesArray + restrictedExplosives;
		_allowedWeaponsArray = _allowedWeaponsArray + restrictedLAT + restrictedMAT;
};

//Recon Team
if (roleDescription player find "Recon" > -1) then {
	_allowedItemsArray = _allowedItemsArray + ["optic_Nightstalker"];
	_allowedWeaponsArray = _allowedWeaponsArray + restrictedWeaponsRecon;
};

//Spotters
if (roleDescription player find "Spotter" > -1) then {
	_allowedItemsArray = _allowedItemsArray + restrictedUniformsMarksman + restrictedUniformsSniper;
};

//Snipers
if ((roleDescription player find "Sniper" > -1) && (roleDescription player find "Spotter" == -1)) then {
	_allowedItemsArray = _allowedItemsArray + restrictedOpticsMarksman + restrictedOpticsSniper + restrictedUniformsMarksman + restrictedUniformsSniper;
	_allowedWeaponsArray = generalPistols + restrictedSniperRifles + underWaterGun;
};

//FSG Team Leader, FSG Gunner
if (roleDescription player find "FSG" > -1) then {
	_allowedWeaponsArray = generalPistols + generalSMGs + generalCarbines + restrictedMAT + restrictedLAT;
	if (roleDescription player find "Team Leader" > -1) then {
		_allowedWeaponsArray = _allowedWeaponsArray + restrictedAssaultRiflesUGL;
	};
};

//UAV Operator
if (roleDescription player find "UAV" > -1) then {
	_allowedItemsArray = _allowedItemsArray + ["B_UavTerminal"];
	_allowedWeaponsArray = generalPistols + generalSMGs + generalCarbines + generalAssaultRifles + underWaterGun;
};

//Pilots
if (roleDescription player find "Pilot" > -1) then {
	_allowedItemsArray = generalItems + generalMagazines + generalGlasses + generalHeadgear + restrictedHeadgearPilot + restrictedUniformsPilot + allowedVestsPilot;
	_allowedWeaponsArray = generalPistols + generalSMGs;
};

//Initialise Virtual Arsenal on _arsenalObject:
["AmmoboxInit", [_arsenalObject, false, {true}]] call BIS_fnc_arsenal;

//Add allowed equipment to that Virtual Arsenal:
[_arsenalObject, _allowedItemsArray, false, false] call BIS_fnc_addVirtualItemCargo;
[_arsenalObject, _allowedWeaponsArray, false, false] call BIS_fnc_addVirtualWeaponCargo;
[_arsenalObject, _allowedBackpacksArray, false, false] call BIS_fnc_addVirtualBackpackCargo;
[_arsenalObject, _allowedMagazinesArray, false, false] call BIS_fnc_addVirtualMagazineCargo;

whitelistArray = whitelistArray + afterArsenalBackpacks + _allowedItemsArray + _allowedWeaponsArray + _allowedBackpacksArray + _allowedMagazinesArray;
blacklistArray = blacklistArray;

/*
These items need to be added because the special gear compositions BIS use for their units are not defined in ArsenalDefinitions.sqf.
This way, the default weapon / backpack the player unit spawns with doesn't get removed by AW_fnc_cleanInventory.
*/
{
	whitelistArray pushBackUnique _x;
} forEach (weapons player + [backpack player]);