" node plugins


" python3 plugins
call remote#host#RegisterPlugin('python3', '/home/wisdomwolf/.local/share/nvim/bundle/denite.nvim/rplugin/python3/denite', [
      \ {'sync': v:true, 'name': '_denite_init', 'type': 'function', 'opts': {}},
      \ {'sync': v:true, 'name': '_denite_start', 'type': 'function', 'opts': {}},
      \ {'sync': v:true, 'name': '_denite_do_action', 'type': 'function', 'opts': {}},
     \ ])
call remote#host#RegisterPlugin('python3', '/home/wisdomwolf/.local/share/nvim/bundle/deoplete.nvim/rplugin/python3/deoplete', [
      \ {'sync': v:false, 'name': '_deoplete_init', 'type': 'function', 'opts': {}},
     \ ])


" ruby plugins


" python plugins


