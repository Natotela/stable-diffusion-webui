$backto = $PWD.Path
$custNodes = "F:\Progz\stable-diffusion-webui\extensions\"
$subfolders = Get-ChildItem -Path $custNodes -Directory
cd $custNodes
ForEach ($subfolder in $subfolders) { Write-Host $subfolder.FullName ; cd $subfolder ; git pull; F:\Progz\ComfyUI_windows_portable\python_embeded\python.exe -m pip install -r requirements.txt; cd.. }
# ForEach ($subfolder in $subfolders) { Write-Host $subfolder.FullName ; cd $subfolder ; git add -A ; git commit -m "%%DATE%% %%TIME%% lamalo" ; git pull; cd.. }
cd $backto