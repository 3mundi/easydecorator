class Timestamp

  def self.decorate(value, format)
    return '' if value.nil?
    time = Time.zone.at(value.to_i)
    time.strftime(format).to_s
  end
end
