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
# User.delete_all

# i = 0
# 5.times do
#   i += 1
#   User.create(id: i, name: "test#{i}", age: "2#{i}".to_i )
# end

# User.create
# User.create(name: "tanaka", age: 19)
# User.create(name: "takahashi", age: 25)
# User.create(name: "hayashi", age: 31)
# User.create(name: "mizutani", age: 28)
# User.create(name: "otsuka", age: 35)

# --------------------------------------------------

##データ抽出_1
## - select

# pp User.all
# pp User.select(:id, :name, :age).all
# pp User.select(:id, :name, :age).first
# pp User.select(:id, :name, :age).last

#最初の三件のみ
# pp User.select(:id, :name, :age).first(3)

#idと名前のみ
# pp User.select(:id, :name, :age).all

# --------------------------------------------------

##データ抽出_2
## - find

#findメソッドはidで探す場合のみ
# pp User.find(3)

#さらにフィールドを指定したい場合はselectメソッド(:id, :name, :age)のような書き方もできる
# pp User.select("id, name, age").find(3)

#idではなく他の値で検索したい場合はfind_byメソッドを使う(find_byの後にはfind_by_nameのようにカラム名を続けても使用することができる)
#下の4行は全て同じ実行結果になる
# pp User.select("id, name, age").find_by(name: "tanaka")
# pp User.select("id, name, age").find_by name: "tanaka" #Rubyでは括弧を省略することもできる
# pp User.select("id, name, age").find_by_name "tanaka" #find_by_nameのようにカラム名をつなげて使用することもできる
# pp User.select("id, name, age").find_by_name("tanaka")

#存在しないレコードを抽出した場合
# pp User.select("id, name, age").find_by_name("kiriya")
# #nilではなくエラーで返してほしい時はメソッド名の後に!をつける
# pp User.select("id, name, age").find_by_name!("kiriya")

# --------------------------------------------------

##データ抽出_3
## - where

#20代のレコード
# pp User.select("id, name, age").where(age: 20..29)
#値をピンポイントで指定することもできる
# pp User.select("id, name, age").where(age: [19, 31])


## - AND (whereを繋いで使用する)

# pp User.select("id, name, age").where("age >= 20").where("age < 30")
# #もしくは括弧内でandを使う
# pp User.select("id, name, age").where("age >= 20 and age < 30")


## - OR (whereを繋いで使用する)
#括弧内でorを使う
# pp User.select("id, name, age").where("age <= 20 or age >= 30")
# #もしくはorメソッドとして使用する(その際はor以下に同じ構造を持たなければいけない)
# pp User.select("id, name, age").where("age <= 20").or(User.select("id, name, age").where("age >= 30"))
# #またはselectメソッドを文末にもってくる
# pp User.where("age <= 20").or(User.where("age >= 30")).select("id, name, age")


# ## - NOT("ではない"を検索)
# pp User.select("id, name, age").where.not(id: 3)

# --------------------------------------------------

# ## - プレイスホルダー
# ## - シンボル


# min = 20
# max = 30

# pp User.select("id, name, age").where("age >= #{min} and age < #{max}") ##絶対にしてはいけない!!!!!
                                                                        ##(変数の値を直接条件文字列に入れてしまうと悪意のあるコードが紛れる可能性があるため)
#安全に値を埋め込むにはプレイスホルダーを使う(?)　※プレイスホルダーとは仮のの情報(【例】「〇〇の秋」の〇〇)
# pp User.select("id, name, age").where("age >= ? and age < ?", min, max)
# #もしくはシンボルを使う(:)
# pp User.select("id, name, age").where("age >= :min and age < :max", { min: min, max: max })


# ## - LIKE(文字列の部分一致) "%i"=>後方一致、"i%"=>前方一致、"%i%"=>部分一致
# pp User.select("id, name, age").where("name LIKE ?", "%i")

# --------------------------------------------------

## - order

#年齢順
# pp User.select("id, name, age").order("age")
# pp User.select("id, name, age").order(:age)

#逆順
# pp User.select("id, name, age").order("age desc")
# pp User.select("id, name, age").order(age: :desc)


# ## - limit

# #limitで3件に絞る
# pp User.select("id, name, age").order(:age).limit(3)
# #offsetで任意のレコードをスキップする
# pp User.select("id, name, age").order(:age).limit(3).offset(1)

# --------------------------------------------------

## - class method
## - scope


# class User < ActiveRecord::Base
  #class method
  # def self.top3
  #   select("id, name, age").order(:age).limit(3)
  # end

  #class method(引数を受ける場合)
  # def self.top(num)
  #   select("id, name, age").order(:age).limit(num)
  # end


  #scope
  # scope :top3, -> { select("id, name, age").order(:age).limit(3) }

  #scope(引数を受ける場合)
  # scope :top, ->(num) { select("id, name, age").order(:age).limit(num) }
# end

# User.delete_all

# User.create(name: "tanaka", age: 19)
# User.create(name: "takahashi", age: 25)
# User.create(name: "hayashi", age: 31)
# User.create(name: "mizutani", age: 28)
# User.create(name: "otsuka", age: 35)

# pp User.all

# # pp User.top3

# #引数を使う場合
# pp User.top(2)


# --------------------------------------------------

# これ以降は冗長になってきたのでファイルを分けました。

# --------------------------------------------------