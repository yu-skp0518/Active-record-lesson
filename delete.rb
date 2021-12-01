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

# delete: 単機能だけど高速(レコードを削除するだけ)
# - delete 一件削除
# - delete_all 全件削除

# destroy: 高機能だけど低速(関連するオブジェクトを考慮したり削除する前後でなんらかの自動処理を加えることができる)
# - destroy 一件削除
# - destroy_all 全件削除


# User.delete(1)
# User.where("age >= 25").delete_all

pp User.all