function push_all() {
  git add .
  gc -m "let's go"
  git push origin
}

git_checkout_main_branch() {
  default_branch="$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')"
  git checkout "$default_branch"
}


alias jj="push_all"
alias JJ="push_all && gh pr view --web || gh pr create --web"
alias gm="git_checkout_main_branch"

function pc() {
  gh pr checkout $1
}
