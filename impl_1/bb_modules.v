`timescale 100 ps/100 ps
module HSOSC (
  CLKHFPU,
  CLKHFEN,
  CLKHF
)
;
input CLKHFPU ;
input CLKHFEN ;
output CLKHF ;
endmodule /* HSOSC */

module PLL_B (
  REFERENCECLK,
  FEEDBACK,
  DYNAMICDELAY7,
  DYNAMICDELAY6,
  DYNAMICDELAY5,
  DYNAMICDELAY4,
  DYNAMICDELAY3,
  DYNAMICDELAY2,
  DYNAMICDELAY1,
  DYNAMICDELAY0,
  BYPASS,
  RESET_N,
  SCLK,
  SDI,
  LATCH,
  INTFBOUT,
  OUTCORE,
  OUTGLOBAL,
  OUTCOREB,
  OUTGLOBALB,
  SDO,
  LOCK
)
;
input REFERENCECLK ;
input FEEDBACK ;
input DYNAMICDELAY7 ;
input DYNAMICDELAY6 ;
input DYNAMICDELAY5 ;
input DYNAMICDELAY4 ;
input DYNAMICDELAY3 ;
input DYNAMICDELAY2 ;
input DYNAMICDELAY1 ;
input DYNAMICDELAY0 ;
input BYPASS ;
input RESET_N ;
input SCLK ;
input SDI ;
input LATCH ;
output INTFBOUT ;
output OUTCORE ;
output OUTGLOBAL ;
output OUTCOREB ;
output OUTGLOBALB ;
output SDO ;
output LOCK ;
endmodule /* PLL_B */

