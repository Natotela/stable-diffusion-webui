$backto = $PWD.Path
$custNodes = "F:\Progz\stable-diffusion-webui\extensions\"
$subfolders = Get-ChildItem -Path $custNodes -Directory
cd $custNodes
ForEach ($subfolder in $subfolders) { cd $subfolder ; git pull; cd.. }
cd $backto