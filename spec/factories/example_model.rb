class ExampleModel
  include EasyDecorator

  DATETIME_FORMAT = '%h:%m %Y'
  MONEY_FORMAT = '%.2f'

  attr_writer :name, :date, :price, :create_at_timestamp, :description

  decorate :name, length: 3, position: 1
  decorate :description, length: 200, position: :last
  decorate :create_at_timestamp, format: DATETIME_FORMAT, type: :timestamp, length: 5, position: 3
  decorate :date, format: DATETIME_FORMAT, type: :date, length: 5, position: 2
  decorate :price, format: MONEY_FORMAT, delimiter: ',', type: :money, length: 4, position: 4

  def initialize(name:, date:, price:, create_at_timestamp:, description:)
    self.name = name
    self.date = date
    self.price = price
    self.create_at_timestamp = create_at_timestamp
    self.description = description
  end
end
