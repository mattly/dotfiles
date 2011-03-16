"----------------------------------------------------------------------
" table_format.vim
" Makes range/selection into neatly formatted table
"
" Copyright (c) 2003 Michael Graz
" mgraz.vim@plan10.com

if exists('loaded_plugin_table')
    finish
endif
let loaded_plugin_table = 1

"----------------------------------------------------------------------
" Globals

" Table mode 0
if ! exists ('g:table_0_split')
    let g:table_0_split = 1
endif
if ! exists ('g:table_0_padding')
    let g:table_0_padding = 1
endif
" Table mode 1
if ! exists ('g:table_1_split')
    let g:table_1_split = 2
endif
if ! exists ('g:table_1_padding')
    let g:table_1_padding = 3
endif

"----------------------------------------------------------------------
" Mappings

if !hasmapto('<Plug>NormalTableMode0', 'n')
    nmap <silent> <Leader>a :.,'}call <Sid>TableInternal(0, 0)<cr>
endif
if !hasmapto('<Plug>VisualTableMode0', 'v')
    vmap <silent> <Leader>a "ty:call <Sid>TableInternal(0, 1)<cr>
endif

if !hasmapto('<Plug>NormalTableMode1', 'n')
    nmap <silent> <Leader>A :.,'}call <Sid>TableInternal(1, 0)<cr>
endif
if !hasmapto('<Plug>VisualTableMode1', 'v')
    vmap <silent> <Leader>A "ty:call <Sid>TableInternal(1, 1)<cr>
endif

"----------------------------------------------------------------------
" Helper function used by mappings

function! <Sid>TableInternal(table_mode, visual_mode) range
    if a:table_mode == 0
        let space_split   = g:table_0_split
        let space_padding = g:table_0_padding
    else
        let space_split   = g:table_1_split
        let space_padding = g:table_1_padding
    endif
    if a:visual_mode == 0
        call TableRange (a:firstline, a:lastline, space_split, space_padding)
    else
        let line_start = a:firstline
        let line_end = line_start + strlen(substitute (@t, "[^\n]", "", "g"))
        if visualmode() == "\<c-v>"
            " This is blockwise visual mode, so pass along the columns
            let col_start = virtcol("'<")
            let col_end = col_start + strpart(getregtype('t'), 1)
            call TableRange (line_start, line_end, space_split, space_padding, 0, col_start, col_end)
        else
            " Linewise visual, so do not pass columns
            call TableRange (line_start, line_end-1, space_split, space_padding)
        endif
    endif
endfunction

"----------------------------------------------------------------------
" Main table functions
" Args:
"   space_split = 1
"   space_padding = space_split
"   max_field_length = 0
"   col_start = 0
"   col_end = 0  -- end of line

function! Table(...) range
    if a:0 == 0
        call TableRange (a:firstline, a:lastline)
    elseif a:0 == 1
        call TableRange (a:firstline, a:lastline, a:1)
    elseif a:0 == 2
        call TableRange (a:firstline, a:lastline, a:1, a:2)
    elseif a:0 == 3
        call TableRange (a:firstline, a:lastline, a:1, a:2, a:3)
    elseif a:0 == 4
        call TableRange (a:firstline, a:lastline, a:1, a:2, a:3, a:4)
    elseif a:0 == 5
        call TableRange (a:firstline, a:lastline, a:1, a:2, a:3, a:4, a:5)
    else
        echo "** Error: expecting only a maximum of 5 parameters"
    endif
endfunction

function! TableRange(line_start, line_end, ...)
    let space_split = 1
    let space_padding = 1
    let max_field_len = 0
    let col_start = 0
    let col_end = 0

    " Parse parameters
    if a:0 >= 1
        let value = a:1
        if value < 1
            let value = 1
        endif
        let space_split = value
        let space_padding = value
    endif
    if a:0 >= 2
        let space_padding = a:2
    endif
    if a:0 >= 3
        let max_field_len = a:3
    endif
    if a:0 >= 4
        let col_start = a:4
    endif
    if a:0 >= 5
        let col_end = a:5
    endif
    if a:0 > 5
        echo "** Error: expecting only a maximum of 5 parameters"
        return
    endif

    let fld_cnt = 0         " number of fields found
    let indent_len = 1000   " amount to indent

    " One side effect is that tabs are converted to spaces
    " before the table is formatted.
    let expandtab_save = &expandtab
    set expandtab
    exe a:line_start.','.a:line_end.' retab'

    " Iterate over range
    let line_num = a:line_start
    while line_num <= a:line_end
        call <Sid>Tokenize (line_num, space_split, col_start, col_end)
        if s:tkn_count == 0
            let line_num=line_num+1
            continue      " skip blank lines
        endif

        " Min indentation
        if s:tkn_indent < indent_len
            let indent_len = s:tkn_indent
        endif

        let i=0
        while i < s:tkn_count
            " Get current max field length
            if i >= fld_cnt
                let max_len = 0
            else
                exe 'let max_len = fld_'.i
            endif

            " Get current token length
            exe 'let token_len = s:tkn_len_'.i
            if max_field_len > 0 && token_len > max_field_len
                let token_len = max_field_len
            endif

            " Should this length be saved?
            if i >= fld_cnt || token_len > max_len
                " This is the max token length seen so far for this field
                exe 'let fld_'.i.' = '.token_len
            endif

            " Update max number of fields seen
            if i >= fld_cnt
                let fld_cnt = i + 1
            endif

            let i=i+1
        endwhile

        let line_num=line_num+1
    endwhile

    " At this point:
    " indent_len has the min indentation
    " fld_cnt has the max field count
    " fld_0, fld_1, ... have the max field sizes

    " Determine length of result line
    let i=0
    let line_len=0
    while i < fld_cnt
        exe 'let len = fld_'.i
        let line_len = line_len + len
        if i > 0
            let line_len = line_len + space_padding
        endif
        let i=i+1
    endwhile
    if line_len > col_end - col_start
        let pad_extra = space_padding
    elseif line_len < col_end - col_start
        let pad_extra = col_end - col_start - line_len
    else
        let pad_extra = 0
    endif

    " debugging
    if 0
        echo "indent_len" indent_len
        echo "fld_cnt" fld_cnt
        let i=0
        while i < fld_cnt
            exe 'let len = fld_'.i
            echo "fld_" i len
            let i=i+1
        endwhile
        return
    endif

    " Blank string used for padding
    let blanks='                                                  '
    let blanks=blanks.blanks.blanks.blanks

    " Build up indent string
    let indent_str = strpart(blanks, 1, indent_len)

    " Iterator over range again
    let line_num = a:line_start
    while line_num <= a:line_end
        call <Sid>Tokenize (line_num, space_split, col_start, col_end)
        if s:tkn_count == 0
            let line_num=line_num+1
            continue      " skip blank lines
        endif

        " Start building string
        let str = indent_str

        let i=0
        while i < s:tkn_count
            " Retrieve token and length
            exe 'let token_str = s:tkn_str_'.i
            exe 'let token_len = s:tkn_len_'.i

            " Pad the token if it is not the last
            if i+1 < s:tkn_count
                " Get max field length
                exe 'let fld_len = fld_'.i
                if fld_len > token_len
                    " Pad the token
                    let pad_len = fld_len - token_len
                    let pad_str = strpart (blanks, 1, pad_len)
                    let token_str = token_str . pad_str
                endif
            endif

            " Add space between tokens
            if i > 0
                let str = str . strpart (blanks, 0, space_padding)
            endif

            " Add the token to the string
            let str = str . token_str

            let i=i+1
        endwhile

        " Get rest of line if just dealing with a fragment
        if col_start > 0
            let str_len = strlen(str)
            let str0 = getline (line_num)
            let str = strpart(str0, 0, col_start-1) . str
            if col_end > 0
                let pad_len = line_len - str_len + pad_extra
                let pad_str = strpart (blanks, 1, pad_len)
                let str = str . pad_str . strpart(str0, col_end-1)
            endif
        endif

        " Replace the old line
        exe line_num 'delete'
        call append (line_num-1, str)

        let line_num=line_num+1
    endwhile

    if col_end > 0
        " Clean up any extra spaces added to the end of lines
        exe 'silent '.a:line_start.','.a:line_end.' substitute / \+$//e'
    endif

    echo 'processed '.(a:line_end-a:line_start+1).' lines'

    let &expandtab = expandtab_save
endfunction

"----------------------------------------------------------------------
" Input:
"   pattern_mode
"   0: tokens are complete words separated by a one or more spaces
"   1: tokens are groups of words separated by two or more spaces
" Output:
"   tkn_count: number of tokens found
"   tkn_indent: indentation of first token
"   tkn_str_0, tkn_str_1, ...: the actual tokens
"   tkn_len_0, tkn_len_1, ...: length of each token

function! <Sid>Tokenize(line_num, space_split, col_start, col_end)
    let s:tkn_count = 0

    " Retrieve the string
    let str = getline (a:line_num)

    " Get the part of the string of interest
    if a:col_start > 0 && a:col_end > 0
        let str = strpart (str, a:col_start-1, a:col_end-a:col_start)
    elseif a:col_start > 0
        let str = strpart (str, a:col_start-1)
    endif

    " Indentation
    let s:tkn_indent = strlen(matchstr (str, '^\s*'))

    " Trim leading space
    let str = substitute (str, '^\s\+', '', '')

    if a:space_split == 1
        let pattern = '^\S\+'
    else
        " example: ^\S\+\( \{1,3}\S\+\)*
        let split = a:space_split - 1
        let pattern = '^\S\+\( \{1,'.split.'}\S\+\)*'
    endif

    " Get tokens
    let i=0
    while i < 100
        let token = matchstr (str, pattern)
        let length = strlen (token)

        if length == 0
            break
        endif

        " Assign global variables
        exe 'let s:tkn_str_'.i.' = token'
        exe 'let s:tkn_len_'.i.' = length'

        " Advance to next token
        let str = substitute (str, pattern, '', '')
        let str = substitute (str, '^\s\+', '', '')
        let i=i+1
    endwhile
    let s:tkn_count = i

endfunction

