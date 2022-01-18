unit Hero;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Graphics, Personage,Weapon,Shield;
 
   type THero = class (TPersonage)
   name:string;
   state:string;
   spells:Integer;
   weapons:array [1..5] of TWeapon;
   shield:TShield;
   portrait:TPicture;
   portrait_path:string;
   constructor create();
   function damage():integer;
   procedure levelUp();

   function isAttackSuccesful(e:TPersonage):boolean;
  end;

implementation

constructor THero.create();
var weapon1:TWeapon;
    shield1:TShield;
begin
  weapon1:=TWeapon.create();
  weapons[1]:=weapon1;
  weapon1:=TWeapon.create();
  weapons[2]:=weapon1;
  weapon1:=TWeapon.create();
  weapons[3]:=weapon1;
  weapon1:=TWeapon.create();0
  weapons[4]:=weapon1;
  weapon1:=TWeapon.create();
  weapons[5]:=weapon1;
  shield1:=TShield.create();
  shield:=shield1;
end;

function THero.damage():integer;
begin
  writeln(name,' издает боевой клич и поднимает', weapons[1].name);
   damage:=random(weapons[1].damage)+1;
  end;

    function THero.isAttackSuccesful(e:TPersonage):boolean;
    begin

      if random(attack)>random(e.defend) then begin
            isAttackSuccesful:=true;
            writeln(name,' нанес удар!');
      end
      else begin
          isAttackSuccesful:=false;

            writeln(name,' не нанес удар!');
      end;
    end;

procedure THero.levelUp()   ;
begin
  writeln('Герой', name,' повысил уровень!')    ;
  exp_points:=0;
  exp_level:=exp_level+1;
  next_level_exp_points:=round(1.2*next_level_exp_points);
  max_hp:=round(max_hp*1.2);
  hp:=max_hp;
  attack:=attack+1;
  defend:=defend+1;
end;

end.

