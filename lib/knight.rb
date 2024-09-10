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

  # Public: Initializes the Knight object.
  #
  # visited: An array to store the positions the knight has already visited,
  # preventing revisiting them and causing infinite loops.
  #
  # Returns a new Knight object.
  def initialize
    @visited = []
  end

  # Public: Finds the shortest path for the knight from the initial location to the final location using BFS.
  #
  # initial_location - The starting position of the knight as an array [x, y].
  # final_location - The target position where the knight must move.
  #
  # Returns an array representing the shortest path from the initial to the final location.
  def knight_move(initial_location, final_location)
    # Start the BFS with the final location, marking it as visited
    queue = [Node.new(final_location)] # Initialize the queue with the final location as a node
    @visited << final_location # Mark the final location as visited

    # Continue exploring the queue until it's empty or the initial location is found
    until queue.empty?
      current = queue.shift # Dequeue the first node (FIFO)
      # If the current position is the initial location, return the constructed path
      return get_path(current) if current.position == initial_location

      # For each valid move from the current position, enqueue the new node
      next_possible_moves(current).each { |move| queue << move }
      # Mark the current position as visited to avoid reprocessing
      @visited << current.position
    end
  end

  private

  # Private: Returns an array of valid next possible moves from the current position.
  #
  # node - The current node, representing the knight's current position on the board.
  #
  # Returns an array of Node objects representing valid moves.
  def next_possible_moves(node)
    MOVES.map { |dx, dy| [node.position[0] + dx, node.position[1] + dy] } # Calculate new positions
         .select { |location| valid?(location) && !@visited.include?(location) } # Filter out invalid/visited locations
         .map { |location| Node.new(location, node) } # Create new nodes for each valid move
  end

  # Private: Checks if the given position is valid (i.e., within the boundaries of the chessboard).
  #
  # new_position - The position being checked as an array [x, y].
  #
  # Returns true if the position is within the bounds (0..7 for both x and y); otherwise, false.
  def valid?(new_position)
    # Ensure both coordinates are within board limits
    new_position.all? { |coordinates| coordinates.between?(0, 7) }
  end

  # Private: Recursively constructs the path from the final node back to the initial node.
  #
  # node - The current node being traced back.
  # path - An array that accumulates the positions along the path (default: []).
  #
  # This method works by recursively following the parent nodes from the target to the starting position.
  #
  # Returns an array of positions representing the path.
  def get_path(node, path = [])
    path << node.position # Add the current node's position to the path
    node.parent ? get_path(node.parent, path) : path # Recursively trace the parent node until the root is reached
  end
end
