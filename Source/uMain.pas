unit uMain;

interface

uses
  System.SysUtils,
  System.Classes,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls;

type
  TfrmMain = class(TForm)
    Label1: TLabel;
    btnVerify: TButton;
    eLog: TMemo;
    eCardNumber: TEdit;
    btnCardInfo: TButton;
    procedure btnVerifyClick(Sender: TObject);
    procedure btnCardInfoClick(Sender: TObject);
  private
  public
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  uCardNumber;

procedure TfrmMain.btnCardInfoClick(Sender: TObject);
begin
  var LInfo: TCardNumber.TCardInfo;
  if TCardNumber.GetInfo(eCardNumber.Text, LInfo) then
  begin
    eLog.Lines.Add('�߱޻�:     ' + LInfo.issuer);
    eLog.Lines.Add('BIN:        ' + LInfo.bin);
    eLog.Lines.Add('��ǥ���ڸ�: ' + LInfo.arg_name);
    eLog.Lines.Add('����/����:  ' + LInfo.card_gubun);
    eLog.Lines.Add('�귣��:     ' + LInfo.brand);
    eLog.Lines.Add('�ſ�/üũ:  ' + LInfo.card_type);
  end;
end;

procedure TfrmMain.btnVerifyClick(Sender: TObject);
begin
  if TCardNumber.IsValid(eCardNumber.Text) then
    eLog.Lines.Add('Valid')
  else
    eLog.Lines.Add('Invalid');
end;

end.
