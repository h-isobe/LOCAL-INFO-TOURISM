# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
   name: '佐藤',
   email: 'a@a',
   password: '111111',
   introduction: 'よろしくです'
)

User.create!(
   name: '鈴木',
   email: 'b@b',
   password: '222222',
   introduction: 'よろしくです'
)

User.create!(
   name: '高橋',
   email: 'c@c',
   password: '333333',
   introduction: 'よろしくです'
)

User.create!(
   name: '田中',
   email: 'd@d',
   password: '444444',
   introduction: 'よろしくです'
)

User.create!(
   name: '伊藤',
   email: 'e@e',
   password: '555555',
   introduction: 'よろしくです'
)

User.create!(
   name: '渡辺',
   email: 'f@f',
   password: '666666',
   introduction: 'よろしくです'
)

User.create!(
   name: '山本',
   email: 'g@g',
   password: '777777',
   introduction: 'よろしくです'
)

User.create!(
   name: '小林',
   email: 'h@h',
   password: '888888',
   introduction: 'よろしくです'
)

User.create!(
   name: '加藤',
   email: 'i@i',
   password: '999999',
   introduction: 'よろしくです'
)

Category.create!(
  name: 'グルメ'
)

Category.create!(
  name: '観光'
)

Category.create!(
   name: 'レジャー'
)

Category.create!(
  name: '服装'
)

Category.create!(
  name: 'お土産'
)

Category.create!(
  name: 'その他'
)

