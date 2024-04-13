require 'uri'
require 'net/http'

module ApiOrderService
  def self.get_order_status(url, body)
    uri = URI.parse(url + '?' + body.collect {|k, v| "#{k}=#{v}"}.join('&'))
    begin
      str = Net::HTTP.get_response(uri)
    rescue => exception
      return {"status" => '500', "message" => 'Cannot get order status'}
    end
    return JSON.parse(str.body)
  end

  def self.send_order(method, url, body)
    case method
    when 'GET'
      send_get_request(url, body)
    when 'POST'
      send_post_request(url, body)
    end
  end

  private

  def self.send_get_request(url, body)
    uri = URI.parse(url + '?' + body.collect {|k, v| "#{k}=#{v}"}.join('&'))
    begin
      str = Net::HTTP.get_response(uri)
    rescue => exception
      return {"status" => '500', "message" => 'Error in sending request to API (GET Request Error)'}
    end
    return JSON.parse(str.body)
  end

  def self.send_post_request(url, body)
    uri = URI.parse(url)
    begin
      str = Net::HTTP.post_form(uri, body)
    rescue => exception
      return {"status" => '500', "message" => 'Error in sending request to API (POST Request Error)'}
    end
    return JSON.parse(str.body)
  end

end