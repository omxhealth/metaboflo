$ ->
  if $("#subject-tree").length
    base_icon = '/assets/jstree-themes/knoxy/icons'
    tree = $("#subject-tree")

    
    tree.bind 'loaded.jstree', (event, data) -> 
      tree.find('a').each (index, value) ->
        if value.href == window.location.href 
          $(value).addClass('current-node')
      
    tree.jstree
      plugins: [ "themes", "html_data", 'types', 'cookies' ]
      core: { "initially_open" : [ "root", 'tree-experiments', 'tree-samples', 'tree-groups' ] }
      themes:
        theme: 'knoxy'
        dots: true
        icons: true
      html_data:
        ajax:
          url: tree.data('source')
      types:
        valid_children: [ 'subject']
        types:
          default:
            icon: 
              image: "#{base_icon}/folder.png" 
          subject:
            icon: 
              image: "#{base_icon}/subjects/patient.png" 
          medications:
            icon: 
              image: "#{base_icon}/medicine.png" 
          tests:
            icon: 
              image: "#{base_icon}/test.png" 
          evaluations:
            icon: 
              image: "#{base_icon}/evaluation.png" 
          experiment:
            icon: 
              image: "#{base_icon}/experiment.png" 
          sample:
            icon: 
              image: "#{base_icon}/sample.png" 
          aliquot:
            icon: 
              image: "#{base_icon}/aliquot.png" 
          group:
            icon: 
              image: "#{base_icon}/grouping.png" 
