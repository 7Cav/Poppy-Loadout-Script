#include "..\script_component.hpp"
params ["_unit"];

// - Shortrange -------------------------------------------
if (isPlayer _unit) then {
    _unit spawn {
        waitUntil {[] call acre_api_fnc_isInitialized};
        private _srChannel = [_this] call FUNC(findGroupChannel);
        [["ACRE_PRC343"] call acre_api_fnc_getRadioByType, _srChannel] call acre_api_fnc_setRadioChannel;
    };
};

// - Longrange --------------------------------------------
if !(isArray (missionConfigFile >> "CfgPoppy" >> "ACRE" >> "channelNames")) exitWith {};
private _lrChannels = getArray (missionConfigFile >> "CfgPoppy" >> "ACRE" >> "channelNames");

{
    private _radio = _x;

    [_radio, "default", "PoppyPreset"] call acre_api_fnc_copyPreset;
    {
        [_radio, "PoppyPreset", _forEachIndex + 1, "label", _x] call acre_api_fnc_setPresetChannelField;
    } forEach _lrChannels;
    [_radio, "PoppyPreset"] call acre_api_fnc_setPreset;

    false
} count ["ACRE_PRC152", "ACRE_PRC148", "ACRE_PRC117F"];
