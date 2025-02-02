module CartItems
  class Base < ActiveInteraction::Base
    array :accessory_ids

    def execute
      raise NotImplementedError("This method must be implemented in a subclass")
    end

    private

    def validate_complemetary_accessories
      constraints = ComplementaryAccessoryConstraint
        .where(
          accessory_id: accessory_ids,
          complementary_accessory_id: accessory_ids
        )

      return unless constraints.exists?

      accessory_ids = constraints.map do |constraint|
        [constraint.accessory_id, constraint.complementary_accessory_id]
      end

      raise self.class::Error, "The following accessory ids cannot be added together: #{accessory_ids}"
    end
  end
end
