unit Weapon;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Item;
type TWeapon =class(TItem)
 damage:integer;
 constructor create();
end;
implementation
 constructor TWeapon.create();
 begin
   damage:=25;
   name:='Экскалибур'
 end;
end.

