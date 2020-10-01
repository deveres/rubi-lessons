
def fCalc(i)
  if i==0
    return 0
  end

  if i==1
    return 1
  end

  return fCalc(i-1)+fCalc(i-2)
end


fibonaci = []

i=0
while fCalc(i)<=100
  fibonaci.push(fCalc(i))
  i +=1
end

puts fibonaci
