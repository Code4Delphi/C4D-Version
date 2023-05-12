unit C4D.Version.Consts;

interface

uses
 C4D.Version.Types;

const
  LanguageValues: array[TVersionLanguage] of Word = ($0401, $0402, $0403,
    $0404, $0405, $0406, $0407, $0408, $0409, $040A, $040B, $040C, $040D,
    $040E, $040F, $0410, $0411, $0412, $0413, $0414, $0415, $0416, $0417,
    $0418, $0419, $041A, $041B, $041C, $041D, $041E, $041F, $0420, $0421,
    $0804, $0807, $0809, $080A, $080C, $0810, $0813, $0814, $0816, $081A,
    $0C0C, $100C, $0000);

const
  CharacterSetValues: array[TVersionCharSet] of Integer = (0, 932, 949, 950,
    1200, 1250, 1251, 1252, 1253, 1254, 1255, 1256, -1);

implementation

end.

