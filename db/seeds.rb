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
  title: 'Dayz Standalone - Thug life',
  youtube_id: 'm34lu4UQHak',
  uploader: 'IALT OFFICIAL',
  duration: 72,
  categories: [funny]
},
{
  title: 'DayZ - Scaring People Standalone Edition',
  youtube_id: 'pAYNzq6QRa8',
  uploader: 'BestBudGaming',
  duration: 609,
  categories: [funny]
},
{
  title: 'DayZ [EXP 0.53] - Hands on the new Flaregun',
  youtube_id: 'k7eexbwdSdU',
  uploader: 'Adrian Schdskanalovski',
  duration: 29,
  categories: [showcase]
},
{
  title: '"Ruby" (DayZ Standalone) #51',
  youtube_id: 'qC3X2sq4o0k',
  uploader: 'Silo Entertainment',
  duration: 1142,
  categories: [roleplay, funny]
},
{
  title: 'Mr. Moon: "Maverick" - DayZ Standalone',
  youtube_id: 'HY8mOw7-RT8',
  uploader: 'Mr. Moon',
  duration: 1665,
  categories: [roleplay]
}
  ])