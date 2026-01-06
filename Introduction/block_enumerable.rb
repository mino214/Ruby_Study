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
  temp       
end
puts

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

# ==========================================================================================================

## Enumerableモジュール
# Enumerable は Ruby の標準機能の1つ（モジュール）で、配列やハッシュなどのコレクションでよく使います。
# for や while は「どうやって繰り返すか（How）」がコードに出やすいですが、
# Enumerable を使うと「何をしたいか（What）」をメソッド（map / select / find など）で表現できます。
# その結果、コードが読みやすく、スッキリ書けるのがメリットです。
# それでは、いくつかの代表的な Enumerable メソッドを紹介します。

## ==== 1. each メソッド ====
# each はコレクションの各要素に対して処理を繰り返すメソッドです。
# 返還値は元のコレクションです。もし要素を変換したい場合は map を使います。

puts "\n\neach メソッドの例:"
arr = [1, 2, 3, 4, 5]
ret = arr.each  {|n| puts n}

p ret == arr # => true

## ==== 2. map メソッド ====
# map はコレクションの各要素を変換して新しい配列を作成するメソッドです。
# 返還値は変換後の新しい配列です。
puts "\n\nmap メソッドの例:"

arr = [1, 2, 3, 4, 5]
new_arr = arr.map {|n| n * 2}
p new_arr # => [2, 4, 6, 8, 10]

p arr == new_arr # => false

## ==== 3. select / reject メソッド ====
# select は条件に合う要素だけを抽出し、新しい配列を作成するメソッドです。
# reject は条件に合わない要素を抽出します。
puts "\n\nselect / reject メソッドの例:"

arr = [1, 2, 3, 4, 5, 6]

p arr.select { |n| n.even? }  # => [2, 4, 6]
p arr.reject { |n| n.even? }  # => [1, 3, 5] enenは偶数を意味します


## ==== 4. find / all? / any? / none? メソッド ====
# findは条件に合う最初の要素を返します。
puts "\n\nfind メソッドの例(1,3,5,6,10):"
p [1,3,5,6,10].find { |n| n > 5 }  # => 6

# all?, any?, none?は条件に合うかどうかを真偽値で返します。
# all?は全ての要素が条件を満たすか
# any?は少なくとも一つの要素が条件を満たすか
# none?は全ての要素が条件を満たさないか
puts "\n\nall? / any? / none? メソッドの例:"

puts "\n 2,4,6のall? メソッド:"
p [2,4,6].all?  { |x| x.even? }  # true
puts "\n 1,3,4のany? メソッド:"
p [1,3,4].any?  { |x| x.even? }  # true
puts "\n 1,3,5のnone? メソッド:"
p [1,3,5].none? { |x| x.even? }  # true


## ==== 5. reduce メソッド ====
# reduce はコレクションの要素を一つにまとめるメソッドです。
# 形式は以下の通りです。

# collection.reduce(initial_value) {|acc, x| ...}
# acc は累積値、x は現在の要素を表します。
puts "\n\nreduce メソッド："
p [1,2,3,4].reduce(0) {|sum, n| sum + n }  # => 10
p [1,2,3,4].reduce(1) {|mul, n| mul * n } # => 24

## ==== 6. sort / sort_by / reverse メソッド ====
# sort は要素を昇順に並べ替えるメソッドです。
# 返り値は新しい配列です。
puts "\n\nsortメソッドの例:"
p [5,2,8,1,4].sort  # => [1, 2, 4, 5, 8]
p ["a","c","b"].sort  # => ["a", "b", "c"]

# 逆に並べ替えたい場合は reverse メソッドを使います。
puts "\n\nreverseメソッドの例:"
p [5,2,8,1,4].reverse  # => [4, 1, 8, 2, 5]　ソートではないです。
p ["a","c","b"].reverse  # => ["b", "c", "a"]
# しかしreverseは整列された配列を逆順にするだけなので、sortと組み合わせて使うことが多いです。

# 実はsortを使っても逆順にできます。
puts "\n\nsortメソッドで逆順にする例:"
p [5,2,8,1,4].sort { |a, b| b <=> a }  # => [8, 5, 4, 2, 1]

# sort_byメソッドは、要素を特定の基準で並べ替えるときに使います。
# 基準は長さとか点数など、任意の条件で指定できます。
puts "\n\nsort_byメソッドの例:"
words = ["apple", "fig", "banana", "kiwi"]
p words.sort_by { |word| word.length }  # => ["fig", "kiwi", "apple", "banana"]

#integerの配列を絶対値でソートする例
numbers = [-10, 5, -3, 2, -8]
puts "\n\n整数配列を絶対値でソートする例:"
p numbers.sort_by { |n| n.abs }  # => [2, -3, 5, -8, -10] 
# 基本ソートよりも速い場合があります。

## ==== 7. uniq / compactメソッド ====
# uniqは配列の重複要素を取り除くメソッドです。
puts "\n\nuniqメソッドの例:"
arr = [1, 2, 2, 3, 4, 4, 5]
p arr.uniq  # => [1, 2, 3, 4, 5]

# compactは配列からnil要素を取り除くメソッドです。
puts "\n\ncompactメソッドの例:"
arr = [1, nil, 2, nil, 3]
p arr.compact  # => [1, 2, 3]

## ==== 8. each_with_index / each_with_object メソッド ====
# each_with_indexは各要素とそのインデックスを同時に取得するメソッドです。
puts "\n\neach_with_indexメソッドの例:"
arr = ["a", "b", "c"]
arr.each_with_index do |value, index|
  puts "Index: #{index}, Value: #{value}"
end

# each_with_objectは指定したオブジェクトを各要素と一緒に渡すメソッドです。
# reduceに似ていますが、初期値を明示的に渡せる点が異なります。
puts "\n\neach_with_objectメソッドの例:"
arr = [1, 2, 3, 4, 5]
result = arr.each_with_object([]) do |n, obj|
  obj << n * 2
end
p result  # => [2, 4, 6, 8, 10]

p ["a","b"].each_with_object("") { |char, str| str << char.upcase }  # => "AB"

## ==== 9. group_by メソッド ====
# group_byは要素を特定の基準でグループ化するメソッドです。
puts "\n\ngroup_byメソッドの例:"
arr = [1, 2, 3, 4, 5, 6]
grouped = arr.group_by { |n| n.even? }
p grouped # => {false=>[1, 3, 5], true=>[2, 4, 6]}

p grouped[true]  # => [2, 4, 6]
p grouped[false] # => [1, 3, 5]

p grouped[true][0]  # => 2
p grouped[false][1] # => 3

puts "\n\n学点（grade）で group_by の例:"

scores = [95, 82, 77, 61, 59, 88, 100, 73, 69]

# 点数 → 学点に変換するメソッド
def grade(score)
  case score
  when 90..100 then "A"
  when 80..89  then "B"
  when 70..79  then "C"
  when 60..69  then "D"
  else              "F"
  end
end

grouped = scores.group_by { |s| grade(s) }
p grouped
# 例）{"A"=>[95, 100], "B"=>[82, 88], "C"=>[77, 73], "D"=>[61, 69], "F"=>[59]}

puts "Aの学生: #{grouped["A"].inspect}" # inspectメソッドは配列を見やすく表示するために使います
puts "Bの学生: #{grouped["B"].inspect}"
puts "Cの学生: #{grouped["C"].inspect}"
puts "Dの学生: #{grouped["D"].inspect}"
puts "Fの学生: #{grouped["F"].inspect}"

# 存在しないキーの場合、nilを返す代わりに空配列を返す
puts "Eの学生: #{grouped.fetch("E", []).inspect}"

## ==== 10. partition メソッド ====
# partitionは要素を条件に基づいて二つのグループに分けるメソッドです。
# trueのグループとfalseのグループに分けられます。

puts "\n\npartitionメソッドの例:"
arr = [1, 2, 3, 4, 5, 6]
even, odd = arr.partition { |n| n.even? }
p even  # => [2, 4, 6]
p odd   # => [1, 3, 5]


# 追加情報

## ==== 11. take / drop メソッド ====
# take(n)は最初のn個の要素を取得するメソッドです。
# drop(n)は最初のn個の要素をスキップして残りを取得するメソッドです。
puts "\n\ntake / drop メソッドの例:"
arr = [1, 2, 3, 4, 5, 6]
p arr.take(3)  # => [1, 2, 3]
p arr.drop(3)  # => [4, 5, 6]

## ==== 12. each_slice / each_cons メソッド ====
# each_slice(n)はコレクションをn個ずつのグループに分けて処理するメソッドです。
puts "\n\neach_slice メソッドの例:"
arr = [1, 2, 3, 4, 5, 6]
arr.each_slice(2) do |slice|
  p slice
end # => [1, 2] [3, 4] [5, 6]

# each_cons(n)は連続するn個の要素をグループにして処理するメソッドです。
puts "\n\neach_cons メソッドの例:"
arr = [1, 2, 3, 4, 5, 6]
arr.each_cons(2) do |cons|  
  p cons
end # => [1, 2] [2, 3] [3, 4] [4, 5] [5, 6]

## ==== 13. zip メソッド ====
# zipは複数のコレクションを組み合わせて配列の配列を作成するメソッドです。
puts "\n\nzip メソッドの例:"
arr1 = [1, 2, 3]
arr2 = ["a", "b", "c"]
zipped = arr1.zip(arr2)
p zipped  # => [[1, "a"], [2, "b"], [3, "c"]]

# もし要素数が異なる場合、足りない部分はnilで埋められます。
arr3 = [true, false]
zipped2 = arr1.zip(arr2, arr3)
p zipped2  # => [[1, "a", true], [2, "b", false], [3, "c", nil]]

## ==== 14. cycle メソッド ==== 
# cycleはコレクションの要素を繰り返し処理するメソッドです。
# もし引数を指定しなければ無限に繰り返します。
puts "\n\ncycle メソッドの例 (3回繰り返し):"
arr = [1, 2, 3]
count = 0
arr.cycle do |n|
  puts n
  count += 1
  break if count >= 9  # 3回繰り返したら終了
end

arr = ["A", "B", "C"]
count = 0
puts "\n\ncycle メソッドの例 (2回繰り返し):"
arr.cycle(2) do |char|
  puts char
  count += 1
end