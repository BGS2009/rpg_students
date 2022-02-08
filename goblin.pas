unit Goblin;

{$mode objfpc}{$H+}

interface

uses
  Classes, StdCtrls, SysUtils,Enemy,Personage;
    


   type TGoblin = class (TEnemy)
       constructor create();
        function isAttackSuccesful(e:TPersonage):boolean;
   end;

implementation
uses Unit1;


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
   Unit1.Form1.Memo1.Append('dhjkhk');
   if random(attack)>random(e.defend) then begin
     new_message:=(name+'нанёс удар!');
         isAttackSuccesful:=true;
   end
   else begin
    isAttackSuccesful:=false;
    new_message:=(name+'не нанёс удар!');
    if hp<0.2 *  max_hp then
    begin
    if random(3) = 0 then
    begin
    new_message:=('Гоблин сбежал!');
    e.gold:= e.gold-(random(15)+5) ;
    hp:=0;
    end;
   end;

 end;

 end;
end.

