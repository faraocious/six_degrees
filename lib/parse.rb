module SixDegrees

  class Parse

    def initialize(filepath)
      @filepath = filepath
    end

    def parse
      h = Hash.new []
      File.exists? @filepath
      File.readlines(@filepath).each do |line|
        a = self.class.author(line)
        h[a.to_sym] = h[a.to_sym] + self.class.mentions(line) 
        h[a.to_sym].uniq!
      end
      h
    end

    class << self
      def author(string)
        /^([A-Za-z0-9_]+):/.match(string)[1]
      end

      def mentions(string)
        string.scan(/@([A-Za-z0-9_]+)/).flatten.map(&:to_sym)
      end
    end
  end
end
