require_relative 'instance_counter.rb'

class Station

  include InstanceCounter

  NAME_FORMAT = /^[a-zа-я\d]+-?[a-zа-я\d]+$/i
  NOT_VALID_NAME = "недопустимое имя"

  @@all_stations = []

  def self.all
    @@all_stations
  end


  attr_reader :name, :trains

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@all_stations << self
    
    #register_instance
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
    return true
  rescue
    return false
  end

  protected

  def validate!
    raise NOT_VALID_NAME if @name.nil? || @name !~ NAME_FORMAT
  end
end
