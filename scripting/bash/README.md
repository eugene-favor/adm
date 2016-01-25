Positional parameters 

```
$1,$2,$3…
```
Stores all the arguments that were entered on the command line ($1 $2 ...).

```
$*
```

Stores all the arguments that were entered on the command line, individually quoted ("$1" "$2" ...).

```
"$@"
```    
    
Stores the number of command-line arguments that were passed to the shell program.

```
 $#.
``` 
 
current options set for the shell.

```
$- 
```

pid of the current shell (not subshell)

```
$$ 
```

most recent parameter (or the abs path of the command to start the current shell immediately after startup)

```
$_ 
```
the (input) field separator

```
$IFS
```

most recent foreground pipeline exit status

```
$?
``` 
 
PID of the most recent background command

```
$!
```

name of the shell or shell script

```
$0 
```