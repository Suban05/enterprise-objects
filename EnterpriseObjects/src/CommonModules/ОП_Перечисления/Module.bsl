// @strict-types

#Область ПрограммныйИнтерфейс

// Возвращает список типов методов.
// 
// Возвращаемое значение:
//  Структура - Типы:
// * Конструктор - Строка
// * Метод - Строка
Функция ТипыМетодов() Экспорт

	Типы = Новый Структура;
	Типы.Вставить("Конструктор", "Конструктор");
	Типы.Вставить("Метод", "Метод");
	Возврат Типы;

КонецФункции

// Возвращает список типов модификаторов доступа.
// 
// Возвращаемое значение:
//  Структура - Типы:
// * Экспорт - Строка
// * Служебно - Строка
Функция МодификаторыДоступа() Экспорт

	Типы = Новый Структура;
	Типы.Вставить("Экспорт", "Экспорт");
	Типы.Вставить("Служебно", "Служебно");
	Возврат Типы;

КонецФункции

#КонецОбласти