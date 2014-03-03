require 'mongoid'
Mongoid.load!("./mongoid.yml")
module BrandAid
  module Css
    extend self
    def rule items
      res = items[:head].join(", ") + " {\n"
      res += items[:body].to_a.map do |p|
        k, v0 = p
        v1 = v0.map do |v|
          "\"#{v}\""
        end
        "\t#{k}: #{v1.join(", ")};\n"
      end.join ""
      res += "}\n"
    end
    def css t
      res = ""
      t[:rules].each do |r|
        res += rule r
      end
    end
  end
end
