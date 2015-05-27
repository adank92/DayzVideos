# Fresh data
Category.destroy_all
User.destroy_all
Video.destroy_all

# Users
admin = User.create!( name: 'Admin', 
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
videos = [
          {
            youtube_id: 'm34lu4UQHak',
            categories: [funny],
            user: admin,
            active: true
          },
          {
            youtube_id: 'pAYNzq6QRa8',
            categories: [funny],
            user: admin,
            active: true
          },
          {
            youtube_id: 'k7eexbwdSdU',
            categories: [showcase],
            user: admin,
            active: true
          },
          {
            youtube_id: 'qC3X2sq4o0k',
            categories: [roleplay, funny],
            user: admin,
            active: true
          },
          {
            youtube_id: 'HY8mOw7-RT8',
            categories: [roleplay, gunfights],
            user: admin,
            active: true
          },
          {
            youtube_id: '7A-IuZurCQ0',
            categories: [roleplay, gunfights],
            user: admin,
            active: true
          },
          {
            youtube_id: 'WVvAacB0JtY',
            categories: [roleplay, gunfights],
            user: admin,
            active: true
          },
          {
            youtube_id: 'OA4GAvVWfPA',
            categories: [roleplay, gunfights],
            user: admin,
            active: true
          },
          {
            youtube_id: 'OmEsMATd-oE',
            categories: [roleplay, gunfights],
            user: admin,
            active: true
          },
          {
            youtube_id: 'Td3Re0a-Ay0',
            categories: [roleplay, gunfights],
            user: admin,
            active: true
          },
          {
            youtube_id: 'pM7aJ-h0Mi8',
            categories: [roleplay, gunfights],
            user: admin,
            active: true
          },
          {
            youtube_id: 'XzK2b_vRgWA',
            categories: [roleplay, gunfights],
            user: admin,
            active: true
          },
          {
            youtube_id: 'j8_CB49FrKM',
            categories: [roleplay, gunfights],
            user: admin,
            active: true
          },
          {
            youtube_id: 'YQOtvQ2AvOA',
            categories: [roleplay, gunfights],
            user: admin,
            active: true
          },
          {
            youtube_id: 'i_3w8aEE8Mc',
            categories: [roleplay, gunfights],
            user: admin,
            active: true
          },
          {
            youtube_id: 'n5tuZK42xZQ',
            categories: [roleplay, gunfights],
            user: admin,
            active: true
          },
          {
            youtube_id: 'mqBlzoCDVPE',
            categories: [roleplay, gunfights],
            user: admin,
            active: true
          },
          {
            youtube_id: 'kLxwKAVx8-A',
            categories: [roleplay, gunfights],
            user: admin,
            active: true
          },
          {
            youtube_id: 'k4UNVDbZHlA',
            categories: [roleplay, gunfights],
            user: admin,
            active: true
          },
          {
            youtube_id: 'x-EfqmYVXZw',
            categories: [roleplay, gunfights],
            user: admin,
            active: true
          },
          {
            youtube_id: 'ncxVaYjUatg',
            categories: [roleplay, gunfights],
            user: admin,
            active: true
          },
          {
            youtube_id: 'FpASiIqasIk',
            categories: [roleplay, gunfights],
            user: admin,
            active: true
          },
          {
            youtube_id: 'UvLJwi69Q9Q',
            categories: [roleplay, gunfights],
            user: admin,
            active: false
          },
          {
            youtube_id: 'uFpV7OKEUIg',
            categories: [roleplay, gunfights],
            user: admin,
            active: false
          }
        ]

videos.each do |v|
  video = Video.new(v)
  video.save!
end
