require 'moped'
module BrandAid
  Session = Moped::Session.new(["localhost:27017"]).use(:brandaid)
  module Css
    extend self
    def rule items
      res = items[0].join(", ") + " {\n"
      res += items[1].map do |p|
        k, v = p
        "\t#{k}: #{v.join(", ")};\n"
      end.join ""
      res += "}\n"
    end
    def rules t
      t.map do |r|
        rule r
      end.join("")
    end
  end
  module ModelHelpers
    private
    def get_brand name
      @brand = Session[:brands].find(name: name).first
      @brand.delete "_id"
      return @brand
    end
    def put_brand name
      Session[:brands].find(name: name).update(@brand) 
    end
  end
end
