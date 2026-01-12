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
input0 = File.join(__dir__, "text_files", "input0.txt")
input1 = File.join(__dir__, "text_files", "input1.txt")
input2 = File.join(__dir__, "text_files", "input2.txt")

output = File.join(__dir__, "text_files", "output.txt")
output1 = File.join(__dir__, "text_files", "output1.txt")
output2 = File.join(__dir__, "text_files", "output2.txt")
output3 = File.join(__dir__, "text_files", "output3.txt")
output4 = File.join(__dir__, "text_files", "output4.txt")

delete_file = File.join(__dir__, "text_files", "delete.txt")
result_file = File.join(__dir__, "text_files", "result.txt")

# fileを読み書きには、主に以下の方法があります。 
# 1. File.open + ブロック
# 2. File.read / File.write
# 3. File.foreach + ブロック  
# 4. File.exist? などの便利メソッド


# == 1. File.open + ブロック ==
# openメソッドはファイルを開き、ブロック内で操作します。 => streamオブジェクトを返す
# ブロックが終わると自動的にファイルが閉じられます。
# ファイルサイズが大きい場合やライン単位で処理したい場合に便利です。
# blockを使わない場合は、明示的にcloseメソッドで閉じる必要があります。 

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

# 今回は　mode aで追記してみましょう！
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

puts "\n\nFile.read / File.writeの例 : "
text = File.read(input1, encoding: "UTF-8")
puts text

output2 = File.join(__dir__, "text_files", "output2.txt")
File.write(output2, "これはFile.writeによる書き込みテストです。\n2行目の内容です。") # fileを生成する
puts File.read(output2)

# == 3. File.foreach + ブロック ==
# foreachメソッドはファイルを1行ずつ読み込み、ブロックに渡します。
# 大きなファイルを行単位で処理したい場合に便利です。

puts "\n\nFile.foreach + blockの例 : "
File.foreach(input0) do |line|
  puts line.chomp
end   

puts "\n\nchompオプション付きの例 : "
File.foreach(input0, chomp: true) do |line|
  puts line
end

# == 4. File.exist? などの便利メソッド ==
# exist? : ファイルやディレクトリが存在するか確認します。
# delete : ファイルを削除します。
# rename : ファイルやディレクトリの名前を変更します。 

puts "\n\nFile.exist? の例 : "
if File.exist?(output2)
  puts "#{output2} は存在します\n"
else
  puts "#{output2} は存在しません\n"
end

if File.exist?(output3)
  puts "#{output3} は存在します\n"
else
  puts "#{output3} は存在しません\n"
end


puts "\n\nFile.rename の例 : "
if File.exist?(output4)
  File.rename(output4, output3)
  puts "#{output4} を #{output3} に名前変更しました\n"
else
  puts "#{output4} は存在しません\n"
end


puts "\n\nFile.delete の例 : "
File.write(delete_file, "このファイルは後で削除されます。")
if File.exist?(delete_file)
  File.delete(delete_file)
  puts "#{delete_file} を削除しました\n"
else
  puts "#{delete_file} は存在しません\n"
end

# ==パースの例 ==
# パースとは、データを特定の形式から別の形式に変換することです。
# 例えば、CSVファイルを読み込んで配列やハッシュに変換したり、JSONデータをオブジェクトに変換したりすることです。
# Rubyでは、標準ライブラリや外部ライブラリを使って様々な形式のデータをパースできます。

# input2.txt: "10, 40, 20, 30, 50"

puts "\n\n readパースの例 : "

text = File.read(input2, encoding: "UTF-8").strip
nums = text
  .split(/\s*,\s*/)          # カンマ区切り（空白OK）
  .reject(&:empty?)
  .map { |s| Integer(s) }
puts "[File.read] nums=#{nums.inspect}, sum=#{nums.sum}, avg=#{nums.sum / nums.size.to_f}"

# ================================================

puts "\n\n open +blockパースの例 : "
# input2.txt を open で読んで、1行目をパースする例

nums = []
File.open(input2, "r", encoding: "UTF-8") do |f|
  line = f.gets           # 1行読む（input2は1行想定）
  line = line.to_s.strip  # nil対策
  nums = line
    .split(/\s*,\s*/)
    .reject(&:empty?)
    .map { |s| Integer(s) }
end
puts "[File.open] nums=#{nums.inspect}, sum=#{nums.sum}"

# ================================================
puts "\n\n foreach +blockパースの例 : "

nums = []

File.foreach(input1, chomp: true).with_index(1) do |line, lineno|
  next if line.strip.empty?

  begin
    nums << Integer(line.strip)
  rescue ArgumentError
    puts "[File.foreach] line#{lineno} 数値じゃない -> #{line.inspect}"
  end
end

puts "[File.foreach] nums=#{nums.inspect}, max=#{nums.max}, min=#{nums.min}"

# 結果をresult_fileに書き込む
File.open(result_file, "w", encoding: "UTF-8") do |f|
  f.puts "Parsed numbers: #{nums.inspect}"
  f.puts "Sum: #{nums.sum}"
  f.puts "Average: #{nums.sum / nums.size.to_f}" unless nums.empty?
  f.puts "Max: #{nums.max}" unless nums.empty?
  f.puts "Min: #{nums.min}" unless nums.empty?
end

