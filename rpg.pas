program rpg;      //Название программы
//подключение модулей и классов
uses crt, personage, hero, enemy, mage, paladine, barbarian, vampire, orc,
  goblin, map;




var

  heroes:array[1..4] of THero;  //массив из героев (партия героев)
  level:TMap;                   //карта
  state:string;                 //состояние партии героев (ищет приключения, сражается, мертва...)
  choice:integer;               //выбор действия
  current_location:integer;     //текущее положение на карте
  r,i,l:integer;


  //проверка, мертвы ли все враги
  function isEveryEnemyDead():boolean;
  var i,a:integer;
  begin
    a:=0;
    for i:=1 to 4 do begin
      if  (not level.locations[current_location].enemies[i].isDead) then begin
        a:=a+1;
      end;
    end;
    if a<>0 then isEveryEnemyDead:=false else isEveryEnemyDead:=true;
  end;

    //проверка, мертвы ли все герои
  function isEveryHeroDead():boolean;
  var i,a:integer;
  begin
    a:=0;
    for i:=1 to 4 do begin
      if  (not heroes[i].isDead) then begin
        a:=a+1;
      end;
    end;
    if a<>0 then isEveryHeroDead:=false else isEveryHeroDead:=true;
  end;

//Отрисовка интерфейса
procedure createInterface();
var i:integer;
begin

       writeln ('Вы находитесь в локации ',level.locations[current_location].place);
       writeln(heroes[1].name);
       writeln('Здоровье: ');
       writeln(heroes[1].gethpBar);
       writeln(heroes[2].name);
       writeln('Здоровье: ');
       writeln(heroes[2].gethpBar);
       writeln(heroes[3].name);
       writeln('Здоровье: ');
       writeln(heroes[3].gethpBar);
       writeln(heroes[4].name);
       writeln('Здоровье: ');
       writeln(heroes[4].gethpBar);
       writeln('--------------------Действия---------------------------');


end;

//Отрисовка интерфейса для сражения
procedure createBattleInterface();
var i:integer;
begin

     writeln ('Вы находитесь в ',level.locations[current_location].place);

       writeln(heroes[1].name,'                 ', level.locations[current_location].enemies[1].name);
       writeln('Здоровье: ' ,'                   Здоровье: ');
       writeln(heroes[1].gethpBar,'    ', level.locations[current_location].enemies[1].gethpBar);
       writeln(heroes[2].name,'              ', level.locations[current_location].enemies[2].name);
       writeln('Здоровье: ' ,'                   Здоровье: ');
       writeln(heroes[2].gethpBar,'    ', level.locations[current_location].enemies[2].gethpBar);
       writeln(heroes[3].name,'                       ', level.locations[current_location].enemies[3].name);
       writeln('Здоровье: ' ,'                   Здоровье: ');
       writeln(heroes[3].gethpBar,'    ', level.locations[current_location].enemies[3].gethpBar);
       writeln(heroes[4].name,'                  ', level.locations[current_location].enemies[4].name);
       writeln('Здоровье: ' ,'                   Здоровье: ');
       writeln(heroes[4].gethpBar,'    ', level.locations[current_location].enemies[4].gethpBar);
       writeln('--------------------События---------------------------');


end;

//Битва
procedure battle();
begin
   //Для каждого героя
    for i:= 1 to 4 do
    begin
      //если он жив
      if not heroes[i].isDead then
      begin
        //выбирается случайный противник
        r:=random(4)+1;
        //живой противник
        While (level.locations[current_location].enemies[r].isDead and (not isEveryEnemyDead())) do begin  r:=Random(4)+1;
          end;
         //если атака героя успешна
        if heroes[i].isAttackSuccesful(level.locations[current_location].enemies[r]) then begin
          //наносим урон
          level.locations[current_location].enemies[r].getDamage(heroes[i].damage);
          //если противник умер, герой повысил уровень
          if level.locations[current_location].enemies[r].isDead() then heroes[i].levelUp();
        end else writeln('Атака отражена!');

      end;
      // Если  противник с номером i жив
      if not level.locations[current_location].enemies[i].isDead then
      begin
        //если герои мертвы
        if iseveryHeroDead() then begin
          //прекратить битву
           break;
        end;
       // выберем случайного героя
        r:=random(4)+1;

        While heroes[r].isDead do r:=Random(4)+1;
       //если атака противника успешна
        if level.locations[current_location].enemies[i].isAttackSuccesful(heroes[r]) then
        begin
          WriteLn('Урон получил ', heroes[i].name);
          //герой получает урон
          heroes[r].getDamage(level.locations[current_location].enemies[i].damage);
        end
        else WriteLn(heroes[i].name, ' ударили, но удар отражён!');
      end;
    end;
  end;


procedure startGame();
var i: Integer; hType: char; name0: string;
begin
  for i:=1 to 4 do
  begin
    clrscr;
    hType:=Chr(0);
    while not ((hType='1') or (hType='2') or (hType='3')) do
    begin
      clrscr;
      WriteLn('Выберите, кем является герой №', i, '!');
      writeln('1 - варвар');
      writeln('2 - паладин');
      writeln('3 - маг');
      hType:=ReadKey;
    end;
    WriteLn('Введите имя для героя №',i);
    ReadLn(name0);
    case (hType) of
      '1': heroes[i]:=TBarbarian.create(name0);
      '2': heroes[i]:=Tpaladine.create(name0);
      '3': heroes[i]:=TMage.create(name0);
    end;
  end;

end;
begin

  randomize;
  state:='wander';
  current_location:=1;
  level:=TMap.create;
  startGame();
  writeln('Нажмите Enter для перехода к приключениям!');
  readln;

    while ((not heroes[1].isDead) or (not heroes[2].isDead) or (not heroes[3].isDead) or (not heroes[4].isDead))   do


begin

   if state='wander' then begin
     createInterface();
      writeln('Вы находитесь в ',level.locations[current_location].place) ;
      writeln('Здесь можно:');
      writeln('1.Перейти в предыдущую локацию');
      if (not isEveryEnemyDead) then writeln('2.Искать и убивать врагов')
      else  writeln('2.Перейти в следующую локацию');
      readln(choice);
      if choice=1 then current_location:=level.locations[current_location].prev_location[1];
      if choice=2 then  begin
         if (not isEveryEnemyDead) then state:='battle'
         else current_location:=level.locations[current_location].next_location[1];

      end;
   end;
   if state='battle' then begin
     createBattleInterface();
      battle;
      if iseveryEnemyDead then state:='wander';
   end;





    delay(1000);
    clrscr;
   end;


     createInterface();

     writeln('Все ваши герои мертвы. Игра проиграна!')  ;
    readln;

end.

