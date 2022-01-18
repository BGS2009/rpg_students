unit Item;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type TItem = class
weight:integer;
price:integer;
name:string;
constructor create();
  end;


implementation
 constructor TItem.create();
 begin
 name:='Экскалибур';
 weight:=15;
 price:=120;

 end;

end.

