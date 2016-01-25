for ubuntu 12.04 - 13.10

with GRUB boot loader

1. When OS load hold SHIFT
2. Select boot option, press "e" to edit
3. Add

```
rw init=/bin/bash
```

at the end of string - instead of "ro quiet splash $vt_handoff"

4. Press F10 and get root promt "#"
5. Enter

```
#passwd
```