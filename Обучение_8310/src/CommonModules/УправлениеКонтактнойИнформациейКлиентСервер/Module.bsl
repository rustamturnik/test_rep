////////////////////////////////////////////////////////////////////////////////
// Подсистема "Контактная информация".
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// ПРОГРАММНЫЙ ИНТЕРФЕЙС

// Функция формирует представление с видом для формы ввода адреса.
//
// Параметры:
//    СтруктураАдреса  - Структура - структура адреса.
//    Представление    - Строка - представление адреса.
//    НаименованиеВида - Строка - наименование вида.
//
// Возвращаемое значение:
//    Строка - представление адреса с видом.
//
Функция СформироватьПредставлениеАдреса(СтруктураАдреса, Представление, НаименованиеВида = Неопределено) Экспорт 
	
	Представление = "";
	
	Страна = ЗначениеПоКлючуСтруктуры("Страна", СтруктураАдреса);
	
	Если Страна <> Неопределено Тогда
		ДополнитьПредставлениеАдреса(СокрЛП(ЗначениеПоКлючуСтруктуры("НаименованиеСтраны", СтруктураАдреса)), ", ", Представление);
	КонецЕсли;
	
	ДополнитьПредставлениеАдреса(СокрЛП(ЗначениеПоКлючуСтруктуры("Индекс", СтруктураАдреса)),			", ", Представление);
	ДополнитьПредставлениеАдреса(СокрЛП(ЗначениеПоКлючуСтруктуры("Регион", СтруктураАдреса)),			", ", Представление);
	ДополнитьПредставлениеАдреса(СокрЛП(ЗначениеПоКлючуСтруктуры("Район", СтруктураАдреса)),			", ", Представление);
	ДополнитьПредставлениеАдреса(СокрЛП(ЗначениеПоКлючуСтруктуры("Город", СтруктураАдреса)),			", ", Представление);
	ДополнитьПредставлениеАдреса(СокрЛП(ЗначениеПоКлючуСтруктуры("НаселенныйПункт", СтруктураАдреса)),	", ", Представление);
	ДополнитьПредставлениеАдреса(СокрЛП(ЗначениеПоКлючуСтруктуры("Улица", СтруктураАдреса)),			", ", Представление);
	ДополнитьПредставлениеАдреса(СокрЛП(ЗначениеПоКлючуСтруктуры("Дом", СтруктураАдреса)),				", " + ЗначениеПоКлючуСтруктуры("ТипДома", СтруктураАдреса) + " № ", Представление);
	ДополнитьПредставлениеАдреса(СокрЛП(ЗначениеПоКлючуСтруктуры("Корпус", СтруктураАдреса)),			", " + ЗначениеПоКлючуСтруктуры("ТипКорпуса", СтруктураАдреса)+ " ", Представление);
	ДополнитьПредставлениеАдреса(СокрЛП(ЗначениеПоКлючуСтруктуры("Квартира", СтруктураАдреса)),			", " + ЗначениеПоКлючуСтруктуры("ТипКвартиры", СтруктураАдреса) + " ", Представление);
	
	Если СтрДлина(Представление) > 2 Тогда
		Представление = Сред(Представление, 3);
	КонецЕсли;
	
	НаименованиеВида	= ЗначениеПоКлючуСтруктуры("НаименованиеВида", СтруктураАдреса);
	ПредставлениеСВидом = НаименованиеВида + ": " + Представление;
	
	Возврат ПредставлениеСВидом;
	
КонецФункции

// Формирует строковое представление телефона.
//
// Параметры:
//    КодСтраны     - Строка - код страны.
//    КодГорода     - Строка - код города.
//    НомерТелефона - Строка - номер телефона.
//    Добавочный    - Строка - добавочный номер.
//    Комментарий   - Строка - комментарий.
//
// Возвращаемое значение - Строка - представление телефона.
//
Функция СформироватьПредставлениеТелефона(КодСтраны, КодГорода, НомерТелефона, Добавочный, Комментарий) Экспорт
	
	Представление = СокрЛП(КодСтраны);
	Если Не ПустаяСтрока(Представление) И Лев(Представление,1)<>"+" Тогда
		Представление = "+" + Представление;
	КонецЕсли;
	
	Если Не ПустаяСтрока(КодГорода) Тогда
		Представление = Представление + ?(ПустаяСтрока(Представление), "", " ") + "(" + СокрЛП(КодГорода) + ")";
	КонецЕсли;
	
	Если Не ПустаяСтрока(НомерТелефона) Тогда
		Представление = Представление + ?(ПустаяСтрока(Представление), "", " ") + СокрЛП(НомерТелефона);
	КонецЕсли;
	
	Если НЕ ПустаяСтрока(Добавочный) Тогда
		Представление = Представление + ?(ПустаяСтрока(Представление), "", ", ") + "доб. " + СокрЛП(Добавочный);
	КонецЕсли;
	
	Если НЕ ПустаяСтрока(Комментарий) Тогда
		Представление = Представление + ?(ПустаяСтрока(Представление), "", ", ") + СокрЛП(Комментарий);
	КонецЕсли;
	
	Возврат Представление;
	
КонецФункции

//Возвращает структуру контактной информации по типу
//
// Параметры:
//    ТипКИ - тип контактной информации
//
// Возвращаемое значение:
//    СтруктураКИ - пустая структура контактной информации, ключи - имена полей, значения поля
//
Функция СтруктураКонтактнойИнформацииПоТипу(ТипКИ) Экспорт
	
	Если ТипКИ = ПредопределенноеЗначение("Перечисление.ТипыКонтактнойИнформации.Адрес") Тогда
		Возврат СтруктураПолейАдреса();
	ИначеЕсли ТипКИ = ПредопределенноеЗначение("Перечисление.ТипыКонтактнойИнформации.Телефон") Тогда
		Возврат СтруктураПолейТелефона();
	Иначе
		Возврат Новый Структура;
	КонецЕсли;
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

// Дополняет представление адреса строкой.
//
// Параметры:
//    Дополнение         - Строка - дополнение адреса.
//    СтрокаКонкатенации - Строка - строка конкатенации.
//    Представление      - Строка - представление адреса.
//
Процедура ДополнитьПредставлениеАдреса(Дополнение, СтрокаКонкатенации, Представление)
	
	Если Дополнение <> "" Тогда
		Представление = Представление + СтрокаКонкатенации + Дополнение;
	КонецЕсли;
	
КонецПроцедуры

// Возвращает строку значения по свойству структуры.
// 
// Параметры:
//    Ключ - Строка - ключ структуры.
//    Структура - Структура - передаваемая структура.
//
// Возвращаемое значение - ПустаяСтрока или ПроизвольныйТип - значение.
//
Функция ЗначениеПоКлючуСтруктуры(Ключ, Структура)
	
	Значение = Неопределено;
	
	Если Структура.Свойство(Ключ, Значение) Тогда 
		Возврат Строка(Значение);
	КонецЕсли;
	
	Возврат "";
	
КонецФункции

// Возвращает строку дополнительных значений по имени реквизита.
//
// Параметры:
//    Форма - Форма - передаваемая форма.
//    ИмяРеквизита - Строка с именем реквизита.
//
// Возвращаемое значение - Неопределено или СтрокаКоллекции - строка коллекции.
//
Функция ПолучитьСтрокуДополнительныхЗначений(Форма, ИмяРеквизита) Экспорт
	
	Отбор = Новый Структура("ИмяРеквизита", ИмяРеквизита);
	Строки = Форма.КонтактнаяИнформацияОписаниеДополнительныхРеквизитов.НайтиСтроки(Отбор);
	
	Возврат ?(Строки.Количество() = 0, Неопределено, Строки[0]);
	
КонецФункции

// Возвращает пустую структура адреса
//
// Возвращаемое значение:
//    СтруктураАдреса - ключи - имена полей, значения поля
//
Функция СтруктураПолейАдреса() Экспорт
	
	СтруктураАдреса = Новый Структура;
	СтруктураАдреса.Вставить("Представление", "");
	СтруктураАдреса.Вставить("Страна", "");
	СтруктураАдреса.Вставить("НаименованиеСтраны", "");
	СтруктураАдреса.Вставить("КодСтраны","");
	СтруктураАдреса.Вставить("Индекс","");
	СтруктураАдреса.Вставить("Регион","");
	СтруктураАдреса.Вставить("РегионСокращение","");
	СтруктураАдреса.Вставить("Район","");
	СтруктураАдреса.Вставить("РайонСокращение","");
	СтруктураАдреса.Вставить("Город","");
	СтруктураАдреса.Вставить("ГородСокращение","");
	СтруктураАдреса.Вставить("НаселенныйПункт","");
	СтруктураАдреса.Вставить("НаселенныйПунктСокращение","");
	СтруктураАдреса.Вставить("Улица","");
	СтруктураАдреса.Вставить("УлицаСокращение","");
	СтруктураАдреса.Вставить("Дом","");
	СтруктураАдреса.Вставить("Корпус","");
	СтруктураАдреса.Вставить("Квартира","");
	СтруктураАдреса.Вставить("ТипДома","");
	СтруктураАдреса.Вставить("ТипКорпуса","");
	СтруктураАдреса.Вставить("ТипКвартиры","");
	СтруктураАдреса.Вставить("НаименованиеВида","");
	
	Возврат СтруктураАдреса;
	
КонецФункции

// Возвращает пустую структура телефона
//
// Возвращаемое значение:
//    СтруктураТелефона - ключи - имена полей, значения поля
//
Функция СтруктураПолейТелефона() Экспорт
	
	СтруктураТелефона = Новый Структура;
	СтруктураТелефона.Вставить("Представление", "");
	СтруктураТелефона.Вставить("КодСтраны", "");
	СтруктураТелефона.Вставить("КодГорода", "");
	СтруктураТелефона.Вставить("НомерТелефона", "");
	СтруктураТелефона.Вставить("Добавочный", "");
	СтруктураТелефона.Вставить("Комментарий", "");
	
	Возврат СтруктураТелефона;
	
КонецФункции

// Получает сокращение географического названия объекта
//
// Параметры:
//    ГеографическоеНазвание - географическое название объекта
//
// Возвращаемое значение - Пустая строка или Последнее слово в географическом названии
//
Функция АдресноеСокращение(Знач ГеографическоеНазвание) Экспорт
	
	Сокращение = "";
	МассивСлов = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивСлов(ГеографическоеНазвание, " ");
	Если МассивСлов.Количество() > 1 Тогда
		Сокращение = МассивСлов[МассивСлов.Количество() - 1];
	КонецЕсли;
	
	Возврат Сокращение;
	
КонецФункции

// Возвращает строку списка полей.
//
// Параметры:
//    СоответствиеПолей - список значений - соответствия полей.
//    БезПустыхПолей    - необязательный флаг сохранения полей с пустыми значениями
//
//  Возвращаемое значение - строка, преобразованная из списка
//
Функция ПреобразоватьСписокПолейВСтроку(СоответствиеПолей, БезПустыхПолей=Истина) Экспорт
	
	СтруктураЗначенийПолей = Новый Структура;
	Для Каждого Элемент Из СоответствиеПолей Цикл
		СтруктураЗначенийПолей.Вставить(Элемент.Представление, Элемент.Значение);
	КонецЦикла;
	
	Возврат СтрокаПолей(СтруктураЗначенийПолей, БезПустыхПолей);
КонецФункции

// Возвращает список значений. Преобразует строку полей в список значений.
//
// Параметры:
//    СтрокаПолей - Строка - строка полей.
//
// Возвращаемое значение - Список значений - список значений полей.
//
Функция ПреобразоватьСтрокуВСписокПолей(СтрокаПолей) Экспорт
	
	// XML сериализацию преобразовывать не надо
	Если КонтактнаяИнформацияКлиентСервер.ЭтоКонтактнаяИнформацияВXML(СтрокаПолей) Тогда
		Возврат СтрокаПолей;
	КонецЕсли;
	
	Результат = Новый СписокЗначений;
	
	СтруктураЗначенийПолей = СтруктураЗначенийПолей(СтрокаПолей);
	Для каждого ЗначениеПоля Из СтруктураЗначенийПолей Цикл
		Результат.Добавить(ЗначениеПоля.Значение, ЗначениеПоля.Ключ);
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

//  Преобразует строку полей вида ключ=значение в структуру
//
//  Параметры:
//      СтрокаПолей             - строка полей с данными в виде ключ=значение
//      ВидКонтактнойИнформации - необязательный вид КИ для определения состава незаполненных полей
//
//  Возвращаемое значение: структура значений полей.
//
Функция СтруктураЗначенийПолей(СтрокаПолей, ВидКонтактнойИнформации=Неопределено) Экспорт
	
	Если ВидКонтактнойИнформации = Неопределено Тогда
		Результат = Новый Структура;
	Иначе
		Результат = СтруктураКонтактнойИнформацииПоТипу(ВидКонтактнойИнформации.Тип);
	КонецЕсли;
	
	ПоследнийЭлемент = Неопределено;
	
	Для Итерация = 1 По СтрЧислоСтрок(СтрокаПолей) Цикл
		ПолученнаяСтрока = СтрПолучитьСтроку(СтрокаПолей, Итерация);
		Если Лев(ПолученнаяСтрока, 1) = Символы.Таб Тогда
			Если Результат.Количество() > 0 Тогда
				Результат.Вставить(ПоследнийЭлемент, Результат[ПоследнийЭлемент] + Символы.ПС + Сред(ПолученнаяСтрока, 2));
			КонецЕсли;
		Иначе
			ПозицияСимвола = Найти(ПолученнаяСтрока, "=");
			Если ПозицияСимвола <> 0 Тогда
				НазваниеПоля = Лев(ПолученнаяСтрока, ПозицияСимвола - 1);
				ЗначениеПоля = Сред(ПолученнаяСтрока, ПозицияСимвола + 1);
				Если НазваниеПоля = "Регион" Или НазваниеПоля = "Район" Или НазваниеПоля = "Город" 
					Или НазваниеПоля = "НаселенныйПункт" Или НазваниеПоля = "Улица" Тогда
					Если Найти(СтрокаПолей, НазваниеПоля + "Сокращение") = 0 Тогда
						Результат.Вставить(НазваниеПоля + "Сокращение", АдресноеСокращение(ЗначениеПоля));
					КонецЕсли;
				КонецЕсли;
				Результат.Вставить(НазваниеПоля, ЗначениеПоля);
				ПоследнийЭлемент = НазваниеПоля;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

//  Возвращает строку списка полей.
//
//  Параметры:
//    СтруктураЗначенийПолей - структура значений полей.
//      БезПустыхПолей       - необязательный флаг сохранения полей с пустыми значениями
//
//  Возвращаемое значение - строка, преобразованная из структуры
//
Функция СтрокаПолей(СтруктураЗначенийПолей, БезПустыхПолей=Истина) Экспорт
	
	Результат = "";
	Для Каждого ЗначениеПоля Из СтруктураЗначенийПолей Цикл
		Если БезПустыхПолей И ПустаяСтрока(ЗначениеПоля.Значение) Тогда
			Продолжить;
		КонецЕсли;
		
		Результат = Результат + ?(Результат = "", "", Символы.ПС)
		            + ЗначениеПоля.Ключ + "=" + СтрЗаменить(ЗначениеПоля.Значение, Символы.ПС, Символы.ПС + Символы.Таб);
	КонецЦикла;
	
	Возврат Результат;
КонецФункции