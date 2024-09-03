# moves = [
#   [-1, 2], [-1, -2], [1, 2], [1, -2],
#   [-2, 1], [-2, -1], [-1, 2], [-1, -2]
# ]

# source = [0, 0]
# destination = [3, 3]
# path = []
# queue = [source]

# until queue.empty?
#   current = queue.shift
#   path << current
#   p current
#   moves.each do |move|
#     x, y  = source[0] + move[0], source[1] + move[1]
#     queue << [x, y] if x.between?(0, 7) && y.between?(0, 7) && !path.include?([x, y])
#   end
# end


adj_list = [
  [1, 6, 8],
  [0, 4, 6, 9],
  [4, 6],
  [4, 5, 8],
  [1, 2, 3, 5, 9],
  [3, 4],
  [0, 1, 2],
  [8, 9],
  [0, 3, 7],
  [1, 4, 7]
]

queue = adj_list[0]
visited = Array.new(adj_list.flatten.uniq.length)

until queue.empty?
  current = queue.shift

end
