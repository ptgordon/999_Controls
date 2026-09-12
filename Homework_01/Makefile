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
# Where `make watch` parks the build chatter, so it can share a terminal with
# an editor without painting over it. Covered by *.log in .gitignore.
BUILDLOG ?= build.log
# PID of the loop inside `make watch`, so `make stop` can find it. Signalling
# make itself is unreliable -- it blocks SIGINT/SIGTERM while a recipe runs --
# so the pidfile records the loop's shell, whose death make does notice.
WATCHPID ?= .watch.pid

.PHONY: all figures clean distclean watch stop view

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
#
# Every rebuild writes to $(BUILDLOG) rather than the terminal: backgrounded in
# the terminal you edit in, a chatty loop scribbles over the editor's screen on
# every save. Only a change in pass/fail state is announced, so a run of broken
# saves says so once instead of once a second.
watch:
	@echo "watching for changes -- build output in $(BUILDLOG); Ctrl-C, or \`make stop\` from another terminal"
	@echo $$$$ > $(WATCHPID); trap 'rm -f $(WATCHPID); exit 0' INT TERM; \
	failed=0; while true; do \
	  if $(MAKE) --no-print-directory all > $(BUILDLOG) 2>&1; then \
	    [ "$$failed" = 1 ] && echo "build OK"; failed=0; \
	  else \
	    [ "$$failed" = 0 ] && echo "build FAILED -- see $(BUILDLOG)"; failed=1; \
	  fi; \
	  sleep 1; \
	done

# Stop a `make watch` started anywhere -- another terminal, a backgrounded job
# you can no longer Ctrl-C, or one orphaned by a closed shell.
stop:
	@if [ -s $(WATCHPID) ] && kill -0 "$$(cat $(WATCHPID))" 2>/dev/null; then \
	  kill "$$(cat $(WATCHPID))" && echo "stopped watcher $$(cat $(WATCHPID))"; \
	  rm -f $(WATCHPID); \
	else \
	  rm -f $(WATCHPID); echo "no watcher running"; \
	fi

# Open the PDF in a viewer that picks up each rebuild. Run in a second
# terminal alongside `make watch`.
view: $(DOC).pdf
	$(VIEWER) $(DOC).pdf

clean:
	latexmk -C $(DOC).tex

distclean: clean
	rm -rf output $(PLOTFIGS) $(BUILDLOG) $(WATCHPID)
