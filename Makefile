COFFEE_PATHS := test

coffee:
	./node_modules/coffee-script/bin/coffee -c $(COFFEE_PATHS)

docs: docco sweeten_docco

docco:
	./node_modules/docco/bin/docco test/fixtures/*.coffee

sweeten_docco:
	./sweeten-docco

test: coffee
	node test/basic_test

clean: clean_coffee clean_docs

clean_coffee:
	-find $(COFFEE_PATHS) -name '*.coffee' | sed 's/coffee$$/js/' |xargs rm

clean_docs:
	-rm -rf docs

.PHONY: coffee docco sweeten_docco test clean clean_coffee clean_docs
