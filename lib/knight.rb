# source = [0, 0]
# destination = [3, 3]
# path = [source]
# queue = [source]


# until queue.empty?
#   current = queue.shift
#   p current
#   moves.each do |move|
#     x, y = current[0] + move[0], current[1] + move[1]
#     if x.between?(0, 7) && y.between?(0, 7)
#       new_post = [x, y]
#       unless path.include?(new_post)
#         path << new_post
#         queue << new_post
#       end
#     end
#     break if path.include?(destination)
#   end
# end

class Knight
  class Node
    attr_accessor :position, :parent

    def initialize(position, parent = nil)
      @position = position
      @parent = parent
    end
  end

  private_constant :Node
  attr_accessor :piece

  MOVES = [
    [-1, 2], [-1, -2], [1, 2], [1, -2],
    [-2, 1], [-2, -1], [2, 1], [2, -1]
  ]
  @@path = []

  def initialize
    @piece = nil
  end

  def get_possible_moves(position)
    parent = Node.new(position)
    self.piece = parent if self.piece.nil?

    MOVES.reduce([]) do |output, move|
      new_position = [position[0] + move[0], position[1] + move[1]]
      if valid?(new_position) && !@@path.include?(new_position)
        node = Node.new(new_position, parent)
        output << node
        @@path << node
      end
      output
    end
  end

  def valid?(new_position)
    new_position[0].between?(0, 7) && new_position[1].between?(0, 7)
  end

end

k = Knight.new
p k.get_possible_moves([0, 0])
