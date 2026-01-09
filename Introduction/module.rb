# moduleについての説明ファイルです

## moduleとは？
# moduleはよく使うメソッド、定数などの機能をまとめる単位です
# moduleを使う目的は次のように説明できます
# 1. 再利用
# 2. 多重継承のかわり
# 3. 名前空間(namespace) => 名前の衝突を防ぐ用途にも使います。

# Javaのinterfaceに似てますね
# でも少し違いますので注意

# moduleに使う三つのことを調べましょう

# 1. mixin
# mixinは概念的なもので、モジュールの機能をクラスに混ぜることです

# 2. include 
# 命令でmixinを実際にやるためのキーワードです
# インスタンスメソッドとして混ぜることです（インスタンスが呼べるメソッドが増える）

# 3. extend
# これも命令で、モデルをクラスメソッドとして混ぜることです（クラス自体が呼べるメソッドが増える）

#　つまり　include = インスタンスメソッドが使う、　extend　= クラスメソッドが使う

puts "モジュールのinclude例 "
module Walkable
  def walk
    puts "#{@name}は歩く"
  end
end

module Swimmable
  def swim
    puts "#{@name}は泳ぐ"
  end
end
class Animal
  def initialize(name)
    @name = name
  end
end

class Duck < Animal
  include Walkable
  include Swimmable
end

d = Duck.new("Donald")
d.walk
d.swim

# ================================= extend

puts "\n\n モジュールのextend例1"
module Walkable1
  def walk(name)
    puts "#{name}は歩く"
  end
end

module Swimmable1
  def swim(name)
    puts "#{name}は泳ぐ"
  end
end

class Duck1
  extend Walkable1
  extend Swimmable1
end

Duck1.walk("Donald_extend")
Duck1.swim("Donald_extend")

puts "\n\n モジュールのextend例2"
module Walkable2
  def set_name(name)
    @name = name # @もできます
  end            # extend では @name は クラスのインスタンス変数（クラス側の@name） になる

  def walk
    puts "#{@name}は歩く"
  end
end

class Duck2
  extend Walkable2
end

Duck2.set_name("ClassDonald")
Duck2.walk

# extend は「クラスにメソッドを追加」なので、@name は Duck2（クラス自身）の状態になります

# ====================================

# namespaceの例
puts "\n\n モジュールのnamespace例 "
module School
  class Student
    def hello
      puts "School::Studentです"
    end
  end
end

module Game
  class Student
    def hello
      puts "Game::Studentです"
    end
  end
end

School::Student.new.hello
Game::Student.new.hello

# 別ファイルのmoduleを使う時は require_relative で読み込む必要がある