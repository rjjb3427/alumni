 json.staff do
  json.teachers @teachers.each do |teacher|
    json.extract! teacher, :id, :github_nickname, :twitter_nickname, :first_name, :last_name, :role
    json.thumbnail teacher.thumbnail(width: 100, height: 100, crop: :fill)
    json.bio do
      json.fr teacher.bio_fr
      json.en teacher.bio_en
    end
    json.batches teacher.batches do |batch|
      json.slug batch.slug
      json.city batch.city.name
    end
  end
  json.teacher_assistants @teacher_assistants.each do |teacher|
    json.extract! teacher, :id, :github_nickname, :twitter_nickname, :first_name, :last_name, :role
    json.thumbnail teacher.thumbnail(width: 80, height: 80, crop: :fill)
    json.bio do
      json.fr teacher.bio_fr
      json.en teacher.bio_en
    end
    json.batches teacher.batches do |batch|
      json.slug batch.slug
      json.city batch.city.name
    end
  end
end
