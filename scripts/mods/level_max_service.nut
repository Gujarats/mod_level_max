::LevelMax.OriginalLevelXP <- clone ::Const.LevelXP;

::LevelMax.rebuildLevelXP <- function()
{
    local maximumLevel = ::LevelMax.conf("MaximumLevel");
    local VeteranLevelStart = 11;
    ::Const.LevelXP = clone ::LevelMax.OriginalLevelXP;

    while (::Const.LevelXP.len() < maximumLevel)
    {
        local veteranIndex = ::Const.LevelXP.len() - VeteranLevelStart;
        // 4000 is the base XP required for the first generated veteran level
        // after level 11. Each later generated level adds another 1000 XP,
        // preserving the intended escalating veteran-level progression.
        ::Const.LevelXP.push(::Const.LevelXP[::Const.LevelXP.len() - 1] + 4000 + 1000 * veteranIndex);
    }

    while (::Const.LevelXP.len() > maximumLevel)
    {
        ::Const.LevelXP.pop();
    }
};

::LevelMax.isNormalStatRollRequired <- function( _player )
{
    if (!::LevelMax.conf("EnableNormalStatRollsAfterLevel11")
        || _player.m.Level <= 11
        || _player.m.Level > ::LevelMax.conf("MaximumLevel"))
    {
        return false;
    }

    if (_player.m.Attributes.len() == 0)
    {
        return true;
    }

    for (local i = 0; i < ::Const.Attributes.COUNT; i = ++i)
    {
        if (_player.m.Attributes[i].len() != 0 && _player.m.Attributes[i][0] != 1)
        {
            return false;
        }
    }

    return true;
};

::LevelMax.rebuildLevelXP();

::LevelMax.HooksMod.hook("scripts/entity/tactical/player", function( q )
{
    q.getAttributeLevelUpValues = @(__original) function()
    {
        if (::LevelMax.isNormalStatRollRequired(this))
        {
            this.m.Attributes.clear();
            this.fillAttributeLevelUpValues(1);
        }

        return __original();
    };

    q.updateLevel = @(__original) function()
    {
        local levelBefore = this.m.Level;
        __original();

        local postElevenLevels = ::Math.max(0, this.m.Level - ::Math.max(11, levelBefore));
        if (postElevenLevels > 0 && ::LevelMax.conf("GrantPerkPointsAfterLevel11"))
        {
            this.m.PerkPoints += postElevenLevels;
        }
    };
});
