def rgb(r, g, b)
    hhh = {0 => "0", 1 => "1", 2 => "2",
      3 => "3",4 => "4", 5 => "5",
      6 => "6",7 => "7", 8 => "8",
      9 => "9",10 => "A", 11 => "B",
      12=>"C",13 => "D", 14 => "E", 15 => "F"
    }
    r = 0 if r < 0
    r = 255 if r > 255
    g = 0 if g < 0
    g = 255 if g > 255
    b = 0 if b < 0
    b = 255 if b > 255
    ans = hhh[r / 16]
    ans = ans + hhh[r % 16]
    ans = ans + hhh[g / 16]
    ans = ans + hhh[g % 16]
    ans = ans + hhh[b / 16]
    ans = ans + hhh[b % 16]
    ans
  end