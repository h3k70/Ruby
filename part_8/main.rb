require_relative "railway.rb"
require_relative "station.rb"
require_relative "route.rb"
require_relative "train.rb"
require_relative "cargo_train.rb"
require_relative "passenger_train.rb"
require_relative "wagon.rb"
require_relative "cargo_wagon.rb"
require_relative "passenger_wagon.rb"

class Main

  ACTIONS = [
    "Создать станцию",
    "Создать поезд",
    "Создать маршрут",
    "Назначаить маршрут поезду",
    "Добавить станцию в маршрут",
    "Удалить станцию из маршрута",
    "Создать вагон",
    "Прицепить вагон к поезду",
    "Отцепить вагон от поезда",
    "Переместить поезд по маршруту вперед",
    "Переместить поезд по маршруту назад",
    "Вывести список станций",
    "Вывести список поездов на станции",
    "Вывести список вагонов поезда",
    "Заполнить вагон",
  ]

  def run(railway)
    loop do
      ACTIONS.each.with_index(1) do |action, index|
        puts "#{index}. #{action}"
      end

      puts
      puts "Введите цифру действия от 1 до 15"
      puts "(0 - Выход)"

      user_choice = gets.to_i

      case user_choice
      when 1 then railway.create_station
      when 2 then railway.create_train
      when 3 then railway.create_route
      when 4 then railway.assign_route
      when 5 then railway.add_station
      when 6 then railway.remove_station
      when 7 then railway.create_wagon
      when 8 then railway.hook_wagon
      when 9 then railway.unhook_wagon
      when 10 then railway.train_forward
      when 11 then railway.train_backwards
      when 12 then railway.stations_list
      when 13 then railway.trains_list
      when 14 then railway.wagon_list
      when 15 then railway.wagon_stuff
      end

      break if user_choice == 0
    end
  end
end

main = Main.new
railway = Railway.new

main.run(railway)
