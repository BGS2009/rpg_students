unit Orc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Enemy,Personage;
   
    { TOrc }

  type TOrc = class(TEnemy)
  function damage:Integer;
  function isAttackSuccesful(e:TPersonage):boolean;
  constructor create();
end;
implementation
uses Unit1;
  
function TOrc.damage: Integer;
begin
                 uses Unit1;
  damage:=Random(attack)+round(0.1*random(max_Hp-hp));
end;

constructor TOrc.create();
begin
  portrait_path:='img/Orc.png';
  hp:=80;
  max_hp:=80;
  attack:=7;
  defend:=14;
  name:='Орк';
  exp_points:=120;
end;

function TOrc.isAttackSuccesful(e:TPersonage):boolean;
    begin
      Unit1.Form1.Memo1.Append(name+'нанёс удар!');
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

