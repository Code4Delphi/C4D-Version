unit Utils;

interface

uses
  System.SysUtils,
  Vcl.Dialogs;

type
  TUtils = class
  private
  public
    class function SelectFile(const ADefaultFile: string; const ADefaultExt: string = 'exe'): string;
  end;

implementation


class function TUtils.SelectFile(const ADefaultFile: string; const ADefaultExt: string = 'exe'): string;
var
  LOpenDialog: TOpenDialog;
  LFolder: string;
begin
  LOpenDialog := TOpenDialog.Create(nil);
  try
    LOpenDialog.Title := 'C4D - Select a file';
    if(not ADefaultFile.Trim.IsEmpty)then
    begin
      LFolder := ExtractFilePath(ADefaultFile);
      if(System.SysUtils.DirectoryExists(LFolder))then
        LOpenDialog.InitialDir := LFolder;

      if(System.SysUtils.FileExists(ADefaultFile))then
        LOpenDialog.FileName := ExtractFileName(ADefaultFile);
    end;

    if(not ADefaultExt.Trim.IsEmpty)then
    begin
      LOpenDialog.DefaultExt := ADefaultExt;
      LOpenDialog.Filter := Format('Arquivo %s|*.%s', [ADefaultExt.ToUpper, ADefaultExt]);
    end;

    if(not LOpenDialog.Execute)then
      Exit(ADefaultFile);

    Result := LOpenDialog.FileName;
  finally
    LOpenDialog.Free;
  end;
end;

end.
