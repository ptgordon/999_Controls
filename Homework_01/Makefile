# Homework build. Run `make` to regenerate script output and build main.pdf.

DOC     := main
SCRIPTS := $(wildcard hw_*.m)
OUTPUTS := $(patsubst %.m,output/%.txt,$(SCRIPTS))
DRAWIOS := $(wildcard *.drawio)
FIGS    := $(patsubst %.drawio,figures/%.pdf,$(DRAWIOS))
DRAWIO  := $(shell command -v drawio 2>/dev/null)
# Any PDF viewer that reloads when the file changes (zathura does).
VIEWER  ?= zathura

.PHONY: all figures clean distclean watch view

# The no-op recipe keeps `make watch` quiet when nothing is stale.
all: $(DOC).pdf
	@:

$(DOC).pdf: $(DOC).tex $(SCRIPTS) $(OUTPUTS) $(wildcard figures/*.pdf)
# -g: force a real run. latexmk cannot see figures reached via \IfFileExists,
# so let make decide staleness (prereqs above) and force latexmk when it does.
	latexmk -pdf -g -silent -interaction=nonstopmode $(DOC).tex

# Console output for each script, captured verbatim.
output/%.txt: %.m
	@mkdir -p output
	octave --no-gui -q $< > $@ 2>&1

# Diagrams. Needs the draw.io desktop app on PATH; otherwise export by hand:
#   draw.io > File > Export as > PDF (crop to page), save into figures/.
figures: $(FIGS)

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
	rm -rf output
