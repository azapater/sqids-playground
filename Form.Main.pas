unit Form.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Skia,
  FMX.Skia, FMX.Controls.Presentation, FMX.Edit, FMX.Objects, FMX.StdCtrls,
  FMX.Layouts, System.Actions, FMX.ActnList, FMX.TabControl, System.Rtti,
  FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope;

type
  TMainForm = class(TForm)
    lblTitle: TSkLabel;
    lblAlphabet: TSkLabel;
    edtAlphabet: TEdit;
    Layout1: TLayout;
    btnDefault: TSpeedButton;
    btnLowercase: TSpeedButton;
    btnLetters: TSpeedButton;
    btnNumbers: TSpeedButton;
    btnUppercase: TSpeedButton;
    btnShuffle: TSpeedButton;
    lblLength: TSkLabel;
    TrackBarLength: TTrackBar;
    TabControl: TTabControl;
    tabResults: TTabItem;
    tabEncode: TTabItem;
    tabDecode: TTabItem;
    ActionList: TActionList;
    ActionChangeLength: TAction;
    Grid1: TGrid;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    lblEncode: TSkLabel;
    edtEncode: TEdit;
    edtEncodeResult: TEdit;
    lblEncodeResult: TSkLabel;
    lblDecode: TSkLabel;
    edtDecode: TEdit;
    lblDecodeResult: TSkLabel;
    edtDecodeResult: TEdit;
    procedure ActionListChangeLength(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnShuffleClick(Sender: TObject);
    procedure btnAssignAlphabetClick(Sender: TObject);
    procedure TabControlChange(Sender: TObject);
    procedure edtAlphabetChangeTracking(Sender: TObject);
    procedure EditsChangeTracking(Sender: TObject);
  private
    procedure UpdateResults;
  end;

var
  MainForm: TMainForm;

implementation

uses
  DM.Db, CommonU;

{$R *.fmx}

procedure TMainForm.ActionListChangeLength(Sender: TObject);
begin
  var newLength := TrackBarLength.Value;
  lblLength.Words.ItemByName['length'].Text := newLength.ToString;
  MySqids.Length := Trunc(newLength);
  UpdateResults();
end;

procedure TMainForm.btnAssignAlphabetClick(Sender: TObject);
begin
  var clickedButtonTag := TComponent(Sender).Tag;
  edtAlphabet.Text := CommonU.ALPHABETS[clickedButtonTag];
end;

procedure TMainForm.btnShuffleClick(Sender: TObject);
begin
  edtAlphabet.Text := CommonU.ShuffleString(edtAlphabet.Text);
end;

procedure TMainForm.edtAlphabetChangeTracking(Sender: TObject);
begin
  MySqids.Alphabet := edtAlphabet.Text;
  lblAlphabet.Words.ItemByName['chars'].Text := edtAlphabet.Text.Length.ToString;
  UpdateResults();
end;

procedure TMainForm.EditsChangeTracking(Sender: TObject);
begin
  UpdateResults();
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  DbModule.InitData();
  edtAlphabet.Text := CommonU.ALPHABET_DEFAULT;
end;

procedure TMainForm.TabControlChange(Sender: TObject);
begin
  UpdateResults();
end;

procedure TMainForm.UpdateResults;
begin
  if TabControl.ActiveTab = tabResults then
    DbModule.Refresh()
  else if TabControl.ActiveTab = tabEncode then
    edtEncodeResult.Text := MySqids.Encode(edtEncode.Text)
  else if TabControl.ActiveTab = tabDecode then
    edtDecodeResult.Text := MySqids.Decode(edtDecode.Text);
end;

end.
