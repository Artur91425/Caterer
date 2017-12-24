local L = AceLibrary("AceLocale-2.2"):new("Caterer")

L:RegisterTranslations("ruRU", function() return {
	
	[" loaded."] = " загружен.",
	
	--Food
	["Conjured Cinnamon Roll"] = "Сотворенная плюшка с корицей",
	["Conjured Sweet Roll"] = "Сотворенная сладкая булочка",
	--Water
	["Conjured Crystal Water"] = "Сотворенная талая вода",
	["Conjured Sparkling Water"] = "Сотворенная шипучка",
	
	--Classes
	["Warlock"] = "Чернокнижник",
	["Warrior"] = "Воин",
	["Priest"] = "Жрец",
	["Rogue"] = "Разбойник",
	["Hunter"] = "Охотник",
	["Paladin"] = "Паладин",
	["Druid"] = "Друид",
	
	--Options
	["Food"] = "Еда",
	["Set food for trades."] = "Установите еду для обмена.",
	["Water"] = "Вода",
	["Set water for trades."] = "Установите воду для обмена.",
	["Filter"] = "Фильтр",
	["Filter options."] = "Настройки фильтра.",
	["Quantity"] = "Количество",
	["Quantity options."] = "Настройки количества.",
	["Set items quantity."] = "Установите количество предметов.",
	["Set quantity for food."] = "Установите количество для еды.",
	["Set quantity for water."] = "Установите количество для воды.",
	["Trade"] = "Обмен",
	["Trade options."] = "Настройки обмена.",
	["Friends"] = "Друзья",
	["Toggle trade with friends."] = "Вкл./Выкл. обмен с друзьями.",
	["Group/Raid members"] = "Члены группы/рейда",
	["Toggle trade with group/raid members."] = "Вкл./Выкл. обмен с членами группы/рейда.",
	["Guild members"] = "Члены гильдия",
	["Toggle trade with guild members."] = "Вкл./Выкл. обмен с членами гильдии.",
	["Other"] = "Другие",
	["Toggle trade with other players."] = "Вкл./Выкл. обмен с другими игроками.",
	["Whisper requests"] = "Запросы шепотом",
	["Toggle whisper requests."] = "Вкл./Выкл. запросы шепотом.",
	
	--Errors
	["Service is temporarily disabled."] = "Сервис временно отключен.",
	["Expected string: '#cat [amount of food] [amount of water]'. Note: the number must be a multiple of 20."] = "Ожидается строка: '#cat [кол-во еды] [кол-во воды]'. Примечание: номер должен быть кратным 20.",
	["I can't complete the trade right now. I'm out of "] = "Я не могу завершить обмен сейчас. У меня недостаточно ",
	["Trade is impossible, no "] = "Обмен невозможен, нет ",
	["food."] = "еды.",
	["water."] = "воды.",

} end)