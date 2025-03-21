#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОписаниеПеременных

Перем Метод; // Строка
Перем ТипМетода; // Строка
Перем Модуль; // ОбщийМодуль
Перем Класс; // ФиксированнаяСтруктура
Перем Экземпляр; // Структура
Перем ПубличныйЭкземпляр; // ФиксированнаяСтруктура

#КонецОбласти

#Область ПрограммныйИнтерфейс

// Вызывает метод экземпляра.
// 
// Параметры:
//  Параметр1 - Произвольный - Параметр1
//  Параметр2 - Произвольный - Параметр2
//  Параметр3 - Произвольный - Параметр3
//  Параметр4 - Произвольный - Параметр4
//  Параметр5 - Произвольный - Параметр5
//  Параметр6 - Произвольный - Параметр6
//  Параметр7 - Произвольный - Параметр7
// 
// Возвращаемое значение:
//  Произвольный
Функция _(Параметр1 = Неопределено, Параметр2 = Неопределено, Параметр3 = Неопределено,
	Параметр4 = Неопределено, Параметр5 = Неопределено, Параметр6 = Неопределено,
	Параметр7 = Неопределено) Экспорт

	Параметры = Новый Массив();
	
	// TODO: возможно, под конструктор нужен отдельный объект-модуль, 
	// а то сейчас, кажется, что тут все намешано. 
	// Например, свойство Класс нужно только для конструктора.
	ЭтоКонструктор = ТипМетода = ОП_Перечисления.ТипыМетодов().Конструктор;
	Если ЭтоКонструктор Тогда
		УстановитьОбъект(ОП_Экземпляры.Экземпляр(Класс));
	КонецЕсли;

	Если Экземпляр = Неопределено Тогда
		ВызватьИсключение("Экземпляр класса не определен");
	КонецЕсли;

	ДобавитьПараметр(Параметры, Экземпляр);
	ДобавитьПараметр(Параметры, Параметр1);
	ДобавитьПараметр(Параметры, Параметр2);
	ДобавитьПараметр(Параметры, Параметр3);
	ДобавитьПараметр(Параметры, Параметр4);
	ДобавитьПараметр(Параметры, Параметр5);
	ДобавитьПараметр(Параметры, Параметр6);
	ДобавитьПараметр(Параметры, Параметр7);

	Результат = Неопределено;
	Если ЭтоКонструктор Тогда
		ОП_Экземпляры.ПриСоздании(Модуль, Параметры);
		Результат = Экземпляр;
	Иначе
		Если ОП_Рефлексия.ЭтоПроцедураОбъекта(Модуль, Метод) Тогда
			ОП_Рефлексия.ВызватьПроцедуруОбъекта(Модуль, Метод, Параметры);
		Иначе
			Результат = ОП_Рефлексия.ВызватьФункциюОбъекта(Модуль, Метод, Параметры);		
		КонецЕсли;			
	КонецЕсли;
	
	Если Результат = Экземпляр Тогда
		Возврат ПубличныйЭкземпляр(Результат);
	КонецЕсли;
	Возврат Результат;

КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Устанавливает имя метода.
// 
// Параметры:
//  Тип - Строка - Тип метода. Типы методов см. в ОП_Перечисления.ТипыМетодов
Процедура УстановитьТипМетода(Тип) Экспорт
	ПроверитьЗаполненность("ТипМетода", ТипМетода);
	ТипМетода = Тип;
КонецПроцедуры

// Устанавливает имя метода.
// 
// Параметры:
//  Имя - Строка - Имя метода
Процедура УстановитьИмяМетода(Имя) Экспорт
	ПроверитьЗаполненность("Метод", Метод);
	Метод = Имя;
КонецПроцедуры

// Устанавливает модуль, в котором описан класс.
// 
// Параметры:
//  ОбщийМодуль - ОбщийМодуль - Общий модуль
Процедура УстановитьМодуль(ОбщийМодуль) Экспорт
	ПроверитьЗаполненность("Модуль", Модуль);
	Модуль = ОбщийМодуль;
КонецПроцедуры

// Устанавливает текущий экземпляр объекта.
// 
// Параметры:
//  Объект - Структура - Объект
Процедура УстановитьОбъект(Объект) Экспорт
	ПроверитьЗаполненность("Экземпляр", Экземпляр);
	Экземпляр = Объект;
КонецПроцедуры

// Устанавливает текущий экземпляр объекта.
// 
// Параметры:
//  Класс_ - ФиксированнаяСтруктура - Объект
Процедура УстановитьКласс(Класс_) Экспорт
	ПроверитьЗаполненность("Класс", Класс);
	Класс = Класс_;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Параметры:
//  Параметры - Массив из Произвольный - Параметры
//  Значение - Произвольный - Значение
Процедура ДобавитьПараметр(Параметры, Значение) Экспорт
	Если Значение <> Неопределено Тогда
		Параметры.Добавить(Значение);
	КонецЕсли;
КонецПроцедуры

Функция ПубличныйЭкземпляр(Экземпляр) Экспорт
	
	Если ПубличныйЭкземпляр = Неопределено Тогда
		Копия = Новый Структура();
		Для каждого КлючЗначение Из Экземпляр Цикл
			Копия.Вставить(КлючЗначение.Ключ, КлючЗначение.Значение);
		КонецЦикла;
	
		Для каждого Переменная Из Экземпляр.Класс.Переменные Цикл
			Если Переменная.МодификаторДоступа = ОП_Перечисления.МодификаторыДоступа().Служебно Тогда
				Копия.Удалить(Переменная.Имя);
			Иначе
				Копия[Переменная.Имя] = Обработки.ОП_Присваиватель.Присваиватель(
					Экземпляр,
					Переменная.Имя,
					Копия[Переменная.Имя]
				);
			КонецЕсли;
		КонецЦикла;
		ПубличныйЭкземпляр = Новый ФиксированнаяСтруктура(Копия);
	КонецЕсли;
	Возврат ПубличныйЭкземпляр;
	
КонецФункции
	
Процедура ПроверитьЗаполненность(Поле, Значение)

	Если ЗначениеЗаполнено(Значение) Тогда
		ВызватьИсключение(СтрШаблон("Поле %1 недоступно для записи", Поле));
	КонецЕсли;
	
КонецПроцедуры
		
#КонецОбласти

#КонецЕсли
