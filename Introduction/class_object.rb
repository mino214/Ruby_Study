# classとobjectの説明ファイルです

# まず、classとは？
# classは　データ（状態）とメソッド（行動）をまとめた設計図のようなものです
#　形は以下のようになります

# class名は必ず大文字で始まり、PascalCaseで書きます。
# ここでPascalCaseとは、各単語の最初の文字を大文字にし、単語間にスペースやアンダースコアを入れない書き方です。
# 例: MyClass, Animal, VehicleType

# class クラス名 
# 変数や定数などのデータ（状態）位置は関係ない
# def initialize メソッド（コンストラクタ） =>　必須ではない, Rubyでは明示的なデストラクタは基本的に使いません（GCが回収します）
#   初期化処理を書く場所 -> @変数 = 引数 
# end
#
# def メソッド名(引数)
#   メソッドの処理を書く場所
# end  
#   クラスの定義 データとかメソッドとか
# end

# classの中で変数の宣言する方法

# 1. local変数
# メソッドの中だけ使う変数です
#　変数名　＝　値　　＝＞　name = "佐藤"

# 2. instance変数
# オブジェクトに保存する変数です
# @変数名　＝　値　　＝>  @age = 59

# 3. class変数
# class 全体にする変数です。　
# クラス全体（＋サブクラス）で共有される変数です。注意して使ってください
# @@変数名　＝ 値　　=> @@city = "Fukuoka"


# 車classを作ってみましょう
puts "classの例 : "
class Car 

  @@car_count = 0

  def initialize(name, make, model, year)
    @name = name      # 名前
    @make = make      # メーカー
    @model = model    # モデル
    @year = year      # 年式
    @speed = 0 # 変数（状態）
    @@car_count +=1
  end

  def display_info
    puts "車の情報: #{@name} #{@year}年式 #{@make} #{@model}"
  end

  def speed_up(increase)
    @speed += increase ## rubyは ++ができません
    puts "速度を#{increase} km/h 上げました。"
  end

  def speed_down(decrease)
    if@speed - decrease < 0
      puts "0km/h以下はできません"
      @speed = 0
    else
      @speed -= decrease
      puts "速度を#{decrease} km/h 下げました。"
    end
  end

  def show_car_speed
    puts "現在の速度は #{@speed}km/h "
  end

  def return_count 
     @@car_count
  end

end

# 簡単なclassを完成しました
# 今度は実際にclassを使ってみましょう

car1 = Car.new("A","トヨタ", "プリウス",2025) # initializeを使っているにで初期値が必要です！
car2 = Car.new("B",'テスラ',"model x",2026)

puts car1.display_info()
puts car2.display_info()

# もし初期値を入力しない場合は？ -errorです
# car3 = Car.new()
# puts car3.display_info()

puts "car_total count : #{car1.return_count}"
puts car1.return_count() == car2.return_count() # true

# 他にも色々なメソッドを使ってみましょう
puts "\n\nspeed関連メソッド　: "
car1.show_car_speed()

car1.speed_up(100)
car1.show_car_speed()

car1.speed_down(50)
car1.show_car_speed()

car1.speed_down(60)
car1.show_car_speed()

# ======================================

## getterとsetter
# Rubyはカプセル化は基本的に抵抗しています。
# カプセル化　＝＞　https://trends.codecamp.jp/blogs/media/terminology248
# だから@car_countような変数に直接接近できません
# なので、read/writeメソッドを抵抗する必要があります
# これを attr_reader, attr_writer, attr_accessorを使って抵抗しています

# attr_reader : only read 
# attr_writer : onlt write
# attr_accessor : readとwrite全部できる

# 実際に使ってみましょう

puts "\n\ngetter/setterの例"
class Student
  attr_reader :name, :id
  attr_writer :memo
  attr_accessor :department

  def initialize(name, id, department)
    @name = name
    @id   = id
    @department = department
  end

  def show_info
    puts "name : #{name} id : #{@id} department : #{@department}"
  end

  def show_memo
    puts @memo
  end
end

student = Student.new("佐藤",251111,"Computer Software")
student.show_info()

puts "department : #{student.department}"

student.department = "Computer Science"

puts "department : #{student.department}"

student.memo = "hi! i'm student!"

# puts student.memo 

student.show_memo
