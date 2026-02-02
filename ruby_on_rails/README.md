## 始める前に
macOS環境でRuby on Railsを使います。
windowsやlinuxでは異なる場合があります。


## Railsの設置
普通ルビィのバージョンマーネジャーは mise, rbenv, asdを使いますが、macOSを使っているので、当プロジェクトにはrbenv使います。

### ターミナルで
``` bash
# homebrewとebenvが設置されるのを前提といます。
gem update --system
gem install bundler
gem install rails
rbenv rehash
rails -v
```

### プロジェクト中での設定
``` bash
cd ~/フォルダ位置
rails new フォルダ名前
cd フォルダ名前
bin/rails s
```