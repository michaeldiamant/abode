function push_all() {
  git add .
  gc -m "let's go"
  git push origin
}

git_checkout_main_branch() {
  for branch in master main master-v9; do
    if git show-ref --verify --quiet "refs/heads/$branch" || \
       git show-ref --verify --quiet "refs/remotes/origin/$branch"; then
      git checkout "$branch"
      return
    fi
  done
  echo "❌ No main branch (main/master/master-v9) found in this repo."
}


alias jj="push_all"
alias JJ="push_all && gh pr view --web || gh pr create --web"
alias gm="git_checkout_main_branch"

function pc() {
  gh pr checkout $1
}
