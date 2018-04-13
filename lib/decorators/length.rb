module EasyDecorator
  class Length

    def self.decorate(value, length)
      value = '' if value.nil?
      value.to_s.ljust(length, ' ')[0, length]
    end
  end
end
