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
