program C4DVersionDemo01;

uses
  Vcl.Forms,
  C4D.VersionDemo01.View.Main in 'Src\View\C4D.VersionDemo01.View.Main.pas' {C4DVersionInfoDemo01ViewMain};

{$R *.res}


begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'C4D VersionInfo Title';
  Application.Hint := 'C4D VersionInfo Hint';
  Application.CreateForm(TC4DVersionInfoDemo01ViewMain, C4DVersionInfoDemo01ViewMain);
  Application.Run;

end.
