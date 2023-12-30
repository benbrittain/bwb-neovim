if exists("g:loaded_buck2")
    finish
endif
let g:loaded_buck2 = 1

command! -nargs=0 Buck2StartStandaloneServerForBuffer lua require('buck2.standalone').start_standalone_client()

"" Defines a package path for Lua. This facilitates importing the
"" Lua modules from the plugin's dependency directory.
"let s:lua_rocks_deps_loc =  expand("<sfile>:h:r") . "/../lua/buck2/deps"
"exe "lua package.path = package.path .. ';" . s:lua_rocks_deps_loc . "/lua-?/init.lua'"
"
"" Exposes the plugin's functions for use as commands in Neovim.
"command! -nargs=0 FetchTodos lua require("buck2").fetch_todos()
"command! -nargs=0 InsertTodo lua require("buck2").insert_todo()
"command! -nargs=0 CompleteTodo lua require("buck2").complete_todo()
