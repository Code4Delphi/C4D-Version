unit C4D.VersionDemo01.View.Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TC4DVersionInfoDemo01ViewMain = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    btnLimparLog: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edtPathExe01: TEdit;
    btnVersaoSistemaAtual: TButton;
    btnVersaoSistemaDoEdit01: TButton;
    GroupBox2: TGroupBox;
    btnSemanticVersion: TButton;
    btnBuscarExe: TButton;
    ckLogLimparACadaBusca: TCheckBox;
    GroupBox3: TGroupBox;
    Memo2: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure btnLimparLogClick(Sender: TObject);
    procedure btnVersaoSistemaDoEdit01Click(Sender: TObject);
    procedure btnVersaoSistemaAtualClick(Sender: TObject);
    procedure btnSemanticVersionClick(Sender: TObject);
    procedure btnBuscarExeClick(Sender: TObject);
  private
    procedure GetDadosVersaoSistema(const AFileName: string = '');
    function SelectFile(const ADefaultFile: string; const ADefaultExt: string = 'exe'): string;
  public
  end;

var
  C4DVersionInfoDemo01ViewMain: TC4DVersionInfoDemo01ViewMain;

implementation

uses
  C4D.Version;

{$R *.dfm}

procedure TC4DVersionInfoDemo01ViewMain.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
end;

procedure TC4DVersionInfoDemo01ViewMain.btnBuscarExeClick(Sender: TObject);
begin
  edtPathExe01.Text := Self.SelectFile(edtPathExe01.Text);
end;

function TC4DVersionInfoDemo01ViewMain.SelectFile(const ADefaultFile: string; const ADefaultExt: string = 'exe'): string;
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

procedure TC4DVersionInfoDemo01ViewMain.btnLimparLogClick(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

procedure TC4DVersionInfoDemo01ViewMain.btnVersaoSistemaAtualClick(Sender: TObject);
begin
  Self.GetDadosVersaoSistema;
end;

procedure TC4DVersionInfoDemo01ViewMain.btnVersaoSistemaDoEdit01Click(Sender: TObject);
begin
  if(Trim(edtPathExe01.Text).IsEmpty)then
  begin
    edtPathExe01.SetFocus;
    raise Exception.Create('Informe o caminho do .exe desejado');
  end;

  Self.GetDadosVersaoSistema(edtPathExe01.Text);
end;

procedure TC4DVersionInfoDemo01ViewMain.GetDadosVersaoSistema(const AFileName: string = '');
var
  LVersao: IC4DVersionInfo;
begin
  if(ckLogLimparACadaBusca.Checked)then
    btnLimparLog.Click;

  LVersao := TC4DVersion.Info(AFileName);
  Memo1.Lines.Add('GetFileName:           ' + LVersao.GetFileName);
  Memo1.Lines.Add('FileDescription:       ' + LVersao.FileDescription);
  Memo1.Lines.Add('VersionShort:          ' + LVersao.VersionShort);
  Memo1.Lines.Add('VersionLong:           ' + LVersao.VersionLong);
  Memo1.Lines.Add('VersionMajor:          ' + LVersao.VersionMajor.ToString);
  Memo1.Lines.Add('VersionMinor:          ' + LVersao.VersionMinor.ToString);
  Memo1.Lines.Add('VersionPatch:          ' + LVersao.VersionPatch.ToString);
  Memo1.Lines.Add('PreRelease:            ' + BoolToStr(LVersao.PreRelease, True));
  Memo1.Lines.Add('VersionPreRelease:     ' + LVersao.VersionPreRelease);
  Memo1.Lines.Add('VersionNum:            ' + LVersao.VersionNum.ToString);
  Memo1.Lines.Add('ProductName:           ' + LVersao.ProductName);
  Memo1.Lines.Add('VersionProductShort:   ' + LVersao.VersionProductShort);
  Memo1.Lines.Add('VersionProductLong:    ' + LVersao.VersionProductLong);
  Memo1.Lines.Add('Comments:              ' + LVersao.Comments);
  Memo1.Lines.Add('CompanyName:           ' + LVersao.CompanyName);
  Memo1.Lines.Add('InternalName:          ' + LVersao.InternalName);
  Memo1.Lines.Add('LegalCopyright:        ' + LVersao.LegalCopyright);
  Memo1.Lines.Add('LegalTrademarks:       ' + LVersao.LegalTrademarks);
  Memo1.Lines.Add('OriginalFilename:      ' + LVersao.OriginalFilename);
  Memo1.Lines.Add('TranslationString:     ' + LVersao.TranslationString);
  Memo1.Lines.Add('VerFileDate:           ' + DateTimeToStr(LVersao.VerFileDate));
  Memo1.Lines.Add('SpecialBuild:          ' + LVersao.SpecialBuild);
  Memo1.Lines.Add('PrivateBuild:          ' + LVersao.PrivateBuild);
  Memo1.Lines.Add('DebugBuild:            ' + BoolToStr(LVersao.DebugBuild, True));
  Memo1.Lines.Add('Patched:               ' + BoolToStr(LVersao.Patched, True));
  Memo1.Lines.Add('InfoInferred:          ' + BoolToStr(LVersao.InfoInferred, True));
  Memo1.Lines.Add(StringOfChar('-', 150));
end;

procedure TC4DVersionInfoDemo01ViewMain.btnSemanticVersionClick(Sender: TObject);
begin
  if(ckLogLimparACadaBusca.Checked)then
    btnLimparLog.Click;

  Memo1.Lines.Add('Major:           ' + TC4DVersion.SemanticVersion.Major.ToString);
  Memo1.Lines.Add('Minor:           ' + TC4DVersion.SemanticVersion.Minor.ToString);
  Memo1.Lines.Add('Patch:           ' + TC4DVersion.SemanticVersion.Patch.ToString);
  Memo1.Lines.Add('PreRelease:      ' + TC4DVersion.SemanticVersion.PreRelease);
  Memo1.Lines.Add('SemanticVersion: ' + TC4DVersion.SemanticVersion.GetString);
  Memo1.Lines.Add(StringOfChar('-', 150));
end;

end.
