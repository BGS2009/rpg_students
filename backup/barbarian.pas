unit Barbarian;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Graphics, Hero,Weapon,Shield;
 

   { TBarbarian }

  type  TBarbarian = class(THero)
function damage():Integer;
  constructor create(name1:String);
end;
implementation
    

function TBarbarian.damage: Integer;
begin
  if random(2)=0 then begin
     WriteLn(name, ' ударил!');
     readln;
    damage:=Random(attack);

  end
  else
  begin
    WriteLn(name, ' ударил ещё раз!');
    readln;

    damage:=Random(attack)*2;
  end;
end;

constructor TBarbarian.create(name1: String);
var
  weapon1:TWeapon;
  shield1: TShield;
begin
  portrait_path:='img/Barbarian.jpg';
  portrait:=Tpicture.create();
  portrait.loadfromfile(portrait_path);
  shield1:=TShield.create();
  shield1.name:='Щит';
  shield:=shield1;
  weapon1:=TWeapon.create;
  weapon1.name:='Кринг, говорящий меч';
  weapon1.damage:=10;
  weapon:=weapon1;
  name:=name1;
  hp:=125;
  max_Hp:=125;
  attack:=15;
  defend:=5;
  exp_points:=0;
  exp_level:=1;
  next_level_exp_points:=100;
end;
end.

