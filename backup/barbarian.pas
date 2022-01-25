unit Barbarian;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Graphics,Personage, Hero,Weapon,Shield;
 

   { TBarbarian }

  type  TBarbarian = class(THero)
  function damage():Integer;
  function isAttackSuccesful(e:TPersonage):boolean;
  constructor create(name1:String);
end;
implementation
    

function TBarbarian.damage: Integer;
begin
  if random(2)=0 then begin
     readln;
    damage:=Random(attack);

  end
  else
  begin
    new_message:=name+ ' ударил ещё раз!';
    readln;

    damage:=Random(attack)*2;
  end;
end;

function TBarbarian.isAttackSuccesful(e:TPersonage):boolean;
    begin

      if random(attack)>random(e.defend) then begin
            isAttackSuccesful:=true;
            new_message:=name+' ударил!';
      end
      else begin
          isAttackSuccesful:=false;

            new_message:+name+' не нанес удар!';
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
  weapons[1]:=weapon1;
  weapon1:=TWeapon.create();
  weapon1.name:='Белый меч';
  weapon1.damage:=11;
  weapons[2]:=weapon1;
  weapon1:=TWeapon.create();
  weapon1.name:='Демонический меч';
  weapon1.damage:=9;
  weapons[3]:=weapon1;
  weapon1:=TWeapon.create();
  weapon1.name:='Топор';
  weapon1.damage:=13;
  weapons[4]:=weapon1;
  weapon1:=TWeapon.create();
  weapon1.name:='Ангелький меч';
  weapon1.damage:=10;
  weapons[5]:=weapon1;
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

