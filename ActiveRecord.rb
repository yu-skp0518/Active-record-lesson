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
# class User < ActiveRecord::Base
# end
