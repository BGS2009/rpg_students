unit Enemy;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Personage;
  
   type

   { TEnemy }

 TEnemy = class (TPersonage)

      name:string;

      portrait_path:string;
      constructor create();
      procedure appen();

   end;
implementation
uses Unit1;
  
procedure TEnemy.appen();
begin
  Unit1.Form1.Memo1.Append(name+'нанёс удар!');
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

