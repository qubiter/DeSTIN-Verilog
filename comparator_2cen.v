`timescale 1ns / 100ps

module comparator_2cen_16bit(b, index, a_0, a_1)
  output signed [15:0] b;
  output index;
  input signed [15:0] a_0;
  input signed [15:0] a_1;
  
  assign l = (a_0 > a_1)? a_0 : a_1;
  assign index = (a_0 > a_1)? 0 : 1;
endmodule