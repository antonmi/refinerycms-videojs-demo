if defined?(::Refinery::User)
  ::Refinery::User.all.each do |user|
    if user.plugins.where(:name => 'refinerycms-videos').blank?
      user.plugins.create(:name => 'refinerycms-videos',
                          :position => (user.plugins.maximum(:position) || -1) +1)
    end
  end
end

# Added by Refinery CMS Pages extension
Refinery::Pages::Engine.load_seed
