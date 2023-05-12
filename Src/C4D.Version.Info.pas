unit C4D.Version.Info;

//INSPIRADO NA UNIT RxVerInf DO COMPONENTE RXLib

interface

uses
  System.SysUtils,
  Winapi.Windows,
  C4D.Version.Interfaces,
  C4D.Version.Types,
  C4D.Version.Utils;

type
  TC4DVersionInfo = class(TInterfacedObject, IC4DVersionInfo)
  private
    FFileName: PChar;
    FIsValid: Boolean;
    FSize: DWORD;
    FBuffer: PChar;
    FHandle: DWORD;
    FFixedFileInfo: PVSFixedFileInfo;
    FVersion: TRecordVersion;
    FVersionProduct: TRecordVersion;
    procedure ReadAllDados;
    procedure ReadVersionInfo;
    procedure ReadFixedFileInfo;
    procedure ReadVersionFile;
    procedure ReadVersionProduct;
    function FileNameAppCurrent: String;
    function VersionToShortStr(const Version: TRecordVersion): string;
    function VersionToLongStr(const Version: TRecordVersion): string;
    function GetVerValue(const AVerName: String): String;
    function GetTranslation: Pointer;
  protected
    function GetFileName: String;
    procedure SetFileName(const Value: String);
    function FileDescription: String;
    function VersionShort: String;
    function VersionLong: String;
    function VersionMajor: Integer;
    function VersionMinor: Integer;
    function VersionPatch: Integer;
    function PreRelease: Boolean;
    function VersionPreRelease: String;
    function VersionNum: LongInt;
    function ProductName: String;
    function VersionProductShort: String;
    function VersionProductLong: String;
    function Comments: String;
    function CompanyName: String;
    function InternalName: String;
    function LegalCopyright: String;
    function LegalTrademarks: String;
    function OriginalFilename: String;
    function VerFileDate: TDateTime;
    function TranslationString: String;
    function IsValid: Boolean;
    function SpecialBuild: String;
    function PrivateBuild: String;
    function DebugBuild: Boolean;
    function Patched: Boolean;
    function InfoInferred: Boolean;
    function Value(AName: String): String;
  public
    class function New: IC4DVersionInfo; overload;
    class function New(const AFileName: String): IC4DVersionInfo; overload;
    constructor Create; overload;
    constructor Create(const AFileName: String);  overload;
    destructor Destroy; override;
  end;

implementation

uses
  WinTypes,
  WinProcs,
  C4D.Version.Consts;

class function TC4DVersionInfo.New: IC4DVersionInfo;
begin
   Result := Self.Create;
end;

class function TC4DVersionInfo.New(const AFileName: String): IC4DVersionInfo;
begin
   Result := Self.Create(AFileName);
end;

constructor TC4DVersionInfo.Create;
begin
   Self.Create(Self.FileNameAppCurrent);
end;

constructor TC4DVersionInfo.Create(const AFileName: String);
var
 LFileName: String;
begin
   inherited Create;

   LFileName := AFileName;
   if(LFileName.Trim.IsEmpty)then
     LFileName := Self.FileNameAppCurrent;

   FFileName := StrPCopy(StrAlloc(Length(LFileName) + 1), LFileName);
   Self.ReadAllDados;
end;

function TC4DVersionInfo.GetFileName: String;
begin
   Result := StrPas(FFileName);
end;

procedure TC4DVersionInfo.SetFileName(const Value: String);
begin
   if(FBuffer <> nil)then
     FreeMem(FBuffer, FSize);
   FBuffer := nil;
   StrDispose(FFileName);
   FFileName := StrPCopy(StrAlloc(Length(Value) + 1), Value);
   Self.ReadAllDados;
end;

procedure TC4DVersionInfo.ReadAllDados;
begin
   FIsValid := False;
   if(not FileExists(FFileName))then
     Exit;

   Self.ReadVersionInfo;
   Self.ReadFixedFileInfo;
   Self.ReadVersionFile;
   Self.ReadVersionProduct;
end;

procedure TC4DVersionInfo.ReadVersionInfo;
begin
   FIsValid := False;
   FSize := GetFileVersionInfoSize(FFileName, FHandle);
   if(FSize > 0)then
   try
     FBuffer := TC4DVersionUtils.MemAlloc(FSize);
     FIsValid := GetFileVersionInfo(FFileName, FHandle, FSize, FBuffer);
   except
     FIsValid := False;
     raise;
   end;
end;

procedure TC4DVersionInfo.ReadFixedFileInfo;
var
 LPuLen: {$IFNDEF VER80} UINT; {$ELSE} Cardinal; {$ENDIF}
begin
   FFixedFileInfo := nil;
   if(FIsValid)then
     VerQueryValue(FBuffer, '\', Pointer(FFixedFileInfo), LPuLen);
end;

procedure TC4DVersionInfo.ReadVersionFile;
begin
   FVersion.MS := FFixedFileInfo^.dwFileVersionMS;
   FVersion.LS := FFixedFileInfo^.dwFileVersionLS;
end;

procedure TC4DVersionInfo.ReadVersionProduct;
begin
   FVersionProduct.MS := FFixedFileInfo^.dwProductVersionMS;
   FVersionProduct.LS := FFixedFileInfo^.dwProductVersionLS;
end;

destructor TC4DVersionInfo.Destroy;
begin
   if(FBuffer <> nil)then
     FreeMem(FBuffer, FSize);
   StrDispose(FFileName);
   inherited Destroy;
end;

function TC4DVersionInfo.FileNameAppCurrent: String;
var
 LFileName: array[0..MAX_PATH] of Char;
begin
   if(IsLibrary)then
   begin
      GetModuleFileName(HInstance, LFileName, {$IFDEF UNICODE}Length(LFileName){$ELSE}SizeOf(LFileName) - 1{$ENDIF});
      Result := StrPas(LFileName);
   end
   else
     Result := ParamStr(0);
end;

function TC4DVersionInfo.TranslationString: String;
var
 LPointer: Pointer;
begin
   Result := '';
   LPointer := Self.GetTranslation;
   if(LPointer <> nil)then
     Result := IntToHex(MakeLong(HiWord(LongInt(LPointer^)), LoWord(LongInt(LPointer^))), 8);
end;

function TC4DVersionInfo.GetTranslation: Pointer;
var
 LPuLen: {$IFNDEF VER80} UINT; {$ELSE} Cardinal; {$ENDIF}
begin
   Result := nil;
   if(FIsValid)then
     VerQueryValue(FBuffer, '\VarFileInfo\Translation', Result, LPuLen);
end;

function TC4DVersionInfo.VersionNum: LongInt;
begin
   Result := 0;
   if(FIsValid)then
     Result := FFixedFileInfo^.dwFileVersionMS
end;

function TC4DVersionInfo.GetVerValue(const AVerName: String): String;
var
 LszName: array[0..255] of Char;
 LPointer: Pointer;
 LPuLen: {$IFNDEF VER80} UINT; {$ELSE} Cardinal; {$ENDIF}
begin
   Result := '';
   if(FIsValid)then
   begin
      StrPCopy(LszName, '\StringFileInfo\' + TranslationString + '\' + AVerName);
      if(VerQueryValue(FBuffer, LszName, LPointer, LPuLen))then
        Result := StrPas(PChar(LPointer));
   end;
end;

function TC4DVersionInfo.VersionShort: String;
begin
   Result := '';
   if(FIsValid)then
     Result := Self.VersionToShortStr(FVersion);
end;

function TC4DVersionInfo.VersionLong: String;
begin
   Result := Self.GetVerValue('FileVersion');
   if(Result.IsEmpty)and(FIsValid)then
     Result := Self.VersionToLongStr(FVersion);
end;

function TC4DVersionInfo.Comments: String;
begin
   Result := Self.GetVerValue('Comments');
end;

function TC4DVersionInfo.CompanyName: String;
begin
   Result := Self.GetVerValue('CompanyName');
end;

function TC4DVersionInfo.FileDescription: String;
begin
   Result := Self.GetVerValue('FileDescription');
end;

function TC4DVersionInfo.InternalName: String;
begin
   Result := Self.GetVerValue('InternalName');
end;

function TC4DVersionInfo.LegalCopyright: String;
begin
   Result := Self.GetVerValue('LegalCopyright');
end;

function TC4DVersionInfo.LegalTrademarks: String;
begin
   Result := Self.GetVerValue('LegalTrademarks');
end;

function TC4DVersionInfo.OriginalFilename: String;
begin
   Result := Self.GetVerValue('OriginalFilename');
end;

function TC4DVersionInfo.VersionMajor: Integer;
begin
   Result := StrToIntDef(Format('%d', [FVersion.All[2]]), 0);
end;

function TC4DVersionInfo.VersionMinor: Integer;
begin
   Result := StrToIntDef(Format('%d', [FVersion.All[1]]), 0);
end;

function TC4DVersionInfo.VersionPatch: Integer;
begin
   Result := StrToIntDef(Format('%d', [FVersion.All[4]]), 0);
end;

function TC4DVersionInfo.VersionPreRelease: String;
begin
   Result := '';
   if(Self.PreRelease)then
     Result := Self.GetVerValue('PreRelease');
end;

function TC4DVersionInfo.VersionProductShort: String;
begin
   Result := '';
   if(FIsValid)then
     Result := Self.VersionToShortStr(FVersionProduct);
end;

function TC4DVersionInfo.VersionProductLong: String;
begin
   Result := Self.GetVerValue('ProductVersion');
   if(Result.IsEmpty)and(FIsValid)then
     Result := Self.VersionToLongStr(FVersionProduct);
end;

function TC4DVersionInfo.ProductName: String;
begin
   Result := Self.GetVerValue('ProductName');
end;

function TC4DVersionInfo.SpecialBuild: String;
begin
   Result := Self.GetVerValue('SpecialBuild');
end;

function TC4DVersionInfo.PrivateBuild: String;
begin
   Result := Self.GetVerValue('PrivateBuild');
end;

function TC4DVersionInfo.DebugBuild: Boolean;
begin
   Result := TC4DVersionUtils.HasdwFileFlags(FFixedFileInfo, VS_FF_DEBUG);
end;

function TC4DVersionInfo.PreRelease: Boolean;
begin
   Result := TC4DVersionUtils.HasdwFileFlags(FFixedFileInfo, VS_FF_PRERELEASE);
end;

function TC4DVersionInfo.Patched: Boolean;
begin
   Result := TC4DVersionUtils.HasdwFileFlags(FFixedFileInfo, VS_FF_PATCHED);
end;

function TC4DVersionInfo.InfoInferred: Boolean;
begin
   Result := TC4DVersionUtils.HasdwFileFlags(FFixedFileInfo, VS_FF_INFOINFERRED);
end;

function TC4DVersionInfo.IsValid: Boolean;
begin
   Result := FIsValid;
end;

function TC4DVersionInfo.Value(AName: String): String;
begin
   Result := Self.GetVerValue(AName);
end;

function TC4DVersionInfo.VerFileDate: TDateTime;
begin
   Result := NullDate;
   if(FileExists(GetFileName))then
     Result := TC4DVersionUtils.FileDateTime(GetFileName)
end;

function TC4DVersionInfo.VersionToShortStr(const Version: TRecordVersion): string;
begin
   Result := Format('%d.%d.%d', [Version.All[2], Version.All[1], Version.All[4]]);
end;

function TC4DVersionInfo.VersionToLongStr(const Version: TRecordVersion): string;
begin
   Result := Format('%d.%d.%d.%d', [Version.All[2], Version.All[1], Version.All[4], Version.All[3]]);
end;

end.
