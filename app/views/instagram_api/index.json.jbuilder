json.users do
  json.id 1
  json.found @user_hash[:found]
  json.code @user_hash[:code]
  json.error_message @user_hash[:error_message]
  if !@user_hash[:user].nil?
    json.username @user_hash[:user].try(:username)
  end
  json.photos do
    if !@user_hash[:user].nil?
      json.array! @user_hash[:user][:photos], partial: 'photos/photo', as: :photo
    end
  end
end