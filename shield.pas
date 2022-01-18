unit Shield;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Item;
type TShield = class (TItem)
defend:integer;
constructor create();
end;
implementation
constructor TShield.create();
 begin
   defend:=10;
 end;
end.

