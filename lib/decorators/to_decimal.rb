module EasyDecorator
  class ToDecimal

    def self.decorate(value, format, delimiter)
      return '0' if value.nil?
      value = value.to_f / 100
      format(format, value).gsub '.', delimiter
    end
  end
end
