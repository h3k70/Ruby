require_relative 'instance_counter.rb'

class Station

  include InstanceCounter

  @@all_stations = []

  def self.all
    @@all_stations
  end


  attr_reader :name, :trains

  def initialize(name)
    @name = name
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
end
