require_relative 'instance_counter.rb'

class Station
  include InstanceCounter

  NAME_FORMAT = /^[a-zа-я\d]+-?[a-zа-я\d]+$/i.freeze
  NOT_VALID_NAME = 'недопустимое имя'.freeze

  attr_reader :name, :trains

  @@all_stations = []

  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@all_stations << self

    # register_instance
  end

  def add_train(train)
    trains << train
  end

  def trains_by_type(type)
    trains.select { |train| train.type == type }
  end

  def send_train(train)
    trains.delete(train)
  end

  def each_trains
    @trains.each { |train| yield(train) }
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise NOT_VALID_NAME if @name.nil? || @name !~ NAME_FORMAT
  end
end
