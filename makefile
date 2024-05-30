start:

test:
	iverilog -g2012 -o out -W all tbs/$(filter-out $@,$(MAKECMDGOALS)) > log
	./out
	gtkwave pv.vcd
	rm out

test_vcs:
	vcs -Mupdate tbs/$(filter-out $@,$(MAKECMDGOALS)) -full64 -debug_acc+all+dmptf -debug_region+cell+encrypt -sverilog -l log
	./simv
	gtkwave pv.vcd

test_gui:

	vcs -Mupdate tbs/$(filter-out $@,$(MAKECMDGOALS)) -full64 -debug_acc+all+dmptf -debug_region+cell+encrypt -kdb -sverilog -l log
	./simv -gui &

test_win:
	iverilog -g2012 -o out -W all tbs/$(filter-out $@,$(MAKECMDGOALS)) > log
	vvp out
	gtkwave pv.vcd