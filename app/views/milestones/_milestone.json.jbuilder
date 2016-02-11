json.partial! "posts/post", post: milestone
json.content render_markdown(enriched_content(milestone.content))
json.original_content milestone.content.gsub(/\r\n/, "\n")
json.date milestone.created_at.strftime('%B %Y')

