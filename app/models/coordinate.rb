class Coordinate < Base

  belongs_to :pic

  attr_accessible :x_point,
                  :y_point,
                  :pic_id

  # no any validation

  class << self

    def create_from_array(coordinates, pic_id)
      coordinates.values.each do |coordinate|
        Coordinate.create(x_point: coordinate.first.to_i,
                          y_point: coordinate.last.to_i,
                          pic_id:  pic_id.to_i)
      end
    end

  end
end