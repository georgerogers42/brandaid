require 'moped'
module BrandAid
  extend self
  def Session
    url = URI.parse(ENV['MONGOHQ_URL'] || "localhost:27017")
    Moped::Session.new(url)
  end
  module Css
    extend self
    def rule items
      res = items[0].map do |rule|
        if rule.is_a? Array
          rule.join " "
        else
          rule
        end
      end.join(", ") + " {\n"
      res += items[1].to_a.map do |p|
        k, v = p
        if v.is_a? String
          "\t#{k}: #{v};\n"
        elsif v.is_a? Array
          "\t#{k}: #{v.join(", ")};\n"
        else
          throw ArgumentError
        end
      end.join ""
      res += "}\n"
    end
    def rules t
      t.map do |r|
        rule r
      end.join("")
    rescue => e
      e
    end
  end
  module ModelHelpers
    private
    def session
      @session ||= BrandAid.Session
    end
    def get_brand name
      @brand = session[:brands].find(name: name).first
    end
    def put_brand name
      session[:brands].find(name: name).update(@brand) 
    end
    def create_brand name
      brand = {
        name: name,
      }
      BrandAid.Session[:brands].insert(brand)
    end
  end
end
