unit C4D.Version;

interface

uses
  System.SysUtils,
  C4D.Version.Interfaces,
  C4D.Version.Info,
  C4D.Version.SemanticVersion;

type
  IC4DVersionInfo = C4D.Version.Interfaces.IC4DVersionInfo;

  TC4DVersion = class
  public
    class function Info: IC4DVersionInfo; overload;
    class function Info(const AFileName: String): IC4DVersionInfo; overload;
    class function SemanticVersion: TC4DVersionSemanticVersion;
  end;

implementation

class function TC4DVersion.Info: IC4DVersionInfo;
begin
   Result := TC4DVersionInfo.New;
end;

class function TC4DVersion.Info(const AFileName: String): IC4DVersionInfo;
begin
   if(not AFileName.Trim.IsEmpty)and(not FileExists(AFileName))then
     raise Exception.Create('Informed file not found');
   Result := TC4DVersionInfo.New(AFileName);
end;

class function TC4DVersion.SemanticVersion: TC4DVersionSemanticVersion;
begin
   Result := TC4DVersionSemanticVersion.GetInstance;
end;

end.

