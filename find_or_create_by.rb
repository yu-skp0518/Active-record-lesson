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


#find_or_create_by
## - 抽出しても該当のレコードが見つからない場合、
##   検索条件の内容でレコードを作成する

# user = User.find_or_create_by(:name => "hayashi")
# pp user

# #この内容だと抽出後レコードは作成されるがnameカラムしか埋まらず他はnilが入る
# user = User.find_or_create_by(:name => "yokota")
# pp user

#name以外のカラムも埋めるためにブロックを使用する
user = User.find_or_create_by(:name => "yokota") do |u|
  u.age = 18
end
pp user
