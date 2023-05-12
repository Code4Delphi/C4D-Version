unit C4D.Version.Interfaces;

interface

USES
  Winapi.Windows;

type
  IC4DVersionInfo = interface
    ['{063CB77C-1AD6-494E-9ACF-D102CB447167}']
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
  end;

implementation

end.


