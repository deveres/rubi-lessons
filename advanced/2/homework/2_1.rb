
hash = [
    {:month=>'Январь', :days=>31},
    {:month=>'Февраль', :days=>28},
    {:month=>'Март', :days=>31},
    {:month=>'Апрель', :days=>31},
    {:month=>'Май', :days=>31},
    {:month=>'Июнь', :days=>30},
    {:month=>'Июль', :days=>31},
    {:month=>'Август', :days=>31},
    {:month=>'Сентябрь', :days=>30},
    {:month=>'Октябрь', :days=>31},
    {:month=>'Ноябрь', :days=>30},
    {:month=>'Декабрь', :days=>31}
]

hash.each do |item|
  if item[:days]==30
    puts item[:month]
  end
end
