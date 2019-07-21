//zeusupdater.sqf

sleep 20;

zeusUpdaterFnc = {
    params ["_isUserCall"];
    private _obj = (
        entities "AllVehicles"
            - entities "Animal"
            - [
                Quartermaster,Quartermaster_1,Quartermaster_2,Quartermaster_3,Quartermaster_4,Quartermaster_5,
                CVN_CIWS_1,CVN_CIWS_2,CVN_CIWS_3,CVN_RAM,CVN_SAM_2,CVN_SAM_3,Base_AA
            ]
    );

    {_x addCuratorEditableObjects [_obj, true]; } forEach allCurators;
    if (isNil "_isUserCall") then {
        sleep 180;
        [] spawn zeusUpdaterFnc;
    };
};

[] spawn zeusUpdaterFnc;