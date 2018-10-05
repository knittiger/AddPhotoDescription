# AddPhotoDescription
Add camera related description text over jpeg image (date, time, shutter speed, iso, etc.)

## 概要
処理対象となるJPEGファイルから以下の情報を取得し、透過文字として重ねて表示した画像を生成する
- 日時
- カメラ機種
- シャッタースピード
- ISO感度
- 焦点距離
- F値
ファイル情報から取得できないイベント名称、イベント開催場所は実行時にコマンドラインで入力可能。

## 使用方法
1. .ps1ファイルと.batファイルを同じフォルダに格納する
2. １のフォルダにsrcフォルダを作成し、処理対象となる画像ファイルを格納する（複数配置OK）
3. batファイルを実行。同じフォルダのdst フォルダに処理結果JPEGファイルを出力する

srcフォルダ内にファイルが複数ある場合にはまとめて処理します

## 注意事項
処理対象ファイルが破損しても責任は負いかねます。バックアップした上で使用してください。


## overview
This program read jpeg properties shown as below and put it to the original file as overlay text.
- date and time
- Camera vender and model
- shutter speed
- ISO speed
- focusl length
- F value

## Install & Usage
1. Put .ps1 file and .bat file to same folder.
2. Create scr folder and put target JPEG files into it.
3. Execute .bat file. The Result JPEG file will appeare in dst folder.

## Warning!!
Please backup src JPEG files before execute !
