# Minor-Project
## Проектирование базы данных для фирмы, занятой в торговле
### Выполнили студенты 3-го курса:  
+ Жигульская Евгения Леонидовна - БЭК193
+ Казаченко Иван Сергеевич - БЭК193
+ Казаченко Илья Сергеевич - БЭК193 
+ Шалашов Андрей Алексеевич - БЭК193 
### Задача
Спроектировать базу данных, которая помогла бы оценить примерные затраты на магазин, а в будущем позволила бы определить оптимальую модель ведения бизнеса.
### Сфера
Мы рассмотрим сферу ритейла товаров электроники. Наш бизнес осуществляет торговлю различными гаджетами - сматфоны, наушники и т.д., работает как онлайн, так и в офлайн формате. Чаще всего в нашей БД будут совершаться операции по продаже товаров, а также по поставкам, так как это основная деятельность магазина. 
### Актуальность
Как нам кажется, эта тема весьма актуальна, так как подходит под многие “кейсы” современного бизнеса, внеся некоторые незначительные корректировки, эту базу данных можно использовать для других сфер: одежда, канцелярия, косметика и тд. Прежде всего эта база данных нужна для для хранения информации о товарах магазина, о ближайших поставках, о проданных товарах (в онлайн/офлайн формате), о клиентах, о суммах их покупок, о суммах скидок, а также всю информацию о персонале магазина.
### Техническое решение
Бизнес находится на стади развития, поэтому нам важно выбрать правильное решение, для хранения данных и обеспечения доступа к ним. 
Работать с базами данных гораздо удобнее, чем просто с файлами, так как они упорядочивают информацию. Функционал баз данных позволяет делать множество полезных штук, таких как запросы с логическими условиями, группировка и сортировка значений, выборка из определенного промежутка и другое.
В качестве решения, мы выбрали облачную базу данных - DBaaS (Database as a Service). Облачный кластер можно достаточно быстро и удобно развернуть у любого провайдера IT-инфраструктуры. На облачной базе данных (Managed Databases) можно запустить любую удобную СУБД - MySQL, PostgreSQL, Redis, Neo4j, mongoDB. 
Преимущества облачной инфраструктуры:  
+ Масштабируемость. С развитием бизнеса будет увеличиваться объём данных для хранения, а также нагрузка на базу данных. Облачные решения позволяют масштабировать кластеры быстро и без потерь.  
+ Отказоустойчивость и качество. Компании, предоставляющие данную услугу берут на себя обеспечение ее работоспособности и круглосуточную поддержу со стороны инженеров и системных адинистраторов.  
+ Бэкапы. Помимо мастера (ведущего сервера кластера баз данных, через который осуществляются чтение, запись и прочие обновления данных) можно создать реплику, которая в точности повторяет мастера, но доступна только для чтения. Бэкапы позволяют восстановить данные при форсмажорах и авариях без потерь.
### Проектирование БД
Мы построили схему БД для фирмы, а также прописали скрипт её создания на PostgreSQL. Типы данных для первичных ключей мы записывать не стали, так как они очевидные и везде будут одинаковыми (тип serial). В уже реализованной базе данных в PostgreSQL он будет работать как порядковый номер и сам заполняться.  
Также следует внести комментарии по некоторым названиям, которые могут быть не совсем очевидны. 
+ “Type_of_delivery” это тип доставки, который выбирает клиент (может быть самовывоз, доставка в пункт выдачи, доставка курьером). 
+ “worker_id” в сущности онлайн продаж означает человека, который собирал заказ, а в оффлайн продажах того, кто пробивал товар на кассе. 
+ “payment_method” - это тип оплаты наличными при получении/онлайн картой/ картой при получении. 
+ “deliveries” - это сущность, которая несет в себе информацию о поставках товаров в магазин.  

В нашей БД мы реализовали систему карт лояльности для клиентов магазина. Сущность “loyalty_card_holders” содержит информацию о клиентах, о суммарном размере их покупок, а также текущей скидке по карте. В сущности “loyalty_card_discounts” хранится информация о скидочной политике магазина, от какой суммы покупок работает та или иная скидка.  
Что касается работников магазина, то там реализована сущность с должностями (staff), с самими работниками (workers), а также с их премиями и бонусами (bonus_for_worker). 
##Связки “один ко многим” использовались: 
+ для карт лояльности и продаж (так как на одну карту может быть несколько покупок, но одна покупка на несколько карт не может быть реализована). 
+ для работника и продаж (так как один работник может пробить на кассе  несколько заказов, но один заказ не может быть пробит несколькими работниками). 
+ для категории товара и самого товара (один товар может относиться только к одной категории, а категория может относиться ко многим товарам). 
+ для должности и работника (работник может занимать только одну должность, а должность может быть занята несколькими работниками (3 менеджера)). 
+ для карты лояльности и размера скидки (одна и та же скидка может быть у нескольких карт, а одна карта может иметь одну скидку). 

Мы считаем, связки “многие ко многим” в целом  интуитивно понятны и не нуждаются в подробном объяснении. 
