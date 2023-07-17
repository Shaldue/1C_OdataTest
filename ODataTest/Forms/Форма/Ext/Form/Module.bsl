﻿
&НаКлиенте
Процедура ВыполнитьЗапросКоманда(Команда)
	ТелоОтвета = "";
	ВыполнитьЗапросНаСервере();
КонецПроцедуры

&НаСервере
Процедура ВыполнитьЗапросНаСервере()
	
	Если Сервер = "" Тогда
		Сервер = "192.168.1.11/alex_asu2";
	КонецЕсли;
	
	Если Адрес = "" Тогда
		Адрес = "odata/standard.odata/Catalog_%D0%92%D0%B0%D0%BB%D1%8E%D1%82%D1%8B?$format=json";	
	КонецЕсли;
	
	Если Телозапроса = "" Тогда
		ТелоЗапроса = СформироватьJSON();
	КонецЕсли;
	
	Если Метод = "" Тогда
		Метод = "GET";
	КонецЕсли;
	
	ВыполнитьЗапрос(Метод); 
	
КонецПроцедуры

&НаСервере
Функция СформироватьJSON()
	
	Запись = Новый ЗаписьJSON;
	Запись.УстановитьСтроку();
	
	Запись.ЗаписатьНачалоОбъекта();
	
	Запись.ЗаписатьИмяСвойства("Description");
	Запись.ЗаписатьЗначение("Odata");
	
	Запись.ЗаписатьКонецОбъекта();
	
	СтрокаJSON = Запись.Закрыть();
	
	Возврат СтрокаJSON;
	
КонецФункции // СформироватьJSON()

&НаСервере
Процедура ВыполнитьЗапрос(ИмяМетода)
	
	Сообщение = Новый СообщениеПользователю;
	
	Попытка
		HTTPСоединение = Новый HTTPСоединение(Сервер,,Пользователь,Пароль,,,,);	
	Исключение
		ТелоОтвета = "Неудалось соединиться с сервером" + Сервер + Символы.ПС + ОписаниеОшибки();
		Возврат;
	КонецПопытки;
	
	HTTPЗапрос = Новый HTTPЗапрос(Адрес);
	Если ИмяМетода <> "GET" И ИмяМетода <> "DELETE" Тогда
		HTTPЗапрос.УстановитьТелоИзСтроки(ТелоЗапроса);
	КонецЕсли;
	
	Попытка
		Результат = HTTPСоединение.ВызватьHTTPМетод(ИмяМетода, HTTPЗапрос);
		ТелоОтвета = Результат.ПолучитьТелоКакСтроку();
	Исключение
		ТелоОтвета = ОписаниеОшибки();
		Возврат;
	КонецПопытки;
		
КонецПроцедуры

&НаКлиенте
Процедура Очистить(Команда)
	ОчисткаПолей();	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ОчисткаПолей();
	Метод = "GET";
КонецПроцедуры

&НаСервере
Процедура ОчисткаПолей()
	ТелоЗапроса = "{" + Символы.ПС + "}";
	ТелоОтвета = "{" + Символы.ПС + "}";	
КонецПроцедуры
