Примечаие:
		Касаемо 4-ой задачи у меня нет еще каких-либо идей по ее реализации или оптимизации.
		Касаемо 5-ой задачи у меня есть полное осознание, что, в принципе, не имеет смысла перезаписывать элементы дерева в так называемую 
		"Исполняемую последовательность". Можно было выпонять действия с элментами в течении "первом проходе"
		 (или "заполнения исполняемой последовательности"), используя алгоритм первой задачи, но вместо печати детей и родителей 
		 просто перезаписывать результат дествия в ячейку в котрой хранится родитель (Нужно было бы только поменять шаг-переход между уровнями дерева с 2 до 1, 
		 так как родитель печается один раз,а в дееве с математическими действиями, после исполнения действия и записи результат на метсо родителя, мы снова 
		 обращаемся к нему). Такая реализация дала бы выигрыш во времени примерно раза в полтора (наверно) и код бы занимал в два раза меньше места. 
		 Однако речь идет о "первой идее" или "первой реализации", более того о "дедлайне". Таким образом представлена далеко не самый оптимальный, 
		 но в полне корректный алгоритм.