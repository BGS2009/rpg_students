unit Enemy;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Personage;
  
   type

   { TEnemy }

 TEnemy = class (TPersonage)

      function isAttackSuccesful(e:Tpersonage):boolean;  virtual;
      constructor create();
      procedure append();

   end;
implementation
uses Unit1;
  
procedure TEnemy.append();
begin
  Unit1.Form1.Memo1.Append(name+'нанёс удар!');
end;

function TEnemy.isAttackSuccesful(e: Tpersonage): boolean;
begin
  Unit1.Form1.Memo1.Append('enemy');
  if random(attack)>random(e.defend) then begin
            isAttackSuccesful:=true;
      end
      else begin
          isAttackSuccesful:=false;
      end;
end;

constructor TEnemy.create();
begin
    hp:=40;
    max_hp:=40;
    attack:=5;
    defend:=5;
    gold:=random(10)+10;
end;
end.

