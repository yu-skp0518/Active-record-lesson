require 'active_record'
require 'pp'
require 'active_support/all'

Time.zone_default = Time.find_zone! 'Tokyo'
ActiveRecord::Base.default_timezone = :local
ActiveRecord::Base.establish_connection(
  "adapter" => "sqlite3",
  "database" => "./myapp.db"
  )


## - class method
## - scope

class User < ActiveRecord::Base
  #class method
  # def self.top3
  #   select("id, name, age").order(:age).limit(3)
  # end

  #class method(引数を受ける場合)
  def self.top(num)
    select("id, name, age").order(:age).limit(num)
  end


  ##scope
  # scope :top3, -> { select("id, name, age").order(:age).limit(3) }

  ##scope(引数を受ける場合)
  # scope :top, ->(num) { select("id, name, age").order(:age).limit(num) }
end

User.delete_all

User.create(name: "tanaka", age: 19)
User.create(name: "takahashi", age: 25)
User.create(name: "hayashi", age: 31)
User.create(name: "mizutani", age: 28)
User.create(name: "otsuka", age: 35)

pp User.all


# pp User.top3

#引数を使う場合
pp User.top(2)