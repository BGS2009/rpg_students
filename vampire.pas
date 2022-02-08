unit Vampire;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Enemy,Personage;
   

   type TVampire = class (TEnemy)
       bleeding:integer;
       b:boolean;
       constructor create();
       function isAttackSuccesful(e:Tpersonage):boolean;
       function damage():integer;
  end;
implementation
uses Unit1;
 

constructor Tvampire.create();
    begin

  portrait_path:='img/Vampire.png';
     hp:=70;
     max_hp:=70;
     attack:=20;
     gold:=0;
     defend:=3;
     bleeding:=20;
     b:=false;
     name:='Вампир';
      exp_points:=140;
   end;
function Tvampire.isAttackSuccesful(e:Tpersonage):boolean;
  begin
    Unit1.Form1.Memo1.Append(name+'нанёс удар!');
   if random(attack)>random(e.defend) then
   begin
     isAttackSuccesful:=true;
     new_message:='Укусил героя!';
     if random(bleeding)>10 then
     begin
       b:=true;
     end
     else
     begin
       b:=false;
     end;
   end
   else
   begin
       b:=false;
     isAttackSuccesful:=false;
     new_message:='Не смог укусить героя!';
    end;
  end;

function Tvampire.damage():integer;
  begin
    if b=true then
    begin
     damage:=random(5)+1+bleeding;
    end
    else
    begin
      damage:=random(5)+1;
    end;
    end;
end.

