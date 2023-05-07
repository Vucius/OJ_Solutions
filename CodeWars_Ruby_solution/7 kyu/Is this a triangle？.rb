def is_triangle(a,b,c)
    p a, b, c
    return false if [a,b,c].min < 0
    if a >= b && a >= c
      return b + c > a
    elsif b >= a && b >= c
      return a + c > b
    else
      return a + b > c
    end
  end