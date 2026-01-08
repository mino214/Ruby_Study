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

# もし初期値を入力しない場合は？ =>errorです
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
# なので、read/writeメソッドを提供する必要があります
# これを attr_reader, attr_writer, attr_accessorを使って提供しています

# attr_reader : only read 
# attr_writer : only write
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
    puts "name : #{name} id : #{id} department : #{department}"
  end

  def show_memo
    puts @memo
  end
  
end

student = Student.new("佐藤",251111,"Computer Software")
student.show_info()

puts "department : #{student.department}" # 実はこれメソッドの呼び出しです

student.department = "Computer Science"

puts "department : #{student.department}"

student.memo = "hi! I'm student!"

# puts student.memo        # => NoMethodError（reader がない）
# student.name = "藤原"     # => NoMethodError（writer がない）

student.show_memo

# もし直接methodで定義する場合は
class Student0
  def department # getter
    @department
  end

  def department=(dep) # setter
    @department = dep
  end
end

# 上のclassのようにします

# =====================================================

## self
# self は状況によって指すものが変わります。

#使う理由
# self を使う理由
# 1. セッター呼び出しで、ローカル変数代入と区別するため（self.name = ...）
# 2. メソッドチェーンのため（self を返して obj.m1.m2... を可能にする）
# 3. 「現在のレシーバ（メソッドを呼び出したオブジェクト）」を明確にするため
# 4. クラスメソッドを定義するため（def self.xxx）

# 1) インスタンスメソッド内の self は「そのメソッドを呼び出したオブジェクト（インスタンス）」です。
#    つまり @score は self が持つ状態（インスタンス変数）です。

#    selfを返すと、メソッドチェーン（obj.m1.m2.m3）ができます。
#    （例：raise_score が self を返すので、連続で呼び出せる）

puts "\n\nオブジェクト中でself : "

class Student1

  attr_reader :score

  def initialize(score)
    @score = score
  end

  def department=(dep)
    @department = dep
  end

  def change(dep)
    department = dep       # local 
    self.department = dep  # setter
  end

  def raise_score # メソッドチェーン
    @score +=10
    self
  end
end

s = Student1.new(60)
s.raise_score.raise_score.raise_score
puts "#{s.score} "

# classの中でのself
# インスタンスメソッド内のselfはそのオブジェクトですけど
# クラスメソッド内のselfはクラス自身です

puts "\n\n \n\nクラス中でself : "

class Student2
  def self.school
    "KNUT"
  end
end

puts Student2.school


# =================================================

## public / private / protected（アクセス修飾子）

# public    : 外部から自由にメソッドを呼び出せる（デフォルト）

# private   : レシーバ（obj. / self.）を付けて呼び出せない
#             クラス内部で「foo」のように暗黙の self でのみ呼べる

# protected : 同じクラス/継承関係の中なら、他のインスタンスに対しても呼び出せる

# 例は継承とsuperで作成します

# =================================================

## 継承とsuper
# 親クラスの機能を子クラスが引き継ぐこと

puts "\n\npublic, private, protected"

class Parent

  private
  def initialize()
    @num = 1
  end

  public
  def public_parent_print()
    puts "親のpublicメソッドです！"
  end

  def num_return()
    @num
  end

  private
  def private_parent_print()
    puts "親のprivateメソッドです！"
  end

  protected
  def protected_parent_print()
    puts "親のprotectedメソッドです！"
  end
end

class Child < Parent # ParentをChildが継承する
  def child_print
    protected_parent_print()
  end
end

parent=Parent.new();
child =Child.new();


# puts "#{parent.num}" 不可能
puts "num : #{parent.num_return()}" #メソッドを使えば可能


child.public_parent_print()
# child.protected_parent_print() クラス外からは呼べない。同じクラス/サブクラスの内部だけOK
# child.private_parent_print() クラス外から呼べない + レシーバ付き呼び出し不可
child.child_print() # これは可能です

# initializeも継承できる！　ただし子クラスがinitializeを作らない場合

## super
# super は 子クラス から 親クラスの同名メソッド を呼び出すために使います。
# 特に initialize（コンストラクタ）でよく使います

# super       引数をそのまま渡す
# super()     引数なし
# super(x,y)  指定して渡す

puts "\n\n super"

# superの3パターンまとめ
# superの3パターンまとめ（エラー修正版）

class Parent1
  def initialize(name, age)
    @name = name
    @age  = age
  end

  def info(prefix)
    puts "#{prefix} Parent: name=#{@name}, age=#{@age}"
  end

  def greet
    puts "Parent greet (no args)"
  end
end

class Child1 < Parent1
  # (3) super(x, y) : 引数を指定して渡す（←ここが重要）
  def initialize(name, age, department)
    @department = department
    super(name, age)  # 親は2引数なので、ここで明示する
  end

  # (1) super : 引数をそのまま渡す（このメソッドの引数は1個なのでOK）
  def info(prefix)
    super            # super(prefix) と同じ
    puts "#{prefix} Child extra: dept=#{@department}"
  end

  # (2) super() : 引数なしで呼ぶ
  def greet(msg)
    puts "Child greet got msg=#{msg}"
    super()          # 親の greet を引数なしで呼ぶ
  end
end

c = Child1.new("Sato", 20, "CS")
c.info("[INFO]")

puts "\n--- greet ---"
c.greet("hey!")

# ===================================================================

## 「オーバーライド」と「オーバーライディング」
# override   : 親のメソッドを子クラスで上書きすること
# overriding : その「上書きしている行為」(同じ意味で使われることが多い)

# オーバーライド（override）の例
# 子クラスで親クラスのメソッドを同じ名前で再定義する

puts "\n\nオーバーライド」と「オーバーライディング"
class Parent2
  def greet
    puts "Parent: こんにちは"
  end

  def info(name)
    puts "Parent info: name=#{name}"
  end
end

class Child2 < Parent2
  # 親の greet をオーバーライド
  def greet
    puts "Child: やあ！"
  end

  # super を使って親の処理も活かす（拡張パターン）
  def info(name)
    super(name)                 # 親の info を呼ぶ
    puts "Child info: extra!"   # 追加の処理
  end
end

p = Parent2.new
c = Child2.new

p.greet          # Parent版
c.greet          # Child版（オーバーライド）

p.info("Sato")
c.info("Sato")   # 親の処理 + 子の処理

# もし親と子のメソッドの名前が同じならこの方が優先されます

# =============================================================


## is_a? / kind_of? / instance_of?
# is_a? / kind_of?は継承を含めて「その型の系統か？」を判定する
# 二つはほぼ同じです
# instance_of?は継承は含めず「ちょうどそのクラスのインスタンスか？」だけ判定する
## superclass :継承構造を確認


# =============================================================
# is_a? / kind_of? / instance_of? の例

class Person
end

class Student3 < Person
end

p1 = Person.new
s1 = Student3.new

puts "\n\nis_a? / kind_of? / instance_of? の例"
puts "s1.is_a?(Person)        : #{s1.is_a?(Person)}"        # true（継承を含む）
puts "s1.kind_of?(Person)     : #{s1.kind_of?(Person)}"     # true（is_a? とほぼ同じ）
puts "s1.instance_of?(Person) : #{s1.instance_of?(Person)}" # false（ちょうどそのクラスのみ）

puts "p1.is_a?(Person)        : #{p1.is_a?(Person)}"        # true
puts "p1.instance_of?(Person) : #{p1.instance_of?(Person)}" # true

# =============================================================
# superclass（継承構造を確認）の例

puts "\n\nsuperclass の例"
puts "Student.superclass : #{Student3.superclass}"  # Person
puts "Person.superclass  : #{Person.superclass}"   # Object
puts "Object.superclass  : #{Object.superclass}"   # BasicObject
puts "BasicObject.superclass : #{BasicObject.superclass.inspect}" # nil（最上位）

# (おまけ) 継承チェーンを辿る例
puts "\n継承チェーンを辿る例（while）"
k = Student
while k
  puts k
  k = k.superclass
end

