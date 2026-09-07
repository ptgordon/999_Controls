# Homework build. Run `make` to regenerate script output and build main.pdf.

DOC     := main
SCRIPTS := $(wildcard hw_*.m)
OUTPUTS := $(patsubst %.m,output/%.txt,$(SCRIPTS))
DRAWIOS := $(wildcard *.drawio)
FIGS    := $(patsubst %.drawio,figures/%.pdf,$(DRAWIOS))
DRAWIO  := $(shell command -v drawio 2>/dev/null)

.PHONY: all figures clean distclean

all: $(DOC).pdf

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

clean:
	latexmk -C $(DOC).tex

distclean: clean
	rm -rf output
