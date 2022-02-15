unit Map;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Location,item,goblin,orc,vampire,enemy;
   type Tmap= class
     locations:array[1..10] of TLocation;
     constructor create;
     //procedure show_map();

   end;

implementation
   constructor TMap.create;
   var enemy1:TEnemy;
     i:integer;
   begin
     locations[1]:=TLocation.create;
     locations[1].place:='Гоблинский лагерь';
     locations[1].setBackground('goblincamp.jpg')   ;
     locations[1].loot[1]:=Titem.create('Золотая корона');
     for i:=0 to 3 do begin
     enemy1:=TGoblin.create();
     locations[1].enemies.add(enemy1);
     end;

     locations[1].next_location[1]:=2;

     locations[2]:=TLocation.create;
     locations[2].place:='Орочья деревня';
     locations[2].setBackground('orcvillage.jpg')   ;
     locations[2].loot[1]:=Titem.create('Палица короля орков');
    for i:=0 to 3 do begin
     enemy1:=TOrc.create();
     locations[2].enemies.add(enemy1);
     end;
     locations[2].next_location[1]:=3;
     locations[2].prev_location[1]:=1;


     locations[3]:=TLocation.create;
     locations[3].place:='Замок вампиров';
     locations[3].setBackground('vampirecastle.jpg')   ;
     locations[3].loot[1]:=Titem.create('Вставная челюсть с клыками');
     for i:=0 to 3 do begin
     enemy1:=TVampire.create()   ;
     locations[3].enemies.add(enemy1);
     end;
     locations[3].next_location[1]:=10;
     locations[3].prev_location[1]:=2;

     locations[10]:=TLocation.create;
     locations[10].place:='Человеческий город';
     locations[10].next_location[1]:=1;
     locations[10].prev_location[1]:=10;
   end;

end.

