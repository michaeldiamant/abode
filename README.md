# abode
Simplifies setting up a new computer with bootstrap scripts and saved configs.*

## MacOS Setup
Steps to follow:
* `make first` to start installing dependencies.
* Confirm oh-my-zsh is in working order.
* Run `p10k configure` to install recommended fonts.
* `cd dotfiles && make` to add symbolic links via stow.
* `make first-macos` to switch from FreeBSD to GNU-based tooling (e.g. grep).
* `make second` to install more dependencies.
* `make second-macos` to install macOS-specific dependencies.
* Manually configure some apps:
  * Most apps require security exceptions. Open each app and follow prompts.
  * AltTab, Hyperkey - Not sure where config lives. Must configure in UI.

Make manual system setting changes for improved experience:
* Keyboard: Enable _Keyboard Navigation_.
* Accessibility > Display:
  * Increase _Pointer size_.
  * Enable _Reduce motion_.

Allow applications downloaded from anywhere: `sudo spctl --master-disable`.
