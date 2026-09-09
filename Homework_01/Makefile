# Homework build. Run `make` to regenerate script output and build main.pdf.

DOC     := main
SCRIPTS := $(wildcard hw_*.m)
OUTPUTS := $(patsubst %.m,output/%.txt,$(SCRIPTS))
DRAWIOS := $(wildcard *.drawio)
FIGS    := $(patsubst %.drawio,figures/%.pdf,$(DRAWIOS))
# Scripts that draw something also get a PDF export of the figure. Detected by
# looking for a plotting call, so a new plotting script needs no edit here.
PLOTCALLS := plot|semilogx|semilogy|loglog|stem|stairs|bar|hist|surf|mesh|contour|step|impulse|bode|nyquist|rlocus
LPAREN    := (
PLOTM     := $(shell grep -lE '^[^%#]*\b($(PLOTCALLS))[[:space:]]*\$(LPAREN)' $(SCRIPTS) /dev/null)
PLOTFIGS  := $(patsubst %.m,figures/%.pdf,$(PLOTM))
# Exported figure size, in inches. The PDF page is cropped to exactly this, so
# \includegraphics scales it to the text width with no stray margins.
FIGSIZE ?= 6.5 4
DRAWIO  := $(shell command -v drawio 2>/dev/null)
# Any PDF viewer that reloads when the file changes (zathura does).
VIEWER  ?= zathura

.PHONY: all figures clean distclean watch view

# The no-op recipe keeps `make watch` quiet when nothing is stale.
all: $(DOC).pdf
	@:

$(DOC).pdf: $(DOC).tex $(SCRIPTS) $(OUTPUTS) $(PLOTFIGS) $(wildcard figures/*.pdf)
# -g: force a real run. latexmk cannot see figures reached via \IfFileExists,
# so let make decide staleness (prereqs above) and force latexmk when it does.
	latexmk -pdf -g -silent -interaction=nonstopmode $(DOC).tex

# Console output for each script, captured verbatim.
# Figures are forced invisible so a build never pops a plot window open.
output/%.txt: %.m
	@mkdir -p output
	octave --no-gui -q --eval "set(0,'defaultfigurevisible','off'); run('$<');" > $@ 2>&1

# Diagrams. Needs the draw.io desktop app on PATH; otherwise export by hand:
#   draw.io > File > Export as > PDF (crop to page), save into figures/.
figures: $(FIGS) $(PLOTFIGS)

# Figure drawn by a script: run it headless, then print whatever figure it left
# open. Scripts keep plain `figure; plot(...)` -- the export lives here.
figures/hw_%.pdf: hw_%.m
	@mkdir -p figures
	octave --no-gui -q --eval "set(0,'defaultfigurevisible','off'); run('$<'); f = gcf(); set(f, 'paperunits','inches', 'papersize',[$(FIGSIZE)], 'paperposition',[0 0 $(FIGSIZE)]); print(f, '-dpdf', '$@');"

figures/%.pdf: %.drawio
	@mkdir -p figures
ifeq ($(DRAWIO),)
	@echo "drawio CLI not found -- export $< to $@ manually (File > Export as > PDF)"; false
else
	$(DRAWIO) --export --crop --format pdf --output $@ $<
endif

# Rebuild on every save. Polls once a second and lets make decide whether
# anything is actually stale, so an idle loop costs nothing. Ctrl-C to stop.
# Unlike `latexmk -pvc` this also re-runs octave when a .m file changes.
watch:
	@echo "watching for changes -- Ctrl-C to stop"
	@while true; do $(MAKE) --no-print-directory all; sleep 1; done

# Open the PDF in a viewer that picks up each rebuild. Run in a second
# terminal alongside `make watch`.
view: $(DOC).pdf
	$(VIEWER) $(DOC).pdf

clean:
	latexmk -C $(DOC).tex

distclean: clean
	rm -rf output $(PLOTFIGS)
