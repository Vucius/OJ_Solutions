class Array
    def same_structure_as(aim)
      if (self.class.to_s == "Array")
        return false if aim.class.to_s != "Array"
        return false if self.length != aim.length
        self.each_with_index do |e, i|
          if e.class.to_s == "Array"
            return false if !e.same_structure_as(aim[i])
          end
        end
      else
        return false if aim.class.to_s == "Array"
      end
      
      true
    end
  end