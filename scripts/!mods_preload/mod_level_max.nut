::LevelMax <- {
    ID = "mod_level_max",
    Version = "1.0.1",
    Name = "Level Max"
};

::LevelMax.HooksMod <- ::Hooks.register(
    ::LevelMax.ID,
    ::LevelMax.Version,
    ::LevelMax.Name
);
::LevelMax.HooksMod.require("mod_msu >= 1.9.0");

::LevelMax.configureDebugLogging <- function()
{
    if ("GuzBluezDebugLogController" in getroottable()
        && "registerTarget" in ::GuzBluezDebugLogController)
    {
        ::GuzBluezDebugLogController.registerTarget(::LevelMax.ID, ::LevelMax.Mod);
        return;
    }

    ::LevelMax.Mod.Debug.setFlag("default", ::LevelMax.Mod.ModSettings.getSetting("DebugLogging").getValue());
};

::LevelMax.HooksMod.queue(">mod_msu",">mod_reforged", function()
{
    ::LevelMax.Mod <- ::MSU.Class.Mod(
        ::LevelMax.ID,
        ::LevelMax.Version,
        ::LevelMax.Name
    );
    ::LevelMax.conf <- function( _key )
    {
        return ::LevelMax.Mod.ModSettings.getSetting(_key).getValue();
    };

    local general = ::LevelMax.Mod.ModSettings.addPage("General");
    local debugLogging = general.addBooleanSetting("DebugLogging", false, "Debug Logging", "Write Level Max debug lines to log.html.");
    debugLogging.addCallback(function( _data = null )
    {
        ::LevelMax.configureDebugLogging();
    });
    ::LevelMax.configureDebugLogging();
    general.addRangeSetting("MaximumLevel", 51, 11, 100, 1, "Maximum Level", "Highest level player brothers can reach. Takes effect after restarting the game.");
    general.addBooleanSetting("GrantPerkPointsAfterLevel11", true, "Grant Perk Points After Level 11", "Give one perk point at every level from 12 through the maximum.");
    general.addBooleanSetting("EnableNormalStatRollsAfterLevel11", true, "Enable Normal Stat Rolls After Level 11", "Replace the vanilla +1 veteran fallback with normal talent-aware stat rolls from level 12 through the maximum.");

    local legendsDetected = "mods_getRegisteredMod" in getroottable() && ::mods_getRegisteredMod("mod_legends") != null;
    if (legendsDetected)
    {
        ::LevelMax.Mod.Debug.printLog("[LevelMax] Legends detected; Level Max progression hooks are disabled.");
        return;
    }

    ::include("scripts/mods/level_max_service");
});
