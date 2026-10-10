# IEEE Extreme Practice

Solutions to [IEEE Extreme Programming](https://ieeextreme.org/) practice problems,
written in C++.

## Layout

```
src/
  Easy/     # Easy tier problems
  Medium/   # Medium tier problems
  Hard/     # Hard tier problems
  Cheats.cpp
```

Each problem is a standalone `.cpp` file named after the problem, and reads from
stdin / writes to stdout.

## Building

```sh
g++ -std=c++17 -O2 -o build/<name> src/<tier>/<name>.cpp
./build/<name> < input.txt
```

`build/` and `bin/` hold compiled output and are git-ignored.

## Dev shell

A Nix shell with the usual tooling is available:

```sh
nix-shell
```