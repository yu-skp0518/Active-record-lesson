require 'active_record'
require 'pp'
require 'active_support/all'
require 'logger'

Time.zone_default = Time.find_zone! 'Tokyo'
ActiveRecord::Base.default_timezone = :local
ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.establish_connection(
  "adapter" => "sqlite3",
  "database" => "./myapp.db"
  )

class User < ActiveRecord::Base
end

## insert_2

user = User.new do |u|
  u.name = "mochizuki"
  u.age = 18
end

user.save