require 'mongoid'
Mongoid.load!("./mongoid.yml")
module BrandAid
  def self.make_type(plural, type: Array, &b)
    x = Class.new do
      include Mongoid::Document
      field :use_guidelines, type: String
      field plural, type: Array
    end
    x.class_eval(&b) if b
    return x
  end
  Logo = make_type :logos
  Color = make_type :color
  Font = make_type :fonts, type: Array
  Tagline = make_type :taglines, type: String
  class Brand
    include Mongoid::Document
    field :name, type: String
    validates_uniqueness_of :name
    field :use_guidelines
    embeds_one :logos
    embeds_one :colors
    embeds_many :fonts
    embeds_many :taglines
  end
end
