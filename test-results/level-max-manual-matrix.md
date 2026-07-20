# Level Max Manual Test Matrix

| Scenario | Setup | Expected result |
|---|---|---|
| Level 11 to 12 | Default settings; gain enough XP for level 12 | Brother receives one perk point and one normal attribute selection; talent stars influence the roll. |
| Maximum cap | Set maximum level to 12; gain XP beyond level 12 | Brother remains level 12 and cannot gain additional XP. |
| Perks disabled | Cap 12; disable post-11 perks | Level 12 gives no perk point and still gives the normal attribute selection. |
| Attributes disabled | Cap 12; disable post-11 attributes | Level 12 gives the perk point and shows no attribute selection. |
| Both disabled | Cap 12; disable both post-11 settings | Level 12 gives neither a perk point nor an attribute selection. |
| Save/load | Reach a level above 11; save and reload | Level, perk points, spent perks, and pending selections remain unchanged. |
| Legends guard | Install Legends and Level Max together | Log includes the Legends-disabled message; Level Max does not add duplicate rewards. |

