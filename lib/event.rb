class Event
  attr_reader :name, :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map { |food_truck| food_truck.name }
  end

  def food_trucks_that_sell(item)
    @food_trucks.select { |food_truck| food_truck.check_stock(item) > 0 }
  end

  def total_inventory
    result = {}
    @food_trucks.each do |food_truck|
      food_truck.inventory.each do |item, quantity|
        result[item] = {quantity: 0, food_trucks: []} if result[item].nil?
        result[item][:quantity] += quantity
        result[item][:food_trucks] << food_truck
      end
    end
    result
  end

  def overstocked_items
    overstocked_item = []
     total_inventory.each do |item, food_truck|
       if food_truck[:quantity] > 50 && food_truck[:food_trucks].length > 1
         overstocked_item << item
       end
     end
    overstocked_item
  end

  def sorted_item_list
    sorted_items = []
    total_inventory.each do |item, food_truck|
      sorted_items << item.name
    end
    sorted_items.sort
  end


end
