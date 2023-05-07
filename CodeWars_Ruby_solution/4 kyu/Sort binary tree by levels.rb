def tree_by_levels(node)
    return [] if node.nil?
    level = [node]
    ans = []
    level.each do |e|
      ans.push(e.value)
      level.push(e.left) if e.left
      level.push(e.right) if e.right
    end
    ans
  end