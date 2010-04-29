module WebProg
  module Helpers
    def path(path)
      base_path + path
    end

    def base_path
      "/" + File.basename(self.class.root)
    end
  end
end

class NilClass
  def empty?
    true
  end
end
