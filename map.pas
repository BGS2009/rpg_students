unit Map;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Location,item,goblin,orc,vampire;
   type Tmap= class
     locations:array[1..10] of TLocation;
     constructor create;
     //procedure show_map();

   end;

implementation
   constructor TMap.create;
   begin
     locations[1]:=TLocation.create;
     locations[1].place:='Гоблинский лагерь';
     locations[1].setBackground('goblincamp.jpg')   ;
     locations[1].loot[1]:=Titem.create('Золотая корона');
     locations[1].enemies[1]:=TGoblin.create;
     locations[1].enemies[2]:=TGoblin.create;
     locations[1].enemies[3]:=TGoblin.create;
     locations[1].enemies[4]:=TGoblin.create;
     locations[1].next_location[1]:=2;

     locations[2]:=TLocation.create;
     locations[2].place:='Орочья деревня';
     locations[2].setBackground('orcvillage.jpg')   ;
     locations[2].loot[1]:=Titem.create('Палица короля орков');
     locations[2].enemies[1]:=TOrc.create;
     locations[2].enemies[2]:=TOrc.create;
     locations[2].enemies[3]:=TOrc.create;
     locations[2].enemies[4]:=TOrc.create;
     locations[2].next_location[1]:=3;
     locations[2].prev_location[1]:=1;


     locations[3]:=TLocation.create;
     locations[3].place:='Замок вампиров';
     locations[3].setBackground('vampirecastle.jpg')   ;
     locations[3].loot[1]:=Titem.create('Вставная челюсть с клыками');
     locations[3].enemies[1]:=TVampire.create;
     locations[3].enemies[2]:=TVampire.create;
     locations[3].enemies[3]:=TVampire.create;
     locations[3].enemies[4]:=TVampire.create;
     locations[3].next_location[1]:=10;
     locations[3].prev_location[1]:=2;

     locations[10]:=TLocation.create;
     locations[10].place:='Человеческий город';
     locations[10].next_location[1]:=1;
     locations[10].prev_location[1]:=10;
   end;

end.

