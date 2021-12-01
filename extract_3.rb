require 'active_record'
require 'pp'
require 'active_support/all'

Time.zone_default = Time.find_zone! 'Tokyo'
ActiveRecord::Base.default_timezone = :local
ActiveRecord::Base.establish_connection(
  "adapter" => "sqlite3",
  "database" => "./myapp.db"
  )

class User < ActiveRecord::Base
end

User.delete_all

User.create(name: "tanaka", age: 19)
User.create(name: "takahashi", age: 25)
User.create(name: "hayashi", age: 31)
User.create(name: "mizutani", age: 28)
User.create(name: "otsuka", age: 35)

pp User.all

# #データ抽出_3
# # - where

# #20代のレコード
# pp User.select("id, name, age").where(age: 20..29)
# #値をピンポイントで指定することもできる
# pp User.select("id, name, age").where(age: [19, 31])


# # - AND (whereを繋いで使用する)

# pp User.select("id, name, age").where("age >= 20").where("age < 30")
# #もしくは括弧内でandを使う
# pp User.select("id, name, age").where("age >= 20 and age < 30")


# # - OR (whereを繋いで使用する)
# #括弧内でorを使う
# pp User.select("id, name, age").where("age <= 20 or age >= 30")
# #もしくはorメソッドとして使用する(その際はor以下に同じ構造を持たなければいけない)
# pp User.select("id, name, age").where("age <= 20").or(User.select("id, name, age").where("age >= 30"))
# #またはselectメソッドを文末にもってくる
# pp User.where("age <= 20").or(User.where("age >= 30")).select("id, name, age")


## - NOT("ではない"を検索)
# pp User.select("id, name, age").where.not(id: 3)
