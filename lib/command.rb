module SixDegrees

  class Command
    def run(args)

      file = args[0]
      parser = SixDegrees::Parse.new file
      graph = SixDegrees::Graph.simplify_parser parser.parse

      i = 1
      while i < graph[0].size do
        SixDegrees::Graph.iterate! graph, i
        i+=1
      end
      SixDegrees::Graph.pretty_print(graph)

    end
  end
