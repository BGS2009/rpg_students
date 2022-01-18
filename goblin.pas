unit Goblin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Enemy,Personage;
    


   type TGoblin = class (TEnemy)
       constructor create();
        function isAttackSuccesful(e:TPersonage):boolean;
   end;
implementation
   


constructor TGoblin.create();
begin
   
  portrait_path:='img/Goblin.png';
  hp:=30;
  max_hp:=30;
  attack:=5;
  defend:=4;
  gold:=random(20)+20;
  name:='Мерзостный гоблин';
  exp_points:=40;
end;

 function TGoblin.isAttackSuccesful(e:TPersonage):boolean;
 begin

   if random(attack)>random(e.defend) then begin
         isAttackSuccesful:=true;
   end
   else begin
    isAttackSuccesful:=false;
    if hp<0.2 *  max_hp then
    begin
    if random(3) = 0 then
    begin
    writeln('Гоблин сбежал!!');
    e.gold:= e.gold-(random(15)+5) ;
    hp:=0;
    end;
   end;

 end;

 end;
end.

