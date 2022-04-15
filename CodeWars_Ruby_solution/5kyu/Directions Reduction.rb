def dirReduc(arr)
    i = 0
    while (i < arr.length - 1)
      case arr[i]
      when "EAST"
        if arr[i + 1] == "WEST"
          arr.delete_at(i + 1)
          arr.delete_at(i)
          i -= 1 if i > 0
          next
        end
      when "SOUTH"
        if arr[i + 1] == "NORTH"
          arr.delete_at(i + 1)
          arr.delete_at(i)
          i -= 1 if i > 0
          next
        end
      when "WEST"
        if arr[i + 1] == "EAST"
          arr.delete_at(i + 1)
          arr.delete_at(i)
          i -= 1 if i > 0
          next
        end
      when "NORTH"
        if arr[i + 1] == "SOUTH"
          arr.delete_at(i + 1)
          arr.delete_at(i)
          i -= 1 if i > 0
          next
        end
      end
      i += 1
    end
    arr
  end