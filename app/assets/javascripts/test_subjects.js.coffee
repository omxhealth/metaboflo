$ ->
  if $("#subject-tree").length
    tree = $("#subject-tree")

    tree.jstree
      plugins: [ "themes", "html_data" ]
      core: { "initially_open" : [ "root" ] }
      themes:
        theme: 'knoxy'
        dots: false
        icons: true
      html_data:
        ajax:
          url: tree.data('source')

