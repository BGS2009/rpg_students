unit Item;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type TItem = class
weight:integer;
price:integer;
name:string;
constructor create(name1:string);
  end;


implementation
 constructor TItem.create(name1:string);
 begin
 name:=name1;
 weight:=15;
 price:=120;

 end;

end.

