#!/usr/bin/expect -f
set timeout 30
spawn gemini
expect "Type your message"
send "/chat resume\t\r"
interact
