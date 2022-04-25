def sumOfDivided(lst)
    return [] if lst.empty?
    small = [2, 3, 5, 7, 11, 13, 17, 19,
            23, 29, 31, 37, 41, 43, 47]
    ans = []
    max = lst[0].abs
    flag = 0
    sum = 0
    lst.each do |e|
      sum += e if(e % 2 == 0)
      max = e.abs if e.abs > max
    end
    if (sum != 0)
      ans.push([2, sum])
    end
    sum = small[-1] + 2
    while sum <= max
      flag = 0
      small.each do |ss|
        if sum % ss == 0
          flag = 1
          break
        end
      end
      if flag == 1
        sum += 2
        next
      else
        small.push(sum)
        sum += 2
      end
    end
    
    small[1..-1].each do |sss|
      sum = flag = 0
      lst.each do |ll|
        if ll % sss == 0
          sum += ll
          flag = 1
        end
      end
      ans.push([sss, sum]) if flag == 1
      
    end
    ans
  end