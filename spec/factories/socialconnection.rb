FactoryGirl.define do
  factory :socialconnection do
      user_id     "12"
      uid         "123456789"
      provider    "instagram"
      followers   12002
      following   120
      media_count 12
      bio         "Hi, my name is Sharnie Ivery"
      profile_picture "http://gravatar.com/avatar/dcc62623f0f9cae94252b44f2dc8b19f.png?s=40d=mm"
  end
end