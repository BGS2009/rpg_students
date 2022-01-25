unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls, Menus, Barbarian, Hero, MAge, Paladine, Personage, Unit2,Map;

type

  { TForm1 }

  TForm1 = class(TForm)
    battle_pause: TButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    HpL1: TLabel;
    HpL2: TLabel;
    HpL3: TLabel;
    HpL4: TLabel;
    LocTitle: TLabel;
    ManaL1: TLabel;
    ManaL2: TLabel;
    ManaL3: TLabel;
    ManaL4: TLabel;
    NameL1: TLabel;
    Memo1: TMemo;
    NameL2: TLabel;
    NameL3: TLabel;
    NameL4: TLabel;
    HpBar1: TProgressBar;
    HpBar2: TProgressBar;
    HpBar3: TProgressBar;
    HpBar4: TProgressBar;
    ManaBar4: TProgressBar;
    ManaBar1: TProgressBar;
    ManaBar2: TProgressBar;
    ManaBar3: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
    procedure getHeroInfo(n:Integer);
    procedure Image2DblClick(Sender: TObject);
    procedure Image3DblClick(Sender: TObject);
    procedure Image4DblClick(Sender: TObject);
    procedure LoadAndDraw(const sFileName: String ; pic_resize:boolean; x,y:integer);
    procedure battle_pauseClick(Sender: TObject);
    procedure get_messages();
  private

  public

  end;

var
  Form1: TForm1;
  heroes:array [1..4] of THero;
  level_map:TMap;
  current_location:integer;
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.battle_pauseClick(Sender: TObject);
var dmg,i,r:integer;
begin
  for i:=1 to 4 do
  begin
    r:=random(4)+1;
    if heroes[i].isAttackSuccesful(level_map.locations[current_location].enemies[r]) then
    begin
       level_map.locations[current_location].enemies[r].getDamage(heroes[i].damage);
    end;
    r:=random(4)+1;
    if level_map.locations[current_location].enemies[i].isAttackSuccesful(heroes[r]) then
    begin
       heroes[r].getDamage(level_map.locations[current_location].enemies[i].damage);
    end;
  end;

    get_messages();
end;

procedure TForm1.get_messages();
  var message:string;i:integer;
  begin
    for i:=1 to 4 do
    begin
      message:=heroes[i].new_message;
      memo1.Append(message);
      message:=level_map.locations[current_location].enemies[i].new_message;
      memo1.Append(message);
    end;
  end;

procedure TForm1.LoadAndDraw(const sFileName: String;pic_resize:boolean;x,y:integer);
var
  jpg: TPicture;
begin
  jpg := TPicture.Create;
  try
    jpg.LoadFromFile(sFileName);
    if pic_resize then Image5.Picture.Bitmap.SetSize(jpg.Width, jpg.Height);
    Image5.Picture.Bitmap.Canvas.Draw(x, y, jpg.Bitmap);

  finally
    jpg.Free;
  end;
end;


procedure TForm1.FormCreate(Sender: TObject);
var i:integer;
begin
  level_map:=TMap.create();
  current_location:=2;
  //image5.Picture:=level_map.locations[current_location].background;
  loadanddraw(level_map.locations[current_location].background_path,true,0,0);
  level_map.locations[current_location].enemies[3].hp:=0;
  for i:=1 to 4 do begin
       if level_map.locations[current_location].enemies[i].hp>0 then loadanddraw(level_map.locations[current_location].enemies[i].portrait_path,false,100+200*i,300);
  end;
  LocTitle.caption:=level_map.locations[current_location].place;
  heroes[1]:=TMage.create('Ринсвинд');
  heroes[2]:=TBarbarian.create('Рыжая Соня');
  heroes[3]:=Tpaladine.create('Лирой');
  heroes[4]:=TMage.create('Рейстлин');
  image1.picture:=heroes[1].portrait;
  image2.picture:=heroes[2].portrait;
  image3.picture:=heroes[3].portrait;
  image4.picture:=heroes[4].portrait;
  NameL1.Caption:=heroes[1].name;
  NameL2.Caption:=heroes[2].name;
  NameL3.Caption:=heroes[3].name;
  NameL4.Caption:=heroes[4].name;
  HpBar1.Max:=heroes[1].max_hp;
  HpBar2.Max:=heroes[2].max_hp;
  HpBar3.Max:=heroes[3].max_hp;
  HpBar4.Max:=heroes[4].max_hp;
  HpBar1.Position:=heroes[1].hp;
  HpBar2.Position:=heroes[2].hp;
  HpBar3.Position:=heroes[3].hp;
  HpBar4.Position:=heroes[4].hp;
  heroes[1].hp:=10;
  HpBar1.Position:=heroes[1].hp;
  if heroes[1].ClassType=TMage then
  begin
    ManaBar1.Max:=heroes[1].spells;
    ManaBar1.Position:=heroes[1].spells;
    ManaL1.Visible:=True;
    ManaBar1.Visible:=True;
  end;
  if heroes[2].ClassType=TMage then
  begin
    ManaBar2.Max:=heroes[2].spells;
    ManaBar2.Position:=heroes[2].spells;
    ManaL2.Visible:=True;
    ManaBar2.Visible:=True;
  end;
  if heroes[3].ClassType=TMage then
  begin
    ManaBar3.Max:=heroes[3].spells;
    ManaBar3.Position:=heroes[3].spells;
    ManaL3.Visible:=True;
    ManaBar3.Visible:=True;
  end;
  if heroes[4].ClassType=TMage then
  begin
    ManaBar4.Max:=heroes[4].spells;
    ManaBar4.Position:=heroes[4].spells;
    ManaL4.Visible:=True;
    ManaBar4.Visible:=True;
  end;
end;

procedure TForm1.getHeroInfo(n: Integer);
begin
  Form2.Visible:=True;
  Form2.Image1.Picture:=heroes[n].portrait;
  Form2.Label1.Caption:=heroes[n].name;
  Form2.Label2.Caption:=heroes[n].weapons[1].name;
  Form2.Label3.Caption:=heroes[n].shield.name;
end;  

procedure TForm1.Image1DblClick(Sender: TObject);
begin
  getHeroInfo(1);
end;

procedure TForm1.Image2DblClick(Sender: TObject);
begin
  getHeroInfo(2);
end;

procedure TForm1.Image3DblClick(Sender: TObject);
begin
  getHeroInfo(3);
end;

procedure TForm1.Image4DblClick(Sender: TObject);
begin
  getHeroInfo(4);
end;

end.

