module ApplicationHelper
  def show_navbar
    controller_name.in?(%w[games])
  end

  def logo_svg(append_to_class = nil)
    %(<svg class="fill-cyan-600 #{append_to_class}" viewBox="0 0 3 3" aria-hidden="true">\
<path d="m0 3v-1h2v-1h-1v-1h1v1h1v2z"></path>\
</svg>).html_safe
  end

  def grid_to_svg(grid, **html_opts)
    view_box = [0, 0, grid.width, grid.height].join(' ')
    html_opts = {
      xmlns: 'http://www.w3.org/2000/svg',
      viewBox: view_box
    }.merge(html_opts || {})

    content_tag('svg', **html_opts) do
      "<path d=\"#{Game::Utils.grid_to_svg_path(grid)}\"></path>".html_safe
    end
  end
end
