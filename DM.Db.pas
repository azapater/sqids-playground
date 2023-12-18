unit DM.Db;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.NetEncoding.Sqids;

type
  TDbModule = class(TDataModule)
    tblSqids: TFDMemTable;
    tblSqidsNumber: TSmallintField;
    tblSqidsId: TStringField;
    procedure tblSqidsCalcFields(DataSet: TDataSet);
  public
    procedure InitData;
    procedure Refresh;
  end;

var
  DbModule: TDbModule;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

uses
  CommonU;

{ TDataModule1 }

procedure TDbModule.InitData;
begin
  // We preload the memtabe with 1000 rows
  tblSqids.Active := True;
  tblSqids.DisableControls;
  try
    for var i := 0 to 999 do
      begin
        tblSqids.Append;
        tblSqids.FieldByName('Number').AsInteger := i;
        tblSqids.Post;
      end;
    tblSqids.First;
  finally
    tblSqids.EnableControls;
  end;
end;

procedure TDbModule.Refresh;
begin
  tblSqids.Refresh;
end;

procedure TDbModule.tblSqidsCalcFields(DataSet: TDataSet);
begin
  var number := DataSet.FieldByName('Number').asString;
  DataSet.FieldByName('Id').AsString := MySqids.Encode(number);
end;

end.
