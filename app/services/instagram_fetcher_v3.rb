require 'net/http'
module InstagramFetcherV3

  Instagram_host = 'https://www.instagram.com/p/'

  URL = 'https://instagram130.p.rapidapi.com/account-feed'
  INSTAJAX_CDN = 'https://cdn.instajax.com'
  ROOT = 'https://www.instagram.com/'
  IMAGE_ROOT = ROOT + 'p/'

  def self.get_user_hash(username)
    user_hash = {}

    url = URI("#{URL}?username=#{username}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-key"] = APP_CONFIG['rapid_api_key']
    request["x-rapidapi-host"] = APP_CONFIG['rapid_api_host']

    response = http.request(request)
    response.read_body

    # url = ROOT + username + '/'
    # user_hash = {}
    # # response = fetch(url)
    # response = request_page(url)
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
      response_hash = extract_hash(response)
      # if response_hash['entry_data'].empty? || response_hash['entry_data'].include?('HttpErrorPage')
      if response.code == "404"
        user_hash[:found] = false
        user_hash[:code] = '2' # invalid username
        user_hash[:error_message] = I18n.t('instagram.invalid_username')
      else
        photos = extract_photos_hash(response_hash)
        user[:photos] = photos
        user_hash[:user] = user
      end
    end
    user_hash
  end

  private

  def self.request_page(url)
    uri = URI(url)
    begin
      Net::HTTP.get(uri)
    rescue
      'error'
    end
  end

  def self.extract_hash(response)
    JSON.parse(response.body)
  end

  def self.extract_photos_hash(data_hash)
    data_hash.map{|node|
      {
        id: node["node"]["shortcode"],
        image_preview: "#{INSTAJAX_CDN}/#{node["node"]["display_url"]}",
        link: "#{Instagram_host}#{node["node"]["shortcode"]}",
        created_at: node["node"]["taken_at_timestamp"],
        is_video: node["node"]["is_video"]
      }
    }
  end
end