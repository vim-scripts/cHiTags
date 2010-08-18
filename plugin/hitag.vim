hi MyFunction ctermfg=green guifg=green
command! HiFun call HiTags('pf', 'MyFunction')
hi MyMacro ctermfg=LightBlue guifg=LightBlue
command! HiMac call HiTags('d', 'MyMacro')
hi MyGVar ctermfg=Red guifg=Red
command! HiGVar call HiTags('v', 'MyGVar')
function! HiSome()
    HiFun
    HiMac
    HiGVar
endfun
command! HiAll call HiSome()
function! HiTags(kinds, hi)
    exec 'syntax clear '.a:hi
    let hiStr = ""
    if !has('win32')
        let trEof = '\n'
    else
        let trEof = '\r\n'
    endif
    for tagFile in tagfiles()
        if filereadable(tagFile)
            let cmd = 'readtags -n -k '.a:kinds.' -t '.tagFile.' -l  | sort -u | tr "'.trEof.'" " "'
            let tmp = system(cmd)
            if !empty(tmp)
                let hiStr = hiStr.tmp." "
            endif
        endif
    endfor
    if !empty(hiStr)
        exec 'syntax keyword '.a:hi.' '.hiStr
    endif
endfun
