object C4DVersionInfoDemo01ViewMain: TC4DVersionInfoDemo01ViewMain
  Left = 0
  Top = 0
  Caption = 'Code4Delphi - VersionInfo - Demo'
  ClientHeight = 642
  ClientWidth = 964
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 249
    Width = 964
    Height = 393
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 215
    Width = 964
    Height = 34
    Align = alTop
    BevelOuter = bvLowered
    Padding.Left = 2
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 2
    TabOrder = 1
    object btnLimparLog: TButton
      Left = 3
      Top = 3
      Width = 118
      Height = 28
      Cursor = crHandPoint
      Align = alLeft
      Caption = 'Limpar log'
      TabOrder = 0
      OnClick = btnLimparLogClick
    end
    object ckLogLimparACadaBusca: TCheckBox
      Left = 126
      Top = 9
      Width = 123
      Height = 17
      Cursor = crHandPoint
      Caption = 'Limpar a cada busca'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 83
    Width = 964
    Height = 80
    Align = alTop
    Caption = ' Usando a interface IC4DVersionInfo'
    TabOrder = 2
    object Label1: TLabel
      Left = 18
      Top = 29
      Width = 43
      Height = 13
      Caption = 'Path exe'
    end
    object edtPathExe01: TEdit
      Left = 19
      Top = 43
      Width = 531
      Height = 21
      TabOrder = 0
      Text = 'C:\Program Files (x86)\Embarcadero\Studio\20.0\bin\bds.exe'
    end
    object btnVersaoSistemaAtual: TButton
      Left = 581
      Top = 13
      Width = 220
      Height = 25
      Cursor = crHandPoint
      Caption = 'C4D.VersionInfo - Sistema Atual'
      TabOrder = 1
      OnClick = btnVersaoSistemaAtualClick
    end
    object btnVersaoSistemaDoEdit01: TButton
      Left = 581
      Top = 41
      Width = 220
      Height = 25
      Cursor = crHandPoint
      Caption = 'C4D.VersionInfo - Sistema do edit'
      TabOrder = 2
      OnClick = btnVersaoSistemaDoEdit01Click
    end
    object btnBuscarExe: TButton
      Left = 552
      Top = 41
      Width = 26
      Height = 25
      Cursor = crHandPoint
      Hint = 'Buscar .exe'
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnBuscarExeClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 163
    Width = 964
    Height = 52
    Align = alTop
    Caption = ' SemanticVersion '
    TabOrder = 3
    object btnSemanticVersion: TButton
      Left = 3
      Top = 19
      Width = 430
      Height = 25
      Cursor = crHandPoint
      Caption = 
        'Pegar somente SemanticVersion (Sempre do .exe onde estiver sendo' +
        ' usado)'
      TabOrder = 0
      OnClick = btnSemanticVersionClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 0
    Width = 964
    Height = 83
    Align = alTop
    Caption = ' Como usar '
    Padding.Left = 3
    Padding.Right = 3
    Padding.Bottom = 3
    TabOrder = 4
    object Memo2: TMemo
      Left = 5
      Top = 15
      Width = 954
      Height = 63
      Align = alClient
      BorderStyle = bsNone
      Lines.Strings = (
        
          'Para utiliza, basta configurar a vers'#227'o so seu projeto diretamen' +
          'te pela IDE do Delphi em:  Project > Options... (ou Shift+Ctrl+F' +
          '11)'
        'Na tela que abrir acessar: Application > Version Info'
        ''
        
          'Basta preencher os dados da vers'#227'o na tela que sera aberta, e ut' +
          'ilizar esse framework para pegar as informa'#231#245'es.'
        ' ')
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
end
