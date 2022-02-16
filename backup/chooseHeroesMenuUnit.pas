unit ChooseHeroesMenuUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm3 }

  { TChooseHeroesMenuForm }

  TChooseHeroesMenuForm = class(TForm)
    ReadyButton: TButton;
    KindComboBox1: TComboBox;
    KindComboBox2: TComboBox;
    KindComboBox3: TComboBox;
    KindComboBox4: TComboBox;
    NameEdit1: TEdit;
    NameEdit2: TEdit;
    NameEdit3: TEdit;
    NameEdit4: TEdit;
    NameL1: TLabel;
    NameL2: TLabel;
    NameL3: TLabel;
    NameL4: TLabel;
    HeaderLabel: TLabel;
    KindL1: TLabel;
    KindL2: TLabel;
    KindL3: TLabel;
    KindL4: TLabel;
    procedure KindComboBox1Change(Sender: TObject);
    procedure KindComboBox2Change(Sender: TObject);
    procedure KindComboBox3Change(Sender: TObject);
    procedure KindComboBox4Change(Sender: TObject);
    procedure EachComboChange(number:Integer);
    procedure NameEdit1Change(Sender: TObject);
    procedure NameEdit2Change(Sender: TObject);
    procedure NameEdit3Change(Sender: TObject);
    procedure NameEdit4Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NameEditsChange();
    procedure ReadyButtonClick(Sender: TObject);
  private

  public

  end;

var
  ChooseHeroesMenuForm: TChooseHeroesMenuForm;
  ready:Boolean;
  kindCBoxes:array [1..4] of TComboBox;
  nameEdits:array [1..4] of TEdit;

implementation

{$R *.lfm}

{ TForm3 }

procedure TChooseHeroesMenuForm.KindComboBox1Change(Sender: TObject);
begin
  EachComboChange(1);
end;

procedure TChooseHeroesMenuForm.KindComboBox2Change(Sender: TObject);
begin
  EachComboChange(2);
end;

procedure TChooseHeroesMenuForm.KindComboBox3Change(Sender: TObject);
begin
  EachComboChange(3);
end;

procedure TChooseHeroesMenuForm.KindComboBox4Change(Sender: TObject);
begin
  EachComboChange(4);
end;

procedure TChooseHeroesMenuForm.EachComboChange(number: Integer);
begin
  if kindCBoxes[number].ItemIndex=-1 then
  begin
    kindCBoxes[number].ItemIndex:=0;
    ReadyButton.Enabled:=False;
  end
  else
  begin
    if (nameEdits[1].GetTextLen>2) and (nameEdits[2].GetTextLen>2) and (nameEdits[3].GetTextLen>2) and (nameEdits[4].GetTextLen>2) and (kindCBoxes[1].ItemIndex>0) and (kindCBoxes[2].ItemIndex>0) and (kindCBoxes[3].ItemIndex>0) and (kindCBoxes[4].ItemIndex>0) then
      ReadyButton.Enabled:=True
    else ReadyButton.Enabled:=False;
  end;
end;

procedure TChooseHeroesMenuForm.NameEdit1Change(Sender: TObject);
begin
  NameEditsChange();
end;

procedure TChooseHeroesMenuForm.NameEdit2Change(Sender: TObject);
begin
  NameEditsChange();
end;

procedure TChooseHeroesMenuForm.NameEdit3Change(Sender: TObject);
begin
  NameEditsChange();
end;

procedure TChooseHeroesMenuForm.NameEdit4Change(Sender: TObject);
begin
  NameEditsChange();
end;

procedure TChooseHeroesMenuForm.FormCreate(Sender: TObject);
begin
  ready:=False;
  kindCBoxes[1]:=KindComboBox1;
  kindCBoxes[2]:=KindComboBox2;
  kindCBoxes[3]:=KindComboBox3;
  kindCBoxes[4]:=KindComboBox4;
  nameEdits[1]:=NameEdit1;
  nameEdits[2]:=NameEdit2;
  nameEdits[3]:=NameEdit3;
  nameEdits[4]:=NameEdit4;
end;

procedure TChooseHeroesMenuForm.NameEditsChange();
begin
  if (nameEdits[1].GetTextLen>2) and (nameEdits[2].GetTextLen>2) and (nameEdits[3].GetTextLen>2) and (nameEdits[4].GetTextLen>2) and (kindCBoxes[1].ItemIndex>0) and (kindCBoxes[2].ItemIndex>0) and (kindCBoxes[3].ItemIndex>0) and (kindCBoxes[4].ItemIndex>0) then
  begin
    ReadyButton.Enabled:=True;
  end
  else ReadyButton.Enabled:=False;
end;

procedure TChooseHeroesMenuForm.ReadyButtonClick(Sender: TObject);
begin
  ready:=True;
  Close;
end;

end.
