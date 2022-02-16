unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls, Menus, Barbarian, Hero, Mage, Paladine, Personage, Healer, Unit2, Map,Enemy, chooseheroesmenuunit;

type

  { TForm1 }

  TForm1 = class(TForm)
    battle_pause: TButton;
    ChooseHeroesBtn: TButton;
    nxt_location_btn: TButton;
    PortraitImg1: TImage;
    PortraitImg2: TImage;
    PortraitImg3: TImage;
    PortraitImg4: TImage;
    BackGroundAndEnemiesImage: TImage;
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
    act_location_btn: TButton;
    prv_location_btn: Tbutton;
    procedure ChooseHeroesBtnClick(Sender: TObject);
    procedure nxt_location_btnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PortraitImg1DblClick(Sender: TObject);
    procedure getHeroInfo(n:Integer);
    procedure PortraitImg2DblClick(Sender: TObject);
    procedure PortraitImg3DblClick(Sender: TObject);
    procedure PortraitImg4DblClick(Sender: TObject);
    procedure LoadAndDraw(const sFileName: String ; pic_resize:boolean; x,y:integer);
    procedure battle_pauseClick(Sender: TObject);
    procedure get_messages();

  private

  public

  end;

var
  Form1: TForm1;
  heroes:array [0..3] of THero;
  level_map:TMap;
  current_location:integer;
implementation

{$R *.lfm}

{ TForm1 }


  //проверка, мертвы ли все враги
  function isEveryEnemyDead():boolean;
  var i,a:integer;
  begin
    a:=0;
    for i:=0 to 3 do begin
      if  (not TEnemy(level_map.locations[current_location].enemies[i]).isDead) then begin
        a:=a+1;
      end;
    end;
    if a<>0 then isEveryEnemyDead:=false else isEveryEnemyDead:=true;
  end;

    //проверка, мертвы ли все герои
  function isEveryHeroDead():boolean;
  var i,a:integer;
  begin
    a:=0;
    for i:=0 to 3 do begin
      if  (not heroes[i].isDead) then begin
        a:=a+1;
      end;
    end;
    if a<>0 then isEveryHeroDead:=false else isEveryHeroDead:=true;
  end;

procedure TForm1.battle_pauseClick(Sender: TObject);
var dmg,i,r:integer;
begin

  //Для каждого героя
    for i:= 0 to 3 do
    begin
      //если он жив
      if not heroes[i].isDead then
      begin
        //не клерик
        if (heroes[i].ClassType<>THealer) then
        begin
          //выбирается случайный противник
          r:=random(4);
          //живой противник
          While (TEnemy(level_map.locations[current_location].enemies[r]).isDead and (not isEveryEnemyDead())) do r:=Random(4);
           //если атака героя успешна
          if heroes[i].isAttackSuccesful(TEnemy(level_map.locations[current_location].enemies[r])) then
          begin
            //наносим урон
            TEnemy(level_map.locations[current_location].enemies[r]).getDamage(heroes[i].damage);
            //если противник умер, герой повысил уровень
            if TEnemy(level_map.locations[current_location].enemies[r]).isDead() then heroes[i].levelUp();
          end;
        end
        else
        //клерик
        begin
          //выбирается случайный герой
          r:=random(4);
          //живой герой
          While (heroes[r].isDead and (not isEveryHeroDead())) do r:=Random(4);
          THealer(heroes[i]).Heal(heroes[r]);
        end;
      end;
      // Если  противник с номером i жив
      if not TEnemy(level_map.locations[current_location].enemies[i]).isDead then
      begin
        //если герои мертвы
        if iseveryHeroDead() then begin
          //прекратить битву
           form1.battle_pause.enabled:=False;
        end;
       // выберем случайного героя
        r:=random(4);

        While heroes[r].isDead do r:=Random(4)+1;
       //если атака противника успешна
        if TEnemy(level_map.locations[current_location].enemies[i]).isAttackSuccesful(heroes[r]) then
        begin
          //герой получает урон
          heroes[r].getDamage(TEnemy(level_map.locations[current_location].enemies[i]).damage);
        end;
      end;
    end;

    get_messages();

  HpBar1.Position:=heroes[0].hp;
  HpBar2.Position:=heroes[1].hp;
  HpBar3.Position:=heroes[2].hp;
  HpBar4.Position:=heroes[3].hp;
  ManaBar1.Position:=heroes[0].spells;
  ManaBar2.Position:=heroes[1].spells;
  ManaBar3.Position:=heroes[2].spells;
  ManaBar4.Position:=heroes[3].spells;
  if iseveryEnemyDead then begin
    form1.battle_pause.enabled:=False;
    form1.nxt_location_btn.Visible:=True;
  end;
  BackGroundAndEnemiesImage.Picture:=level_map.locations[current_location].background;
  loadanddraw(level_map.locations[current_location].background_path,true,0,0);
  for i:=0 to 3 do begin
    if TEnemy(level_map.locations[current_location].enemies[i]).hp>0 then loadanddraw(TEnemy(level_map.locations[current_location].enemies[i]).portrait_path,false,100+200*i,300);
  end;
end;

procedure TForm1.get_messages();
  var message:string;i:integer;
  begin
    for i:=0 to 3 do
    begin
      message:=heroes[i].new_message;
      memo1.Append(message);
      message:=TEnemy(level_map.locations[current_location].enemies[i]).new_message;
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
    if pic_resize then BackGroundAndEnemiesImage.Picture.Bitmap.SetSize(jpg.Width, jpg.Height);
    BackGroundAndEnemiesImage.Picture.Bitmap.Canvas.Draw(x, y, jpg.Bitmap);

  finally
    jpg.Free;
  end;
end;


procedure TForm1.FormCreate(Sender: TObject);
var i:integer;
begin
  ChooseHeroesBtn.Align:=alClient;
  //ChooseHeroesBtn.Visible:=False;
  level_map:=TMap.create();
  current_location:=1;
  {
  BackGroundAndEnemiesImage.Picture:=level_map.locations[current_location].background;
  loadanddraw(level_map.locations[current_location].background_path,true,0,0);

  for i:=0 to 3 do begin
       if TEnemy(level_map.locations[current_location].enemies[i]).hp>0 then loadanddraw(TEnemy(level_map.locations[current_location].enemies[i]).portrait_path,false,100+200*i,300);
  e
  LocTitle.caption:=level_map.locations[current_location].place;
  heroes[0]:=TMage.create('Ринсвинд');
  heroes[1]:=TBarbarian.create('Рыжая Соня');
  heroes[2]:=Tpaladine.create('Лирой');
  heroes[3]:=TMage.create('Рейстлин');
  PortraitImg1.picture:=heroes[0].portrait;
  PortraitImg2.picture:=heroes[1].portrait;
  PortraitImg3.picture:=heroes[2].portrait;
  PortraitImg4.picture:=heroes[3].portrait;
  NameL1.Caption:=heroes[0].name;
  NameL2.Caption:=heroes[1].name;
  NameL3.Caption:=heroes[2].name;
  NameL4.Caption:=heroes[3].name;
  HpBar1.Max:=heroes[0].max_hp;
  HpBar2.Max:=heroes[1].max_hp;
  HpBar3.Max:=heroes[2].max_hp;
  HpBar4.Max:=heroes[3].max_hp;
  HpBar1.Position:=heroes[0].hp;
  HpBar2.Position:=heroes[1].hp;
  HpBar3.Position:=heroes[2].hp;
  HpBar4.Position:=heroes[3].hp;
  if heroes[0].ClassType=TMage then
  begin
    ManaBar1.Max:=heroes[0].spells;
    ManaBar1.Position:=heroes[0].spells;
    ManaL1.Visible:=True;
    ManaBar1.Visible:=True;
  end;
  if heroes[1].ClassType=TMage then
  begin
    ManaBar2.Max:=heroes[1].spells;
    ManaBar2.Position:=heroes[1].spells;
    ManaL2.Visible:=True;
    ManaBar2.Visible:=True;
  end;
  if heroes[2].ClassType=TMage then
  begin
    ManaBar3.Max:=heroes[2].spells;
    ManaBar3.Position:=heroes[2].spells;
    ManaL3.Visible:=True;
    ManaBar3.Visible:=True;
  end;
  if heroes[3].ClassType=TMage then
  begin
    ManaBar4.Max:=heroes[3].spells;
    ManaBar4.Position:=heroes[3].spells;
    ManaL4.Visible:=True;
    ManaBar4.Visible:=True;
  end;
  }
end;

procedure TForm1.nxt_location_btnClick(Sender: TObject);
begin

end;

procedure TForm1.ChooseHeroesBtnClick(Sender: TObject);
var
  i: Integer;
begin
  ready:=False;
  Form1.Visible:=False;
  ChooseHeroesMenuForm.ShowModal;
  if ready then
  begin
    ChooseHeroesBtn.Visible:=False;
    HpL1.Visible:=True;
    HpL2.Visible:=True;
    HpL3.Visible:=True;
    HpL4.Visible:=True;
    BackGroundAndEnemiesImage.Picture:=level_map.locations[current_location].background;
    loadanddraw(level_map.locations[current_location].background_path,true,0,0);

    for i:=0 to 3 do begin
     if TEnemy(level_map.locations[current_location].enemies[i]).hp>0 then loadanddraw(TEnemy(level_map.locations[current_location].enemies[i]).portrait_path,false,100+200*i,300);
    end;
    LocTitle.caption:=level_map.locations[current_location].place;
    for i:=0 to 3 do
    begin
      case (kindCBoxes[i+1].ItemIndex) of
        1: heroes[i]:=TBarbarian.create(nameEdits[i].Text);
        2: heroes[i]:=TMage.create(nameEdits[i].Text);
        3: heroes[i]:=Tpaladine.create(nameEdits[i].Text);
      end;
    end;
    PortraitImg1.picture:=heroes[0].portrait;
    PortraitImg2.picture:=heroes[1].portrait;
    PortraitImg3.picture:=heroes[2].portrait;
    PortraitImg4.picture:=heroes[3].portrait;
    NameL1.Caption:=heroes[0].name;
    NameL2.Caption:=heroes[1].name;
    NameL3.Caption:=heroes[2].name;
    NameL4.Caption:=heroes[3].name;
    HpBar1.Max:=heroes[0].max_hp;
    HpBar2.Max:=heroes[1].max_hp;
    HpBar3.Max:=heroes[2].max_hp;
    HpBar4.Max:=heroes[3].max_hp;
    HpBar1.Position:=heroes[0].hp;
    HpBar2.Position:=heroes[1].hp;
    HpBar3.Position:=heroes[2].hp;
    HpBar4.Position:=heroes[3].hp;
    if heroes[0].ClassType=TMage then
    begin
      ManaBar1.Max:=heroes[0].spells;
      ManaBar1.Position:=heroes[0].spells;
      ManaL1.Visible:=True;
      ManaBar1.Visible:=True;
    end;
    if heroes[1].ClassType=TMage then
    begin
      ManaBar2.Max:=heroes[1].spells;
      ManaBar2.Position:=heroes[1].spells;
      ManaL2.Visible:=True;
      ManaBar2.Visible:=True;
    end;
    if heroes[2].ClassType=TMage then
    begin
      ManaBar3.Max:=heroes[2].spells;
      ManaBar3.Position:=heroes[2].spells;
      ManaL3.Visible:=True;
      ManaBar3.Visible:=True;
    end;
    if heroes[3].ClassType=TMage then
    begin
      ManaBar4.Max:=heroes[3].spells;
      ManaBar4.Position:=heroes[3].spells;
      ManaL4.Visible:=True;
      ManaBar4.Visible:=True;
    end;
  end;
  Form1.Visible:=True;
end;

procedure TForm1.getHeroInfo(n: Integer);
begin
  Form2.Visible:=True;
  Form2.Image1.Picture:=heroes[n].portrait;
  Form2.Label1.Caption:=heroes[n].name;
  Form2.Label2.Caption:=heroes[n].weapons[1].name;
  Form2.Label3.Caption:=heroes[n].shield.name;
end;  

procedure TForm1.PortraitImg1DblClick(Sender: TObject);
begin
  getHeroInfo(0);
end;

procedure TForm1.PortraitImg2DblClick(Sender: TObject);
begin
  getHeroInfo(1);
end;

procedure TForm1.PortraitImg3DblClick(Sender: TObject);
begin
  getHeroInfo(2);
end;

procedure TForm1.PortraitImg4DblClick(Sender: TObject);
begin
  getHeroInfo(3);
end;

end.

