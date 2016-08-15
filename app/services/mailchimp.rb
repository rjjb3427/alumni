# Batch.find(17).users.each { |u| Mailchimp.new.subscribe_to_alumni_list(u); puts u.email; sleep 1 }

class Mailchimp
  def initialize
    @gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
    @list_id = ENV['MAILCHIMP_ALUMNI_LIST_ID']
  end

  def subscribe_to_alumni_list(user)
    mailchimp_member(user.email).upsert(
      body: {
        email_address: user.email,
        status: "subscribed",
        merge_fields: {
          FNAME:  user.first_name,
          LNAME:  user.last_name,
          BATCH:  user.batch.slug,
          GITHUB: user.github_nickname,
          CITY:   user.batch.city.slug
        }
      }
    )
  end

  def remove_from_alumni_list(user)
    mailchimp_member(user.email).delete
  rescue Gibbon::MailChimpError => e
    if e.message =~ /405/ || e.message =~ /404/
      puts "Could not find member with email #{user.email}"
    else
      raise e
    end
  end

  private

  def mailchimp_member(email)
    @gibbon.lists(@list_id).members(Digest::MD5.hexdigest(email))
  end
end
