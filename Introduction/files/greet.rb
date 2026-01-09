# require_relativeで使うファイルです
puts "[loaded] greet.rb"
module Greet
  def self.hello(name)
    "Hello, #{name}!"
  end
end