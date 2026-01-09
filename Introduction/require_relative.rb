# require_relativeの説明ファイルです

#　== require_relativeとは？==

# 現在のファイルの位置を基準として
# 相対パスで別のRubyファイルを読み込むための命令です。

# ファイルを分割して管理しやすくします（クラスとかモジュールを別のファイルに分ける）

# == requireとは？ == 

# Rubyが用意している「読み込み命令」で、別のRubyファイルやライブラリを読み込みます。
# 主に標準ライブラリ（例: set, json）や gem（外部ライブラリ）を使うときに使います。

# require は $LOAD_PATH（ライブラリ検索パス）からファイルを探して読み込みます。

# 注意：
# - require / require_relative は「同じファイルを2回目以降は読み込まない」（一度だけロード）
# - 毎回読み直したい場合は load を使う（デバッグ用途など）

# このファイルでは ./files/greet.rb　と　./files/math_tools.rbを使います

# tip : 読む時、　「.rb」は省略可能です
#       ..は上位フォルダです
# 読み込むファイルには、通常 class / module などを定義して使います（処理だけ書いてもOK）


require_relative "./files/greet"
require_relative "./files/math_tools"

# require_relative File.join(__dir__, "files", "greet")
# require_relative File.join(__dir__, "files", "math_tools") 
# __dir__はrequire_relativeがあるフォルダの位置基準にします　＝＞おすすめ

puts "\n--- require_relative demo ---"

# Greetモジュールの利用（モジュール名::メソッド）
puts Greet.hello("Minseok")          # => "Hello, Minseok!"

# MathToolsモジュールの利用
puts MathTools.pow(2, 10)            # => 1024

# 変数に入れて使う例
msg = Greet.hello("Sato")
pow = MathTools.pow(3, 4)
puts "msg = #{msg}"
puts "3^4 = #{pow}"


# requireは標準ライブラリやgemを読み込むときに使います（$LOAD_PATHから探す）

require "set"
require "json"

s = Set.new([1, 2, 2, 3])
p s.to_a                 # => [1, 2, 3]

data = { name: "Sato", id: 251111 }
json = JSON.generate(data)
puts json                # => {"name":"Sato","id":251111}

# gemを使う場合：先に `gem install xxx` してから require します

# 例：colorize というgem（入ってないと LoadError になります）
# require "colorize"
# puts "Hello".colorize(:green)

load File.join(__dir__, "files", "greet.rb")  # 毎回読み直す
load File.join(__dir__, "files", "greet.rb")  # 2回目も実行される
