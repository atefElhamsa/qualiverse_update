[Setup]
AppId={{A3F4420A-8A47-4E7F-99E6-D0E9E6D8A613}
AppName=QualiVerse
AppVersion=1.0.71
DefaultDirName={autopf}\QualiVerse
DefaultGroupName=QualiVerse
OutputDir=Output
OutputBaseFilename=qualiverse_setup
Compression=lzma
SolidCompression=yes
PrivilegesRequired=admin

[Files]
Source: "build\windows\x64\runner\Release\qualiverse.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\QualiVerse"; Filename: "{app}\qualiverse.exe"
Name: "{autodesktop}\QualiVerse"; Filename: "{app}\qualiverse.exe"; Tasks: desktopicon

[Tasks]
Name: "desktopicon"; Description: "Create a &desktop icon"; GroupDescription: "Additional icons:"; Flags: unchecked

[Run]
Filename: "{app}\qualiverse.exe"; Description: "Launch QualiVerse"; Flags: nowait postinstall skipifsilent
