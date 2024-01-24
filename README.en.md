### Change the language
[![Static Badge](https://img.shields.io/badge/Portugu%C3%AAs-(ptBR)-green)](https://github.com/Code4Delphi/C4D-Version)
[![Static Badge](https://img.shields.io/badge/English-(en)-red)](https://github.com/Code4Delphi/C4D-Version/blob/master/README.en.md)


#  C4D-Version - Control your system version
<p align="center">
  <a href="https://github.com/Code4Delphi/Code4D-Wizard/blob/master/Images/C4D-Logo.png">
    <img alt="Code4Delphi" height="100" src="https://github.com/Code4Delphi/Code4D-Wizard/blob/master/Images/c4d-logo-100x100.png">
  </a> 
</p>
With C4D-Version, you can control the version of your system through the Version Info of the Delphi IDE itself.



## 📞 Contacts

<p align="left">
  <a href="https://t.me/Code4Delphi" target="_blank">
    <img src="https://img.shields.io/badge/Telegram:-Join%20Channel-blue?logo=telegram">
  </a>   
   &nbsp;
  <a href="https://www.youtube.com/@code4delphi" target="_blank">
    <img src="https://img.shields.io/badge/YouTube:-Join%20Channel-red?logo=youtube&logoColor=red">
  </a> 
   &nbsp;
  <a href="https://www.linkedin.com/in/cesar-cardoso-dev" target="_blank">
    <img src="https://img.shields.io/badge/LinkedIn:-Follow-blue?logo=LinkedIn&logoColor=blue">
  </a> 
  &nbsp;
  <a href="mailto:contato@code4delphi.com.br" target="_blank">
    <img src="https://img.shields.io/badge/E--mail-contato%40code4delphi.com.br-yellowgreen?logo=maildotru&logoColor=yellowgreen">
  </a>
</p>

<br/>

> [!IMPORTANT]
> ### ⭐ Don't forget to leave your star to help propagate the directory.



## ⚙️ Installation

* Installation using [**Boss**](https://github.com/HashLoad/boss):

```
boss install github.com/Code4Delphi/C4D-Version
```

* **Manual installation**: Open your Delphi and add the following folder to your project, in *Project > Options > Resource Compiler > Directories and Conditionals > Include file search path*

```
..\C4D-Version\Src
```



## 🚀 Quickstart
* Add your system version data by going to *Project > Options... (ou Shift+Ctrl+F11) > Application > Version Info*

![Tela-Version-Info-Delphi.png](https://github.com/Code4Delphi/C4D-Version/blob/master/Img/Readme/Tela-Version-Info-Delphi.png)

* Add uses to your system:
```
uses
  C4D.Version;
```

## 📝 Complete version data
* Adding data from the **current system version** in a TMemo:
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
* Here's what the return would look like:
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


## 🆚 Semantic versioning
* Adding only the system's **Semantic versioning** data to a TMemo:
```
begin
   Memo1.Lines.Clear;
   Memo1.Lines.Add('Major: ' + TC4DVersion.SemanticVersion.Major.ToString);
   Memo1.Lines.Add('Minor: ' + TC4DVersion.SemanticVersion.Minor.ToString);
   Memo1.Lines.Add('Patch: ' + TC4DVersion.SemanticVersion.Patch.ToString);
   Memo1.Lines.Add('PreRelease:  ' + TC4DVersion.SemanticVersion.PreRelease);
   Memo1.Lines.Add('Semantic versioning complete: ' + TC4DVersion.SemanticVersion.GetString);
end;
```
* Here's what the return would look like:
```
Major: 1
Minor: 0
Patch: 0
PreRelease:      
SemanticVersion: 1.0.0
```


## 🖥 Accessing data from other .exe
* It is also possible to access data from other .exes, just pass the .exe path as a parameter when calling the method: TC4DVersion.Info(). Here's how we would recover data from the Windows calculator .exe:
``` 
var
  LVersao: IC4DVersionInfo;
begin
  LVersao := TC4DVersion.Info('C:\Windows\System32\calc.exe');
```

## ⌨️ Demo
* Next to the project sources, you will find a test project, in the folder:
```
..\C4D-Version\Samples\Demo01
```
![Tela-Demo.png](https://github.com/Code4Delphi/C4D-Version/blob/master/Img/Readme/Tela-Demo.png)



## ✅ Advantages of using Delphi's Version Info:
* The version data is inserted in the .exe, so when you rest the mouse over our .exe files, the version data and product information are displayed:

![Dados-da-versao-no-Hint-do-executavel.png](https://github.com/Code4Delphi/C4D-Version/blob/master/Img/Readme/Dados-da-versao-no-Hint-do-executavel.png)


* If we access the .exe properties, we will see that the version data and product information will also be displayed in the Details tab:

![Propriedades-do-executavel.png](https://github.com/Code4Delphi/C4D-Version/blob/master/Img/Readme/Propriedades-do-executavel.png)



> [!TIP]
> You can use C4D-Version to create an updater, this updater would access the .exe version of your system, and based on the data, make the necessary updates.


[Back to top](#change-the-language)
