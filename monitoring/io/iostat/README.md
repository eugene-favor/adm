Snapshot of Random Read Test:

```
Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s avgrq-sz avgqu-sz   await  svctm  %util
sda               0.00     0.00  172.67    0.00  1381.33     0.00     8.00     0.99    5.76   5.76  99.47
```

Snapshot of Sequential Read Test:

```
Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s avgrq-sz avgqu-sz   await  svctm  %util
sda              13.00     0.00  367.00    0.00 151893.33     0.00   413.88     2.46    6.71   2.72 100.00
```

**rrqm/s wrqm/s** are read and write requests merged per second
**r/s, w/s** read and write requests to the device
**rsec/s, wsec/s** amount of sectors read and written from the device
**avgrq-sz** size of each request
**avgqu-sz** the average queue length of requests to the device
**await** how long requests took to be serviced including their time in the queue
**svctm** how long requests took to be serviced by the device after they left the queue
**%util** Utilization, in more detail, is the service time in ms * total IO operations / 1000 ms. This gives the percentage of how busy the single disk was during the given time slice.

