def likes(names)
    ans = String.new
    case names.length
      when 0
      ans = "no one likes this"
      when 1
      ans = names[0] + " likes this"
      when 2
      ans = names[0] + " and " + names[1] + " like this"
      when 3
      ans = names[0] + ", " + names[1] + " and " + names[2] + " like this"
      else
      ans = names[0] + ", " + names[1] + " and #{names.length - 2} others like this"
    end
    ans
  end