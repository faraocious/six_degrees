module SixDegrees

  class Graph
    class << self
      def simplify_parser(graph)
        bi = {}
        bi.default = []
        graph.each_pair do |author, mentions|
          bi[author] = mentions.select do |mention|
            graph[mention].include? author
          end
        end
        [bi]
      end

      def iterate(graph)
        level = graph.size
        graph[level - 1].each_pair do | author, mentions |
          graph[level] = {}
          graph[level].default = []
          graph[level][author] << mentions.map do |mention|
            graph[level - 1][mention] - [author]
          end
          graph[level][author].uniq!
          p graph[level]
        end
        graph
      end
    end
  end

end
