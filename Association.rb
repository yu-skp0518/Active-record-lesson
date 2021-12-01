require 'active_record'
require 'pp'
require 'active_support/all'

Time.zone_default = Time.find_zone! 'Tokyo'
ActiveRecord::Base.default_timezone = :local
ActiveRecord::Base.establish_connection(
  "adapter" => "sqlite3",
  "database" => "./myapp.db"
  )

## - Association
# User -> Comments

class User < ActiveRecord::Base
  has_many :comments, dependent: :destroy
end

class Comment < ActiveRecord::Base
  belongs_to :user
end

User.delete_all

User.create(name: "tanaka", age: 19)
User.create(name: "takahashi", age: 25)
User.create(name: "hayashi", age: 31)
User.create(name: "mizutani", age: 28)
User.create(name: "otsuka", age: 35)

Comment.delete_all

Comment.create(user_id: 1,body: "hello-1")
Comment.create(user_id: 1,body: "hello-2")
Comment.create(user_id: 2,body: "hello-3")

# ##includesとすることでコメントの情報も一緒に引っ張ってきてくれる
# ##つまり下記はユーザーテーブルからユーザーidが1のもの(と、紐づいたコメント)を引っ張ってくるという内容
# user = User.includes(:comments).find(1)
# # pp user.comments

# user.comments.each do |c|
#   puts "#{user.name}: #{c.body}"
# end

# ##includesとすることでコメントの情報も一緒に引っ張ってきてくれる
# comments = Comment.includes(:user).all
# comments.each do |c|
#   puts "#{c.body} by #{c.user.name}"
# end

# ------------------------------------------------------

User.find(1).destroy
pp Comment.select(:id, :user_id, :body).all