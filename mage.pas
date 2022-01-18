unit Mage;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Hero,Personage,Weapon,Shield,Graphics;
     type TMage = class (THero)
      constructor create(name1:String);
      function isAttackSuccesful(e:TPersonage):boolean;
      function damage():integer;
     end;
implementation
  constructor TMage.create(name1:String);
  var
    weapon1:TWeapon;
    shield1: TShield;
  begin
    portrait_path:='img/Mage.jpg';
    portrait:=TPicture.create();
    portrait.loadfromfile(portrait_path);
    weapon1:=TWeapon.create();
    weapon1.name:='Посох';
    weapon1.damage:=3;
    weapons[1]:=weapon1;
    weapon1:=TWeapon.create();
    weapon1.name:='Огненный посох';
    weapon1.damage:=9;
    weapons[2]:=weapon1;
    weapon1:=TWeapon.create();
    weapon1.name:='Водяной посох';
    weapon1.damage:=2;
    weapons[3]:=weapon1;
    weapon1:=TWeapon.create();
    weapon1.name:='Стихийный посох';
    weapon1.damage:=10;
    weapons[4]:=weapon1;
    weapon1:=TWeapon.create();
    weapon1.name:='Волшебная палочка';
    weapon1.damage:=5;
    weapons[5]:=weapon1;
    shield1:=TShield.create();
    shield1.name:='Щит';
    shield:=shield1;
    name:=name1;

    name:=name1;
    hp:=40;
    max_hp:=40;
    attack:=5;
    defend:=5;
    gold:=0;
    spells:=4;

         exp_points:=0;
         exp_level:=1;
         next_level_exp_points:=100;
end;


function TMage.isAttackSuccesful(e:TPersonage):boolean;
 begin
   if spells<=0 then begin
         writeln('У мага ',name,' кончилась мана!');
   if random(attack)>random(e.defend) then begin
         isAttackSuccesful:=true;
   end
   else begin
       isAttackSuccesful:=false;
   end;

   end
   else begin
       writeln(name,' бросает огненный шар!');
       isAttackSuccesful:=true;
   end;
 end;
 function TMage.damage():integer;
begin
  if spells>0 then begin
     spells:=spells-1;
     damage:=random(20)+5;
  end
  else begin
   damage:=random(3)+1;
   end;
  end;
end.

