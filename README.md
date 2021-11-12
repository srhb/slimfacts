Check out default.nix -- we're going to manipulate "host data" from
`hosts/*.json` with it :-)

Try out:
```
$ nix repl default.nix
nix-repl> hosts-by.uuid."cdbe0842-b0fc-bc99-14b3-f68a8598529e"
```

(note quotes around the uuid)
