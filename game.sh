#!/bin/sh
# Game launcher. The binary resolves shaders/, models/, textures/, config.txt and logs/ RELATIVE TO THE CURRENT
# WORKING DIRECTORY, so launching ./game from a file manager (right-click > Run), a .desktop entry, or any other
# folder makes it exit instantly with "Failed to open file: shaders/fullscreen.vert.spv" - no window, and the
# error lands in a logs/ folder created wherever the launcher happened to be. Same cd-to-my-own-folder fix the
# other launchers already use; run THIS instead of the bare binary.
cd "$(dirname "$0")" || exit 1
# 64MB thread stacks. glibc fixes a thread's default stack from RLIMIT_STACK at EXEC time, so this must be set
# BEFORE the binary starts - the game re-execs itself to achieve the same thing when launched directly.
ulimit -s 65536 2>/dev/null || true
exec ./game "$@"
