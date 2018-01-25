local L = AceLibrary('AceLocale-2.2'):new('Caterer')

L:RegisterTranslations('ruRU', function() return {
	
	["Attention! Addon %s is not designed for your class. It must be disabled."] = "Внимание! Аддон %s не предназначен для вашего класса. Он должен быть отключен.",
	["loaded."] = "загружен.",
	["LeftClick to toggle addon.\nRightClick to open dropdown menu.\nLeftClick on the point tooltip to quickly manage the addon."] = "Нажмите левую кнопку мыши, чтобы Вкл./Выкл. аддон.\nНажмите правую кнопку мыши, чтобы открыть меню.\nНажмите левую кнопку мыши на пункт в подсказке для быстрого управления аддоном.",
	["Trade with friends"] = "Обмен с друзьями",
	["Trade with group"] = "Обмен с членами группы/рейда",
	["Trade with guild"] = "Обмен с членами гильдии",
	["Trade with other"] = "Обмен с другими",
	["Class"] = "Класс",
	["nil"] = "нет",
	["On"] = "Вкл.",
	["Off"] = "Выкл.",
	
	--Food
	["Conjured Cinnamon Roll"] = "Сотворенная плюшка с корицей",
	["Conjured Sweet Roll"] = "Сотворенная сладкая булочка",
	--Water
	["Conjured Crystal Water"] = "Сотворенная талая вода",
	["Conjured Sparkling Water"] = "Сотворенная шипучка",
	
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
	["Add to tooltip"] = "Добавить в подсказку",
	["Adds the current settings to the tooltip."] = "Добавляет текущие настройки в подсказку.",
	["Trade"] = "Обмен",
	["Trade options."] = "Настройки обмена.",
	["Friends"] = "Друзья",
	["Toggle trade with friends."] = "Вкл./Выкл. обмен с друзьями.",
	["Group/Raid members"] = "Члены группы/рейда",
	["Toggle trade with group/raid members."] = "Вкл./Выкл. обмен с членами группы/рейда.",
	["Guild members"] = "Члены гильдии",
	["Toggle trade with guild members."] = "Вкл./Выкл. обмен с членами гильдии.",
	["Other players"] = "Другие игроки",
	["Toggle trade with other players."] = "Вкл./Выкл. обмен с другими игроками.",
	["List of exceptions"] = "Список исключений",
	["Exception list options."] = "Настройки списка исключений.",
	["Add/Edit"] = "Добавить/Изменить",
	["Add/Edit a player to the exclusion list.\n\nUsage: <%s> <%s> <%s>"] = "Добавляет/Изменяет игрока в списке исключений.\n\nИспользование: <%s> <%s> <%s>",
	["player name"] = "имя игрока",
	["amount of food"] = "кол-во еды",
	["amount of water"] = "кол-во воды",
	["Player"] = "Игрок",
	["%s was successfully %s."] = "%s был успешно %s.",
	["added"] = "добавлен",
	["edited"] = "изменен",
	["removed"] = "удален",
	["Remove"] = "Удалить",
	["Remove a player from the exclusion list.\n\nUsage: <%s>"] = "Удаляет игрока из списка исключений.\n\nИспользование: <%s>",
	["Print"] = "Печать",
	["Printing an exclusion list."] = "Выводит список исключений.",
	["The list is empty."] = "Список пуст.",
	["Clear"] = "Очистить",
	["Completely clears the entire list."] = "Полностью очищает список исключений.",
	["Do you really want to clear list of exceptions?"] = "Вы действительно хотите очистить список исключений?",
	["The list has been successfully cleared."] = "Список был успешно очищен.",
	["Adds the list of exceptions to the tooltip."] = "Добавляет список исключений в подсказку.",
	["Whisper requests"] = "Запросы шепотом",
	["Toggle whisper requests."] = "Вкл./Выкл. запросы шепотом.",
	["Reset"] = "Сброс",
	["Reset all settings."] = "Сброс всех настроек.",
	["Do you really want to reset the settings to their default values?"] = "Вы действительно хотите сбросить настройки до значений по умолчанию?",
	["All settings are reset to default value."] = "Все настройки сброшены до значения по умолчанию.",
	
	--Errors
	["Make yourself your own water."] = "Сделайте себе собственную воду.",
	["Service is temporarily disabled."] = "Сервис временно отключен.",
	["The total number of items should not exceed 120."] = "Общее количество предметов не должно превышать 120.",
	["The quantity for both items can not be zero."] = "Количество для обоих предметов не может быть равно нулю.",
	["Expected string: '<%s> <%s> <%s>'. Note: the number must be a multiple of 20."] = "Ожидается строка: '<%s> <%s> <%s>'. Примечание: номер должен быть кратным 20.",
	["I can't complete the trade right now. I'm out of %s."] = "Я не могу завершить обмен сейчас. У меня недостаточно %s.",
	["Trade is impossible, no %s."] = "Обмен невозможен, нет %s.",
	["Had a problem picking things up!"] = "Имеется проблема со взятием предмета!",		
	["It is necessary to come closer."] = "Необходимо подойти ближе.",
	["This player is not listed."] = "Этого игрока нет в списке.",
	
} end)