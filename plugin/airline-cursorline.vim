let g:highlight_cursor_linenr = ''

function! HighlightCursorLineNr(mode)
    " Only update if we have changed mode
    " for avoiding flickering
    if g:highlight_cursor_linenr == a:mode
        return ''
    endif

    let fg_color = 'NONE'
    let bg_color = 'NONE'
    let palette = g:airline#themes#{g:airline_theme}#palette

    " We get the palette from the 'section_a' where is displayed the actual
    " mode.
    " [0] = foreground color
    " [1] = background color
    if a:mode == 'NORMAL' || a:mode == 'COMMAND'
        let fg_color = palette.normal['airline_a'][0]
        let bg_color = palette.normal['airline_a'][1]
    elseif a:mode == 'INSERT'
        let fg_color = palette.insert['airline_a'][0]
        let bg_color = palette.insert['airline_a'][1]
    elseif a:mode == 'VISUAL' || a:mode == 'V-LINE' || a:mode == 'V-BLOCK'
        let fg_color = palette.visual['airline_a'][0]
        let bg_color = palette.visual['airline_a'][1]
    endif

    execute 'hi CursorLineNr guifg=' . fg_color . ' guibg=' . bg_color
    "
    " Refresh the screen, otherwise the highlighting doesn't execute
    " until a key is pressed
    redraw

    let g:highlight_cursor_linenr = a:mode

    return ''
endfunction

augroup HighlightCursorLine
    autocmd!
    autocmd VimEnter * let g:airline_section_a .= '%{HighlightCursorLineNr(airline#parts#mode())}' | AirlineRefresh | redraw
augroup END
