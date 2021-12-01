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

# pp User.all

## - update(高機能だけど低速[validationなども付け加えることもできるがupdate_allはそれができない])

# #idで抽出して更新する場合
# User.update(1, age: 50)
# pp User.select("id, name, age").all

# #id以外の条件で抽出する場合
# User.where(name: "tanaka").update(age: 60)
# pp User.select("id, name, age").all

# #複数のフィールドで変更をかけたい場合(年齢と名前を変更)
# User.where(name: "tanaka").update(age: 70, name: "taguchi")
# pp User.select("id, name, age").all

# #複数のレコードを同時に修正する場合
# User.where("age >= 20").update(age: 80)
# pp User.select("id, name, age").all


## - update_all(低機能だけど高速)

User.where("age >= 20").update_all("age = age + 2")
pp User.select("id, name, age").all