# Dell Latitude 5411 boostrap

## Key remapping
The keyboard shares _Home_, _End_, and _Insert_ with function keys and numlock.  Toggling the fn key to access non-function keys complicates programming (e.g. _F3_ jump to definition).  To improve my workflow, I inverted mappings to access _Home_, _End_, and _Insert_ without toggling the fn key.


Original keycode mappings discovered via `xev -event keyboard`:
| Default action | Fn action
|---|---|
| F11 = 95 | Home = 110
| F12 = 96 | End = 115
| Numlock = 118 | Insert = 77


Exporting configuration:  `xmodmap -pke`

Resources:
* https://medium.com/@saplos123456/persistent-keyboard-mapping-on-ubuntu-using-xmodmap-cd01ad828fcd
* https://askubuntu.com/a/24930

## Grub updates
The default CPU c-states configuration causes random freezing.  After fixing the freezing, I discovered the CPU does _not_ turn off when put to sleep.  Through experimentation, I landed on the following grub configurations to make it all work.

Append the following to `/etc/default/grub`.  After saving, apply via `sudo update-grub`, and restart:
`GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi=force intel_idle.max_cstate=3 mem_sleep_default=deep"`

After restart, confirm the settings took effect:
* `grep . /sys/devices/system/cpu/cpu0/cpuidle/state*/name`
* `cat /sys/module/intel_idle/parameters/max_cstate`
* `cat /sys/power/mem_sleep`

Resources:
* https://downloads.dell.com/manuals/all-products/esuprt_laptop/esuprt_laptop_latitude/latitude-14-5411-laptop_reference-guide_en-us.pdf
* https://www.dell.com/community/Latitude/Latitude-5401-Battery-drain-in-S3-sleep-in-Linux/td-p/7852462?ref=lithium_reltopic
* https://www.kernel.org/doc/Documentation/power/states.txt
