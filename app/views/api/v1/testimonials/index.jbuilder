json.array! @testimonials.each do |testimonial|
  json.extract! testimonial, :content, :locale
  json.user do
    json.batch do
      json.extract! testimonial.user.batch, :slug
      json.city do
        json.extract! testimonial.user.batch.city, :name
      end
    end
  end
end
