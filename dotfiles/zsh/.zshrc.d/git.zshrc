function push_all() {
  git add .
  gc -m "let's go"
  gps
}

alias jj="push_all"
alias JJ="push_all && gh pr view --web || gh pr create --web"

function pc() {
  gh pr checkout $1
}
