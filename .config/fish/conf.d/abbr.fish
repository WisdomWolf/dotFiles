if not set -q ABBR_INIT_COMPLETE
    echo 'Initializing abbrs'

    abbr -a -U -- ipy ipython
    abbr -a -U -- pacI 'sudo pacman -Syu'
    abbr -a -U -- pacQ 'pacman -Qi'
    abbr -a -U -- pacS 'pacman -Qs'
    abbr -a -U -- pacU 'pacman -U'
    abbr -a -U -- pacb 'makepkg -sci'
    abbr -a -U -- pacblame 'pacman -Qo'
    abbr -a -U -- pacd 'pacman -U *.pkg.*'
    abbr -a -U -- paci 'sudo pacman -S'
    abbr -a -U -- pacol 'pacman -Qdt'
    abbr -a -U -- pacor 'pacman -Rns (pacman -Qtdq)'
    abbr -a -U -- pacown 'pacman -Ql'
    abbr -a -U -- pacq 'pacman -Si'
    abbr -a -U -- pacr 'pacman -R'
    abbr -a -U -- pacrm 'pacman -Rns'
    abbr -a -U -- pacs 'pacman -Ss'
    abbr -a -U -- pacu 'pacman -Syyu'
    abbr -a -U -- upgrade 'sudo pacman -Sy && sudo powerpill -Su && paru -Su'

    set -U ABBR_INIT_COMPLETE true
end
