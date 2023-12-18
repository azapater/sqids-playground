program SqidsPlayground;

uses
  System.StartUpCopy,
  FMX.Forms,
  Form.Main in 'Form.Main.pas' {MainForm},
  DM.Db in 'DM.Db.pas' {DbModule: TDataModule},
  CommonU in 'CommonU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDbModule, DbModule);
  Application.Run;
end.
