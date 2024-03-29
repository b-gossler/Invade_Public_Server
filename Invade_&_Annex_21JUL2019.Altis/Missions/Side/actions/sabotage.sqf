/*
Author:

	Quiksilver

Description:

	Object is teleported to side mission location
	addAction on object executes this script
	when script is done, spawn explosion and teleport object away

	Modified for simplicity and other applications (non-destroy missions).
	BIS_fnc_spawn/BIS_fnc_timetostring are all performance hogs.

To do:

	Needs re-framing for 'talk to contact' type missions [DONE]

	This code is now just a variable switch, to be sent back in order that the mission script can continue.

	Does it allow for possibility of failure? I dont know, too tired at the moment.

_______________________________________________________*/

//-------------------- Send hint to player that he's planted the bomb
private _name = name player;

private _sidecompleted = format["<t align='center'><t size='2.2'>Side-mission update</t><br/>____________________<br/>%1 planted charges on the objective.  Clear the area, detonation in 30 seconds!</t>",_name];
[_sidecompleted] remoteExec ["AW_fnc_globalHint",0,false];

sleep 1;

[] remoteExec ["Aw_fnc_smSucSwitch",2];
