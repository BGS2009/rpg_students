unit Healer;

{$mode objfpc}{$H+}

interface

uses
  Hero, Personage, Weapon, Shield,Classes, SysUtils;

type

{ healer }

 { THealer }

 THealer = class(THero)
   private
   healHP: integer;
   procedure levelUp();
   public
   constructor create(name1:String);
   procedure Heal(h:TPersonage);
 end;

implementation

uses
  Unit1;

{ healer }

procedure THealer.levelUp();
begin
  writeln('Герой', name,' повысил уровень!')    ;
  exp_points:=exp_points-next_level_exp_points;
  exp_level:=exp_level+1;
  next_level_exp_points:=round(1.2*next_level_exp_points);
  healHP:=healHP+5;
end;

constructor THealer.create(name1: String);
begin
  portrait_path:='img/healer.jpg';
  portrait:=Tpicture.create();
  portrait.loadfromfile(portrait_path);
  name:=name1;
  gold:=0;
  hp:=65;
  max_hp:=65;
  shield:=TShield.create();
  shield.name:='';
  weapons[1]:=TWeapon.create();
  weapons[1].name:='Лечитель';
  exp_points:=0;
  healHP:=5;
  exp_level:=1;
  next_level_exp_points:=100;
end;

procedure THealer.Heal(h:TPersonage);
var
  hp_before: Integer;
begin
  hp_before:=h.hp;
  h.hp:=h.hp+healHP;
  if h.hp>max_hp then h.hp:=h.max_hp;
  new_message:=name+' вылечил '+h.name+' на '+IntToStr(h.hp-hp_before)+' единиц жизней';
end;


end.

