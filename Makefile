.POSIX:
.SUFFIXES:

OCAMLC = ocamlfind ocamlc
OCAMLOPT = ocamlfind ocamlopt

PACKAGE = -package tsdl,gg,tgls.tgl3 -linkpkg

all: dice
dice: dice.cmx log.cmx main.cmx
	@echo "+ $@"
	@$(OCAMLOPT) -o $@ $(PACKAGE) dice.cmx log.cmx main.cmx

main.cmx: dice.cmx log.cmx
dice.cmx: dice.cmi
log.cmx: log.cmi

.PHONY: clean
clean:
	@rm -f dice
	@find . -name '*.cmx' -or -name '*.cmi' -or -name '*.o' | xargs rm -f

.SUFFIXES: .ml .cmx
.ml.cmx:
	@echo "+ $<"
	@$(OCAMLOPT) $(PACKAGE) -c $<

.SUFFIXES: .mli .cmi
.mli.cmi:
	@echo "+ $<"
	@$(OCAMLC) $(PACKAGE) -c $<
