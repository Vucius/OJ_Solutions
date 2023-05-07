def next_bigger(n)
    k = n.digits
    return -1 if k.length == 1
    # 3 5 8 9 5 4 8 4 8 4 8 8 9 5
    k[0..-2].each_with_index do |e, i|
      #p e, i
      if (e > k[i + 1])
        k[0..i].each_with_index do |f, j|
          if (f > k[i + 1])
            tmp = k[j]
            k[j] = k[i + 1]
            k[i + 1] = tmp
            ss = k[0..i].sort!{|a, b| b<=>a } + k[(i + 1)..-1]
            return ss.reverse.join.to_i
          end
        end
      end
    end
    -1
  end