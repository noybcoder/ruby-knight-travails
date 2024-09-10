# frozen_string_literal: true

# Knight class that represents the knight piece in chess and can calculate
# the shortest path from one position to another on the chessboard.
class Knight
  # Inner class Node represents a position on the chessboard and tracks its parent node
  # to enable the backtracking of the knight's path.
  class Node
    # Allows read and write access to the position and parent attributes.
    attr_accessor :position, :parent

    # Public: Initializes a new Node instance.
    #
    # position - An array representing the coordinates of the node on the chessboard.
    # parent - The parent Node from which this node was reached, used for backtracking the path (default: nil).
    #
    # Returns a new Node object.
    def initialize(position, parent = nil)
      @position = position
      @parent = parent
    end
  end

  # Makes the Node class private to encapsulate the node structure within the Knight class.
  private_constant :Node

  # MOVES constant defines all possible moves a knight can make on a chessboard.
  # Each pair of numbers represents the change in x and y coordinates for a valid knight move.
  MOVES = [
    [-1, 2], [-1, -2], [1, 2], [1, -2],
    [-2, 1], [-2, -1], [2, 1], [2, -1]
  ].freeze

  def initialize
    @visited = []
  end

  def next_possible_moves(node)
    MOVES.map { |dx, dy| [node.position[0] + dx, node.position[1] + dy] }
         .select { |location| valid?(location) && !@visited.include?(location) }
         .map { |location| Node.new(location, node) }
  end

  def valid?(new_position)
    new_position.all? { |coordinates| coordinates.between?(0, 7) }
  end

  def get_path(node, path = [])
    path << node.position
    node.parent ? get_path(node.parent, path) : path
  end

  def knight_move(initial_location, final_location)
    queue = [Node.new(final_location)]
    @visited << final_location

    until queue.empty?
      current = queue.shift
      return get_path(current) if current.position == initial_location

      next_possible_moves(current).each { |move| queue << move }
      @visited << current.position
    end
  end
end

k = Knight.new
p k.knight_move([0, 0], [7, 7])
