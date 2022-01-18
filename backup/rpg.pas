program rpg;      //Название программы
//подключение модулей и классов
uses crt, personage, hero, enemy, mage, paladine, barbarian, vampire, orc,
  goblin, map;




var

  heroes:array[1..4] of THero;
  level:TMap;
  state:string;
  choice:integer;
  current_location:integer;
  r,i,l:integer;

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

procedure createInterface();
var i:integer;
begin

     writeln ('Вы находитесь в ',level.locations[current_location].place);

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
procedure battle();
begin
   //Battle
    for i:= 1 to 4 do
    begin
      if not heroes[i].isDead then
      begin

        r:=random(4)+1;

        While (level.locations[current_location].enemies[r].isDead and (not isEveryEnemyDead())) do begin  r:=Random(4)+1;
          end;
        if heroes[i].isAttackSuccesful(level.locations[current_location].enemies[r]) then begin
          level.locations[current_location].enemies[r].getDamage(heroes[i].damage);
          if level.locations[current_location].enemies[r].isDead() then heroes[i].levelUp();
        end else writeln('Атака отражена!');

      end;
      if not level.locations[current_location].enemies[i].isDead then
      begin
        if iseveryHeroDead() then begin
           break;
        end;
        r:=random(4)+1;

        While heroes[r].isDead do r:=Random(4)+1;
        if level.locations[current_location].enemies[i].isAttackSuccesful(heroes[r]) then
        begin
          WriteLn('Урон получил ', heroes[i].name);
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

