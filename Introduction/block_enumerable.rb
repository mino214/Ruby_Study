# blockとenumerableを説明するファイルです

# blockとは？
# メソッドに渡す「処理（コードのかたまり）」のことです。（コールバックとも呼ばれます）
# 値を渡すというより、「処理そのもの」を渡すイメージです。
# だから、Rubyではforやwhileよりeachやmapなどのblockを使う事が多いです
# blockには二つの種類があります。

## {}を使うblock
# 一行で書く場合に使います
# 例：配列の各要素を2倍にする
numbers = [1, 2, 3, 4, 5]
doubled = numbers.map { |n| n * 2 } # mapについてはあとで説明します
puts "元の配列: #{numbers}"
puts "2倍にした配列: #{doubled}"

## do..endを使うblock
# 複数行で書く場合に使います
# 例：配列の各要素を2倍にする

puts "\n\n元の配列: #{numbers}"
print "2倍にした配列:　"
numbers = [1, 2, 3, 4, 5]
doubled = numbers.map do |n|
  temp = n * 2
  print "#{temp} "
end

## ここで注意！
# {}とdo..endは同じ意味ですが、優先順位が異なります
# 例えば、メソッドの引数としてblockを渡す場合、{}の方が優先されます

## 優先順位の例（{} の方が結びつきが強い）

# 例1：puts と map を一緒に使うとき
# {} は map に強く結びつくので、意図通りに動く
puts "\n\n\n例1：{}" # は map に強く結びつくので、意図通りに動く
print [1, 2, 3].map { |x| x * 2 }   # => 2 4 6（配列の中身が出力される）

# do..end は puts に結びつきやすいので、map にブロックが渡らずエラーになることがある
# （環境によって表示は違うが、基本的に意図と違う動きになりやすい）
puts "\n例1 do - end：" # do..end は puts に結びつきやすいので、意図と違う動きになる可能性がある"
print [1, 2, 3].map do |x|
  x * 2
end

# 上記は意図と違う動きになる可能性があります。
puts "\n例2： " # 例2：括弧を付ければ do..end でも安全
print([1, 2, 3].map do |x|
  x * 2
end)

# 結論：
# - 1行なら {} が安全
# - do..end を式の中で使うときは、() を付けて渡す先を明確にする

##　blockのパラメーター
# blockパラメーターは| |で囲みます
# | |の中にはblockに渡される各要素が入ります
# 例：配列の各要素を表示する
puts "\n\n配列の各要素を表示します:"
numbers.each { |n| print n }

## yieldキーワード
# yieldはメソッド内でblockを呼び出すためのキーワードです

# def メソッド名
#  yield パラメーター
# end

# 例：yieldを使ったメソッド
puts "\n\nyieldを使ったメソッドの例:"

def Hello
  yield 
end
Hello { puts "\n\nHello from block!" }

## block_given?メソッド
# block_given?はメソッド内でblockが渡されたかどうかを確認
# 例外処理などで使う

puts "\n\nblock_given?の例:"
def block_checker
  if block_given?
    yield
  else
    puts "No block provided."
  end
end
block_checker { puts "Block is provided!" }
block_checker

## enumerableモジュール
# enumerableはRubyの標準ライブラリで、コレクションです（配列やハッシュなど）に対して使います
# 