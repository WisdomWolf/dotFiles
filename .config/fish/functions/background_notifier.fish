function background_notifier --on-event bg_notify_event
    set msg_levels DEBUG NOTICE ERROR INFO
    if contains $argv[1] msg_levels
        set notice_level $argv[1]
        set msg $argv[2..-1]
    else
        set notice_level "NOTICE"
        set msg $argv
    end
    echo "$notice_level: $msg"
end
