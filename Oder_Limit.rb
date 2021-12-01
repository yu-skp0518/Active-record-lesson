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

# # - order

# #年齢順
# pp User.select("id, name, age").order("age")
# pp User.select("id, name, age").order(:age)

# #逆順
# pp User.select("id, name, age").order("age desc")
# pp User.select("id, name, age").order(age: :desc)


# ## - limit

# #limitで3件に絞る
# pp User.select("id, name, age").order(:age).limit(3)
# #offsetで任意のレコードをスキップする
# pp User.select("id, name, age").order(:age).limit(3).offset(1)
