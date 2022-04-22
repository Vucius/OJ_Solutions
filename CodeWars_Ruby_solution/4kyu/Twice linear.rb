def dbl_linear(n)
    ans = [1]
    i = 0
    k = 5*n-1
    while i <= k
      ans.push ans[i] * 2 + 1
      ans.push ans[i] * 3 + 1
      i += 1
    end
    ans.uniq!
    ans.sort!
    return ans[n]
  end