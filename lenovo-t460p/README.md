# Lenovo T460p bootstrap

## Key remapping
The _Print_ key is adjacent to the _Right Control_ key.  Since I rarely use the _Print_ key, I aliased _Print_ to _Control_ so that I can hit either key.

Notes:
* I tested the instructions on Ubuntu 18.04.
* I don't know if evdev changes are required.  I made the evdev change first and didn't re-test reverting the changes.  I versioned the modified _evdev_.  Here's the diff:

```
michael@abode:~$ diff ~/evdev.bak /usr/share/X11/xkb/keycodes/evdev 
93a94
>         alias <RCTL> = <PRSC>;
```

