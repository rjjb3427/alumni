json.partial! "posts/post", post: job
json.city job.city
json.company job.company
json.contact_email job.contact_email
json.ad_url job.ad_url
json.content render_markdown(job.description)
json.original_content job.description
