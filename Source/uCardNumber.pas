unit uCardNumber;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  System.JSON,
  System.IOUtils;

type
  TCardNumber = class
  public
    type
      TCardInfo = class
      public
        issuer: string;     // 발급사
        bin: string;        // BIN
        arg_name: string;   // 전표인자명
        card_gubun: string; // 개인/법인
        brand: string;      // 브랜드
        card_type: string;  // 신용/체크
      end;
  strict private
    const
      DATA_FILE = 'card_bin_table.json';
    class var
      FItems: TObjectDictionary<string, TCardInfo>;

    class constructor Create;
    class destructor Destroy;
  private
    class procedure LoadFromFile; static;
  public
    class function  GetInfo(const ANumber: string; out ACardInfo: TCardInfo): Boolean; static;
    class function  IsValid(const ANumber: string): Boolean; static;
  end;

implementation

{ TCardNumber }

class constructor TCardNumber.Create;
begin
  FItems := TObjectDictionary<string, TCardInfo>.Create([doownsValues]);
  LoadFromFile;
end;

class destructor TCardNumber.Destroy;
begin
  FItems.Free;
end;

class function TCardNumber.GetInfo(const ANumber: string; out ACardInfo: TCardInfo): Boolean;
begin
  var LBin := Copy(ANumber, 1, 6);
  Result := Fitems.TryGetValue(LBin, ACardInfo);
end;

class function TCardNumber.IsValid(const ANumber: string): Boolean;
  function Check(const ANumber: Integer): Integer;
  begin
    var LTemp := ANumber * 2;
    Result := (LTemp div 10) + (LTemp mod 10);
  end;
begin
  var LCount := Length(ANumber);
  var LMode: Integer;

  if (LCount mod 2) = 0 then
    LMode := 1
  else
    LMode := 0;

  var LSum := 0;
  for var i := 1 to LCount do
  begin
    if not CharInSet(ANumber[i], ['0'..'9']) then
      Exit(False);

    var LNumber := StrToInt(ANumber[i]);

    if (i mod 2) = LMode then
      LSum := LSum + Check(LNumber)
    else
      LSum := LSum + LNumber;
  end;

  Result := (LSum mod 10) = 0;
end;

class procedure TCardNumber.LoadFromFile;
begin
  if not TFile.Exists(DATA_FILE) then
    Exit;

  var LArray := TJSONArray.ParseJSONValue(TFile.ReadAllBytes(DATA_FILE), 0) as TJSONArray;
  for var i := 0 to LArray.Count-1 do
  begin
    var LCardInfo := TCardInfo.Create;
    LCardInfo.issuer     := LArray.Items[i].GetValue<string>('issuer');
    LCardInfo.bin        := LArray.Items[i].GetValue<string>('bin');
    LCardInfo.arg_name   := LArray.Items[i].GetValue<string>('arg_name');
    LCardInfo.card_gubun := LArray.Items[i].GetValue<string>('card_gubun');
    LCardInfo.brand      := LArray.Items[i].GetValue<string>('brand');
    LCardInfo.card_type  := LArray.Items[i].GetValue<string>('card_type');

    FItems.AddOrSetValue(LCardInfo.bin, LCardInfo);
  end;
end;

end.
