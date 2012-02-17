module SixDegrees

  class Graph
    class << self
      def build_bidirectional(uni)
        bi = {}
        uni.each_pair do |author, mentions|
          bi[author] = mentions.select do |mention|
            uni[mention].include? author
          end
        end
        bi
      end
    end
  end

end
