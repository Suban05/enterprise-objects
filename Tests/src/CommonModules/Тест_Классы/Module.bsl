Процедура ИсполняемыеСценарии() Экспорт
	
	ЮТТесты
		.ДобавитьТест("Тест_СоздаетКлассКакОбъект")
		.ДобавитьТест("Тест_СоздаетОбъектКласса")
		.ДобавитьТест("Тест_ВызываетМетодОбъекта")
		.ДобавитьТест("Тест_ВызываетМетодОбъектаСПараметром")
		.ДобавитьТест("Тест_СоздаетОбъектСВложеннымОбъектом")
		.ДобавитьТест("Тест_НеМожетПрочитатьПриватныеПоляОбъекта")
		.ДобавитьТест("Тест_МожетПрочитатьПубличныеПоляОбъекта")
		.ДобавитьТест("Тест_МожетИзменитьЗначенияПубличныхПолейОбъекта")
		.ДобавитьТест("Тест_ИзменяетПолеЧерезДругойМетод");
	
КонецПроцедуры

Процедура Тест_СоздаетКлассКакОбъект() Экспорт

	Класс = ОП_Классы.Класс(Тест_ТестовыйКласс);
	ЮТест
		.ОжидаетЧто(Класс).ИмеетТип("ФиксированнаяСтруктура")
		.Что(Класс).Свойство("Новый").ИмеетТип("ОбработкаОбъект.ОП_МетодОбъекта")
		.Что(Класс).Свойство("ПрограммныйИнтерфейс").ИмеетТип("Массив")
		.Что(Класс).Свойство("Переменные").ИмеетТип("Массив")
		.Что(Класс).Свойство("Модуль").ИмеетТип("ОбщийМодуль")
		.Что(Класс).Свойство("Класс").ИмеетТип("ФиксированнаяСтруктура")
		.Что(Класс).Свойство("Родитель").ЭтоНеопределено()
		.Что(Класс).НетСвойства("Привет")
		.Что(Класс).НетСвойства("Документ");

КонецПроцедуры

Процедура Тест_СоздаетОбъектКласса() Экспорт
	
	ЮТест.ОжидаетЧто(
		ОП_Классы.Класс(Тест_ТестовыйКласс).Новый._()
	).ИмеетТип("ФиксированнаяСтруктура");
	
КонецПроцедуры

Процедура Тест_ВызываетМетодОбъекта() Экспорт
	
	Объект = ОП_Классы.Класс(Тест_ТестовыйКласс).Новый._();
	ЮТест.ОжидаетЧто(Объект.Привет._()).Равно("Привет");
	
КонецПроцедуры

Процедура Тест_ВызываетМетодОбъектаСПараметром() Экспорт

	Объект = ОП_Классы.Класс(Тест_ТестовыйКласс).Новый._();
	ЮТест.ОжидаетЧто(Объект.ДатаСтрокой._(Дата(2025, 1, 1))).Равно("01.01.2025");

КонецПроцедуры

Процедура Тест_СоздаетОбъектСВложеннымОбъектом() Экспорт

	Документ = ОП_Классы.Класс(Тест_ТестовыйКласс).Новый._()
		.Документ._(
			ОП_Классы.Класс(Тест_Сотрудник).Новый._(
				"Иван", "Иванов", "Инженер серверной разработки"
			)
		);
	ЮТест.ОжидаетЧто(Документ).ИмеетТип("ФиксированнаяСтруктура");

КонецПроцедуры

Процедура Тест_НеМожетПрочитатьПриватныеПоляОбъекта() Экспорт

	Сотрудник = ОП_Классы.Класс(Тест_Сотрудник).Новый._("Иван", "Иванов", "Инженер");	
	ЮТест
		.ОжидаетЧто(Сотрудник).НетСвойства("Имя")
		.Что(Сотрудник).НетСвойства("Иванов")
		.Что(Сотрудник).НетСвойства("Должность")
		.Что(Сотрудник).НетСвойства("ДатаСоздания");

КонецПроцедуры

Процедура Тест_МожетПрочитатьПубличныеПоляОбъекта() Экспорт

	Сотрудник = ОП_Классы.Класс(Тест_Сотрудник).Новый._("Иван", "Иванов", "Инженер");
	Документ = ОП_Классы.Класс(Тест_Документ).Новый._(Сотрудник);
	ЮТест
		.ОжидаетЧто(Документ.Сотрудник._()).Равно(Сотрудник)
		.Что(Документ.Дата._()).Равно(Дата(1, 1, 1))
		.Что(Документ.Подписан._()).ЭтоЛожь();

КонецПроцедуры

Процедура Тест_МожетИзменитьЗначенияПубличныхПолейОбъекта() Экспорт
	
	Сотрудник = ОП_Классы.Класс(Тест_Сотрудник).Новый._("Иван", "Иванов", "Инженер");
	Документ = ОП_Классы.Класс(Тест_Документ).Новый._(Сотрудник);	
	Документ.Дата._(Дата(2025, 1, 1));
	ЮТест.ОжидаетЧто(Документ.Дата._()).Равно(Дата(2025, 1, 1));

КонецПроцедуры

Процедура Тест_ИзменяетПолеЧерезДругойМетод() Экспорт

	Тест = ОП_Классы.Класс(Тест_ТестовыйКласс).Новый._();
	Документ = Тест.Документ._(
		ОП_Классы.Класс(Тест_Сотрудник).Новый._(
			"Иван", "Иванов", "Инженер серверной разработки"
		)
	);
	ЮТест.ОжидаетЧто(Тест.Статус._()).Равно("Создан документ");

КонецПроцедуры
