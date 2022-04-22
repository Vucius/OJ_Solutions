def fib(n)
    return n if n == 0 || n == 1
    return 1 if n == 2
    f1 = n.abs / 2
    f2 = f1 + 1
    a1 = fib(f1)
    a2 = fib(f2)
    if n.even?
      return a1 * (2 * a2 - a1) * -1 if n < 0
      return a1 * (2 * a2 - a1)
    else
      return a1 * a1 + a2 * a2
    end
  end