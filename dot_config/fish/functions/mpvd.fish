function mpvd
    mpv --no-terminal $argv &
    disown
end