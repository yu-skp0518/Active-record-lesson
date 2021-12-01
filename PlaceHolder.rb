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

## - プレイスホルダー
## - シンボル


min = 20
max = 30

##pp User.select("id, name, age").where("age >= #{min} and age < #{max}") ##絶対にしてはいけない!!!!!
                                                                        #(変数の値を直接条件文字列に入れてしまうと悪意のあるコードが紛れる可能性があるため)
##安全に値を埋め込むにはプレイスホルダーを使う(?)　※プレイスホルダーとは仮のの情報(【例】「〇〇の秋」の〇〇)
pp User.select("id, name, age").where("age >= ? and age < ?", min, max)
##もしくはシンボルを使う(:)
pp User.select("id, name, age").where("age >= :min and age < :max", { min: min, max: max })


## - LIKE(文字列の部分一致) "%i"=>後方一致、"i%"=>前方一致、"%i%"=>部分一致
pp User.select("id, name, age").where("name LIKE ?", "%i")