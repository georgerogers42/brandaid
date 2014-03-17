require 'moped'
module BrandAid
  extend self
  def Session
    url = URI.parse(ENV['MONGOHQ_URL'] || "mongodb://localhost:27017/brandaid")
    sess = Moped::Session.new(["#{url.host}:#{url.port}"])
    sess.use(url.path.sub('/', ''))
    sess.login(url.user, url.password) if url.user && url.password
    return sess
  end
  module ProcLike
    def call *args
      super
    end
    alias_method :[], :call
    def to_proc
      method(:call).to_proc
    end
  end

  module Css
    extend self
    include ProcLike
    def rule items
      res = items["selectors"].map do |rule|
        if rule.is_a? Array
          rule.join " "
        else
          rule
        end
      end.join(", ") + " {\n"
      res += items["rules"].to_a.map do |p|
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
    def call t
      t.map do |r|
        rule r if r["kind"] == "font"
      end.join("")
    rescue => e
      e
    end
    alias_method :rules, :call
  end
  module Page
    extend self
    include ProcLike
    def rule r
      RDiscount.new(r["text"].to_s).to_html
    end
    def call t
      t.map do |r|
        rule r
      end
    end
    alias_method :rules, :call
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
        styles: { default: [] }
      }
      session[:brands].insert(brand)
    end
  end
end
