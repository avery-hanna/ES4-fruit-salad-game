if {[catch {

# define run engine funtion
source [file join {C:/lscc/radiant/2023.1} scripts tcl flow run_engine.tcl]
# define global variables
global para
set para(gui_mode) 1
set para(prj_dir) "Z:/Es4/fruit-salad-game/ES4-fruit-salad-game"
# synthesize IPs
# synthesize VMs
# propgate constraints
file delete -force -- fruitSalad_impl_1_cpe.ldc
run_engine_newmsg cpe -f "fruitSalad_impl_1.cprj" "mypll.cprj" -a "iCE40UP"  -o fruitSalad_impl_1_cpe.ldc
# synthesize top design
file delete -force -- fruitSalad_impl_1.vm fruitSalad_impl_1.ldc
run_engine_newmsg synthesis -f "fruitSalad_impl_1_lattice.synproj"
run_postsyn [list -a iCE40UP -p iCE40UP5K -t SG48 -sp High-Performance_1.2V -oc Industrial -top -w -o fruitSalad_impl_1_syn.udb fruitSalad_impl_1.vm] "Z:/Es4/fruit-salad-game/ES4-fruit-salad-game/impl_1/fruitSalad_impl_1.ldc"

} out]} {
   runtime_log $out
   exit 1
}
