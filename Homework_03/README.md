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

    \answerfigure{figures/hw_02_F.pdf}{Caption}

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

## Hand-made figures

Anything `graphicx` reads -- `pdf`, `png`, `jpg` -- can be dropped into
`figures/` and included the same way as a generated plot:

    \answerfigure{figures/2_B_Schematic.png}{The two-mass system of Problem 1.B.}

Put the call wherever the figure belongs in the answer: right after
`\problem{...}` for a schematic the question gives you, or inside `\answer{}`
between two paragraphs. It is an `[H]` float, so it stays exactly where it is
written rather than drifting to the top of the page.

Scans and screenshots are usually smaller than the text block, and stretching
one to `\linewidth` only magnifies its pixels, so give those an explicit width:

    \answerfigure[0.8\linewidth]{figures/2_B_Schematic.png}{Caption.}

A rule of thumb: image width in pixels / 6.5 is the dpi you get at full text
width -- keep that above about 150. The 958 px schematic above is 147 dpi at
full width, 184 dpi at `0.8\linewidth`.

Hand-made figures are prerequisites of `main.pdf`, so `make` and `make watch`
rebuild when you replace one. They are also committed -- `.gitignore` only
skips `figures/hw_*.pdf`, the exports `make` regenerates.

## Tables

A symbol / units / description table -- the one that defines the variables of a
problem -- is `symboltable`:

    \begin{symboltable}{Signal}{}
      \sym{x(t)}{m}{Position of tire center}
      \sym{y(t)}{m}{Position of car frame}
      \sym{r(t)}{m}{Road height (depends on $v_{car}(t)$)}
    \end{symboltable}

The first argument is the heading of the left column (`Signal`, `Parameter`,
`State`, ...); the other two headings are always `Units` and `Description`.
The second argument is the caption -- leave it empty, as above, for a table
with no caption.

`\sym` does the typesetting for you: the symbol goes into math mode and the
units get their brackets, so write `\sym{k_w}{N/m}{Tire Stiffness}`, not
`\sym{$k_w$}{[N/m]}{...}`. Math inside a description is written as usual:
`\sym{M_2}{Kg}{$\frac{1}{4}$ Mass of Car}`.

The description column is `0.45\linewidth` by default and wraps when a
description is longer than that. An optional argument overrides it, which is
what to reach for when a table of short descriptions looks too wide:

    \begin{symboltable}[0.3\linewidth]{Parameter}{Quarter-car parameters.}

Any other table is `answertable`, which takes a column spec instead and leaves
the rows to you:

    \begin{answertable}{|c|P{0.5\linewidth}|}{Pole locations.}
      \hline
      Pole & Behaviour \\ \hline\hline
      $s=-2$ & decays in half a second \\ \hline
      $s=0$  & does not decay \\ \hline
    \end{answertable}

`P{width}` is a centred version of `p{width}`, for a column that has to wrap;
`c`, `l`, `r` and `p{}` all work as normal. Both environments are `[H]` floats
like `\answerfigure`, so they stay where they are written.

## Reusing for the next assignment

1. Copy this folder to `Homework_02/`.
2. Edit the METADATA block at the top of `main.tex`.
3. Replace the SOLUTIONS section at the bottom of `main.tex`.

Helpers available in the SOLUTIONS section:

| macro | does |
|---|---|
| `\problem{2.A}{Title}` | numbered problem heading (title may be empty) |
| `\matlabcode{hw_02_A.m}` | syntax-highlighted listing of the script |
| `\codeoutput{output/hw_02_A.txt}` | the captured console output |
| `\answerfigure{figures/x.pdf}{Caption}` | figure, placeholder if missing (also how a plotted script's export is included) |
| `\answerfigure[0.8\linewidth]{figures/x.png}{Caption}` | same, at a chosen width instead of the full text width |
| `\begin{wideproblem}{1.1b}{Title}...\end{wideproblem}` | problem on its own landscape page, for diagrams too wide to read in portrait |
| `\begin{symboltable}{Signal}{Caption}...\end{symboltable}` | symbol/units/description table; rows are `\sym{x(t)}{m}{Text}`, empty caption prints none |
| `\begin{answertable}{\|c\|c\|}{Caption}...\end{answertable}` | any other table; you write the rows, `P{0.4\linewidth}` is a centred wrapping column |
| `\prompt{Question text}` | italic restatement of the assignment question |
| `\answer{...}` | written answer; leave it empty and a placeholder box prints instead |
