`timescale 1ns / 100ps

module comparator_8cen_16bit(d, arg, a_000, a_001, a_010, a_011, a_100, a_101, a_110, a_111);
  output [15:0] d;
  output [2:0] arg;
  input [15:0] a_000;
  input [15:0] a_001;
  input [15:0] a_010;
  input [15:0] a_011;
  input [15:0] a_100;
  input [15:0] a_101;
  input [15:0] a_110;
  input [15:0] a_111;
  
  wire [15:0] c_0;
  wire [15:0] c_1;
  wire [1:0] index_0;
  wire [1:0] index_1;
  wire index;
  
  assign arg[2] = index;
  
  comparator_4cen_16bit compare_a_0xx(.arg(index_0), .c(c_0), .a_00(a_000), .a_01(a_001), .a_10(a_010), .a_11(a_011));
  comparator_4cen_16bit compare_a_1xx(.arg(index_1), .c(c_1), .a_00(a_100), .a_01(a_101), .a_10(a_110), .a_11(a_111));
  comparator_2cen_16bit compare_c_x(.b(d), .index(index), .a_0(c_0), .a_1(c_1));
  selector_2cen_2bit select_index_x(.out(arg[1:0]), .in_0(index_0), .in_1(index_1), .sel(index));
endmodule