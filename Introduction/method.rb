# メソッド(関数)に付いて説明するファイルです。
# まず、ルビーでは「関数」というよりも「メソッド」と呼ばれています。

# メソッド（method)とは？
## オブジェクトに対して呼び出す処理機能ことです。

## 基本的な形を見てみましょう。
=begin

def メソッド名(引数) # 引数は必須ではありません
  # コード...
  return 値          # return も必須ではありません（最後の式が戻り値になります）
end

=end

# =begin =endは複数の列のコメントです。

#　でも、引数とreturnはメソッド核心なので覚えてください
# 実際に使ってみましょう

puts "method基本形の例　:"
def test_print() 
    puts "test_printが実行されました！"
end

#宣言はこれで完了です。　使う時には メッソド名(引数)をだけ使います。
test_print()

# 今回は引数を使ってみましょう！
puts "\n\nmethod基本形の例(引数使用）:"
def myname(name)
    puts "私の名前は#{name}です"
end
myname("佐藤")

# 今回はreturnも使ってみましょう！
puts "\n\nmethod基本形の例(return使用）:"
def plus_return(a,b)
    return a + b
end

num1 = 100
num2 = 50

puts "#{num1} + #{num2} = #{plus_return(num1,num2)}"

# 引数にデフォルト値も可能です

puts "\n\ndefault設定　: "

def default_test(color = "なし")
    puts "選択したカラーは#{color}"
end

default_test()
default_test("red")

# 他に四つくらい持って調べてみましょう

# 1. return 省略
# 最後の式が戻り値になります
puts "\n\nreturn省略　: "

def return_omission(x, y)
    x * y
end
puts "10 * 7 = #{return_omission(10,7)}"

# 2. arrayを使って複数の値を返す
puts "\n\n複数の値を返す　: "
def min_max(arr)
  [arr.min, arr.max]
end

mn, mx = min_max([3, 7, 2, 9])
puts "min = #{mn}, max = #{mx}"

# 3.返還メソッドに？を付ける
# ?を付けることで、真偽値を返すメソッドであることを示す慣習があります
puts "\n\nメソッドに？を付ける例　: "
def adult?(age)
    age >=20
end
puts "18歳は成人ですか？ #{adult?(18)}"
puts "25歳は成人ですか？ #{adult?(25)}"

# 4.返還メソッドに！を付ける

puts "\n\nメソッドに!を付ける例　："

s = "hello"

# upcase は「新しい文字列」を返す（元の s は変わらない）
t = s.upcase
puts "s = #{s}"  # hello
puts "t = #{t}"  # HELLO

# upcase! は「元の文字列 s を直接変更する（破壊的）」メソッド
s.upcase!
puts "s = #{s}"  # HELLO

# 注意：!メソッドは「変更した場合はそのオブジェクトを返す」ことが多い
#       でも、変更が発生しなかった場合は nil を返すことがある（重要！）
u = "HELLO"
result = u.upcase!       # すでに大文字なので変更なし → nil になりやすい
p result                 # nil
puts "u = #{u}"          # HELLO

# まとめ
# メソッドを宣言するには def キーワードを使います
# 引数や return は必須ではありませんが、メソッドの核心なので覚えておきましょう
# メソッド名に ? や ! を付ける慣習もあります
# メソッドの名前が小文字で始まり、単語の区切りに _ を使うスネークケースであることも覚えておきましょう
# 大文字を使えば、いろいろな問題が発生します（定数やクラスと混同されるなど）


