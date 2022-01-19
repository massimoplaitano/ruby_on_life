module ApplicationHelper
  def logo_svg
    '<svg class="h-8 w-auto sm:h-10 fill-cyan-600" viewBox="0 0 3 3" aria-hidden="true"><path d="m0 3v-1h2v-1h-1v-1h1v1h1v2z"/></svg>'.html_safe
  end
end
