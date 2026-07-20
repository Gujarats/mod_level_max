# Level Max Manual Test Matrix

| Scenario | Setup | Expected result |
|---|---|---|
| Level 11 to 12 | Default settings; gain enough XP for level 12 | Brother receives one perk point and normal, talent-aware attribute values instead of the vanilla `+1` fallback. |
| Maximum cap | Set maximum level to 12; gain XP beyond level 12 | Brother remains level 12 and cannot gain additional XP. |
| Perks disabled | Cap 12; disable post-11 perks | Level 12 gives no perk point and still gives the normal attribute selection. |
| Normal stat rolls disabled | Cap 12; disable normal stat rolls | Level 12 preserves vanilla `+1` fallback values. |
| Existing brother | Load a save with a brother already above level 11, then level once within the cap | The next level-up selection uses normal, talent-aware values. |
| Save/load | Reach a level above 11; save and reload | Level, perk points, spent perks, and pending selections remain unchanged. |
| Legends guard | Install Legends and Level Max together | Log includes the Legends-disabled message; Level Max does not add duplicate rewards. |
