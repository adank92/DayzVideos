# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Video.destroy_all
Category.destroy_all

funny = Category.create!( name: 'Funny' )
gunfights = Category.create!( name: 'Gunfights' )
showcase = Category.create!( name: 'Showcase' )
roleplay = Category.create!( name: 'Roleplay' )

Video.create!([
{
  youtube_id: 'm34lu4UQHak',
  categories: [funny]
},
{
  youtube_id: 'pAYNzq6QRa8',
  categories: [funny]
},
{
  youtube_id: 'k7eexbwdSdU',
  categories: [showcase]
},
{
  youtube_id: 'qC3X2sq4o0k',
  categories: [roleplay, funny]
},
{
  youtube_id: 'HY8mOw7-RT8',
  categories: [roleplay, gunfights]
}
  ])