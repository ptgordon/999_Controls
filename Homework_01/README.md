# Homework LaTeX template

`main.tex` collates the answers into `main.pdf`. Code listings are pulled
directly from the `.m` files and console output is captured by `make`, so
nothing is copy-pasted by hand.

## Build

    make            # runs each hw_*.m, captures output, builds main.pdf
    make watch      # same, but rebuilds automatically on every save
    make view       # open main.pdf in a viewer (VIEWER=okular make view)
    make clean      # remove LaTeX build artifacts
    make distclean  # also remove output/

## Live rebuilds

`make watch` polls once a second and rebuilds whatever is stale -- editing
`main.tex` rebuilds the PDF, editing a `hw_*.m` re-runs it through octave and
then rebuilds. Ctrl-C stops it. Run `make view` in a second terminal: zathura
reloads the PDF on its own, so the page updates a second or so after each save.

Build output goes to `build.log`, not the terminal, so `make watch &` in the
terminal you edit in will not scribble over the editor on every save. The only
thing it prints is a line when the build starts failing and another when it
starts passing again; `cat build.log` for the details. (A backgrounded job
still shares the terminal, so anything it printed would land on top of nvim --
that is what the log file avoids. `BUILDLOG=/tmp/hw.log make watch` moves it.)

(`latexmk -pvc` does the same for LaTeX alone, but it will not re-run octave
when a script changes, so the captured output would go stale.)

## Plots

A script that plots is also exported to `figures/<script>.pdf` by `make`. The
script itself stays plain -- `figure; plot(t,y); xlabel(...)` -- and the
Makefile runs it headless, sets the paper size to the figure size and prints
it, so the PDF page is cropped tight and `\answerfigure` scales it to the text
width. Include it with:

    \answerfigure{figures/hw_01_F.pdf}{Caption}

Detection is automatic: any `hw_*.m` containing a plotting call gets a figure
target, so a new plotting script needs no Makefile edit. Override the export
size with `make FIGSIZE="7 3"`. A plotting script also gets the usual
`output/<script>.txt`; it is just empty unless the script prints something too.

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
| `\answerfigure{figures/x.pdf}{Caption}` | full-width figure, placeholder if missing (also how a plotted script's export is included) |
| `\begin{wideproblem}{1.1b}{Title}...\end{wideproblem}` | problem on its own landscape page, for diagrams too wide to read in portrait |
| `\prompt{Question text}` | italic restatement of the assignment question |
| `\answer{...}` | written answer; leave it empty and a placeholder box prints instead |
