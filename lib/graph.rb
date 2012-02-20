module SixDegrees

  class Graph
    class << self
      def simplify_parser(graph)
        bi = {}
        bi.default = []
        graph.each_pair do |author, mentions|
          bi[author] = [mentions.select do |mention| graph[mention].include? author end]
        end
        bi
      end

      def iterate!(graph,level)
        graph.each_pair do | author, mentions |
          author_connections = [] 
          graph[author].each do |iteration|
            author_connections << iteration
          end
          author_connections.uniq!

          graph[author][level] = [] if graph[author][level] == nil
          graph[author][level] << mentions[level - 1].map do |mention|
            graph[mention][level - 1].select do |candidate|
              false if author_connections.include? candidate
              true
            end
          end
          graph[author][level].sort!.flatten!.uniq!
          graph[author][level] -= [author]
        end
        graph
      end

      def pretty_print(graph)
        print_graph = graph.sort_by { |author, mentions| author }
        print_graph.each do |mentions|
          author = mentions.shift
          print_mentions = mentions.map { |level| level.join(', ') unless level.empty? }

          puts author
          puts print_mentions
          puts '' 
        end 
          
      end
    end
  end
end
