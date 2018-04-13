require 'rspec'
require 'byebug'
require_relative '../lib/easy_decorator'
require_relative 'factories/example_model'

describe EasyDecorator do

  it 'decorate model' do
    example_model = ExampleModel.new(
      name: 'Name',
      date: DateTime.new(1981,4,16),
      price: 1990,
      create_at_timestamp: 356245200,
      description: 'Long Description'
    )
  end
end