# Caterer
 
This addon fully automates the trading of food and water.
 
![caterer](https://user-images.githubusercontent.com/24303693/34414693-bfe0eae4-ebfb-11e7-8f45-c1f20cafccd2.jpg)
 
## Setting addon
First you need to configure the addon. This can be done very quickly.
1. Trade Filter  
Choose which players you want to trade with.  
![trade_filter](https://user-images.githubusercontent.com/24303693/34449854-696275c0-ed0e-11e7-9bbe-ced4a2a6bdff.jpg)  
2. Setting the number of items  
Set the amount of food and water for each class.  
![trade_filter_by_class](https://user-images.githubusercontent.com/24303693/34449843-3d56819c-ed0e-11e7-8b5d-163d62cc8d19.jpg)
 
## Usage
All you have to do is prepare enough items. Unfortunately, automatic creation of items can not be implemented, so you have to do it manually.  
The addon will do the rest, and you can go for a coffee. Just make sure there is enough food and water for everyone. :)
 
### Standard trade
When a player starts trading with you, the addon will add a configured number of items depending on his class and will complete the trade automatically.
 
### Exception list
You can set the individual number of items for each player. To do this, just add the player to the list and specify the required number of items.  
Command:
`/cat filter list add <player name> <amount of food> <amount of water>`  
or enter this information in the dropdown menu.
 
When a player from the list starts trading with you, a specified number of items will be added. The numbers specified for the standard trade will be ignored.
 
### Whisper based request system:
You can request a specific amount of water and food. To do this, wisper to the mage:
`#cat <amount of food> <amount of water>`  
Note:  
The `#cat` prefix is mandatory, so the addon can distinguish the request from an ordinary message. The amount of food is specified in the first parameter, the amount of water is specified in the second. **Both** parameters are required.
If you do not need an item, write zero in the corresponding parameter. Examples:  
* `#cat 20 0` - you will receive 20 pcs. of food.  
* `#cat 20 40` - you will receive 20 pcs. of food and 40 pcs. of water.
 
The amounts specified in a request supersede the amounts from the exception list and from the standard trade.
* * *
**P.S. My English is not very good, so I apologize for any mistakes. I will gladly accept any adjustments and corrections. :)**
