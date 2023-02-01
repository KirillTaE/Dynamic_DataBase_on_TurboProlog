
Domains
     name, world, color, sex, material = string
     europe, year, price = integer
	 file = datafile
	 arr = string*
	 integers = integer*
Database
     dt_shirt(name, price, sex, world, europe, color, material, year)
Predicates
     repeat
     do_mbase
     %assert_database
     menu
     process(integer)
     clear_database
     %t_shirt(name, price, sex, world, europe, color, material, year)
     error
	 read_until_not_integer(integer)
	 write_all
	 write_all(arr,integers,arr,arr,integers,arr,arr,integers)
	 write_all_csv
	 write_all_csv(arr,integers,arr,arr,integers,arr,arr,integers)
	 %list_to_set(arr,arr,arr)
	 %member(name,arr)
	 %reverse(arr,arr)
	 %reverse(arr,arr,arr)
	 read_rows()
	 front_string(string, string, string)
	 read_prov(integer)
	 find(integer)
	 find_shirt_name(string)
	 find_material(string)
	 find_name(string)
	 find_mat(string)
Goal
     do_mbase.
Clauses

	
     repeat.
     repeat:-repeat.
	 
                       /*База данных футболок*/
	 /*
     t_shirt("StarkCotton",695,"M","XXL", 57, "Red", "Cotton", 2021).
     t_shirt("B.O.M.J.",1000,"M","XXL", 27, "Blu", "Polyester", 2016).
	 t_shirt("Adidas",2115,"F","L", 37, "White", "Elastane", 2015).
	 t_shirt("Messi",2435,"F","M", 53, "Black", "Linen", 2001).
	 
                       /*конец начальных данных*/
					   
     assert_database:-
		 t_shirt(Name,Price,Sex,World,Europe,Color, Material,Year),
		 assertz(dt_shirt(Name,Price,Sex,World,Europe,Color, Material, Year)),
		 fail.
     assert_database:-!.
	*/
     clear_database:-
              retract(dt_shirt(_,_,_,_,_,_,_,_)),
              fail.
     clear_database:-!.

	read_prov(Vibor):- 
					readint(Vibor);
					
					error,
					Vibor = 0,
					menu.
								
     do_mbase :-
              %assert_database,
              makewindow(1,11,3," T-SHIRTS DATABASE ",0,0,25,80),
              menu,
              clear_database.

     menu :-
              repeat, clearwindow,
              nl,
              write(" ********************************* "),nl,
			  write(" * 1. Read Database from file    * "),nl,
              write(" * 2. Add new T-shirt in DB      * "),nl,
              write(" * 3. Delete T-shirt from DB     * "),nl,
              write(" * 4. Edit T-shirt in DB         * "),nl,
              write(" * 5. Find T-shirt               * "),nl,
              write(" * 6. Show all data              * "),nl,
			  write(" * 7. Write Database to file     * "),nl,
			  write(" * 8. Delete All DB              * "),nl,
              write(" * 9. Exit                       * "),nl,
              write(" ********************************* "),nl,
              write(" Choose number 1-9 : "),
              read_prov(Vibor),nl,
			  process(Vibor),Vibor = 9.

              /* Добавление информации офутболки в БД */

	 process(1) :-
				makewindow(2,11,3,"Read data from file",2,20,15,40),shiftwindow(2),		
				write("Input File name (data.csv): "),
				readln(Filename), 
				existfile(Filename),
				openread(datafile, Filename), 
				readdevice(datafile),
				read_rows(),
				closefile(datafile), readdevice(keyboard),
				write("DB successfully read from file."),nl,!,
				write("Press space bar"), readchar(_), 
                removewindow, shiftwindow(1), clearwindow, menu;
		
				%makewindow(7,11,3,"Read data from file",10,30,7,40),shiftwindow(6),
				write("Error reading file!"), nl, !,
				write("Press space bar."),readchar(_),
				removewindow, shiftwindow(1), clearwindow, menu, fail.
				
     process(2) :-
              makewindow(3,11,3,"Add data",2,20,18,58),shiftwindow(3),
              write("Please, Input T-shirt:"),nl,
              write("Name: "), readln(Name),
              write("Price (RUB): "), read_until_not_integer(Price),
              write("Sex: "), readln(Sex),
              write("Size (International) : "), readln(World),
              write("Size (Europe): "), read_until_not_integer(Europe),
              write("Color: "), readln(Color),
			  write("Material: "), readln(Material),
			  write("Production year: "), read_until_not_integer(Year),
			  assertz(dt_shirt(Name,Price,Sex,World,Europe,Color, Material,Year)),
              write(Name," added to DB"), nl,!,
              write("Press space bar. "), readchar(_),
              removewindow, shiftwindow(1), clearwindow, menu.

                       /* Удаление */

     process(3) :-
              makewindow(4,11,3,"Delete data",10,30,7,40),shiftwindow(4),
              write("Input T-shirt name: "), readln(Name),
              retract(dt_shirt(Name,_,_,_,_,_,_,_)),
              write(Name," removed from DB "), nl, !,
              write("Press space bar."), readchar(_), 
			  removewindow, shiftwindow(1);
			  
			  write("No data."),nl,!,
              write("Press space bar."),readchar(_),
              removewindow, shiftwindow(1).
			
                       /* Изменение */			
			  
	process(4) :-
              makewindow(5,11,3,"Edit data",2,20,18,58),shiftwindow(5),
              write("Input T-shirt name: "), readln(Name1),
              retract(dt_shirt(Name1,_,_,_,_,_,_,_)),
              %write(Name," removed from DB "), 
			  
			  write("Name: "), readln(Name),
              write("Price (RUB): "), read_until_not_integer(Price),
              write("Sex: "), readln(Sex),
              write("Size (International) : "), readln(World),
              write("Size (Europe): "), read_until_not_integer(Europe),
              write("Color: "), readln(Color),
			  write("Material: "), readln(Material),
			  write("Production year: "), read_until_not_integer(Year),
			  assertz(dt_shirt(Name,Price,Sex,World,Europe,Color, Material,Year)),nl, !,
              write("Press space bar."), readchar(_), 
			  removewindow, shiftwindow(1);
			  
			  write("No data."),nl,!,
              write("Press space bar."),readchar(_),
              removewindow, shiftwindow(1), clearwindow, menu.

                       /* Просмотр данных о футболке*/

     process(5) :-
              makewindow(6,11,3," Show T-shirt ", 2,30,22,47),  shiftwindow(6),
			  write("1. Find T-shirt by Name "),nl,
			  write("2. Find T-shirt by Material "),nl, 
			  write(" Choose number 1-2 : "),
			  read_until_not_integer(N), 
			  N>0,N<3,
			  find(N),
			  write("Press space bar"), readchar(_), 
			  removewindow, shiftwindow(1), clearwindow, menu;
			  /*
              write("Input T-shirt name: "), readln(Name),
              dt_shirt(Name,Price,Sex,World,Europe,Color, Material,Year),nl,
              write(" Name                : ",Name),nl,
              write(" Price (RUB)         : ",Price),nl,
              write(" Sex                 : ",Sex),nl,
              write(" Size (International): ",World),nl,
              write(" Size (Europe):      : ",Europe), nl,
              write(" Color               : ",Color),nl,
			  write(" Material            : ",Material),nl,
			  write(" Production year     : ",Year),nl, nl, !,
              write("Press space bar"), readchar(_), 
              removewindow, shiftwindow(1), clearwindow, menu;
				*/
              write("Wrong input."),nl,!,
              write("Press space bar."),readchar(_),
              removewindow, shiftwindow(1), clearwindow, menu.
	
                       /* Просмотр всех записей базы данных */
					   
     process(6) :-
              makewindow(7,11,3," Show All data ", 0,0,25,80),  shiftwindow(7),
			  %findall(Name, dt_shirt(Name,_,_,_,_,_,_,_), All_T),
			  %list_to_set(All_T, [], UniqueT_shirts),
			  %write(All_T),
			  write("Name, Price(Rub), Sex, Size(Inter.), Size(Europe), Color, Material, Year"),
			  nl,
			  write("************************************************************************"),
			  nl,
			  %write_all(All_T),
			  write_all,
			  nl,!,
			  write("Press space bar."),readchar(_),
              removewindow, shiftwindow(1), clearwindow, menu;
			  
			  write("No data."),nl,!,
              write("Press space bar."),readchar(_),
              removewindow, shiftwindow(1), clearwindow, menu.
			  
                       /* Запись в файл */
	 process(7) :-
              makewindow(8,11,3," Write Database to file ", 7,30,12,47),  shiftwindow(8),
			  %findall(Name, dt_shirt(Name,_,_,_,_,_,_,_), All_T),
			  write("Input file name (data.csv): "),
			  readln(Filename),
			  existfile(Filename), % Существует ли файл 
			  openwrite(datafile, Filename), 
			  writedevice(datafile), 
			  %write_all_csv(All_T),
			  write_all_csv,
			  closefile(datafile), 
			  writedevice(screen),
			  
			  %existfile("data1.csv"), % Существует ли файл 
			  %save("data1.csv"),nl,
			  write("DB successfully written to file."),
			  nl,!,
			  write("Press space bar."),readchar(_),
              removewindow, shiftwindow(1), clearwindow, menu;
			  
			  write("Error writing file!"),nl,!,
              write("Press space bar."),readchar(_),
              removewindow, shiftwindow(1), clearwindow, menu.

                       /* Удаление всех записей */			  
	 process(8) :-
              makewindow(9,11,3," Delete All DB ",10,30,7,40),  shiftwindow(9),
			  clear_database,
			  write("DB has been cleared"),
			  nl,!,
			  write("Press space bar."),readchar(_),
              removewindow, shiftwindow(1), clearwindow, menu;
			  
			  write("Error writing file!"),nl,!,
              write("Press space bar."),readchar(_),
              removewindow, shiftwindow(1), clearwindow, menu.
			  
                       /* Выход */			  
     process(9) :-
			  clear_database,
              write("See you again! "),readchar(_),exit.

                       /*Обработка ошибки*/

/**/
     %process(Vibor):-
              %Vibor<1, error; Vibor>9, error.

     error:-
              write("Choose number 1 to 9"), nl,
              write("(Press the spase bar to continue)"),readchar(_).
			  
	 find(1):-clearwindow, write("Input T-shirt name: "), readln(Name),
						find_shirt_name(Name), find_name(Name).

	 find(1):-write("No such T-shirt in database!").

	 find(2):-clearwindow, write("Input T-shirt material: "), readln(Material),
						find_material(Material), find_mat(Material).

	 find(2):-write("No such T-shirt in database!").

	 find(_):-write("Error ").
	  
	 find_shirt_name(Name):- 
	          dt_shirt(Name,Price,Sex,World,Europe,Color, Material,Year),nl,
              write(" Name                : ",Name),nl,
              write(" Price (RUB)         : ",Price),nl,
              write(" Sex                 : ",Sex),nl,
              write(" Size (International): ",World),nl,
              write(" Size (Europe):      : ",Europe), nl,
              write(" Color               : ",Color),nl,
			  write(" Material            : ",Material),nl,
			  write(" Production year     : ",Year),nl, nl, fail.
	 find_shirt_name(_).
	
	 find_material(Material):-
	          dt_shirt(Name,Price,Sex,World,Europe,Color, Material,Year),nl,
              write(" Name                : ",Name),nl,
              write(" Price (RUB)         : ",Price),nl,
              write(" Sex                 : ",Sex),nl,
              write(" Size (International): ",World),nl,
              write(" Size (Europe):      : ",Europe), nl,
              write(" Color               : ",Color),nl,
			  write(" Material            : ",Material),nl,
			  write(" Production year     : ",Year),nl, nl, fail.
	 find_material(_).
 
	 find_name(Name):-dt_shirt(Name,_,_,_,_,_,_,_).
	 find_mat(Material):-dt_shirt(_,_,_,_,_,_,Material,_).
	 
	read_until_not_integer(Integer):-
      readint(Integer),
	  Integer >=0, !;
	  
      write("Enter integer number >=0: "),
      read_until_not_integer(Integer).
	 	
	
	write_all() :-%write("DB2_1"),
		findall(P1, dt_shirt(P1,_,_, _,_,_,_,_), P1s),
		findall(P2, dt_shirt(_,P2,_,_,_,_,_,_ ), P2s),
		findall(P3, dt_shirt(_,_,P3, _,_,_,_,_), P3s),
		findall(P4, dt_shirt(_,_,_,P4,_,_,_,_ ), P4s),
		findall(P5, dt_shirt(_,_,_,_,P5,_,_,_ ), P5s),
		findall(P6, dt_shirt(_,_,_,_,_,P6,_,_ ), P6s),
		findall(P7, dt_shirt(_,_,_, _,_,_,P7,_), P7s),
		findall(P8, dt_shirt(_,_,_, _,_,_,_,P8), P8s),
		write_all(P1s, P2s, P3s, P4s, P5s, P6s, P7s, P8s);
		writedevice(screen).

	write_all([], [], [], [], [], [], [], []) :- !.
	write_all([P1|T1], [P2|T2], [P3|T3], [P4|T4], [P5|T5], [P6|T6], [P7|T7], [P8|T8]) :-
		%write("DB2_2"),
			  write(P1,", ",
			  P2," (RUB), ",
			  P3,", ",
			  P4,", ",
			  P5,", ",
			  P6,", ",
			  P7,", ",
			  P8),nl,
			  write("------------------------------------------------------------------------"),nl,
		      write_all(T1, T2, T3, T4, T5, T6, T7, T8).


	write_all_csv() :-
		findall(P1, dt_shirt(P1,_,_, _,_,_,_,_), P1s),
		findall(P2, dt_shirt(_,P2,_,_,_,_,_,_ ), P2s),
		findall(P3, dt_shirt(_,_,P3, _,_,_,_,_), P3s),
		findall(P4, dt_shirt(_,_,_,P4,_,_,_,_ ), P4s),
		findall(P5, dt_shirt(_,_,_,_,P5,_,_,_ ), P5s),
		findall(P6, dt_shirt(_,_,_,_,_,P6,_,_ ), P6s),
		findall(P7, dt_shirt(_,_,_, _,_,_,P7,_), P7s),
		findall(P8, dt_shirt(_,_,_, _,_,_,_,P8), P8s),
		write_all_csv(P1s, P2s, P3s, P4s, P5s, P6s, P7s, P8s);
		writedevice(screen).

	write_all_csv([], [], [], [], [], [], [], []) :- !.
	write_all_csv([P1|T1], [P2|T2], [P3|T3], [P4|T4], [P5|T5], [P6|T6], [P7|T7], [P8|T8]) :-
			  write(P1,"; ",
			  P2,"; ",
			  P3,"; ",
			  P4,"; ",
			  P5,"; ",
			  P6,"; ",
			  P7,"; ",
			  P8),nl,
		write_all_csv(T1, T2, T3, T4, T5, T6, T7, T8).
/*
	list_to_set([], Buffer, Buffer):-!.
	list_to_set([Head|Tail], Buffer, Set):-
	  member(Head, Buffer), !, list_to_set(Tail, Buffer, Set);
	  list_to_set(Tail, [Head|Buffer], Set).
	  
	member(Elem, [Elem|_]).
	member(Elem, [_|Tail]):-
		member(Elem, Tail).
	
	reverse(List, ReverseList):-
		reverse(List, [], ReverseList). % вызов вспомогательной функции с пустым буфером
	reverse([], Buffer, Buffer):-!.
	reverse([Head|Tail], Buffer, ReverseList):-
		reverse(Tail, [Head|Buffer], ReverseList).
	*/
	
	read_rows() :-not(eof(datafile)),
					readln(Line),
					front_string(Line, F1_STR, Tail1), %str_int(F1_STR, F1),
					front_string(Tail1, F2_STR, Tail2), str_int(F2_STR, Price),
					front_string(Tail2, F3_STR, Tail3), %str_int(F3_STR, F3),
					front_string(Tail3, F4_STR, Tail4), %str_int(F4_STR, F4),
					front_string(Tail4, F5_STR, Tail5), str_int(F5_STR, Europe),
					front_string(Tail5, F6_STR, Tail6), %str_real(F6_STR, F5_real),
					front_string(Tail6, F7_STR, Tail7), %str_real(F6_STR, F5_real),
					front_string(Tail7, F8_STR, _), str_int(F8_STR, Year),
					assertz(dt_shirt(F1_STR,Price,F3_STR,F4_STR,Europe,F6_STR,F7_STR,Year)), !, read_rows();
					
					not(eof(datafile)), !,
					write(" ********************************"), nl,
					write(" *        READING ERROR!        * "), nl,
					write(" * REMAINING DATA WAS NOT READ! * "), nl,
					write(" *     SOME MATERIALS ADDED!    * "), nl,
					write(" ******************************** "), nl; !.

	front_string("", "", "") :- !.
	front_string(Line, Param, Tail) :-frontchar(Line, LineH, LineT), 
									LineH = ';', !, 
									Param = "", Tail = LineT;
									
									frontchar(Line, LineH, LineT), 
									LineH <> ';', !, 
									front_string(LineT, T, Tail), 
									str_char(LineHS, LineH),	
									concat(LineHS, T, Param).

