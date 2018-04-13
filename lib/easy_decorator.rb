module EasyDecorator
  def self.included(base)
    base.extend ClassMethods
  end

  def decorate
    decorated = {}
    attributes_sorted.each do |attr, options|
      value = self.send(attr)
      value = decorate_by_type value, options
      value = self.length(value, options[:length]) if options[:length]
      decorated[attr] = value
    end
    decorated
  end

  def decorate_by_type(value, options)
    case options[:type]
      when :datetime
        value = self.datetime(value, options[:format])
      when :timestamp
        value = self.timestamp(value, options[:format])
      when :money
        value = self.to_decimal(value, options[:format], options[:delimiter])
      else
        value
    end
    value
  end

  # this method just get attributes from the class and her parent direct
  # example: A < B < C, we gets attributes from A and B, but no C
  def attributes
    @attributes ||= begin
      attributes = {}
      attributes = attributes.merge(self.class.try(:attributes) || {})
      attributes = attributes.merge(self.class.superclass.try(:attributes) || {})
      attributes
    end
  end

  def last_position
    attributes.select { |_key, attr| attr[:position] == :last }
  end

  def reject_the_last
    attributes.reject { |_key, attr| attr[:position] == :last }
  end

  def attributes_sorted
    attributes = reject_the_last.sort_by { |_key, value| value[:position] }
    attributes += last_position.to_a
    attributes
  end

  def length(value, length)
    value = '' if value.nil?
    value.to_s.ljust(length, ' ')[0, length]
  end

  def timestamp(value, format)
    return '' if value.nil?
    time = Time.zone.at(value.to_i)
    time.strftime(format).to_s
  end

  def datetime(value, format)
    return '' if value.nil?
    value.strftime(format).to_s
  end

  def to_decimal(value, format, delimiter)
    return '0' if value.nil?
    value = value.to_f / 100
    format(format, value).gsub '.', delimiter
  end

  module ClassMethods
    attr_accessor :attributes
    OPTIONS_ALLOWED = %i[length format type delimiter position]

    def decorate(association, options = {})
      raise 'Invalid Options' unless options.keys.all? { |option| OPTIONS_ALLOWED.include? option }
      self.attributes ||= {}
      self.attributes[association] = options
    end
  end
end
