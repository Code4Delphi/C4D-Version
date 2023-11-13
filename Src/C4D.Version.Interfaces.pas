unit C4D.Version.Interfaces;

interface

USES
  Winapi.Windows;

type
  IC4DVersionInfo = interface
    ['{063CB77C-1AD6-494E-9ACF-D102CB447167}']
    function GetFileName: string;
    procedure SetFileName(const Value: string);
    function FileDescription: string;
    function VersionShort: string;
    function VersionLong: string;
    function VersionMajor: Integer;
    function VersionMinor: Integer;
    function VersionPatch: Integer;
    function PreRelease: Boolean;
    function VersionPreRelease: string;
    function VersionNum: LongInt;
    function ProductName: string;
    function VersionProductShort: string;
    function VersionProductLong: string;
    function Comments: string;
    function CompanyName: string;
    function InternalName: string;
    function LegalCopyright: string;
    function LegalTrademarks: string;
    function OriginalFilename: string;
    function VerFileDate: TDateTime;
    function TranslationString: string;
    function IsValid: Boolean;
    function SpecialBuild: string;
    function PrivateBuild: string;
    function DebugBuild: Boolean;
    function Patched: Boolean;
    function InfoInferred: Boolean;
    function Value(AName: string): string;
  end;

implementation

end.
