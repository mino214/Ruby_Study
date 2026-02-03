## 始める前に
macOS環境でRuby on Railsを使います。  
WindowsやLinuxでは手順が異なる場合があります。


## Railsのインストール
Rubyのバージョンマネージャーは、一般的に **mise / rbenv / asdf** が使われます。  
今回はmacOS環境なので、このプロジェクトでは **rbenv** を使います。

### ターミナルで
```bash
# Homebrewとrbenvがインストール済みであることを前提とします。
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
bin/rails db:prepare 
bin/rails s
```

---
### Rails 公式サイト
### [ruby on rails 公式サイト](https://rubyonrails.org/)
