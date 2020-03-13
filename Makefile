TARGETS = cv


LATEX   = pdflatex
BIBTEX  = biber

all:  $(MSC_RENDERED) $(TARGETS) debug

$(TARGETS):
	$(LATEX) $@
	-$(BIBTEX) $@ > $(BIBTEX)_out.log
	-$(BIBTEX) $@ > $(BIBTEX)_out.log
	$(LATEX) $@
	$(LATEX) $@
	$(LATEX) $@

debug:
	-grep Warning *.log

clean:
	rm -f *.aux *.bbl *.bcf *.blg *.log *.out *.run.xml *.dvi *.bak *~ $(TARGETS:%=%.pdf)
