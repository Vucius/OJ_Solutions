def score( dice )
  cc = Array.new(7, 0)
  dice.each do |e|
    cc[e] += 1
  end
  
  cc[0] += 1000 if cc[1] >= 3
  cc[0] += (cc[1] % 3) * 100
  cc[0] += 500 if cc[5] >= 3
  cc[0] += (cc[5] % 3) * 50
  return cc[0] if (cc[1] + cc[5] >= 3)
  [2, 3, 4, 6].map do |i|
    if cc[i] >= 3
      cc[0] += i * 100
      return cc[0]
    end
  end
  return cc[0]
end