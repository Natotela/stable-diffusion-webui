$backto = $PWD.Path
$custNodes = "F:\Progz\stable-diffusion-webui\extensions\"
$subfolders = Get-ChildItem -Path $custNodes -Directory
cd $custNodes
ForEach ($subfolder in $subfolders) { Write-Host $subfolder.FullName ; cd $subfolder ; git pull; cd.. }
# ForEach ($subfolder in $subfolders) { Write-Host $subfolder.FullName ; cd $subfolder ; git add -A ; git commit -m "%%DATE%% %%TIME%% lamalo" ; git pull; cd.. }
cd $backto