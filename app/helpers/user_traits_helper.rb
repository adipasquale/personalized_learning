module UserTraitsHelper

  def fill_user_traits user
    Trait.all.each do |trait|
      if user.user_traits.select{ |user_trait| user_trait.trait_id == trait.id }.empty?
        if trait.options.empty?
          user.user_traits.create(trait: trait, value: "")
        else
          user.user_traits.create(trait: trait, option: trait.options.first)
        end
      end
    end
  end

end
