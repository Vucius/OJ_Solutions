def solution(list)
    # todo: complete solution
    ans = ""
    tmp = []
    list.each do |i|
      if tmp.empty?
        tmp << i
      elsif tmp[-1] + 1 == i
        tmp << i
      else
        if tmp.count > 2
          ans += tmp[0].to_s + "-" + tmp[-1].to_s + ","
        elsif tmp.count == 1
          ans += tmp[0].to_s + ","
        else
          ans += tmp[0].to_s + "," + tmp[-1].to_s + ","
        end
        tmp.clear
        tmp << i
      end
    end
    if tmp.count > 2
      ans += tmp[0].to_s + "-" + tmp[-1].to_s
    elsif tmp.count == 1
      ans += tmp[0].to_s
    else
      ans += tmp[0].to_s + "," + tmp[-1].to_s
    end
    return ans
  end