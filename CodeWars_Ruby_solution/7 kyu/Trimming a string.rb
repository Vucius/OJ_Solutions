def trim(string, size)
    if string.length > size
      return string[0..(size - 1)] + "..." if string.length <= 3
      return string[0..(size - 4)] + "..." if (size - 4) >= 0
      return string[0..(size - 1)] + "..."
    end
    return string if string.length <= size
    throw NotImplementedError.new "TODO: trim"
  end
  # > size
  # <= 3
  # <= size