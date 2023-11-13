unit C4D.Version.SemanticVersion;

interface

uses
  System.SysUtils,
  C4D.Version.Interfaces,
  C4D.Version.Info;

type
  TC4DVersionSemanticVersion = class
  private
    class var
      FInstance: TC4DVersionSemanticVersion;
  var
    FMajor: Integer;
    FMinor: Integer;
    FPatch: Integer;
    FPreRelease: string;
  public
    constructor Create;
    class function GetInstance: TC4DVersionSemanticVersion;
    class destructor UnInitialize;
    function GetString: string;
    property Major: Integer read FMajor;
    property Minor: Integer read FMinor;
    property Patch: Integer read FPatch;
    property PreRelease: string read FPreRelease;
  end;

implementation

class function TC4DVersionSemanticVersion.GetInstance: TC4DVersionSemanticVersion;
begin
  if(not Assigned(FInstance))then
    FInstance := Self.Create;
  Result := FInstance;
end;

constructor TC4DVersionSemanticVersion.Create;
var
  LC4DVersionInfo: IC4DVersionInfo;
begin
  LC4DVersionInfo := TC4DVersionInfo.New;
  FMajor := LC4DVersionInfo.VersionMajor;
  FMinor := LC4DVersionInfo.VersionMinor;
  FPatch := LC4DVersionInfo.VersionPatch;
  FPreRelease := LC4DVersionInfo.VersionPreRelease;
end;

function TC4DVersionSemanticVersion.GetString: string;
begin
  Result := FMajor.ToString + '.' + FMinor.ToString + '.' + FPatch.ToString + FPreRelease;
end;

class destructor TC4DVersionSemanticVersion.UnInitialize;
begin
  if(Assigned(FInstance))then
    FreeAndNil(FInstance);
end;

end.
