# MoronBoxHeal

This addon is designed, optimised for Multiboxing. I may or may not, change things so it is able to work without: MoRoNBoxCore.

## Options
![image](https://github.com/RoelCrabbe/MoronBoxHeal/assets/92096051/7b1b6b00-99f0-4698-ae53-faf7e59923c6)

### Healing Settings
  ``Random Target`` : Is the character allowed to search targets randomly?
  Heal Target : Once <Random Target> is disabled, this will use a 'set' value to search for the next target to heal.
  Allowed Overheal : Howmuch % do you want to allow?
  Smart Heal : Is disabled, this will only search random targets. (Keep it on, they it will do both)

### Extended Range Settings
  Extended Range : This is a settings that will keep track of targets that are in caster range (40yrds)
  Update : Checking range of a unit requires OnUpdate to check where everyone is. This setting will allow you to pick howmany times it can run.
  
### Line of Sight Settings
  Line of Sight : Do we want targets that are not in line of sight to heal, be ignored?
  Update : If yes, for howlong do you want this player to be ignored for

### Special Settings
  Mana Protection : If enabled this will make sure you will use other spells given cetain mana criteria later specified.
  Idle Protection : Because the addon uses, onupdate even when doing nothing. This will remove load if not incombat.
  Update : Howmany times can it still fire when not incombat.

## Mana Protection
![image](https://github.com/RoelCrabbe/MoronBoxHeal/assets/92096051/d00930cc-9473-494e-98e3-4ff835caa561)
If the settings from earlier is enabled, these values will be used.
The interface is different for each class, not all spells included. (Only the usefull ones)

![image](https://github.com/RoelCrabbe/MoronBoxHeal/assets/92096051/4d9a340d-699f-469e-b1f3-6c654e3d5631)
### Spell Name Above
  Mana Percentage Slider : When you are below this amount of mana it will use the spell specified on the slicer.
  Lowest Rank: When you have reached this % of mana, this will be the lowest spell you will be using.
  Highest Rank: When you have reached this % of mana, this will be the highest spell you will be using.
  Active Switch: Are you sure you want this setting enabled? You can turn it off and only use other spells, if there are any.

## Presettings
![image](https://github.com/RoelCrabbe/MoronBoxHeal/assets/92096051/1dddbe4a-09f2-48b0-8cb4-238b1c928f33)
When pressing the second bottom left button, this wil open a popup. Where you can select if you want the "pre made" settings to load. (Based on specc / healspell / class).

## Default
![image](https://github.com/RoelCrabbe/MoronBoxHeal/assets/92096051/3ab4bba1-7861-46a7-af62-6684477f0071)
When you have chosen settings you are not happy with, the bottomleft button. Can open a popup to remove / default your settings again.

### Troubles or Nil values, clear WDB

## First Version of the addon :

![image](https://github.com/RoelCrabbe/MoronBoxHeal/assets/92096051/6e67845c-e9f6-447d-939f-6e88967a76f0)
![image](https://github.com/RoelCrabbe/MoronBoxHeal/assets/92096051/98d871cf-9ea4-472e-be27-0fffd59b8cdc)
