#今回は条件文と反復文を学びます。
#条件文は、ある条件が真か偽かによって処理を分岐させるために使います。
#反復文は、同じ処理を繰り返し実行するために使います。

#条件文の基本的な構文は以下の通りです。

# 一番目if文
# if 条件式
#   処理1
# elsif 別の条件式 -> 省略可能
#   処理2
# else　　　　　　　 -> 省略可能
#   処理3
# end
# 空白はtabかスペース2つでインデントします。
# 少し違う点がありますね、if文の終わりにendが必要です。　これを注意しましょう

# HelloRubyファイルで教えたことを活用して、条件文の例を見てみましょう。

# grade計算機 
puts "grade計算機"
print "点数を入力してください(0 - 100点まで)　: "
STDOUT.flush
score1 = gets.chomp.to_i

if score1 >= 90
  grade = "A"
elsif score1 >= 80
  grade = "B"
elsif score1 >= 70
  grade = "C"
elsif score1 >= 60
  grade = "D"
else
  grade = "F"
end

puts "あなたのgradeは #{grade} です。"
# これで、ユーザーが入力した点数に基づいて、対応するgradeを表示することができます。
# 状況に応じてifだけ使ったり、elsifやelseを追加したりできます。

# 二番目case文

# Rubyにはswitch文の代わりに、case文(case-when)があります。
# case 対象
# when 値1
#   処理
# when 値2
#   処理
# else
#   処理
# end

# 先の例をcase文で書き直してみましょう。

#grade計算機 (case文バージョン)
puts "grade計算機"
print "点数を入力してください(0 - 100点まで)　: "
STDOUT.flush
score2 = gets.chomp.to_i

case score2
when 90..100
  grade = "A"
when 80..89
  grade = "B"
when 70..79
  grade = "C"
when 60..69
  grade = "D"
else
  grade = "F"
end

puts "あなたのgradeは #{grade} です。"
# case文は特定の値に基づいて処理を分岐させるのに便利です。
# Rubyの場合、範囲（Range）を指定することもできます。
# n..m は n から m まで（mを含む）の範囲を表します。
# n...m は n から m-1 まで（mを含まない）の範囲を表します。
# また、Rubyのcase文はswitch文のようなフォールスルーがないため、breakは不要です。 # Rubyの特徴
# 最後に、else節は省略可能です（ただし想定外の入力に備えるなら書くのがおすすめです）。

# ========================================================================================= 

# 次に反復文を見てみましょう。
# Rubyでは、主に3つの反復文があります。
# 1. while文
# 2. for文
# 3. eachメソッド

# まず、while文から見てみましょう
# while 条件式
#  処理
# end

# 例: 1から5までの数字を表示する

number = 1 
while number <= 5
  puts "今の数字は#{number} です。"
  number += 1 # number = number + 1 と同じ意味 → 逆に　number -= 1 は引き算　とか　number +=2, *=2 などもあります。
end

# これが基本的なwhile文の使い方です。
# 実は,while文には他の形もあります。
# 二つの違う形を見てみましょう。

# 1. begin - end 形式
# begin
#   処理
# end while 条件式
# これは必ずbeginの内容を一回は実行したい場合に使います。

# 例: 1から5までの数字を表示する (begin - end 形式)

number = 1
begin
  puts "今の数字は#{number} です。"
  number += 1
end while number <= 5

# 2. loof do - end 形式
# loof doは　簡単に話すと無限ループを作るために使います

# roof do 
#  処理
# end

# えっと、無限ループ？　怖いですね。
# でも、安心してください。　中でbreak文を使ってループを抜けることができます。
# 例: 1から5までの数字を表示する (roof do - end 形式)

puts "roof do - end 形式の例です。"
number = 1
roof do
  puts "今の数字は#{number} です。"
  number += 1
  break if number > 5 # end if文の一行バージョン
end

# 他の機能も少し調べてみましょう

# next分

# redo分　ー>　これは少し特殊です。　ループの現在の反復をやり直すために使います。

# until分 ー> while文の逆です。　条件が偽の間、処理を繰り返します。



