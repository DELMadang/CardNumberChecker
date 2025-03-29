object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = #49888#50857#52852#46300' '#48264#54840' '#44160#51613
  ClientHeight = 227
  ClientWidth = 591
  Color = clBtnFace
  Font.Charset = HANGEUL_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #47569#51008' '#44256#46357
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 72
    Height = 15
    Caption = #49888#50857#52852#46300#48264#54840
  end
  object btnVerify: TButton
    Left = 218
    Top = 11
    Width = 75
    Height = 25
    Caption = #44160#51613
    TabOrder = 0
    OnClick = btnVerifyClick
  end
  object eLog: TMemo
    Left = 8
    Top = 42
    Width = 577
    Height = 175
    TabOrder = 1
  end
  object eCardNumber: TEdit
    Left = 91
    Top = 12
    Width = 121
    Height = 23
    MaxLength = 16
    NumbersOnly = True
    TabOrder = 2
  end
  object btnCardInfo: TButton
    Left = 296
    Top = 11
    Width = 75
    Height = 25
    Caption = #52852#46300#51221#48372
    TabOrder = 3
    OnClick = btnCardInfoClick
  end
end
