# https://www.codewars.com/kata/reviews/52788a9ae42add6b1300065a/groups/644fb4eb67b30e0001f1c463
#Use this space to lock down the random number generators.
module Kernel
  def rand
    raise NoMethodError
  end
  def self.rand
    raise NoMethodError
  end
  def srand
    raise NoMethodError
  end
  def self.srand
    raise NoMethodError
  end
end

class Random
  def rand
    raise NoMethodError
  end
  def self.rand
    raise NoMethodError
  end
  def self.srand
    raise NoMethodError
  end
  def srand
    raise NoMethodError
  end
end

class Array
  def sample(*args)
    raise NoMethodError #"Error: You are not allowed to use sample method for generating random numbers."
  end

  def shuffle(*args)
    raise NoMethodError #"Error: You are not allowed to use shuffle method for generating random numbers."
  end
end
