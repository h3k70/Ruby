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
    @trains = []
    @@all_stations << self
    valid!
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

  def valid?
    valid!
    return true
    rescue
    return false
  end

  protected

  def valid!
    raise NOT_VALID_NAME if @name.nil? || @name !~ NAME_FORMAT
  end
end
