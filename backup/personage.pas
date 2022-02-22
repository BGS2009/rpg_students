unit Personage;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Item;
 type

 { TPersonage }

 TPersonage = class
   new_message: String;
   hp:integer;
   max_hp:integer;
   attack:integer;
   defend:integer;
   gold:integer;
   inventory:array[1..100] of TItem;
   exp_points:integer;
   exp_level:integer;
   next_level_exp_points:integer;
   portrait_path:string;
   name:string;
   constructor create();
   function isAttackSuccesful(e:TPersonage):boolean;
   function damage():integer;
   function isDead:Boolean;
   function gethpBar: String;
   procedure levelUp();
   procedure getDamage(dmg:integer);
 end;


implementation
  uses Unit1;

constructor TPersonage.create();
    begin
        hp:=100;
        max_hp:=100;
        attack:=10;
        defend:=10;
        gold:=0;
         exp_points:=0;
         exp_level:=1;
         next_level_exp_points:=100;
    end;

    function TPersonage.isAttackSuccesful(e:TPersonage):boolean;
    begin
       Unit1.Form1.Memo1.Append('personage');
      if random(attack)>random(e.defend) then begin
            isAttackSuccesful:=true;
      end
      else begin
          isAttackSuccesful:=false;
      end;
    end;
   function TPersonage.damage():integer;
   begin
      damage:=random(attack)+1;
     end;
    procedure TPersonage.getDamage(dmg:integer);
    begin
      hp:=hp-dmg;
    end;
    function TPersonage.isDead:Boolean;
    begin
      if hp<=0 then isDead:=True else isDead:=False;
    end;
        function TPersonage.gethpBar: String;
var
  ii, simKolProc:Int64;
  str: String;
begin
  // [%%%%%%%%......]
  //      hp23 div maxhp
  simKolProc:=0;
  str:='[';
  simKolProc:=hp*23 div max_Hp;
  for ii:=1 to simKolProc do str:=str+'%';
  for ii:=1 to 23-simKolProc do str:=str+'.';
  str:=str+']';
  Result:=str;
end;

procedure TPersonage.levelUp();
begin
  new_message:='Персонаж '+name+' повысил уровень!';
  exp_points:=0;
  exp_level:=exp_level+1;
  next_level_exp_points:=round(1.2*next_level_exp_points);
  max_hp:=round(max_hp*1.2);
  hp:=max_hp;
  attack:=attack+1;
  defend:=defend+1;
end;

end.

