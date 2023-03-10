//@script_name JumpToMetadataObject
//@script_display_name Перейти к объекту метаданных из версии хранилища
//@script_description Переходит к выделенному объекту метаданных, измененному в версии хранилища конфигурации
//@script_author Aleksei Adamov
//@script_developer_url https://github.com/AlekseiAdamov
//@script_url https://github.com/AlekseiAdamov/turboconf-scripts/JumpToMetadataObject.os
//@script_section Навигация
//@script_hotkey Control+Shift+J
//@retain_clipboard 0
//@enterprise_mode 1
//@hide_actions 1
//@script_version 1
//@turbomenu 1
//@turbobutton 1

Процедура ПерейтиКОбъектуМетаданных()

	ТурбоКонф = Новый ТурбоКонф;

	// Копируем имя выделенного объекта в списке измененных объектов версии хранилища.
	ТурбоКонф.Копировать();

	Попытка

		ИмяОбъектаМетаданных = СокрЛП(ТурбоКонф.ПолучитьБуферОбмена());

	Исключение

		ТурбоКонф.ПоказатьУведомление("Не удалось получить имя объекта метаданных из буфера обмена");
		Возврат;

	КонецПопытки;

	Если ПустаяСтрока(ИмяОбъектаМетаданных) Тогда

		ТурбоКонф.ПоказатьУведомление("Не удалось получить имя объекта метаданных");
		Возврат;

	КонецЕсли;

	Попытка

		// Переход из произвольного места не всегда работает,
		// лучше всего вначале выбрать корень конфигурации.
		ТурбоКонф.КонтролШифтКлавиша(Клавиши.C); // Активируем окно конфигурации штатным сочетанием клавиш.
		ТурбоКонф.КонтролКлавиша(Клавиши.Home);  // Переходим в корень конфигурации.
		ТурбоКонф.Перейти(ИмяОбъектаМетаданных); // Ищем нужный объект по дереву.

	Исключение

		ТекстСообщения = СтрШаблон("Не удалось перейти к объекту ""%1""", ИмяОбъектаМетаданных);
		ТурбоКонф.ПоказатьУведомление(ТекстСообщения);

	КонецПопытки;

КонецПроцедуры

ПерейтиКОбъектуМетаданных();