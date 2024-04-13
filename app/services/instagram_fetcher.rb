require 'net/http'
module InstagramFetcher

  ROI_START = '<script type="text/javascript">window._sharedData ='
  ROI_END = ';</script>'
  ROOT = 'https://www.instagram.com/'
  IMAGE_ROOT = ROOT + 'p/'

  def self.get_user_hash(username)
    url = ROOT + username + '/'
    user_hash = {}
    # response = fetch(url)
    response = request_page(url)
    if response == 'error'
      user_hash[:found] = false
      user_hash[:code] = '1' # error in connection
      user_hash[:error_message] = I18n.t('instagram.connection_error')
    else
      user_hash[:found] = true
      user_hash[:code] = '0' # success
      user_hash[:error_message] = ''
      user = {}
      user[:id] = 1
      response_hash = extract_hash(response, ROI_START, ROI_END)
      if response_hash['entry_data'].empty? || response_hash['entry_data'].include?('HttpErrorPage')
        user_hash[:found] = false
        user_hash[:code] = '2' # invalid username
        user_hash[:error_message] = I18n.t('instagram.invalid_username')
      else
        user[:username] = response_hash['entry_data']['ProfilePage'][0]['graphql']['user']['username']
        # user[:followed_by] = response_hash['entry_data']['ProfilePage'][0]['graphql']['user']["followed_by"]["count"]     # removed because instagram changed the response
        photos = extract_photos_hash(response_hash)
        user[:photos] = photos
        user_hash[:user] = user
      end
    end
    user_hash
  end

  private

  def self.fetch(uri_str, limit = 10)
    # You should choose a better exception.
    return 'error' if limit == 0

    response = Net::HTTP.get_response(URI(uri_str))

    # RESPONSES << response

    case response
    when Net::HTTPSuccess then
      response.body
    when Net::HTTPRedirection then
      location = response['location']
      # warn "redirected to #{location}"
      fetch(location, limit - 1)
    else
      response.value
    end
  end

  def self.request_page(url)
    uri = URI(url)
    begin
      Net::HTTP.get(uri)
    rescue
      'error'
    end
  end

  def self.extract_hash(response, start_roi, end_roi)
    if response.index(start_roi).nil?
      {'entry_data' => []}
    else
      start_pos = response.index(start_roi) + start_roi.length
      end_pos = response.index(end_roi)
      JSON.parse(response[start_pos..end_pos].chop!)
    end
  end

  def self.extract_photos_hash(data_hash)
    photos = []
    data_hash['entry_data']['ProfilePage'][0]['graphql']['user']['edge_owner_to_timeline_media']['edges'].each do |node|
      photo = {}
      photo[:image_preview] = node['node']['display_url']
      photo[:link] = IMAGE_ROOT + node['node']['shortcode']
      photo[:created_at] = node['node']['taken_at_timestamp']
      photo[:is_video] = node['node']['is_video']
      photos.push photo
    end
    photos
  end
end