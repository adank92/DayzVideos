# Fresh data
Category.destroy_all
User.destroy_all

# Users
User.create!( name: 'Admin', 
              email: 'admin@dayzvideos.com',
              password: 'password',
              password_confirmation: 'password',
              admin: true,
              activated: true,
              activated_at: Time.zone.now )

99.times do |n|
  name = Faker::Name.name
  email = "example#{n}@dayzvideos.com"
  password = 'password'
  User.create!( name: name, 
                email: email, 
                password: password, 
                password_confirmation: password,
                activated: true,
                activated_at: Time.zone.now  )
end

# Categories
funny = Category.create!( name: 'Funny' )
gunfights = Category.create!( name: 'Gunfights' )
showcase = Category.create!( name: 'Showcase' )
roleplay = Category.create!( name: 'Roleplay' )

# Videos
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