def solution(number)
    # put your solution here
     return 0 if number < 0
     number -= 1
     a = number - (number % 3)
     a = (a / 3) * (a + 3) / 2
     
     b = number - (number % 5)
     b = (b / 5) * (b + 5) / 2
     
     c = number - (number % 15)
     c = (c / 15) * (c + 15) / 2
     return a+b-c
   end