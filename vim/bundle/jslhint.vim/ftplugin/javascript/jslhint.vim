"Author: FuDesign2008@163.com
" The plugin is only works with node.js and the installed directory should be
" added to $PATH
"
" only support nodeJS
if !executable('node')
    echoerr 'Node.js is not found!'
    finish
endif


"-----------------------------------------------------------------------------
"    for buffer
"-----------------------------------------------------------------------------
"
if matchend(expand('%'), '.js') == -1 || exists('b:jslhint_loaded')
    finish
endif
let b:jslhint_loaded = 1
let b:jshintrc = []
let b:jslintrc = []
let b:undo_cur_seq = 0
let b:line_num = 0
" bind events
if (!exists('g:JSLHint_auto_check') || g:JSLHint_auto_check) &&  !exists('b:jslhint_binding')
    let b:jslhint_binding = 1
    "au BufLeave <buffer> call s:JSLHintClear()
    "clear buffer's jshintrc when buffer becoming hidden,
    "so when showing the buffer, it can reload jshintrc automatically
    au BufHidden <buffer> call s:ClearBufferJSLHint()
    au BufEnter <buffer> call s:JSLHint()
    au InsertLeave <buffer> call s:JSLHintUpdateIfModified()
    "au InsertEnter <buffer> call s:JSLHint()
    "au BufReadPost <buffer> call s:JSLHint()
    au BufWritePost <buffer> call s:JSLHintUpdateIfModified()

    " due to http://tech.groups.yahoo.com/group/vimdev/message/52115
    "if(!has('win32') || v:version>702)
        "au CursorHold <buffer> call s:JSLHint()
        "au CursorHoldI <buffer> call s:JSLHint()
        "au CursorHold <buffer> call s:ShowCursorJSLHintMsg()
    "endif
    "
    au CursorMoved <buffer> call s:JSLHintUpdateIfModified()
    "au CursorHold <buffer> call s:JSLHintUpdateIfModified()
    "au CursorHoldI <buffer> call s:JSLHintUpdateIfModified()
    "
    "nnoremap <buffer><silent> dd dd:JSUpdate<CR>
    "noremap <buffer><silent> dw dw:JSUpdate<CR>
    "noremap <buffer><silent> u u:JSUpdate<CR>
    "noremap <buffer><silent> <C-R> <C-R>:JSUpdate<CR>
endif
"
"-----------------------------------------------------------------------------
"    for script
"-----------------------------------------------------------------------------
"
if exists('s:jslhint_loaded')
    finish
endif
let s:jslhint_loaded = 1
" 0 1
if !exists('g:JSLHint_jshint_default') || g:JSLHint_jshint_default
    let s:current_is_jslint = 0
else
    let s:current_is_jslint = 1
endif
" 0 1
let s:jslhint_disabled = 0

let s:plugin_path = expand('<sfile>:p:h')
if has('win32')
    let s:plugin_path = substitute(s:plugin_path, '/', '\', 'g')
    let s:cmd_prefix= 'cmd.exe /C "cd /d "' . s:plugin_path . '" && node "' . s:plugin_path . '/'
    let s:cmd_suffix = '/run.js""'
else
    let s:cmd_prefix = 'cd "' . s:plugin_path . '" && node "' . s:plugin_path . '/'
    let s:cmd_suffix = '/run.js"'
endif
"
if !exists('g:JSLHint_highlight_error') || g:JSLHint_highlight_error
    highlight link JSLHintError SpellBad
    let g:JSLHint_highlight_error = 1
endif

" .jshintrc or .jslintrc
" @param {Boolean} is_jslintrc
"
function! s:SetBufferJSLHintrc ()
    if !exists("b:jslhint_loaded")
        return
    endif
    let jsrc = []
    let jsrc_file = s:current_is_jslint ? '.jslintrc' : '.jshintrc'
    " try to find .jshintrc or .jslintrc in project.
    " try to find the .jshintrc or .jslintrc in ancestor directory in 6 times
    " In most cases, 6 times is enough.
    let up_limit = 6
    let counter = 0
    let temp_dir = expand('%:p:h')
    let project_jsrc = ''
    while (counter < up_limit && strlen(temp_dir) > 1)
        let counter = counter + 1
        if filereadable(temp_dir . '/' . jsrc_file)
            let project_jsrc = temp_dir . '/' .jsrc_file
            " to break the while-loop
            let counter = up_limit
        else
            "up to parent directory
            let temp_dir = fnamemodify(temp_dir, ':h')
        endif
    endwhile

    "try to find user's .jshintrc only when the project has no .jshintrc
    if len(project_jsrc) > 2 && filereadable(project_jsrc)
        let jsrc = readfile(project_jsrc)
    else
        let user_jsrc = expand('~/' . jsrc_file)
        if filereadable(user_jsrc)
            let jsrc =  readfile(user_jsrc)
        endif
    endif
    "set buffer's jsrc
    if s:current_is_jslint
        let b:jslintrc = jsrc
    else
        let b:jshintrc = jsrc
    endif
endfunction
"
" echo jsrc
"
function! s:EchoJSLHintrc()
    if !exists("b:jslhint_loaded")
        return
    endif
    if s:current_is_jslint
        echo b:jslintrc
    else
        echo b:jshintrc
    endif
endfunction
"
" clear buffer
"
function! s:ClearBufferJSLHint()
    if !exists("b:jslhint_loaded")
        return
    endif
    "clear jsrc
    if s:current_is_jslint
        let b:jslintrc = []
    else
        let b:jshintrc = []
    endif
    call s:JSLHintClear()
endfunction
"
" update jshint message
"
let s:counter = 1
function! s:JSLHintUpdate()
    if !exists("b:jslhint_loaded")
        return
    endif
    let s:counter = s:counter + 1
    "echo 'call jsupate...' . s:counter
    silent call s:JSLHint()
    silent call s:ShowCursorJSLHintMsg()
endfunction
"
"
function! s:JSLHintToggleChecker()
    if !exists("b:jslhint_loaded")
        return
    endif
    let s:current_is_jslint = s:current_is_jslint ? 0 : 1
    " update ui
    if s:jslhint_disabled
        call s:JSLHintClear()
    else
        call s:JSLHintUpdate()
    endif
    echomsg ['JSHint', 'JSLint'][s:current_is_jslint]. ' is ' . ['enabled', 'disabled'][s:jslhint_disabled] . '.'
endfunction
"
"function s:JSLHintToggle, to disabled/enable jshint
"
function! s:JSLHintToggleEnable()
    if !exists("b:jslhint_loaded")
        return
    endif
    let s:jslhint_disabled = s:jslhint_disabled ? 0 : 1
    " update ui
    if s:jslhint_disabled
        call s:JSLHintClear()
    else
        call s:JSLHintUpdate()
    endif
    echomsg ['JSHint', 'JSLint'][s:current_is_jslint]. ' is ' . ['enabled', 'disabled'][s:jslhint_disabled] . '.'
endfunction
"
" PrintLongMsg() prints [long] message up to (&columns-1) length
" guaranteed without "Press Enter" prompt.
"
" @param {String} msg
"
function s:PrintLongMsg(msg)
    let x=&ruler | let y=&showcmd
    set noruler noshowcmd
    redraw
    echo a:msg
    let &ruler=x | let &showcmd=y
endfun
"
"
"
function! s:JSLHintClear()
    "if !exists("b:jslhint_loaded")
        "return
    "endif
    " Delete previous matches
    let matches = getmatches()
    for matchId in matches
        if matchId['group'] == 'JSLHintError'
            call matchdelete(matchId['id'])
        endif
    endfor
    let b:matchedlines = {}
    " update quickfix window
    if exists('s:jslhint_qf')
        " if jshint quickfix window is already created, reuse it
        call s:ActivateJSLHintQuickFixWindow()
        call setqflist([], 'r')
    else
        " one jshint quickfix window for all buffers
        call setqflist([])
        let s:jslhint_qf = s:GetQuickFixStackCount()
    endif
endfunction
"
" format the result of jshint checker
" @param {String} result
" @param {Integer} start_line
" @return {List}
function! s:JSLHintResultFormat (result, start_line)
    if !exists("b:jslhint_loaded")
        return []
    endif
    let output = split(a:result, "\n")
    let qf_list = []
    let buf_num = bufnr('%')
    let file_name = expand('%:t')
    for error in output
        " Match {line}:{char}:{error or warn}:{message}
        let parts = matchlist(error, '\v(\d+):(\d+):([A-Z]+):(.*)')
        if empty(parts)
            continue
        endif
        " Get line relative to selection
        if s:current_is_jslint
            let line_num = parts[1] + (a:start_line - 1) - len(b:jslintrc)
        else
            " parst[1] starts at 0
            let line_num = parts[1] + (a:start_line - 1)
        endif
        let error_msg = parts[4]
        if line_num >= 1
            " Store the error for an error under the cursor
            let b:matchedlines[line_num] = error_msg
            if g:JSLHint_highlight_error == 1
                call matchadd('JSLHintError', '\v%' . line_num . 'l\S.*(\S|$)')
            endif
        endif
        " Add line to  list
        call add(qf_list, {
            \ 'bufnr' : buf_num,
            \ 'filename' : file_name,
            \ 'lnum' : line_num,
            \ 'col' : parts[2],
            \ 'text' : error_msg,
            \ 'type' : parts[3] == 'ERROR' ? 'E' : 'W'
            \ })
    endfor
    return qf_list
endfunction

function! s:JSLHint()
    if !exists("b:jslhint_loaded")
        return
    endif
    call s:JSLHintClear()
    if s:jslhint_disabled
        return
    endif
    let jsrc = s:current_is_jslint ? b:jslintrc : b:jshintrc
    if len(jsrc) == 0
        call s:SetBufferJSLHintrc()
        let jsrc = s:current_is_jslint ? b:jslintrc : b:jshintrc
    endif
    " Detect range
    if a:firstline == a:lastline
        " Skip a possible shebang line, e.g. for node.js script.
        let start_line = getline(1)[0:1] == '#!' ? 2 : 1
        let end_line = '$'
    else
        let start_line = a:firstline
        let end_line = a:lastline
    endif

    let js_content = join(getline(start_line, end_line), "\n") . "\n"
    if len(js_content) == 0
        return
    endif
    let cmd = s:cmd_prefix . (s:current_is_jslint ? 'jslint' : 'jshint'). s:cmd_suffix
    if s:current_is_jslint
        let output = system(cmd, join(jsrc, "\n") . "\n" . js_content)
    else
        let jsrc_len = len(jsrc) . "\n"
        let output = system(cmd, jsrc_len . join(jsrc, "\n") . "\n" . js_content)
    endif
    if v:shell_error
        echoerr output
        echoerr 'could not invoke JSLHint!'
        let s:jslhint_disabled = 1
        return
    end
    let qf_list = s:JSLHintResultFormat(output, start_line)
    if exists('s:jslhint_qf')
        " if jshint quickfix window is already created, reuse it
        call s:ActivateJSLHintQuickFixWindow()
        call setqflist(qf_list, 'r')
    else
        " one jshint quickfix window for all buffers
        call setqflist(qf_list)
        let s:jslhint_qf = s:GetQuickFixStackCount()
    endif
    "noautocmd copen
endfunction

" show jshint message for cursor position if the message is exists
" tracing line number for performance
function s:ShowCursorJSLHintMsg()
    if !exists("b:jslhint_loaded")
        return
    endif
    let line_num = getpos('.')[1]
    if line_num == b:line_num
        return
    endif
    let b:line_num = line_num
    " Bail if RunJSLHint hasn't been called yet
    if !exists('b:matchedlines')
        return
    endif
    if has_key(b:matchedlines, line_num)
        let  msg = get(b:matchedlines, line_num)
        call s:PrintLongMsg(msg)
    endif
endfunction

" for good performance
" only call JSLHintUpdate if modified
" and if not modified,  only be called  1  time in 5
" -1 => make sure the first time will be run
"let s:check_counter = -1
function! s:JSLHintUpdateIfModified()
    "let s:check_counter = (s:check_counter + 1) % 5
    "if s:check_counter != 0
        "return
    "endif

    let undo_seq = undotree()['seq_cur']
    if undo_seq == b:undo_cur_seq
        call s:ShowCursorJSLHintMsg()
    else
        let b:undo_cur_seq = undo_seq
        call s:JSLHintUpdate()
    endif
endfunction
"
"
"
function s:GetQuickFixStackCount()
    let stack_count = 0
    try
        silent colder 9
    catch /E380:/
    endtry

    try
        for i in range(9)
            silent cnewer
            let stack_count = stack_count + 1
        endfor
    catch /E381:/
        return stack_count
    endtry
endfunction
"
"
"
function s:ActivateJSLHintQuickFixWindow()
    try
        silent colder 9 " go to the bottom of quickfix stack
    catch /E380:/
    catch /E788:/
    endtry
    if s:jslhint_qf > 0
        try
            exe 'silent cnewer ' . s:jslhint_qf
        catch /E381:/
            echoerr 'Could not activate JSLHint Quickfix Window.'
        endtry
    endif
endfunction
"
"

" export commands
"
if exists(':JSLHintUpdate') != 2
    command! JSToggle :call s:JSLHintToggleChecker()
    command! JSToggleEnable :call s:JSLHintToggleEnable()
    command! JSUpdate :call s:JSLHintUpdate()
    command! JSClear :call s:ClearBufferJSLHint()
    command! JSrc :call s:EchoJSLHintrc()
endif

"

