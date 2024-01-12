.PHONY: all build format edit demo clean

#source?=0
#sink?=1
#graph?=graph2.txt
inp?=hostM.txt
# dune build src/ftest.exe
#./ftest.exe graphs/${graph} $(source) $(sink) outfile
#./htest.exe graphs/${inp} $(source) $(sink) outfile


all: build

build:
	@echo "\n   🚨  COMPILING  🚨 \n"
	dune build src/htest.exe
	ls src/*.exe > /dev/null && ln -fs src/*.exe .

format:
	ocp-indent --inplace src/*

edit:
	code . -n

demo: build
	@echo "\n   ⚡  EXECUTING  ⚡\n"
	./htest.exe graphs/${inp} outfile2
	@echo "\n   🥁  RESULT (content of outfile2)  🥁\n"
	@cat outfile2

clean:
	find -L . -name "*~" -delete
	rm -f *.exe
	dune clean
