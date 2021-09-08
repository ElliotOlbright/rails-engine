class Search < ApplicationRecord 
  def self.find_by_name(model, name)
    model.where('LOWER(name) ILIKE ?', "%#{name}%")
		          .order(:name)
  end
end