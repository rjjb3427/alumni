json.partial! "posts/post", post: question
json.content render_markdown(question.content)
json.original_content question.content
