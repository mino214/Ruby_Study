# dataTypeに関しての説明用ファイルです。

# 今までコードを書いたので、だいたい変数の使い方を理解していると思います。
#　rubyはpythonと同じように変数やメソッドの型が明示的に定義されていない言語です。
# そのせいで、変数やメソッドの型に関して混乱することがあるかもしれません。
# まあ、コードが短くなるので、良いこともありますがね。
# ここでは、Rubyの基本的なデータ型について説明します。

# 基本的には、以下のデータ型があります。

# 1. 数値 (Integer, Float)
## Integer: 整数 (例: 1, 42, -7)
## Float: 浮動小数点数 (例: 3.14, -0.001, 2.0)

n = 20
f = 3.14
puts "整数の例: n = #{n}, 型: #{n.class}" # classメソッドは変数の型を返します。
puts "浮動小数点数の例: f = #{f}, 型: #{f.class}"

# 2. 文字列 (String)
## String: 文字列 (例: "Hello, World!", 'Ruby is fun')
## ""（ダブルクォート）は文字列展開（#{ }）やエスケープシーケンス（\n など）が使えます。
## ''（シングルクォート）は基本的にそれらが使えず、文字がそのまま扱われます。
## 例外：''でも \\ と \' はエスケープできます。

name = "佐藤"
str = "\n\nHello, #{name}!\nWelcome to Ruby."
puts "文字列の例: str = #{str}, 型: #{str.class}"
puts 'シングルクォートの例: str = \n\nHello, #{name}!\nWelcome to Ruby., 型: #{str.class}'

# 3. 配列 (Array)
## Array: 複数の値を順序付けて格納するデータ型 (例: [1, 2, 3], ["apple", "banana", "cherry"])
## 反復文でよく使われます。
number_array = [10, 20, 30, 40, 50]
puts "\n\n配列の例: number_array = #{number_array}, 型: #{number_array.class}"
puts "最初の要素: #{number_array[0]}, 最後の要素: #{number_array[-1]}"

string_array = ["apple", "banana", "cherry"]
puts "配列の例: string_array = #{string_array}, 型: #{string_array.class}"
puts "最初の要素: #{string_array[0]}, 最後の要素: #{string_array[-1]}"

# 配列の長さを取得するには、lengthメソッドを使います。
puts "number_arrayの長さ: #{number_array.length}"

# これを使って、配列の要素数を知ることができます。
# なお配列の中間要素にアクセスするには、インデックスを使います。インデックスは0から始まります。
puts "string_arrayの中間要素: #{string_array[string_array.length / 2]}"

# 4. ハッシュ (Hash) と　シンボル (Symbol)
## Hash: キーと値のペアを格納するデータ型
## 例）{"name" => "Alice", "age" => 30} とか { name: "Alice", age: 30 }

### 1. ハッシュロケット（=>）を使う書き方：キーと値のペアを定義します（キーは文字列やシンボルがよく使われます）。
### 2. シンボル（ラベル）を使う書き方：{ name: "Alice" } のように短く書けます。シンボルは「:」で始まります。

### なぜ2つあるの？と思うかもしれませんが、2（シンボル）を使う書き方の方が一般的で、コードも短くなります。
### ただし 1（ハッシュロケット）も、文字列キーを使いたい場合などによく使われます。
### 使い分け：自分のコード内の固定キー（設定・オプションなど）はシンボル、JSON/APIなど外部データは文字列キーが多いです。
puts "\n\nハッシュの例:"
hash1 = {"name" => "佐藤", "age" => 30}
puts "ハッシュロケットの例: hash1 = #{hash1}, 型: #{hash1.class}"
puts "名前: #{hash1["name"]}, 年齢: #{hash1["age"]}"

hash2 = {name: "田中", age: 25}
puts "\nシンボルの例: hash2 = #{hash2}, 型: #{hash2.class}"
puts "名前: #{hash2[:name]}, 年齢: #{hash2[:age]}" 

# 5. 範囲 (Range)
## Range: 連続した値の範囲を表すデータ型 (例: 1..5, 'a'..'e')
## 範囲オブジェクトは反復文でよく使われます。
range_inclusive = 1..5  # 1から5まで（5を含む）
range_exclusive = 1...5 # 1から4まで（5を含まない） 
puts "\n\n範囲の例:"

for num in range_inclusive
  puts "包含範囲の数字: #{num}"
end
puts "\n"
for num in range_exclusive
  puts "非包含範囲の数字: #{num}"
end

# 6. 論理値 (Boolean: true, false)
## Boolean: 真偽値を表すデータ型 (true, false)
## Rubyでは、falseとnil以外のすべての値がtrueと評価されます。
## つまり、0や空文字列("")もtrueと評価されます。
puts "\n\n論理値の例:"
bool_true = true
bool_false = false
puts "bool_true = #{bool_true}, 型: #{bool_true.class}"
puts "bool_false = #{bool_false}, 型: #{bool_false.class}"

## 論理値の評価例
puts "0は真？ :  #{!!0}"  # !! は値を論理値に変換するためのトリックです。
puts "\"\"は真？ :  #{!!""}"
puts "nilは真？ :  #{!!nil}"
puts "falseは真？ :  #{!!false}"

# 7. nil (nullのようなもの)
## nilは「値が存在しない（何もない）」ことを明確に表すために使います。

puts "nilの例"
my_girl_friend = nil

puts "私の彼女は #{my_girl_friend || "いません"}"

## 他にも hashの初期値もnilです
h = { name: "Aki" }
p h[:age]  # p はデバッグ用の出力（inspect形式）です。

# 8. Set (Set)
## Setは重複しない要素の集合です。（同じ値は1つだけ）

puts "\n\n setの例　"
require "set"

s = Set.new([1, 2, 2, 3])
puts s.to_a.inspect      # [1, 2, 3]（順番は保証されない）

s.add(4)                 # 追加
s.delete(2)              # 削除
puts s.include?(3)       # true

# 9. その他（日時(Time), 正規表現(Regexp)）

# Time（現在時刻）
puts "\n\ntimeの例"
t = Time.now
puts t
puts t.year

# Regexp（正規表現）
puts "\n\nRegexpの例"

re = /ab+c/
# /ab+c/ の意味：
# a の後に b が1回以上（+）続いて、その後に c が来るパターン
# 例）"abc", "abbc", "abbbc" はOK / "ac" や "ab" はNG

puts "xxabbbcxx".match?(re)   # true（文字列の中にパターンが含まれている）
puts "xxacxx".match?(re)      # false
puts "xxabxx".match?(re)      # false
puts "xxabcxx".match?(re)     # true
m = "xxabbbcxx".match(re)
puts m[0]   # "abbbc"（実際に一致した部分）

# 定数
# Rubyでは、定数は大文字で始まる名前で表されます。定数の値は変更しないことが期待されますが、実際には変更可能です。
# つまり、定数は慣習的に使用されますが、厳密な制約はありません。

puts "\n\n定数の例です。"
PI = 3.14159
puts "円周率の値は #{PI} です。"

MAX_USERS = 100
puts "最大ユーザー数は #{MAX_USERS} です。"