module TokenGenerator

  TOKEN_LENGTH = 12

  def self.generate_token(model_name, attr_name)
    o = [('a'..'z'), (0..9), ('A'..'Z')].map {|i| i.to_a}.flatten
    token = nil
    loop do
      token = (0...TOKEN_LENGTH).map {o[rand(o.length)]}.join
      break if is_unique(token, attr_name, model_name)
    end
    return token
  end

  private

  def self.is_unique(token, attr_name, model_name)
    model = Object.const_get model_name
    obj = model.find_by(attr_name.to_sym => token)
    if obj.nil?
      return true
    else
      return false
    end
  end
end