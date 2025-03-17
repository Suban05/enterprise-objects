# Enterprise objects

Фреймворк, позволяющий писать код в платформе 1С:Предприятие в объектно-ориентированного стиле.

## Базовый пример

Представим, что у нас есть класс `Кот`.

Вот как мы можем создать его объект:

```bsl
Вася = ОП_Классы.Класс(Кот).Новый._("Вася");
```

Разберем подробнее этот код.

Выражение `ОП_Классы.Класс(Кот)` конструирует класс (структуру) на основе кода, описанного в общем модуле `Кот`.

У класса мы можем вызвать конструктор экземпляра класса `Новый._()`. Это не совсем обычный вызов метода, который можно представить в рамках платформы 1С. По причине ограниченности платформы, мне показалось, что именно такой синтаксис является хорошим способом выразить вызов метода у объекта.
Так что, в рамках нашего фреймворка, методы мы можем вызывать так: `Объект.Метод._()`.

Теперь давайте опишем класс `Кот`.

Создадим общий модуль и реализуем в нем метод `Инициализация`:

```bsl
// ОбщийМодуль.Кот

Процедура Инициализация(Этот) Экспорт

    // Указываем свойства объекта. 
    // По умолчанию свойства всегда приватные.
    Этот.Перем._("Имя");

    // Указываем, что метод будет доступен для вызова из экземпляра
    Этот.Метод._("Мяу");

КонецПроцедуры
```

Метод `Инициализация` принимает в качестве параметра объект `Этот` - это наш класс. Этот метод нужен для описания нашего класса. В нем мы указываем свойства объекта, какие методы объект может принимать, и что класс расширяет.

Чтобы указать свойство объекта, мы можем сделать это так: `Этот.Перем._("Имя")`. По умолчанию свойство всегда приватное.

Чтобы указать публичное свойство, то нужно сделать так: 

```bsl
Этот.Перем._("ЛюбимаяЕда").Экспорт._()
```

Если мы так напишем, то для нашего котика `Вася` автоматически сгенерируются геттеры и сеттеры для поля `ЛюбимаяЕда`. 

```bsl
// сеттер
Вася.ЛюбимаяЕда._("Индейка");

// геттер
Вася.ЛюбимаяЕда._() // "Индейка"
```

Далее опишем конструктор:

```bsl
// Конструктор
Процедура ПриСозданииОбъекта(Этот, Имя) Экспорт
    Этот.Имя = Имя;
КонецПроцедуры
```

Здесь мы указали, что параметром конструктора выступает `Имя`. Обратите внимание на первый параметр. 
Особенность в том, что в каждом методе экземпляра класса, в том числе и конструкторе, первым параметром всегда выступает текущий экземпляр. Это как `this` или `self` в других объектных языках.

И, на конец, опишем метод `Мяу`, который выше мы указали в качестве принимаего метода:

```bsl
Процедура Мяу(Этот) Экспорт
    Сообщить(СтрШаблон("Мяу, я %1", Этот.Имя));
КонецПроцедуры
```

Вот как мы можем вызвать метод:

```bsl
Вася.Мяу._(); // Мяу, я Вася
```
