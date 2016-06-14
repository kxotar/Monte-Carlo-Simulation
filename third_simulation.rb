require 'rubygems'
require 'csv'
require 'restroom'
max_frequency = 5
max_num_of_restrooms = 1..4
facilities_per_restroom = 3
max_use_duration = 1
population_range = 10..600
max_num_of_restrooms.each do |num_of_restrooms|
      data = {}
      population_range.step(10).each do |population_size|
            Person.population.clear
            population_size.times { Person.population << Person.new(rand(max_frequency)+1,
                                                                    rand(max_use_duration)+1) }
            data[population_size] = []
            restrooms = []
            num_of_restrooms.times {restrooms << Restroom.new(facilities_per_restroom)}
            DURATION.times do |t|
                  data[population_size] << restrooms.inject(0) {|n,m| n + m.queue.size }
                  restrooms.each {|restroom|
                        queue = restroom.queue.clone
                        restroom.queue.clear
                        unless queue.empty?
                              restroom.enter queue.shift
                        end
                  }
                  Person.population.each do |person|
                        person.frequency = (t > 270 and t < 390) ? 12 : rand(max_frequency)+1
                        if person.need_to_go?
                              restroom = restrooms.min {|a,b| a.queue.size <=> b.queue.size}
                              restroom.enter person
                        end
                  end
                  restrooms.each {|restroom| restroom.tick }
            end
      end
      CSV.open("simulation3-#{num_of_restrooms}.csv", 'w') do |csv|
            lbl = []
            population_range.step(10).each {|population_size| lbl << population_size }
            csv << lbl
            DURATION.times do |t|
                  row = []
                  population_range.step(10).each do |population_size|
                        row << data[population_size][t]
                  end
                  csv << row
            end
      end
end