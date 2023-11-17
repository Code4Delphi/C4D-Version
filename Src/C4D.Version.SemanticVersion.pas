unit C4D.Version.SemanticVersion;

interface

uses
  System.SysUtils,
  C4D.Version.Interfaces,
  C4D.Version.Info;

type
  TC4DVersionSemanticVersion = class
  private
    FMajor: Integer;
    FMinor: Integer;
    FPatch: Integer;
    FPreRelease: string;
    constructor Create;
  public
    class function GetInstance: TC4DVersionSemanticVersion;
    function GetString: string;
    property Major: Integer read FMajor;
    property Minor: Integer read FMinor;
    property Patch: Integer read FPatch;
    property PreRelease: string read FPreRelease;
  end;

implementation

var
  Instance: TC4DVersionSemanticVersion;

class function TC4DVersionSemanticVersion.GetInstance: TC4DVersionSemanticVersion;
begin
  if(not Assigned(Instance))then
    Instance := Self.Create;
  Result := Instance;
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

initialization

finalization
  if(Assigned(Instance))then
    FreeAndNil(Instance);

end.
