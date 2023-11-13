unit C4D.Version.Utils;

interface

uses
  System.SysUtils,
  Winapi.Windows;

const
  NullDate: TDateTime = 0;

type
  TCharSet = TSysCharSet;

  TC4DVersionUtils = class
  private
    class function WordPosition(const N: Integer; const S: string; const WordDelims: TCharSet): Integer; static;
  public
    class function HasdwFileFlags(AFixedFileInfo: PVSFixedFileInfo; AFlag: Word): Boolean; static;
    class function MemAlloc(Size: LongInt): Pointer; static;
    class function ExtractWord(N: Integer; const S: string; const WordDelims: TCharSet): string; static;
    class function FileDateTime(const FileName: string): System.TDateTime;
  end;

implementation

class function TC4DVersionUtils.HasdwFileFlags(AFixedFileInfo: PVSFixedFileInfo; AFlag: Word): Boolean;
begin
  Result := (AFixedFileInfo.dwFileFlagsMask and AFixedFileInfo.dwFileFlags and AFlag) = AFlag;
end;

class function TC4DVersionUtils.MemAlloc(Size: LongInt): Pointer;
{$IFNDEF VER80}
begin
  GetMem(Result, Size);
end;
{$ELSE}

var
  Handle: THandle;
begin
  if Size < 65535 then
    GetMem(Result, Size)
  else
  begin
    Handle := GlobalAlloc(HeapAllocFlags, Size);
    Result := GlobalLock(Handle);
  end;
end;
{$ENDIF}


class function TC4DVersionUtils.FileDateTime(const FileName: string): System.TDateTime;
var
  Age: LongInt;
begin
  if not FileAge(FileName, Result) then
    Result := NullDate;
  {$WARNINGS OFF}
  Age := FileAge(FileName);
  if Age = -1 then
    Result := NullDate
  else
    Result := FileDateToDateTime(Age);
  {$WARNINGS ON}
end;

class function TC4DVersionUtils.WordPosition(const N: Integer; const S: string;
  const WordDelims: TCharSet): Integer;
var
  Count, I: Integer;
begin
  Count := 0;
  I := 1;
  Result := 0;
  while (I <= Length(S)) and (Count <> N) do
  begin
    { skip over delimiters }
    while (I <= Length(S)) and CharInSet(S[I], WordDelims) do
      Inc(I);
    { if we're not beyond end of S, we're at the start of a word }
    if I <= Length(S) then
      Inc(Count);
    { if not finished, find the end of the current word }
    if Count <> N then
      while (I <= Length(S)) and not CharInSet(S[I], WordDelims) do
        Inc(I)
    else
      Result := I;
  end;
end;

class function TC4DVersionUtils.ExtractWord(N: Integer; const S: string;
  const WordDelims: TCharSet): string;
var
  I: Integer;
  Len: Integer;
begin
  Len := 0;
  I := WordPosition(N, S, WordDelims);
  if I <> 0 then
    { find the end of the current word }
    while (I <= Length(S)) and not CharInSet(S[I], WordDelims) do
    begin
      { add the I'th character to result }
      Inc(Len);
      SetLength(Result, Len);
      Result[Len] := S[I];
      Inc(I);
    end;
  SetLength(Result, Len);
end;

(* FUNCOES QUE FAZIAM PARTE DA UNIT C4D.VersioInfo E FORAM COLOCADAS AQUI POIS NÃO ESTAO SENDO USADAS
  { Rotinas de string de versão longa }
 function LongVersionToString(const Version: TLongVersion): string;
 begin
 with Version do
 Result := Format('%d.%d.%d.%d', [All[2], All[1], All[4], All[3]]);
 end;

 function StringToLongVersion(const Str: string): TLongVersion;
 var
 Sep: Integer;
 Tmp, Fragment: string;
 I: Word;
 begin
 Tmp := Str;
 for I := 1 to 4 do
 begin
 Sep := Pos('.', Tmp);
 if Sep = 0 then Sep := Pos(',', Tmp);
 if Sep = 0 then
 Fragment := Tmp
 else
 begin
 Fragment := Copy(Tmp, 1, Sep - 1);
 Tmp := Copy(Tmp, Sep + 1, MaxInt);
 end;
 if Fragment = '' then
 Result.All[I] := 0
 else
 Result.All[I] := StrToInt(Fragment);
 end;
 I := Result.All[1];
 Result.All[1] := Result.All[2];
 Result.All[2] := I;
 I := Result.All[3];
 Result.All[3] := Result.All[4];
 Result.All[4] := I;
 end;

 function AppFileName: string;
 var
 FileName: array[0..MAX_PATH] of Char;
 begin
 if IsLibrary then
 begin
 GetModuleFileName(HInstance, FileName, {$IFDEF UNICODE}Length(FileName){$ELSE}SizeOf(FileName) - 1{$ENDIF});
 Result := StrPas(FileName);
 end
 else
 Result := ParamStr(0);
 end;

 function AppVerInfo: TC4DVersionInfo;
 begin
 Result := TC4DVersionInfo.Create(AppFileName);
 end;

 { Rotinas do utilitário de instalação }
 function OkToWriteModule(ModuleName: string; NewVer: LongInt): Boolean;
 { Retorne True se não houver problema em substituir ModuleName por NewVer }
 begin
 {Suponha que devemos sobrescrever}
 OkToWriteModule := True;
 with TC4DVersionInfo.Create(ModuleName) do
 begin
 try
 if Valid then {Should we overwrite?}
 OkToWriteModule := NewVer > VersionNum;
 finally
 Free;
 end;
 end;
 end;

 { version functions }
 function GetFileVersion(const FileName: string; var HighVer, LowVer: DWORD): Boolean;
 var
 size, data: DWORD;
 buffer: Pointer;
 FileInfo: PVSFixedFileInfo;
 begin
 Result := False;
 size := GetFileVersionInfoSize(PChar(FileName), data);
 if size = 0 then Exit;
 GetMem(buffer, size + 1);
 try
 GetFileVersionInfo(PChar(FileName), 0, size, buffer);
 if not VerQueryValue(buffer, '\', Pointer(FileInfo), data) then Exit;
 HighVer := FileInfo^.dwFileVersionMS;
 LowVer := FileInfo^.dwFileVersionLS;
 Result := True;
 finally
 FreeMem(buffer);
 end;
 end;

 function GetFileVersionStr(const FileName: string; var Ver: string): Boolean;
 var
 hv, lv: DWORD;
 begin
 Ver := '';
 Result := GetFileVersion(FileName, hv, lv);
 if Result then
 Ver := Format('%d.%d.%d.%d', [HiWord(hv), LoWord(hv), HiWord(lv), LoWord(lv)]);
 end;

 function IsTargetNewer(const FileSource, FileTarget: string): Boolean;
 var
 hs, ls, ht, lt: DWORD;
 {$IFDEF RX_D10}
 FileTargetFileDateTime: TDateTime;
 FileSourceFileDateTime: TDateTime;
 {$ENDIF}
 begin
 Result := False;
 if not FileExists(FileTarget) then Exit;
 if GetFileVersion(FileSource, hs, ls) and GetFileVersion(FileTarget, ht, lt) then
 begin
 if (ht > hs) or ((ht = hs) and (lt > ls)) then Result := True;
 end
 else
 {$IFNDEF RX_D10}if FileDateToDateTime(FileAge(FileTarget)) > FileDateToDateTime(FileAge(FileSource)) then
 Result := True;
 {$ELSE}if FileAge(FileTarget, FileTargetFileDateTime) and FileAge(FileSource, FileSourceFileDateTime) then
 Result := FileTargetFileDateTime > FileSourceFileDateTime;
 {$ENDIF}
 end;

 function IsTargetNewer2(FileSourceDate: TDateTime; const FileSourceVer: string;
 const FileTarget: string): Boolean;
 var
 hs, ls, ht, lt: DWORD;
 CheckDate: Boolean;
 {$IFDEF RX_D10}
 FileTargetFileDateTime: TDateTime;
 {$ENDIF}
 begin
 Result := False;
 if not FileExists(FileTarget) then Exit;
 CheckDate := True;
 if FileSourceVer <> '' then
 begin
 hs := (StrToIntDef(TC4DVersionUtils.ExtractWord(1, FileSourceVer, ['.']), 0) shl 16) +
 StrToIntDef(TC4DVersionUtils.ExtractWord(2, FileSourceVer, ['.']), 0);
 ls := (StrToIntDef(TC4DVersionUtils.ExtractWord(3, FileSourceVer, ['.']), 0) shl 16) +
 StrToIntDef(TC4DVersionUtils.ExtractWord(4, FileSourceVer, ['.']), 0);
 if GetFileVersion(FileTarget, ht, lt) then
 begin
 if (ht > hs) or ((ht = hs) and (lt > ls)) then Result := True;
 CheckDate := False;
 end;
 end;
 if CheckDate then
 {$IFNDEF RX_D10}
 if FileDateToDateTime(FileAge(FileTarget)) > FileSourceDate then
 Result := True;
 {$ELSE}
 if FileAge(FileTarget, FileTargetFileDateTime) then
 Result := FileTargetFileDateTime > FileSourceDate;
 {$ENDIF}
 end;

 function IsSourceNewer(const FileSource, FileTarget: string): Boolean;
 var
 hs, ls, ht, lt: DWORD;
 {$IFDEF RX_D10}
 FileTargetFileDateTime: TDateTime;
 FileSourceFileDateTime: TDateTime;
 {$ENDIF}
 begin
 Result := True;
 if not FileExists(FileTarget) then Exit;
 if GetFileVersion(FileSource, hs, ls) and GetFileVersion(FileTarget, ht, lt) then
 begin
 if (ht > hs) or ((ht = hs) and (lt >= ls)) then Result := False;
 end
 else
 {$IFNDEF RX_D10}if FileDateToDateTime(FileAge(FileTarget)) >= FileDateToDateTime(FileAge(FileSource)) then
 Result := False;
 {$ELSE}if FileAge(FileTarget, FileTargetFileDateTime) and FileAge(FileSource, FileSourceFileDateTime) then
 if FileTargetFileDateTime >= FileSourceFileDateTime then
 Result := False;
 {$ENDIF}
 end;

 function IsSourceNewer2(FileSourceDate: TDateTime; const FileSourceVer: string;
 const FileTarget: string): Boolean;
 var
 hs, ls, ht, lt: DWORD;
 CheckDate: Boolean;
 {$IFDEF RX_D10}
 FileTargetFileDateTime: TDateTime;
 {$ENDIF}
 begin
 Result := True;
 if not FileExists(FileTarget) then Exit;
 CheckDate := True;
 if FileSourceVer <> '' then
 begin
 hs := (StrToIntDef(TC4DVersionUtils.ExtractWord(1, FileSourceVer, ['.']), 0) shl 16) +
 StrToIntDef(TC4DVersionUtils.ExtractWord(2, FileSourceVer, ['.']), 0);
 ls := (StrToIntDef(TC4DVersionUtils.ExtractWord(3, FileSourceVer, ['.']), 0) shl 16) +
 StrToIntDef(TC4DVersionUtils.ExtractWord(4, FileSourceVer, ['.']), 0);
 if GetFileVersion(FileTarget, ht, lt) then
 begin
 if (ht > hs) or ((ht = hs) and (lt >= ls)) then Result := False;
 CheckDate := False;
 end;
 end;
 if CheckDate then
 {$IFNDEF RX_D10}
 if FileDateToDateTime(FileAge(FileTarget)) >= FileSourceDate then
 Result := False;
 {$ELSE}
 if FileAge(FileTarget, FileTargetFileDateTime) then
 if FileTargetFileDateTime >= FileSourceDate then
 Result := False;
 {$ENDIF}
 end;

 function IsEqualVersions(const FileSource, FileTarget: string): Boolean;
 var
 hs, ls, ht, lt: DWORD;
 {$IFDEF RX_D10}
 FileTargetFileDateTime: TDateTime;
 FileSourceFileDateTime: TDateTime;
 {$ENDIF}
 begin
 Result := False;
 if not FileExists(FileTarget) then Exit;
 if GetFileVersion(FileSource, hs, ls) and GetFileVersion(FileTarget, ht, lt) then
 begin
 if (ht = hs) and (lt = ls) then Result := True;
 end
 else
 {$IFNDEF RX_D10}
 if FileDateToDateTime(FileAge(FileTarget)) = FileDateToDateTime(FileAge(FileSource)) then
 Result := True;
 {$ELSE}
 if FileAge(FileTarget, FileTargetFileDateTime) and FileAge(FileSource, FileSourceFileDateTime) then
 if FileTargetFileDateTime = FileSourceFileDateTime then
 Result := True;
 {$ENDIF}
 end;

 function IsEqualVersions2(FileSourceDate: TDateTime; const FileSourceVer: string;
 const FileTarget: string): Boolean;
 var
 hs, ls, ht, lt: DWORD;
 CheckDate: Boolean;
 {$IFDEF RX_D10}
 FileTargetFileDateTime: TDateTime;
 {$ENDIF}
 begin
 Result := False;
 if not FileExists(FileTarget) then Exit;
 CheckDate := True;
 if FileSourceVer <> '' then
 begin
 hs := (StrToIntDef(TC4DVersionUtils.ExtractWord(1, FileSourceVer, ['.']), 0) shl 16) +
 StrToIntDef(TC4DVersionUtils.ExtractWord(2, FileSourceVer, ['.']), 0);
 ls := (StrToIntDef(TC4DVersionUtils.ExtractWord(3, FileSourceVer, ['.']), 0) shl 16) +
 StrToIntDef(TC4DVersionUtils.ExtractWord(4, FileSourceVer, ['.']), 0);
 if GetFileVersion(FileTarget, ht, lt) then
 begin
 if (ht = hs) and (lt = ls) then
 Result := True;
 CheckDate := False;
 end;
 end;
 if CheckDate then
 {$IFNDEF RX_D10}
 if FileDateToDateTime(FileAge(FileTarget)) = FileSourceDate then
 Result := True;
 {$ELSE}
 if FileAge(FileTarget, FileTargetFileDateTime) then
 if FileTargetFileDateTime = FileSourceDate then
 Result := True;
 {$ENDIF}
 end;

 function TC4DVersionInfo.GetVersionLanguage: TVersionLanguage;
 var
 P: Pointer;
 begin
 P := GetTranslation;
 for Result := vlArabic to vlUnknown do
 if LoWord(LongInt(P^)) = LanguageValues[Result] then Break;
 end;

 function TC4DVersionInfo.GetVersionCharSet: TVersionCharSet;
 var
 P: Pointer;
 begin
 P := GetTranslation;
 for Result := vcsASCII to vcsUnknown do
 if HiWord(LongInt(P^)) = CharacterSetValues[Result] then Break;
 end;

 function TC4DVersionInfo.GetTranslation: Pointer;
 var
 {$IFNDEF VER80}
 Len: UINT;
 {$ELSE}
 Len: Cardinal;
 {$ENDIF}
 begin
 Result := nil;
 if FIsValid then
 VerQueryValue(FBuffer, '\VarFileInfo\Translation', Result, Len)
 else
 Result := nil;
 end;

 function TC4DVersionInfo.TranslationString: string;
 var
 P: Pointer;
 begin
 Result := '';
 P := GetTranslation;
 if P <> nil then
 Result := IntToHex(MakeLong(HiWord(LongInt(P^)), LoWord(LongInt(P^))), 8);
 end;

*)

end.
