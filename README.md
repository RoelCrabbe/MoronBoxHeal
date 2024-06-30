# MoronBoxHeal

This addon is optimized for multiboxing. I may or may not make changes so that it can function independently of MoRoNBoxCore.

## Options
![image](https://github.com/RoelCrabbe/MoronBoxHeal/assets/92096051/7b1b6b00-99f0-4698-ae53-faf7e59923c6)

### Healing Settings
      Random Target: Is the character allowed to search targets randomly?
      Heal Target: Once <Random Target> is disabled, this will use a set value to search for the next target to heal.
      Allowed Overheal: How much % do you want to allow?
      Smart Heal: If disabled, this will only search random targets. (Keep it on, then it will do both)

### Extended Range Settings
    Extended Range: This setting keeps track of targets within caster range (40 yards or more).
    Update: Checking the range of a unit requires OnUpdate to determine their position. This setting allows you to specify how many times it can run.
  
### Line of Sight Settings
    Line of Sight: Should targets not in line of sight be ignored for healing?
    Update: If yes, for how long do you want this player to be ignored?

### Special Settings
    Mana Protection: If enabled, this ensures you use other spells based on certain mana criteria later specified.
    Idle Protection: Because the addon uses OnUpdate even when doing nothing, this setting reduces load when out of combat.
    Update: How many times can it still fire when not in combat?

## Mana Protection
![image](https://github.com/RoelCrabbe/MoronBoxHeal/assets/92096051/d00930cc-9473-494e-98e3-4ff835caa561)
If the settings from earlier are enabled, these values will be used.
The interface is different for each class; not all spells are included (only the useful ones).

![image](https://github.com/RoelCrabbe/MoronBoxHeal/assets/92096051/4d9a340d-699f-469e-b1f3-6c654e3d5631)
### Spell Name Above
    Mana Percentage Slider: When you are below this amount of mana, it will use the spell specified on the slider.
    Lowest Rank: When you have reached this percentage of mana, this will be the lowest spell you will be using.
    Highest Rank: When you have reached this percentage of mana, this will be the highest spell you will be using.
    Active Switch: Are you sure you want this setting enabled? You can turn it off and only use other spells, if there are any.

## Presettings
![image](https://github.com/RoelCrabbe/MoronBoxHeal/assets/92096051/1dddbe4a-09f2-48b0-8cb4-238b1c928f33)
When pressing the second button from the bottom left, this will open a popup where you can select if you want the 'pre-made' settings to load (based on spec/heal spell/class).

## Default
![image](https://github.com/RoelCrabbe/MoronBoxHeal/assets/92096051/3ab4bba1-7861-46a7-af62-6684477f0071)
When you are not happy with the chosen settings, the bottom left button can open a popup to reset/default your settings again.

### Troubles or Nil values, clear WDB

## First Version of the addon:

![image](https://github.com/RoelCrabbe/MoronBoxHeal/assets/92096051/6e67845c-e9f6-447d-939f-6e88967a76f0)
![image](https://github.com/RoelCrabbe/MoronBoxHeal/assets/92096051/98d871cf-9ea4-472e-be27-0fffd59b8cdc)
