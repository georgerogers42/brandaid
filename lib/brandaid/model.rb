require 'moped'
module BrandAid
  extend self
  def session
    url = URI.parse(ENV['MONGOHQ_URL'] || "mongodb://localhost:27017/brandaid")
    sess = Moped::Session.new(["#{url.host}:#{url.port}"])
    sess.use(url.path.sub('/', ''))
    sess.login(url.user, url.password) if url.user && url.password
    return sess
  end
  module ProcLike
    def self.included m
      super
      m.class_eval do 
        alias_method :[], :call
      end
    end
    def to_proc
      method(:call).to_proc
    end
  end

  module Css
    extend self
    def rule items
      res = items["selectors"].map do |rule|
        if rule.is_a? Array
          rule.join " "
        elsif rule.is_a? String
          rule
        else
          throw ArgumentError
        end
      end.join(", ") + " {\n"
      res += items["rules"].to_a.map do |p|
        k, v = p
        case v
        when String
          "\t#{k}: #{v};\n"
        when Array
          "\t#{k}: #{v.join(", ")};\n"
        else
          throw ArgumentError
        end
      end.join ""
      res += "}\n"
    end
    def call t
      t.map do |r|
        rule r if r["kind"] == "font"
      end.join("")
    rescue => e
      e
    end
    include ProcLike
    alias_method :rules, :call
  end
  module Page
    extend self
    def rule r
      x = r["text"]
      case x
      when Array
        RDiscount.new(x.join("\n")).to_html
      else
        RDiscount.new(x.to_s).to_html
      end
    end
    def call t
      t.map do |r|
        rule r
      end.join("")
    end
    include ProcLike
    alias_method :rules, :call
  end
  module ModelHelpers
    private
    def session
      @session ||= BrandAid.session
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
        styles: { default: [] }
      }
      session[:brands].insert(brand)
    end
  end
end
