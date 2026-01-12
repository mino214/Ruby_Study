# fileとexceptionの説明ファイルです
# このファイルーでは, ./files/input0.txt, ./files/input1.txt, ./files/output.txtを使います

## Fileクラスとは？ 
# ファイルやディレクトリを操作するためのクラスです。
# ファイルの読み書き、削除、移動、情報取得などができます
# ここではテキストファイルの読み書きを中心に説明しますが、これが基本なので他の操作も同様です。

## fileI/Oとは？
# file input/outputの略で、ファイルからデータを読み込んだり
# ファイルにデータを書き込んだりする操作のことです。
# RubyではFileクラスやIOクラスを使ってfile I/Oを行います。
# 主にテキストファイルやバイナリファイルの読み書きに使います。
# まずは、ファイル経路の指定方法を説明します。
# joinメソッドを使って、OSに依存しないパスを作成しましょう。

# __dir__ を基準にパスを作る（実行場所が変わっても安全）
input0 = File.join(__dir__, "files", "input0.txt")
input1 = File.join(__dir__, "files", "input1.txt")
output1 = File.join(__dir__, "files", "output1.txt")
output = File.join(__dir__, "files", "output.txt")


# fileを読み書きには、主に以下の方法があります。 
# 1. File.open + ブロック
# 2. File.read / File.write
# 3. File.foreach + ブロック  
# 4. File.exist? などの便利メソッド


# == 1. File.open + ブロック ==
# openメソッドはファイルを開き、ブロック内で操作します。 => streamオブジェクトを返す
# ブロックが終わると自動的にファイルが閉じられます。
# ファイルサイズが大きい場合やライン単位で処理したい場合に便利です。

# ここで一つ, modeについて説明します
# modeとは、ファイルを開くときの「読み書き方法」を指定する文字列です。
# r : 読み込み専用モード（デフォルト）
# w : 書き込み専用モード（既存の内容は消去される）
# a : 追記モード（ファイルの末尾に追加）
# r+ : 読み書き両用モード(ファイルが存在しない場合はエラー)
# a+ : 読み書き両用モード（ファイルが存在しない場合は新規作成）
# w+ : 読み書き両用モード（既存の内容は消去される）
# b : バイナリモード（テキストファイル以外の場合に使用）　→ 他のモードと組み合わせて使う（例: "rb", "wb"）

puts "file open + blockの例 : "

File.open(input0, "r") do |f|
  f.each_line do |line|
    puts line.chomp  # chompで改行を削除
  end
end

# 今回は書いてみましょう！
puts "\n\nfile writeの例 : "

File.open(output, "w") do |f|
  f.puts "これはoutput.txtへの書き込みテストです。"
  f.puts "2行目の内容です。"
end  


File.open(output, "r") do |f|
  f.each_line do |line|
    puts line.chomp  # chompで改行を削除
  end
end

# 今回は　amodeで追記してみましょう！
puts "\n\nfile appendの例 : "
File.open(output1, "a") do |f|
  f.puts "これは追記テストです。"
  f.write(File.read(input1))  # input1の内容を追記
end  #　ファイルの内容が続ける

File.open(output1, "r") do |f|
  f.each_line do |line|
    puts line.chomp  # chompで改行を削除
  end
end
# r+, w+ も同様に使えます
puts "\n\nr+ modeの例 : "
File.open(output1, "r+") do |f|
  content = f.read
  puts "現在の内容："
  puts content
  f.puts "\n--- ここから追加 ---"
  f.puts "r+ modeで追加しました。"
end

# w+ : 読み書き両用（ただし開いた瞬間に内容が消える＝上書き/トランケート）
puts "\n\nw+ modeの例（注意：既存内容は消えます）: "
File.open(output1, "w+") do |f|
  # この時点で output1 の中身は空になる
  puts "w+で開いた直後の内容（read）:"
  p f.read  # => ""（空文字列）

  f.puts "--- w+で新しく書いた内容 ---"
  f.puts "w+ modeで書き込みました。"

  # 今書いた内容をその場で読み直したいなら、ファイルポインタを先頭に戻す必要がある
  f.rewind
  puts "rewind後の内容（read）:"
  puts f.read
end

puts"\n\nreturn streamオブジェクトの例 : "
f = File.open(input0, "r")
puts f.class   # File (IO)
f.close  # 忘れずに閉じる

# == 2. File.read / File.write ==
# readメソッドはファイル全体を一度に読み込み、文字列として返します。
# 小さいファイルを一度に読み込みたい場合に便利です。
# writeメソッドは文字列をファイルに書き込みます。既存の内容は上書きされます。



