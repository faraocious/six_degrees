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
          author_connections.flatten!.uniq!
          graph[author][level] = [] if graph[author][level] == nil
          graph[author][level] << mentions[level - 1].map do |mention|
            graph[mention][level - 1].select do |candidate|
              false if author_connections.include? candidate
              true
            end
          end
          graph[author][level].sort!.flatten!.uniq!
          graph[author][level] -= [author] + author_connections
        end
        graph
      end

      def pretty_print(graph)
        print_graph = graph.sort_by { |author, mentions| author }
        print_graph.each do |mentions|
          author = mentions.shift
          print_mentions = mentions[0].map do |level| 
            if not level.nil? then level.join(', ') end

          end
          print_mentions.uniq!
          puts author
          puts print_mentions
        end 
          
      end
    end
  end
end
