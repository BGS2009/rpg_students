unit Enemy;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Personage;
  
   type TEnemy = class (TPersonage)

      name:string;
     
   portrait_path:string;
    constructor create();

   end;
implementation
  

constructor TEnemy.create();
begin
    hp:=40;
    max_hp:=40;
    attack:=5;
    defend:=5;
    gold:=random(10)+10;
end;
end.

