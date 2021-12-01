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
  # validates :name, presence: true
  # validates :age, presence: true
  validates :name, :age, presence: true
  validates :name, length: { minimum: 3 }
end

User.delete_all

User.create(name: "tanaka", age: 19)
User.create(name: "takahashi", age: 25)
User.create(name: "hayashi", age: 31)
User.create(name: "mizutani", age: 28)
User.create(name: "otsuka", age: 35)

## - validation

user = User.new(name: nil, age: nil)
#保存に失敗したらエラーメッセージを出力する
# user.save!

#もし保存が失敗したら
if !user.save
  pp user.errors.messages
end