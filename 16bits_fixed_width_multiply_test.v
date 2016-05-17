`timescale 1ns / 100ps

module multiplier_test();
  
  
  wire signed [15:0] c;
  
  reg signed [15:0] a;
  reg signed [15:0] b;
  reg clk;
    
  fixed_width_multiply_16bits multi_test(.a(a), .b(b), .c(c));
  
  initial
  begin
    // initialzation
    clk = 0;
    a = 0;
    b = 0;
    
    // test part
    // 1st: 0.12*0.34: 668
    #10
    a = 1966;
    b = 5571;
    
    // 2nd: 0.12*-0.34: -669
    #10
    a = 1966;
    b = -5571;
    
    // 3rd: -0.12*0.26: -512
    #10
    a = -1966;
    b = 4260;
    
    // 4th: 0.01*-0.01: -2
    #10
    a = 164;
    b = -164;
    

    #50
    $stop;
  end
  
  //clock
  initial
  begin
  forever
    #5 clk = ~clk;
  end
endmodule
