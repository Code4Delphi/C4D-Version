unit C4D.Version.Types;

interface

type
  TVersionLanguage = (vlArabic, vlBulgarian, vlCatalan, vlTraditionalChinese,
    vlCzech, vlDanish, vlGerman, vlGreek, vlUSEnglish, vlCastilianSpanish,
    vlFinnish, vlFrench, vlHebrew, vlHungarian, vlIcelandic, vlItalian,
    vlJapanese, vlKorean, vlDutch, vlNorwegianBokmel, vlPolish,
    vlBrazilianPortuguese, vlRhaetoRomanic, vlRomanian, vlRussian,
    vlCroatoSerbian, vlSlovak, vlAlbanian, vlSwedish, vlThai, vlTurkish,
    vlUrdu, vlBahasa, vlSimplifiedChinese, vlSwissGerman, vlUKEnglish,
    vlMexicanSpanish, vlBelgianFrench, vlSwissItalian, vlBelgianDutch,
    vlNorwegianNynorsk, vlPortuguese, vlSerboCroatian, vlCanadianFrench,
    vlSwissFrench, vlUnknown);

  TVersionCharSet = (vcsASCII, vcsJapan, vcsKorea, vcsTaiwan, vcsUnicode,
    vcsEasternEuropean, vcsCyrillic, vcsMultilingual, vcsGreek, vcsTurkish,
    vcsHebrew, vcsArabic, vcsUnknown);

  {$IFDEF VER80}
  PVSFixedFileInfo = Pvs_FixedFileInfo;
  DWORD = LongInt;
  {$ENDIF}

  TRecordVersion = record
    case Integer of
      0: (All: array[1..4] of Word);
      1: (MS, LS: LongInt);
  end;

implementation

end.
