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
call remote#host#RegisterPlugin('python3', '/home/wisdomwolf/.local/share/nvim/bundle/iron.nvim/rplugin/python3/iron', [
      \ {'sync': v:false, 'name': 'IronClearReplDefinition', 'type': 'command', 'opts': {}},
      \ {'sync': v:true, 'name': 'IronRepl', 'type': 'command', 'opts': {'bang': ''}},
      \ {'sync': v:false, 'name': 'IronDumpReplDefinition', 'type': 'command', 'opts': {}},
      \ {'sync': v:true, 'name': 'IronStartRepl', 'type': 'function', 'opts': {}},
      \ {'sync': v:false, 'name': 'IronSendSpecial', 'type': 'function', 'opts': {}},
      \ {'sync': v:true, 'name': 'IronPromptCommand', 'type': 'command', 'opts': {}},
      \ {'sync': v:true, 'name': 'IronPromptRepl', 'type': 'command', 'opts': {}},
      \ {'sync': v:false, 'name': 'IronSendMotion', 'type': 'function', 'opts': {'range': ''}},
      \ {'sync': v:false, 'name': 'IronSend', 'type': 'function', 'opts': {}},
     \ ])


" ruby plugins


" python plugins


