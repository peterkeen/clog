RENDERER = Redcarpet::Markdown.new(
  Redcarpet::Render::HTML,
  :fenced_code_blocks => true,
  :strikethrough => true,
  :autolink => true
)
