[Setup]
AppId={{D1A39D4B-A6EE-4CE8-831C-2F72D85196A5}
AppName=QualiVerse
AppVersion=1.0.0
AppPublisher=QualiVerse
DefaultDirName={autopf}\QualiVerse
DefaultGroupName=QualiVerse
DisableProgramGroupPage=yes
OutputBaseFilename=qualiverse_setup
Compression=lzma
SolidCompression=yes
ArchitecturesInstallIn64BitMode=x64
SetupIconFile=resources\app_icon.ico

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "..\..\build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\QualiVerse"; Filename: "{app}\qualiverse.exe"
Name: "{autodesktop}\QualiVerse"; Filename: "{app}\qualiverse.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\qualiverse.exe"; Description: "{cm:LaunchProgram,QualiVerse}"; Flags: nowait postinstall