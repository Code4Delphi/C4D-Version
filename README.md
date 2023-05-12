#  C4D-Version - Controle a versão do seu sistema
<p align="center">
  <a href="https://github.com/Code4Delphi/Code4D-Wizard/blob/master/Img/C4D-Logo.png">
    <img alt="Horse" height="100" src="https://github.com/Code4Delphi/Code4D-Wizard/blob/master/Img/c4d-logo-100x100.png">
  </a>  
</p>
Com o C4D-Version, você pode fazer o controle da versão do seu sistema através do Version Info da própria IDE do Delphi. 



## 📞 Contacts

<p align="left">
  <a href="https://t.me/Code4DelphiDevs" target="_blank">
    <img src="https://img.shields.io/badge/Telegram:-Join%20Channel-blue?logo=telegram">
  </a> 
  &nbsp;
  <a href="mailto:contato@code4delphi.com.br" target="_blank">
    <img src="https://img.shields.io/badge/E--mail-contato%40code4delphi.com.br-yellowgreen?logo=maildotru&logoColor=yellowgreen">
  </a>
   &nbsp;
  <a href="https://go.hotmart.com/U81331747Y?dp=1" target="_blank">
    <img src="https://img.shields.io/badge/Course:-Open%20Tools%20API-F00?logo=delphi">
  </a> 
   &nbsp;
  <a href="https://www.youtube.com/@code4delphi" target="_blank">
    <img src="https://img.shields.io/badge/YouTube:-Join%20Channel-red?logo=youtube&logoColor=red">
  </a> 
</p>



## ⚙️ Instalação

* Instalação usando o [**Boss**](https://github.com/HashLoad/boss):

```
boss install github.com/Code4Delphi/C4D-Version
```

* **Instalação manual**: Abra seu Delphi e adicione a seguinte pasta ao seu projeto, em *Project > Options > Resource Compiler > Directories and Conditionals > Include file search path*

```
..\C4D-Version\Src
```



## 🚀 Como usar
* Adcione os dados da versão do seu sistema, acessando *Project > Options... (ou Shift+Ctrl+F11) > Application > Version Info*

![Tela-Version-Info-Delphi.png](https://github.com/Code4Delphi/C4D-Version/blob/master/Img/Readme/Tela-Version-Info-Delphi.png)

* Adicione a uses a seu sistema:
```
uses
  C4D.Version;
```

* Adicionando os dados da **versão do sistema** em um TMemo:
```
var
 LVersao: IC4DVersionInfo;
begin
   LVersao := TC4DVersion.Info;
   Memo1.Lines.Clear;
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
end;
```
Veja como ficaria o retorno:
```
GetFileName:           C:\Componentes-Delphi\Code4D\C4D-Version\Samples\Demo01\Win32\Debug\C4DVersionDemo01.exe
FileDescription:       Code4Delphi Controle de Versão
VersionShort:          1.0.0
VersionLong:           1.0.0.0
VersionMajor:          1
VersionMinor:          0
VersionPatch:          0
PreRelease:            False
VersionPreRelease:     
VersionNum:            65536
ProductName:           Code4Delphi VersionInfo
VersionProductShort:   1.0.0
VersionProductLong:    1.0.0.0
Comments:              contato@code4delphi.com.br
CompanyName:           Code4Delphi - Cursos e conteúdos de Programação Delphi
InternalName:          Internal Name Code4Delphi
LegalCopyright:        Copyright Code4Delphi
LegalTrademarks:       https://github.com/Code4Delphi
OriginalFilename:      C4DVersionDemo01
TranslationString:     041604E4
VerFileDate:           11/05/2023 22:47:48
SpecialBuild:          
PrivateBuild:          
DebugBuild:            False
Patched:               False
InfoInferred:          False
```

* Adicionando apenas os dados do **Semantic Version** do sistema em um TMemo:
```
begin
   Memo1.Lines.Clear;
   Memo1.Lines.Add('Major:           ' + TC4DVersion.SemanticVersion.Major.ToString);
   Memo1.Lines.Add('Minor:           ' + TC4DVersion.SemanticVersion.Minor.ToString);
   Memo1.Lines.Add('Patch:           ' + TC4DVersion.SemanticVersion.Patch.ToString);
   Memo1.Lines.Add('PreRelease:      ' + TC4DVersion.SemanticVersion.PreRelease);
   Memo1.Lines.Add('SemanticVersion: ' + TC4DVersion.SemanticVersion.GetString);
end;
```
Veja como ficaria o retorno:
```
Major:           1
Minor:           0
Patch:           0
PreRelease:      
SemanticVersion: 1.0.0
```


* Também é possível, acessar os dados de outros .exe, para isso basta passar o caminho do .exe como parâmetro ao char o método: TC4DVersion.Info(). Veja como fariamos para recuperar os dados do .exe do próprio Delphi:
``` 
var
 LVersao: IC4DVersionInfo;
begin
   LVersao := TC4DVersion.Info('C:\Program Files (x86)\Embarcadero\Studio\20.0\bin\bds.exe');
```

## ⌨️ Demo
* Junto aos fontes do projeto, você encontrara um projeto teste, na pasta:
```
..\C4D-Version\Samples\Demo01
```
![Tela-Demo.png](https://github.com/Code4Delphi/C4D-Version/blob/master/Img/Readme/Tela-Demo.png)



## ⭐ Vantagens em se utilizar o Version Info do Delphi
* Os dados da versão são inseridos no .exe, como isso ao repousar o mouse sobre nosso arquivos .exe, os dados da versão e informações do produto são exibidos:

![Dados-da-versao-no-Hint-do-executavel.png](https://github.com/Code4Delphi/C4D-Version/blob/master/Img/Readme/Dados-da-versao-no-Hint-do-executavel.png)


* Se acessarmos as propriedades do .exe, veremos que os dados da versão, e as informações do produto, também seram exibidos na aba Detalhes:

![Propriedades-do-executavel.png](https://github.com/Code4Delphi/C4D-Version/blob/master/Img/Readme/Propriedades-do-executavel.png)
