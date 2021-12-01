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

## データの抽出

#毎回データを作成されないようにまずデータを全削除する
User.delete_all

i = 0
5.times do
  i += 1
  User.create(id: i, name: "test#{i}", age: "2#{i}".to_i )
end

User.create(name: "tanaka", age: 19)
User.create(name: "takahashi", age: 25)
User.create(name: "hayashi", age: 31)
User.create(name: "mizutani", age: 28)
User.create(name: "otsuka", age: 35)