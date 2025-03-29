program CardNumberChecker;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  uCardNumber in 'uCardNumber.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
