json.users do
  json.id 1
  json.found @client[:found]
  json.code @client[:code]
  json.error_message @client[:error_message]
  if !@client[:user].nil?
    json.username @client[:user].try(:username)
  end
  json.photos do
    if !@client[:user].nil?
      json.array! @client[:user][:photos], partial: 'photos/photo', as: :photo
    end
  end
end