# 2. for文に付いて説明します。
# for 変数 in 範囲または配列
#   処理
# end

# 例: 1から5までの数字を表示する (for文)

puts "for文の例です。"
for number in 1..5
  puts "今の数字は#{number} です。"
end

#こんな形もできます。
number_array = [10, 20, 30, 40, 50] # あとで詳しく説明しますが、これは配列です。同じデータタイプの複数の値をまとめて扱うことができます。

puts "\n\n配列を使ったfor文の例です。"
for number in number_array
  puts "配列の数字は#{number} です。"
end

# 3. eachメソッドに付いて説明します。
# eachメソッドは配列や範囲オブジェクトに対して使われます。
# objectなどのデータタイプに関してはあとえで詳しく説明しますが、ここでは範囲オブジェクトと配列に対してeachメソッドを使う方法を紹介します。

# 基本的な形は以下の通りです。
# 範囲または配列.each do |変数|
#   処理
# end

# 一度使ってみましょう
# 例: 1から5までの数字を表示する (eachメソッド) -> rangeオブジェクトを使う場合

puts "\n\neachメソッドの例です。"
(1..5).each do |number|
  puts "今の数字は#{number} です。"
end

# 今回は範囲オブジェクトを使いましたが、配列に対しても同じように使うことができます。
puts "\n\n配列を使ったeachメソッドの例です。"
number_array.each do |number|
  puts "配列の数字は#{number} です。"
end

# もし、一行で書きたい場合は以下のように書くこともできます。
puts "\n\n一行で書いたeachメソッドの例です。"
number_array.each { |number| puts "配列の数字は#{number} です。" }
(1..5).each { |number| puts "今の数字は#{number} です。" }

# Hashオブジェクトに対してもeachメソッドを使うことができますが、Hashオブジェクトに関してはあとで詳しく説明します。
# 簡単に説明すると、Hashオブジェクトはキーと値のペアを持つデータタイプです。
# data = {"key" => "value"} のように定義します。
# Hashオブジェクトに対してeachメソッドを使う場合、以下のように書きます。
# data.each do |key, value|
#   処理
# end

puts "\n\nHashオブジェクトを使ったeachメソッドの例です。"
data = {name: "佐藤", age: 21, city: "東京"}
data.each do |key, value|
  puts "#{key}: #{value}"
end

puts"\n\nHashオブジェクトの値にアクセスする例です。"
puts"#{data[:name]}"
puts"#{data[:age]}"
puts"#{data[:city]}"

data[:job] = "エンジニア" # 新しいキーと値のペアを追加します。
data[:age] = 22          # 既存のキーの値を更新します。

puts"\n\n更新後のHashオブジェクトを表示します。"
data.each do |key, value|
  puts "#{key}: #{value}"
end

# each_with_indexメソッドもあります。これはeachメソッドと似ていますが、インデックス（位置）も一緒に取得できます。
# つまり、indexとvalueの両方を使いたい場合に便利です。
puts "\n\neach_with_indexメソッドの例です。"
number_array.each_with_index do |number, index|
  puts "インデックス: #{index}, 数字: #{number}"
end

#rangeオブジェクトに対しても同じように使うことができます。
puts "\n\nrangeオブジェクトでのeach_with_indexメソッドの例です。"
(10..15).each_with_index do |number, index|
  puts "インデックス: #{index}, 数字: #{number}"
end

# 最後に times, upto, downto, step メソッドを紹介します。

# 1. times メソッド
# 指定した回数だけブロックを繰り返します。
puts "\n\ntimesメソッドの例です。"
5.times do |i|
  puts "これは#{i + 1}回目の繰り返しです。"
end


# 2. upto メソッド
# 指定した数までカウントアップします。 
puts "\n\nuptoメソッドの例です。"
10.upto(15) do |i| # 最後の数も含まれます
  puts "カウントアップ: #{i}"
end

# 3. downto メソッド
# 指定した数までカウントダウンします。
puts "\n\ndowntoメソッドの例です。"
15.downto(10) do |i| # 最後の数も含まれます
  puts "カウントダウン: #{i}"
end

# 4. step メソッド
# 指定した数だけカウントアップまたはカウントダウンします。
puts "\n\nstepメソッドの例です。"
10.step(20, 2) do |i| # 最後の数も含まれます
  puts "カウントアップ: #{i}"
end