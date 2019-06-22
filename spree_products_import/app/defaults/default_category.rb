require 'singleton'

class DefaultCategory
  include Singleton

  def self.object
    Spree::Taxon.find_by(name: 'Categories')
  end
end
