client_record = client.client_record
json.id client.id
json.net client_record.total_net
json.paid client_record.total_paid
json.first_name client.try :first_name
json.last_name client.try :last_name
json.country client.try :country
json.state client.try :state
json.city client.try :city
json.orders_count client_record.orders_count
json.email client.try :email
json.labels ['likes', 'followers', 'video_views', 'comments', 'custom_comments']
json.values [client_record.likes, client_record.followers, client_record.video_views, client_record.comments, client_record.custom_comments]
json.last_activity client.last_activity