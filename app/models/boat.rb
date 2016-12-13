require 'pry'
class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.all.limit(5)
  end

  def self.dinghy
    all.where("length < ?", 20)
  end

  def self.ship
    all.where("length >= ?", 20)
  end

  def self.last_three_alphabetically
    all.order(:name).reverse_order.limit(3) 
  end

  def self.without_a_captain
    #all.where(captain_id: nil) <-- this also works
    all.where("captain_id IS NULL")
  end

  def self.sailboats
    # all_boats = self.all.pluck(:id)
    classification_ids = Classification.all.where(name: "Sailboat").first.id
    BoatClassification.all.where("classification_id = ?", classification_ids)
    binding.pry

  #   all.first.boat_classifications.last.classification.where("name = 'sailboat'")
  #   all.boat_classifications.boat_id.where("name = 'sailboat'")

  #   #
  end
end

# all.first.boat_classifications.last.classification.name


#  all.first.boat_classifications
# => [#<BoatClassification:0x007feaf4215e80
#   id: 3095,
#   boat_id: 1429,
#   classification_id: 1310,
#   created_at: Tue, 13 Dec 2016 22:10:12 UTC +00:00,
#   updated_at: Tue, 13 Dec 2016 22:10:12 UTC +00:00>,
#  #<BoatClassification:0x007feaf4215958
#   id: 3096,
#   boat_id: 1429,
#   classification_id: 1311,
#   created_at: Tue, 13 Dec 2016 22:10:12 UTC +00:00,
#   updated_at: Tue, 13 Dec 2016 22:10:12 UTC +00:00>]
