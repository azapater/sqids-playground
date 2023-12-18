unit CommonU;

interface

uses
  Math,
  System.Classes,
  System.NetEncoding.Sqids;

const
  ALPHABET_DEFAULT = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  ALPHABET_NUMBERS = '0123456789';
  ALPHABET_LETTERS = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  ALPHABET_LOWERCASE = 'abcdefghijklmnopqrstuvwxyz';
  ALPHABET_UPPERCASE = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  ALPHABETS: TArray<string> = [ALPHABET_DEFAULT,
                               ALPHABET_NUMBERS,
                               ALPHABET_LETTERS,
                               ALPHABET_LOWERCASE,
                               ALPHABET_UPPERCASE];

type
  TMySqids = class(TObject)
  private
    FSqids: TSqidsEncoding;
    FAlphabet: string;
    FLength: integer;
    function GetAlphabet: string;
    procedure SetAlphabet(const Value: string);
    function GetLength: integer;
    procedure SetLength(const Value: integer);
  public
    constructor Create;
    destructor Destroy; override;
    function Encode(const ANumbers: string): string;
    function Decode(const AHash: string): string;
    property Alphabet: string read GetAlphabet write SetAlphabet;
    property Length: integer read GetLength write SetLength;
  end;

var
  MySqids: TMySqids;

function ShuffleString(const AString: string): string;

implementation

uses System.SysUtils;

function ShuffleString(const AString: string): string;
var
  j: integer;
  t: char;
begin
  randomize;
  var a := AString;
  for var i := Length(a) downto 1 do
  begin
    j := randomrange(1, i);
    t := a[i];
    a[i] := a[j];
    a[j] := t;
  end;
  Result := a;
end;

{ TMySqids }

constructor TMySqids.Create;
begin
  FSqids := TSqidsEncoding.Create;
end;

destructor TMySqids.Destroy;
begin
  inherited;
  FSqids.Free;
end;

function TMySqids.GetLength: integer;
begin
  Result := FLength;
end;

procedure TMySqids.SetLength(const Value: integer);
begin
  FLength := Value;
  FSqids.Free;
  FSqids := TSqidsEncoding.Create(Alphabet, Length);
end;

procedure TMySqids.SetAlphabet(const Value: string);
begin
  FAlphabet := Value;
  FSqids.Free;
  FSqids := TSqidsEncoding.Create(Alphabet, Length);
end;

function TMySqids.GetAlphabet: string;
begin
  Result := FAlphabet;
end;

function TMySqids.Decode(const AHash: string): string;
begin
  Result := FSqids.DecodeToStr(AHash.Trim);
  // Decoding IDs will usually produce some kind of numeric output,
  // but that doesn't necessarily mean that the ID is canonical.
  // To check that the ID is valid, you can re-encode decoded numbers and check that the ID matches.
  if AHash <> Encode(Result) then
    Result := 'Invalid ID';
end;

function TMySqids.Encode(const ANumbers: string): string;
begin
  var lNumbers := ANumbers.Replace(' ', '');
  if lNumbers.EndsWith(',') then
    lNumbers := lNumbers.TrimRight([',']);
  try
    Result := FSqids.Encode(lNumbers);
  except
    Result := 'invalid numbers';
  end;
end;

initialization
begin
  MySqids := TMySqids.Create;
end;

finalization

begin
  MySqids.Free;
end;

end.
