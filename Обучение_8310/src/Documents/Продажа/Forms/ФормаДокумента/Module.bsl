

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Сообщить("Все ок");
КонецПроцедуры

&НаКлиенте
Процедура ПровестиИЗакрыть(Команда)

	КО = ПредопределенноеЗначение("Справочник.КлючевыеОперации.ПроведениеДокументаПродажа");
	ОценкаПроизводительностиКлиентСервер.НачатьЗамерВремени(КО);
	ПараметрыЗаписи = Новый Структура;
	ПараметрыЗаписи.Вставить("РежимЗаписи",РежимЗаписиДокумента.Проведение);
	Записать(ПараметрыЗаписи);
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ОтображатьКнопкуЗакрытия = Ложь;
КонецПроцедуры
