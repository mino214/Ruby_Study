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
score = gets.chomp.to_i

if score >= 90
  grade = "A"
elsif score >= 80
  grade = "B"
elsif score >= 70
  grade = "C"
elsif score >= 60
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

# 次に反復文を見てみましょう。
# Rubyでは、主に3つの反復文があります。
# 1. while文
# 2. for文
# 3. eachメソッド


