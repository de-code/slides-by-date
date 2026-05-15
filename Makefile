MARP := node_modules/.bin/marp
CHROME_BIN := $(shell ls $(HOME)/.cache/puppeteer/chrome/*/chrome-linux64/chrome 2>/dev/null | sort -V | tail -1)
SLIDES := $(patsubst %/,%,$(sort $(dir $(wildcard 2*-*/slides.md))))
OUT := output

.PHONY: install vscode all-pdf $(SLIDES:%=%.pdf) $(SLIDES:%=%.html) $(SLIDES:%=%.pptx)

install: node_modules vscode

node_modules:
	npm install

vscode:
	mkdir -p .vscode
	@( [ -f .vscode/settings.json ] && cat .vscode/settings.json || echo '{}' ) | \
	  jq '."markdown.marp.themes" = ["./themes/slides.css"]' > .vscode/settings.json.tmp
	mv .vscode/settings.json.tmp .vscode/settings.json

all-pdf: $(SLIDES:%=%.pdf)

$(SLIDES:%=%.pdf): %.pdf: %/slides.md | $(OUT)
	CHROME_NO_SANDBOX=1 $(MARP) $< --output $(OUT)/$@ --browser-path $(CHROME_BIN)

$(SLIDES:%=%.html): %.html: %/slides.md | $(OUT)
	$(MARP) $< --output $(OUT)/$@

$(SLIDES:%=%.pptx): %.pptx: %/slides.md | $(OUT)
	CHROME_NO_SANDBOX=1 $(MARP) $< --output $(OUT)/$@ --browser-path $(CHROME_BIN)

$(OUT):
	mkdir -p $(OUT)
