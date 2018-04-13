module EasyDecorator
  class DateTime

    def self.decorate(value, format)
      return '' if value.nil?
      value.strftime(format).to_s
    end
  end
end