`timescale 1ns / 100ps

module selector_2cen_2bit(out, in_0, in_1, sel);
  output [1:0] out;
  input [1:0] in_0;
  input [1:0] in_1;
  input sel;
  assign out = sel? in_1 : in_0;
endmodule