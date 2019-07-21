/*
By ansin11.
Partially based on code written by kamaradski, chucky, Quicksilver, BACONMOP and Stanhope.

Make sure you understand how _restrictedAircraftArray and the code inside the forEach loop interact with each other before you edit _restrictedAircraftArray!
The class names of all variants of any vehicle share the same beginning. For example:
	CTRG UH-80 Ghost Hawk (Sand) = "B_CTRG_Heli_Transport_01_sand_F"
	CTRG UH-80 Ghost Hawk (Tropic) = "B_CTRG_Heli_Transport_01_tropic_F"
The part that both have in common, "B_CTRG_Heli_Transport_01_", is what goes into _restrictedAircraftArray.
Obviously full class names can also be used, but this will make _restrictedAircraftArray larger. Since BIS occasionally add and remove variants of their
vehicles, not using full class names also reduces maintenance.
*/

private _restrictedAircraftArray = [
	//CTRG UH-80 Ghost Hawk Variants:
	"B_CTRG_Heli_Transport_01_",
	//NATO A-164 Wipeout Variants:
	"B_Plane_CAS_01_",
	//NATO F/A-181 Black Wasp II Variants:
	"B_Plane_Fighter_01_",
	//NATO AH-9 Pawnee / MH-9 Hummingbird Variants:
	"B_Heli_Light_01_",
	//NATO AH-99 Blackfoot Variants:
	"B_Heli_Attack_01_",
	//NATO CH-67 Huron Variants:
	"B_Heli_Transport_03_",
	//NATO UH-80 Ghost Hawk Variants:
	"B_Heli_Transport_01_",
	//NATO (Pacific) V-44 X Blackfish Variants:
	"B_T_VTOL_01_",
	//CSAT To-199 Neophron Variants:
	"O_Plane_CAS_02_",
	//CSAT To-201 Shikra Variants:
	"O_Plane_Fighter_02_",
	//CSAT Mi-290 Taru Variants:
	"O_Heli_Transport_04_",
	//CSAT Mi-48 Kajman Variants:
	"O_Heli_Attack_02_",
	//CSAT PO-30 Orca Variants:
	"O_Heli_Light_02_",
	//CSAT (Pacific) Y-32 Xi'an Variants:
	"O_T_VTOL_02_",
	//AAF A-143 Buzzard Variants:
	"I_Plane_Fighter_03_",
	//AAF A-149 Gryphon Variants:
	"I_Plane_Fighter_04_",
	//AAF CH-49 Mohawk Variants:
	"I_Heli_Transport_02_",
	//AAF WY-55 Hellcat Variants:
	"I_Heli_light_03_",
	//Syndikat Caesar BTT Variants:
	"I_C_Plane_Civil_01_",
	//Syndikat M-900 Variants:
	"I_C_Heli_Light_01_civil_",
	//IDAP EH302 Variants:
	"C_IDAP_Heli_Transport_02_",
	//Civilian Caesar BTT Variants:
	"C_Plane_Civil_01_",
	//Civilian M-900 Variants:
	"C_Heli_Light_01_"
];
private _aircraftObject = vehicle player;
private _aircraftClassName = typeOf _aircraftObject;
private _playerInRestrictedAircraft = false;

{
	if (_aircraftClassName find _x > -1) exitWith {
		_playerInRestrictedAircraft = true;
	};
} forEach _restrictedAircraftArray;

if (_playerInRestrictedAircraft) then {

	//Pilot Seat:
	if (player == driver _aircraftObject && roleDescription player find "Pilot" == -1) exitWith {
		if (player getVariable "isAdmin") exitWith {
			systemChat "Your administrator privileges give you access to this pilot seat. Do not abuse this.";
		};
		hintC "You need to be a pilot to get into the pilot seat of this aircraft.";
		systemChat "You need to be a pilot to get into the pilot seat of this aircraft.";
		moveOut player;
	};
	
	//Copilot Seat:
	if (player == (_aircraftObject turretUnit [0])) exitWith {
		if (roleDescription player find "Pilot" > -1) then {
			[_aircraftObject, true] remoteExec ["enableCopilot", 0, false];
		} else {
			[_aircraftObject, false] remoteExec ["enableCopilot", 0, false];
			systemChat "You need to be a pilot to take control of this aircraft.";
		};
	};

};