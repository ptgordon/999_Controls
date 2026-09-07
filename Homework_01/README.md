# Homework LaTeX template

`main.tex` collates the answers into `main.pdf`. Code listings are pulled
directly from the `.m` files and console output is captured by `make`, so
nothing is copy-pasted by hand.

## Build

    make            # runs each hw_*.m, captures output, builds main.pdf
    make clean      # remove LaTeX build artifacts
    make distclean  # also remove output/

## Diagrams

draw.io files are exported by `make figures`, which shells out to the `drawio`
binary (`pacman -S drawio-desktop`). Wayland/GLib warnings on the console are
harmless as long as the exit code is 0. Without the binary, export by hand:

    draw.io  ->  File  ->  Export as  ->  PDF  ->  crop to page
    save as  figures/<same name>.pdf

Until the export exists, `main.tex` prints a visible placeholder box instead of
failing the build.

## Reusing for the next assignment

1. Copy this folder to `Homework_02/`.
2. Edit the METADATA block at the top of `main.tex`.
3. Replace the SOLUTIONS section at the bottom of `main.tex`.

Helpers available in the SOLUTIONS section:

| macro | does |
|---|---|
| `\problem{2.A}{Title}` | numbered problem heading (title may be empty) |
| `\matlabcode{hw_01_A.m}` | syntax-highlighted listing of the script |
| `\codeoutput{output/hw_01_A.txt}` | the captured console output |
| `\answerfigure{figures/x.pdf}{Caption}` | full-width figure, placeholder if missing |
| `\begin{wideproblem}{1.1b}{Title}...\end{wideproblem}` | problem on its own landscape page, for diagrams too wide to read in portrait |
