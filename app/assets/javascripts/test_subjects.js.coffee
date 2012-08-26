$ ->
  if $("#subject-tree").length
    tree = $("#subject-tree")

    tree.jstree
      plugins: [ "themes", "html_data", 'types' ]
      core: { "initially_open" : [ "root" ] }
      themes:
        theme: 'knoxy'
        dots: false
        icons: true
      html_data:
        ajax:
          url: tree.data('source')
      types:
        valid_children: [ 'subject']
        types:
          subject:
            icon: 
              image: "http://static.jstree.com/v.1.0rc/_docs/_drive.png" 
