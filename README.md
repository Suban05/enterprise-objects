# Enterprise objects

Фреймворк, позволяющий писать код в платформе 1С:Предприятие в объектно-ориентированного стиле.

## Суть

В альтернативной реализации языка 1С - OneScript - возможность писать в объектно-ориентированном стиле реализована. Да, это не полноценное ООП, но тот уровень свободы, который там предоставляется, дает возможность придумывать решения, которые хоть как-то похожи на объектно-ориентированное программирование. Оригинальная платформа в этом плане очень ограничена. Мы можем использовать обработки для описания абстракций, но, честно говоря, у меня такой подход вызывает странные ощущения. Вроде бы, это, действительно, помогает, но с другой стороны, кажется, что назначение этого объекта метаданных совсем другое.
Опыт разработки на других языках, в таких как Java, Ruby, а также изучение концепции Elegant objects, и языка, основанного на этой концепции - eo, раскрыл для меня ООП в новом виде. И у меня появилась идея создать концепцию ООП в платформе 1С, используя структуры и общие модули. Да, подход не новый, и в сообществе было достаточно рекомендаций использовать эти объекты для имитации ООП, но то, что предлагается, не позволяет писать код в элегантном, объектном стиле.

В чем суть моей идеи.

Мы имеем структуры. Структура, по своей сути, объект динамический. Мы можем задавать ключи в произвольном виде, с произвольными строковыми ключами, соблюдая правила именования идентификаторов. Так почему бы нам не сделать так, чтобы значения ключей были не простыми, а имели возможность вызывать какое-то поведение? 

Давайте покажу на примерах.

Вот пример, как можно создать объект в нашем фреймворке:

```bsl
Объект = ОП_Классы.Класс(Кот).Новый._()
```

Разберем подробнее этот код.

`ОП_Классы.Класс(Кот)` - это структура. Вызывая этот метод, мы конструируем структуру на основе класса, описанного в общем модуле.

У класса мы можем вызвать конструктор экземпляра класса `Новый._()`. Да, это не совсем чистый вызов метода, который можно представить в рамках платформы 1С, но выглядит как что-то похожее на вызов метода.
Так что давайте просто примем тот факт, что в рамках фреймворка методы мы можем вызывать так: `Объект.Метод._()`.

Конструктор как метод класса был сделан намеренно, чтобы код выглядел более объектным.

Давайте опишем класс `Кот`.

Создадим общий модуль и в нем реализуем метод `Инициализация`:

```bsl
// ОбщийМодуль.Кот

Процедура Инициализация(Этот) Экспорт

    // Указываем свойства объекта. 
    // По умолчанию свойства всегда приватные.
    Этот.Перем._("Имя");

    // Указываем, что метод будет доступен для вызова
    Этот.Метод._("Мяу");

КонецПроцедуры
```

```bsl
// Конструктор
Процедура ПриСозданииОбъекта(Этот, Имя) Экспорт
    Этот.Имя = Имя;
КонецПроцедуры

Процедура Мяу(Этот) Экспорт
    Сообщить("Мяу");
КонецПроцедуры
```

Обратите внимание, что в каждом методе экземпляра класса первым параметром выступает текущий экземпляр, для которого вызвался метод. Внутри этого контекста нам доступны поля на редактирования.

А вот как мы можем создавать объект и работать с ним:

```bsl
Вася = ОП_Классы.Класс(Кот).Новый._("Вася");
Вася.Мяу._();
```