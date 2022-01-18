unit Orc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Enemy;
   
    { TOrc }

  type TOrc = class(TEnemy)
  function damage:Integer;
  constructor create();
end;
implementation
  
function TOrc.damage: Integer;
begin

  damage:=Random(attack)+round(0.1*random(max_Hp-hp));
end;

constructor TOrc.create();
begin

  hp:=80;
  max_hp:=80;
  attack:=7;
  defend:=14;
  name:='Орк';
   exp_points:=120;
end;


end.

