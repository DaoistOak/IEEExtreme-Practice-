# IEEE Extreme Practice

Solutions for [IEEEXtream](https://ieeextreme.org/), written in C++.

## Sources

Two, because they are used at different times:

- **CS Academy** — the official practice archive. The rules point at
  <https://csacademy.com/ieeextreme-practice/>, described as the *"practice
  community, with sample tasks going back as far as IEEEXtream 10.0"*. This is
  where to prepare.
- **HackerRank** — where the next IEEEXtream is being run.

## Layout

```
src/
  csacademy/     # from the practice archive
    Easy/ Medium/ Hard/ Hardest/
  hackerrank/    # from the live contest
    Easy/ Medium/ Hard/ Hardest/
  Cheats.cpp
```

The four tiers are the ones the rules use — tasks are *"categorized as easy,
medium, hard, and hardest"*. There is no official repository layout for the
contest; this one just keeps the two sources apart and mirrors that wording.
Git cannot store an empty directory, so the unused tiers carry a `.gitkeep`.

Each problem is a standalone `.cpp` named after the problem, reading stdin and
writing stdout.

Testcases received from the browser land in a `.testcases/` directory beside
the source rather than next to it, so the source tree stays clean. They are
git-ignored — always re-fetchable.

```
src/csacademy/Easy/
  ASCII-Dancer.cpp
  .testcases/
    ASCII-Dancer_input0.txt
    ASCII-Dancer_output0.txt
```

## Getting problems in

Install [Competitive Companion](https://addons.mozilla.org/en-US/firefox/addon/competitive-companion/)
in your browser (the Firefox build — Zen is Firefox-based). Then:

1. Open a task page.
2. Press `Ctrl+Shift+U`, or click the green **+** in the toolbar.
3. Neovim receives the problem: the source file is created and the sample
   testcases are written next to it.

No port configuration is needed. The extension broadcasts to a fixed list of
ports which includes `27121`, and that is what competItest listens on.

`.competitest.lua` routes what arrives by judge, so a CS Academy task lands in
`src/csacademy/` and a HackerRank one in `src/hackerrank/`. It only pre-fills
the path — the dialog still appears, so you can send it straight to a tier when
you already know the difficulty.

## Running and testing

In Neovim:

| Key            | Does                                    |
| -------------- | --------------------------------------- |
| `<leader>rr`   | compile and run the current file        |
| `<leader>rc`   | compile only                            |
| `<leader>rtx`  | compile and run against the testcases   |
| `<leader>rtr`  | receive testcases for the current file  |
| `<leader>rtp`  | receive a whole problem                 |
| `<leader>rtk`  | run the testcases without recompiling   |

Compiled output goes to `build/`, matching the project root.

By hand:

```sh
g++ -std=c++20 -O2 -o build/<name> src/<source>/<tier>/<name>.cpp
./build/<name> < input.txt
```

## Dev shell

A Nix shell with the usual tooling:

```sh
nix-shell
```
