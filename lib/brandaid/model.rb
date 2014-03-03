require 'mongoid'
Mongoid.load!("./mongoid.yml")
module BrandAid
  module Css
    extend self
    def rule items
      res = items[:head].join(", ") + " {\n"
      res += items[:body].map do |k, v0|
        v1 = v0.map do |v|
          "\"#{v}\""
        end
        "\t#{k}: #{v1.join(", ")};\n"
      end.join ""
      res += "}\n"
    end
    def css t
      res = ""
      t[:colors].each do |color|
        res += rule color
      end if t[:colors]
      t[:fonts].each do |font|
        res += rule font
      end if t[:fonts]
      return res
    end
  end
end
