# See following for more information: http://www.infinitered.com/blog/?p=19

# Load in .bashrc -------------------------------------------------
source ~/.bashrc

# Hello Messsage --------------------------------------------------
echo -e "Kernel Information: " `uname -smr`
echo -e "${COLOR_BROWN}`bash --version`"
echo -ne "${COLOR_GRAY}Uptime: "; uptime
echo -ne "${COLOR_GRAY}Server time is: "; date


#alias nr='sudo kill -HUP `cat /opt/nginx/logs/nginx.pid`'

# Notes: ----------------------------------------------------------
# When you start an interactive shell (log in, open terminal or iTerm in OS X, 
# or create a new tab in iTerm) the following files are read and run, in this order:
#     profile
#     bashrc
#     .bash_profile
#     .bashrc (only because this file is run (sourced) in .bash_profile)
#
# When an interactive shell, that is not a login shell, is started 
# (when you run "bash" from inside a shell, or when you start a shell in 
# xwindows [xterm/gnome-terminal/etc] ) the following files are read and executed, 
# in this order:
#     bashrc
#     .bashrc

##
# Your previous /Users/stephen/.bash_profile file was backed up as /Users/stephen/.bash_profile.macports-saved_2011-01-12_at_11:48:26
##

