# Caterer

This addon makes a fully automatic trade in food and water.

![caterer](https://user-images.githubusercontent.com/24303693/34414693-bfe0eae4-ebfb-11e7-8f45-c1f20cafccd2.jpg)

## Setting addon
First you need to configure the addon for you. This is done very quickly.
1. Trade Filter  
Choose which players you want to trade with.  
![trade_filter](https://user-images.githubusercontent.com/24303693/34449854-696275c0-ed0e-11e7-9bbe-ced4a2a6bdff.jpg)  
2. Setting the number of items  
Set the amount of food and water for each class.  
![trade_filter_by_class](https://user-images.githubusercontent.com/24303693/34449843-3d56819c-ed0e-11e7-8b5d-163d62cc8d19.jpg)

## Usage
All you need to do is to prepare enough items. Unfortunately, automatic creation of items can not be realized, so you have to do it manually.  
All the rest of the addon will do for you, and you can go to drink coffee. The main thing is that there is enough food and water for everyone. :)

### Standard trade
When the player starts trading with you, the addon will add the necessary (customized) number of items for him class and addon himself will click on the Trade button.

### Exception list
For each player you can adjust the individual number of items. To do this, just add this player to this list, specifying the required number of items.  
Command to add:  
`/cat filter list add <player name> <amount of food> <amount of water>`  
or enter this information in the dropdown menu.

When a player from the list starts trading with you, the number of items listed in the list will be added. Accordingly, for this player, the data specified for the standard trade of its class will be ignored.

### Whisper based request system:
You can send a request to the mage for a specific amount of water and food for you. To do this, you need to send the message to the mage in a whisper:
`#cat <amount of food> <amount of water>`  
Note:  
The prefix `#cat` must be mandatory. So the addon will understand that this is a request, and not an ordinary message. In the request is a strict order. First, the food is indicated, then water. It is mandatory to specify **both** parameters.
If you do not need an item, then in the amount write zero. Examples:  
* `#cat 20 0` - in trade you will receive 20 pcs. food.  
* `#cat 20 40` - in trade you will receive 20 pcs. food and 40 pcs. water.

Requests have the highest priority. Therefore, at the request is ignored data from the list of exceptions (if this player is recorded there) and data from the standard exchange.
* * *
**P.S. I do not know English well, so I apologize for any mistakes. I will gladly accept any adjustments and corrections. :)**
