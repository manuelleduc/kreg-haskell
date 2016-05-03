# KREG.hs
## Description
*KREG.hs* is a command line interface for the [kevoree registry](https://github.com/kevoree/kevoree-registry/tree/jhipster-3.1.0).

The official implementation is in [typescript](https://github.com/kevoree/kreg/tree/typescript).

## Dev dependencies
### Stack
http://docs.haskellstack.org/en/stable/README/

**Installation :** http://docs.haskellstack.org/en/stable/README/#how-to-install

## Building

```
stack build
```


## Execution
```
$ stack exec kreg-exe -- --help
kreg

Usage: kreg-exe (auth | whoami | publish | search)

Available options:
  -h,--help                Show this help text

Available commands:
  auth                     
  whoami                   
  publish                  
  search
```
