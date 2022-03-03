#AddPhotoDescription

Add-Type -AssemblyName System.Drawing

$TEXTOFFSET_X = 100
$TEXTOFFSET_Y = 120
$FontType = "メイリオ"
$FontSize = 21
$FontAlpha = 192

$SrcPath = $PSScriptRoot + ".\src"
$DstPath = $PSScriptRoot + ".\dst"



function AddDescription($srcfile)
{

	#ファイル情報の取得
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

	#文字列補正(不要部分の削除)
	$tmp = $width.split(" ")
	$width = $tmp[0].remove(0,1)
	$tmp = $height.split(" ")
	$height = $tmp[0].remove(0,1)
	$tmp = $ss.split(" ")
	$SS = $tmp[0]

	#画像ファイルからImageオブジェクト生成
	$filepath = $SrcPath + "\" + $srcfile
	$bmp = New-Object System.Drawing.Bitmap($filepath)
	 
	#Graphicsオブジェクト生成
	$graphic = [System.Drawing.Graphics]::FromImage($bmp)
	 
	#文字描写ブラシ生成
	$brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb($FontAlpha, [System.Drawing.Color]::White))
	$font = New-Object System.Drawing.Font($FontType, $FontSize)

	#描画テキスト作成&描画
	$str = $str  +" "+ $date +" "+ $time
	$str = $str  +" "+ $eventname + " " + $place
	$str = $str  +" "+ $vender +" "+ $model
	$str = $str  +" "+ $ss +" "+ $iso +" "+ $focuslength  +" "+ $fvalue

	$graphic.DrawString($str, $font, $brush, $TEXTOFFSET_X, [int]$height-$TEXTOFFSET_Y)
	 
	#結果格納
	$DstFile = $DstPath +"\"+ $srcfile
	$bmp.Save($DstFile)

	#終了処理
	$font.Dispose()
	$brush.Dispose()
	$graphic.Dispose()
	$bmp.Dispose()
}

#ユーザ入力受付
#イベント名称・開催場所はファイルから取得できないのここで取得

$eventname = Read-Host "イベント名称を入力してください"
$place = Read-Host "開催場所を入力してください"

#出力フォルダ作成
New-Item $DstPath -type directory

#srcフォルダ内の全画像に対して処理を実行
$SrcList = Get-ChildItem($SrcPath)
foreach($item in $SrcList){
	Write-Host $item.Name
	AddDescription($item.Name)
}
