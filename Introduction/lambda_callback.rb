# callbackとは？
# callbackはコードの塊（つまり、ブロックやProcオブジェクト）を他のメソッドに引数として渡し、特定のタイミングでそのコードを実行するための仕組みです。
# rubyでは三つの方法でcallbackを実行します：ブロック、Procオブジェクト、ラムダ。

# ブロックコールバック(block callback)
# ルビーで最も一般的なcallbackの方法です。
# メソッドにブロックを渡し、そのメソッド内でyieldキーワードを使ってブロックを実行します。

puts "=== ブロックコールバック ==="
def with_logging
    puts "[スタート]"
    yield # yieldキーワードでブロックを実行
    puts "[エンド]"
end

with_logging do
    puts "処理中..." # スタートとエンドの間に現れる（実行する）
end

# block-given？
# 実際にブロックが渡されたかどうかを確認するために、block_given?メソッドを使うことができます。
# 普通if文と一緒に使われます。

puts "\n\n=== ブロックーギブン ==="
def safe_call
    if block_given?
        yield
    else
        puts "ブロックが渡されませんでした。"
    end
end

safe_call
safe_call {puts "ブロックが渡されました！"}

# === Procコールバック(Proc callback) ===
# Procはブロックを「オブジェクト」として扱うためのクラスです。
# Procにすると、変数に入れて保存したり、メソッドに引数として渡したり、何回も実行できます。

# ポイント：
# - ブロックは「その場で渡す処理」
# - Procは「処理をオブジェクトとして保存・再利用できる」
# - Procは引数の数に柔軟（足りない=>nil、多い=>無視）
# ※ 引数に厳密なのは lambda（Procではなくlambdaの特徴）

puts "\n\n=== Procコールバック ==="

# 1) Procを作る（ブロックをオブジェクト化）
printer = Proc.new { |msg| puts "[printer] #{msg}" }

# 2) Procは保存して何回も使える（再利用）
printer.call("1回目")
printer.call("2回目")

# 3) Procをメソッドに渡して実行できる
def run_callback(cb, msg)
  cb.call(msg)
end

run_callback(printer, "Procコールバックが実行されました！")

# 4) Procは「複数」渡すこともできる（ブロックは1つだけ）
def run_two_callbacks(cb1, cb2)
  cb1.call("first")
  cb2.call("second")
end

cb_a = Proc.new { |x| puts "[A] #{x}" }
cb_b = Proc.new { |x| puts "[B] #{x}" }
run_two_callbacks(cb_a, cb_b)

# 5) Procの引数は柔軟（足りない=>nil、多い=>無視）
flex = Proc.new { |a, b| puts "a=#{a.inspect}, b=#{b.inspect}" }
flex.call(10)          # bはnil
flex.call(10, 20, 30)  # 30は無視

# 6) &を使うと「ブロックをProcとして受け取れる」
def with_logging_proc(&proc_obj)
  puts "[スタート]"
  proc_obj.call if proc_obj
  puts "[エンド]"
end

with_logging_proc do
  puts "Procコールバック内の処理中..."
end

# 次はlambda：Procと似ているが「引数チェックが厳密」＆「returnの動き」が違う

# === ラムダコールバック(lambda callback) ===
# lambdaはブロックオブゼィクトを作るもう一つの方法です。
# 変数に保存したり、メソッドに渡したりできます。

# ※ -> {} や　lambda {} で作成します。 

# なんでlambdaを使うのか
# callbackを「値」として渡す場合
# 引数の数を厳密にチェックしたい場合
# 後で実行する処理を保存しておきたい場合

# Procとの違い
# 1) 引数チェックが厳密（足りないとエラー、多いとエラー）
# 2) returnの動きが違う（lambda内のreturnはlambdaから抜けるだけ、Proc内のreturnはメソッド全体から抜ける）   

puts "\n\n=== ラムダコールバック ==="

double1 = -> (x) { x * 2 }
puts double1.call(5)

double2 = lambda { |x| x * 5 }
puts double2.call(10)

# 複数の列の時はdo...endを使う
with_log = -> do
    puts "[スタート]"
    puts "ラムダコールバック内の処理中..."
    puts "[エンド]"
end

with_log.call

# ラムダをメソッドに渡す
# 数値を受け取って加工するラムダ
puts "\n\n=== ラムダをメソッドに渡す ==="
def run_lambda(cb, value)
    result = cb.call(value)
    puts "ラムダの結果: #{result}"
end 
run_lambda(double1, 7)
run_lambda(double2, 8)  


# コールバックの戻り値を受け取って使うパターン
puts "\n\n=== コールバックの戻り値を受け取って使うパターン ==="
def greet(callback, name)
  puts callback.call(name)
end

cb = ->(n) { "Hello, #{n}!" }
greet(cb, "佐藤")   # Hello, 佐藤

# 引数チェックの厳密さ

puts "\n\n=== 引数チェックの厳密さ ==="
strict_lambda = ->(a, b) { a + b }  
puts strict_lambda.call(3, 4)    # 正常動作
# puts strict_lambda.call(3)     # 引数不足でエラー, Procの場合はnilが入ってエラーにならない

# &を使ってラムダをブロックとして渡す
puts "\n\n=== &を使ってラムダをブロックとして渡す ==="
square = ->(x) { x * x }
p [1, 2, 3].map(&square)     # [1, 4, 9]

# filterメソッドで使う例
puts "\n\n=== filterメソッドで使う例 ==="
is_even = ->(n) { n.even? }
p [1, 2, 3, 4, 5, 6].select(&is_even)  # [2, 4, 6]
                                       # &はブロックとProcの返還を行う
# returnの動きの違い
# lambda内のreturnは「そのlambda」だけを終了させ、呼び出し元メソッドの処理は続く
# Proc内のreturnは「Procを呼び出したメソッド」自体を終了させる（注意）

puts "\n\n=== returnの動きの違い ==="
def test_lambda
    l = -> { return "ラムダからの戻り値" }
    result = l.call
    puts "ラムダ呼び出し後: #{result}"
    "メソッドtest_lambdaの戻り値"
end

p test_lambda  # "メソッドtest_lambdaの戻り値"

def test
  p = Proc.new { return 1 }  
  p.call
  999
end

p test  # 1

# lambdaは独立した関数っぽくreturnできるが、Procのreturnは外側メソッドへ脱出しようとする（lexical return）
#	•	Proc: 引数が足りないと nil、多すぎると無視（柔軟）
#	•	lambda: 引数の数が合わないと ArgumentError（厳密）
#	•	ブロック: その場で渡す“構文”なので、比較軸は 「オブジェクト化できるか（Proc/lambda）」