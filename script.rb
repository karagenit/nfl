#!/usr/bin/env ruby

require 'descriptive_statistics'
require 'csv'

data = CSV.parse(IO.read("data.csv"), headers: true)

def normalize(array)
  mean = array.mean
  sd = array.standard_deviation
  array = array.clone

  for i in 0...(array.length) do
    array[i] = (array[i].to_i - mean) / sd
  end

  array
end

normYdsG = normalize(data['YdsG'])
normPct = normalize(data['Pct'])
normTD100 = normalize(data['TD100'])
normFD100 = normalize(data['1st100'])
normInt100 = normalize(data['Int100'])
normSk100 = normalize(data['Sk100'])

for i in 0...(data.length) do
  data[i]['rank'] = normYdsG[i] + normPct[i] + normTD100[i] + normFD100[i] - normInt100[i] - normSk100[i]
end

ranked = data.sort_by { |row| -row['rank'] }
  
ranked.each do |row|
  puts row['Player']
end

puts "-----"
espn = [14, 10, 11, 31, 12, 26, 2, 4, 27, 16, 1, 29, 30, 34, 23, 5, 25, 24, 19, 8, 9, 20, 13, 22, 3, 21, 17, 6, 18, 32, 33, 7, 28, 15]
count = 0
ranked.each_with_index do |player, index|
  count += 1 if player['Player'].to_i == espn[index]
end
puts count
