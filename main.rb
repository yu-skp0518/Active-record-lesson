#Active Recordを読み込ませる
require 'active_record'

#オブジェクトをわかりやすく表現してくれるRubyのライブラリ(pretty print)
require 'pp'
require 'active_support/all'

#ActiveRecordを使用して実際にどういったSQLが発行されているのか確認するためのツール
require 'logger'

#タイムゾーンを指定する
Time.zone_default = Time.find_zone! 'Tokyo'
ActiveRecord::Base.default_timezone = :local

#loggerを読み込むための記述。(STDOUTは出力先の指定。STDOUT = standard outは標準出力のこと)
ActiveRecord::Base.logger = Logger.new(STDOUT)

#dbに接続するための設定
ActiveRecord::Base.establish_connection(
  #sqliteの場合ユーザー名やパスワードは不要
  "adapter" => "sqlite3",
  "database" => "./myapp.db"
  )

#usersテーブルをオブジェクトに結びつける
# - オブジェクトの名前は規約により、最初が大文字の単数系の単語
# - このように書くことでusersテーブルのレコードをUserクラスのインスタンスをして扱えるようになった
class User < ActiveRecord::Base
end

# --------------------------------------------------

## insert_1
# usersテーブルのレコードはUserクラスのインスタンスとして扱えるようになったので、レコードを作成するために
# user = User.newと書くことができる
  # user = User.new
  # user.name = "tanaka"
  # user.age = 23
  # user.save

  # # user = User.new(:name => "hayashi", :age => 23)
  # user = User.new(name: "hayashi", age: 23) #32行目と同じ意味
  # user.save

  # User.create(name: "hoshi", age: 22)

# --------------------------------------------------

## insert_2
# user = User.new do |u|
#   u.name = "mochizuki"
#   u.age = 18
# end

# user.save

# --------------------------------------------------

## データの抽出

#毎回データを作成されないようにまずデータを全削除する
User.delete_all

# i = 0
# 5.times do
#   i += 1
#   User.create(id: i, name: "test#{i}", age: "2#{i}".to_i )
# end

# User.create
User.create(name: "tanaka", age: 19)
User.create(name: "takahashi", age: 25)
User.create(name: "hayashi", age: 31)
User.create(name: "mizutani", age: 28)
User.create(name: "otsuka", age: 35)

##データ抽出
# pp User.all
# pp User.select(:id, :name, :age).all
# pp User.select(:id, :name, :age).first
# pp User.select(:id, :name, :age).last

#最初の三件のみ
# pp User.select(:id, :name, :age).first(3)

#idと名前のみ
pp User.select(:id, :name).all