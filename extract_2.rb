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

#nilではなくエラーで返してほしい時はメソッド名の後に!をつける
# pp User.select("id, name, age").find_by_name!("kiriya")