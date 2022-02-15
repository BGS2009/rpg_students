unit Location;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Graphics, item,enemy, personage,vampire, orc, goblin, contnrs;
  type TLocation = class
  place:string;
  distance:integer;
  n_distance:integer;
  enemies:TObjectLIst;
  loot:array[1..10] of  TItem;
  direction:string;
  next_location:array[1..4] of integer;
  prev_location:array[1..4] of integer;
  background_path:string;
  background:TPicture;

  constructor create();
  procedure  WhereAreYou();
  procedure setBackground(path:string);

  end;

implementation
  constructor TLocation.create();
  var i:integer;  enemy1:Tenemy;
  begin
  enemies:=TObjectList.create();
  background_path:='img/cave.jpg';
  background:=Tpicture.create();
  background.loadfromfile(background_path);
  place:='Хум';
  distance:=0;
  direction:='Forward';
   for i:=0 to 3 do begin
     enemy1:=TGoblin.create();
     enemies.add(enemy1);
     end;
  n_distance:=15;
  end;
  procedure TLocation.WhereAreYou();
  begin
  writeln('Вы находитесь в ',place);
  writeln('Расстояние от столицы - ',distance,' миль');

  end;
  procedure TLocation.setBackground(path:string);
  begin
      background_path:='img/'+path;
      background:=Tpicture.create();
      background.loadfromfile(background_path);
  end;

end.

