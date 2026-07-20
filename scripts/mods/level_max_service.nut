::LevelMax.OriginalLevelXP <- clone ::Const.LevelXP;

::LevelMax.rebuildLevelXP <- function()
{
    local maximumLevel = ::LevelMax.conf("MaximumLevel");
    local VeteranLevelStart = 11;
    ::Const.LevelXP = clone ::LevelMax.OriginalLevelXP;

    while (::Const.LevelXP.len() < maximumLevel)
    {
        local veteranIndex = ::Const.LevelXP.len() - VeteranLevelStart;
        ::Const.LevelXP.push(::Const.LevelXP[::Const.LevelXP.len() - 1] + 4000 + 1000 * veteranIndex);
    }

    while (::Const.LevelXP.len() > maximumLevel)
    {
        ::Const.LevelXP.pop();
    }
};

::LevelMax.appendPostElevenAttributeRolls <- function( _player )
{
    if (!::LevelMax.conf("GrantAttributeLevelsAfterLevel11"))
    {
        return;
    }

    local additionalLevels = ::Math.max(0, ::LevelMax.conf("MaximumLevel") - 11);
    if (additionalLevels > 0)
    {
        _player.fillAttributeLevelUpValues(additionalLevels);
    }
};

::LevelMax.rebuildLevelXP();

::LevelMax.HooksMod.hook("scripts/entity/tactical/player", function( q )
{
    q.setScenarioValues = @(__original) function()
    {
        __original();
        ::LevelMax.appendPostElevenAttributeRolls(this);
    };

    q.setStartValuesEx = @(__original) function( _backgrounds, _addTraits = true )
    {
        __original(_backgrounds, _addTraits);
        if (_addTraits)
        {
            ::LevelMax.appendPostElevenAttributeRolls(this);
        }
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
