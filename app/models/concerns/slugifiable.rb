module SlugifiableInstanceMethods
  def slug
    self.name.downcase.gsub(" ", "-")
  end
end

module SlugifiableClassMethods
  def find_by_slug(slugged_name)
    self.all.find do |instance|
      instance.slug == slugged_name.downcase
    end
  end
end
