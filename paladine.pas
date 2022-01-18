unit Paladine;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Hero,Weapon,Shield,Graphics;
  
         type Tpaladine = class (THero)
         d:integer;
         constructor create(name1:String);
         procedure getDamage(dmg:integer);
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
  d:=random(15+shield.defend);
  if d>15 then
  begin
  dmg:=0;
  writeln(name,' отбил удар врага!');
  writeln(shield.name,'трещит, но выдерживает удар!')
  end;
  hp:=hp-dmg ;
  end;


end.

