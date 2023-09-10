# Workaround to yank into macOS system clipboard.
# Source: https://github.com/jeffreytse/zsh-vi-mode/issues/19
function zvm_vi_yank() {
	zvm_yank
	echo ${CUTBUFFER} | pbcopy
	zvm_exit_visual_mode
}
