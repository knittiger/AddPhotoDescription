#AddPhotoDescription

Add-Type -AssemblyName System.Drawing

$TEXTOFFSET_X = 100
$TEXTOFFSET_Y = 120
$FontType = "���C���I"
$FontSize = 21
$FontAlpha = 192

$SrcPath = $PSScriptRoot + ".\src"
$DstPath = $PSScriptRoot + ".\dst"



function AddDescription($srcfile)
{

	#�t�@�C�����̎擾
	$shell = New-Object -ComObject Shell.Application
	$folder = $shell.Namespace($SrcPath)
	$file = $folder.parseName($srcfile)

	$date = $folder.GetDetailsOf($File, 12)
	$model = $folder.GetDetailsOf($File, 30)
	$vender = $folder.GetDetailsOf($File, 32)

	$width = $folder.GetDetailsOf($File, 177)
	$height = $folder.GetDetailsOf($File, 179)
	$ss = $folder.GetDetailsOf($File, 260)

	$iso = $folder.GetDetailsOf($File, 265)
	$focuslength = $folder.GetDetailsOf($File, 263)
	$fvalue = $folder.GetDetailsOf($File, 261)

	#������␳(�s�v�����̍폜)
	$tmp = $width.split(" ")
	$width = $tmp[0].remove(0,1)
	$tmp = $height.split(" ")
	$height = $tmp[0].remove(0,1)
	$tmp = $ss.split(" ")
	$SS = $tmp[0]

	#�摜�t�@�C������Image�I�u�W�F�N�g����
	$filepath = $SrcPath + "\" + $srcfile
	$bmp = New-Object System.Drawing.Bitmap($filepath)
	 
	#Graphics�I�u�W�F�N�g����
	$graphic = [System.Drawing.Graphics]::FromImage($bmp)
	 
	#�����`�ʃu���V����
	$brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb($FontAlpha, [System.Drawing.Color]::White))
	$font = New-Object System.Drawing.Font($FontType, $FontSize)

	#�`��e�L�X�g�쐬&�`��
	$str = $str  +" "+ $date +" "+ $time
	$str = $str  +" "+ $eventname + " " + $place
	$str = $str  +" "+ $vender +" "+ $model
	$str = $str  +" "+ $ss +" "+ $iso +" "+ $focuslength  +" "+ $fvalue

	$graphic.DrawString($str, $font, $brush, $TEXTOFFSET_X, [int]$height-$TEXTOFFSET_Y)
	 
	#���ʊi�[
	$DstFile = $DstPath +"\"+ $srcfile
	$bmp.Save($DstFile)

	#�I������
	$font.Dispose()
	$brush.Dispose()
	$graphic.Dispose()
	$bmp.Dispose()
}

#���[�U���͎�t
#�C�x���g���́E�J�Ïꏊ�̓t�@�C������擾�ł��Ȃ��̂����Ŏ擾

$eventname = Read-Host "�C�x���g���̂���͂��Ă�������"
$place = Read-Host "�J�Ïꏊ����͂��Ă�������"

#�o�̓t�H���_�쐬
New-Item $DstPath -type directory

#src�t�H���_���̑S�摜�ɑ΂��ď��������s
$SrcList = Get-ChildItem($SrcPath)
foreach($item in $SrcList){
	Write-Host $item.Name
	AddDescription($item.Name)
}
