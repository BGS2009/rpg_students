unit Shiled;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Item;
type TSheild = class (TItem)
defend:integer;
constructor create();
end;
implementation
constructor TSheild.create();
 begin
   defend:=10;
 end;
end.

