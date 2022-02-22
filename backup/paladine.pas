unit Paladine;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Hero,Weapon,Shield,Graphics,Personage;
  
         type Tpaladine = class (THero)
         d:integer;
         constructor create(name1:String);
         procedure getDamage(dmg:integer);
         function isAttackSuccesful(e:TPersonage):boolean;
  end;
implementation
  
constructor Tpaladine.create(name1:String);
 var weapon1:TWeapon;
    shield1:TShield;
begin
  portrait_path:='img/Paladine.jpg';
  portrait:=Tpicture.create();
  portrait.loadfromfile(portrait_path);
  weapon1:=TWeapon.create;
  weapon1.name:='Жуайез';
  weapon1.damage:=15;
  weapons[1]:=weapon1;
   shield1:=TShield.create;
  shield1.name:='Стальной щит';
 shield1.defend:=15;
  shield:=shield1;
  name:=name1;
    name:=name1;
    hp:=150;
    max_hp:=150;
    attack:=10;
    d:=30;
    gold:=0;
    defend:=5;

         exp_points:=0;
         exp_level:=1;
         next_level_exp_points:=100;
  end;


  procedure TPaladine.getDamage(dmg:integer);
  begin
  hp:=hp-dmg ;
  end;

  function TPaladine.isAttackSuccesful(e:TPersonage):boolean;
      begin

        if random(attack)>random(e.defend) then begin
              isAttackSuccesful:=true;
              new_message:=name+' нанес удар!';
        end
        else begin
            isAttackSuccesful:=false;

              new_message:=name+' не нанес удар!';
        end;
      end;

end.

