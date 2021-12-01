require 'active_record'
require 'pp'
require 'active_support/all'
require 'logger'

Time.zone_default = Time.find_zone! 'Tokyo'
ActiveRecord::Base.default_timezone = :local
ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.establish_connection(
  "adapter" => "sqlite3",
  "database" => "./myapp.db"
  )

class User < ActiveRecord::Base
end

# insert_1
#usersテーブルのレコードはUserクラスのインスタンスとして扱えるようになったので、レコードを作成するために
#user = User.newと書くことができる

  user = User.new
  user.name = "tanaka"
  user.age = 23
  user.save

  # user = User.new(:name => "hayashi", :age => 23)
  user = User.new(name: "hayashi", age: 23) #32行目と同じ意味
  user.save

  User.create(name: "hoshi", age: 22)