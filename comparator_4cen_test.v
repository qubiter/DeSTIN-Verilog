`timescale 1ns / 100ps

module comparator_4cen_test();
  wire signed [15:0] quotient;
  wire cordic_div_flag;
  
  reg signed [15:0] dividend;
  reg signed [15:0] division;
  reg clk;
  reg rst;
  reg cordic_div_en;
  cordic_div_smaller div_exam(.cordic_div_flag(cordic_div_flag), .quotient(quotient), .dividend(dividend), .division(division), .clk(clk), .rst(rst), .cordic_div_en(cordic_div_en));
  
  initial
  begin
    clk = 0;
    rst = 0;
    cordic_div_en = 0;
    dividend = 0;
    division = 0;
    #10
    rst = 1;
    #10
    rst = 0;
    // 1st: 0.8/1.5  8738
    #10
    dividend = 13107;
    division = 24576;
    #10
    cordic_div_en = 1;
    #10
    cordic_div_en = 0;
    // 2nd: 0.03/0.8  629
    #180
    dividend = 492;
    division = 13107;
    #10
    cordic_div_en = 1;
    #10
    cordic_div_en = 0;
    // 3rd: 0.001/0.8  21
    #180
    dividend = 16;
    division = 13107;
    #10
    cordic_div_en = 1;
    #10
    cordic_div_en = 0;
    // 4th: 0.00001/0.8  0
    #180
    dividend = 0;
    division = 13107;
    #10
    cordic_div_en = 1;
    #10
    cordic_div_en = 0;
    // 5th: -0.01/0.8  -209
    #180
    dividend = -164;
    division = 13107;
    #10
    cordic_div_en = 1;
    #10
    cordic_div_en = 0;
    #200
    $stop;
  end
  initial
  begin
  forever
    #5 clk = ~clk;
  end
endmodule
