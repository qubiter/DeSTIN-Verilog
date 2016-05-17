`timescale 1ns / 100ps

module neuronunit_test();
  
  
  wire signed [15:0] dist;
  wire signed [15:0] norm_dist;
  wire divider_flag;
  
  reg clk;
  reg rst;
  reg en_input;
  reg en_renew;
  reg en_divide;
  reg renew_flag;
  reg ini_para;
  
  reg signed [15:0] in;
  reg signed [15:0] mu_ini;
  reg signed [15:0] sigma2_ini;
  
  
  neuronunit neuronunit_exam(.dist(dist), .norm_dist(norm_dist), .divider_flag(divider_flag), .in(in), .mu_ini(mu_ini), .sigma2_ini(sigma2_ini), .en_input(en_input), .en_renew(en_renew), .en_divide(en_divide), .renew_flag(renew_flag), .ini_para(ini_para), .clk(clk), .rst(rst));
  
  initial
  begin
    // initialzation
    clk = 0;
    rst = 0;
    en_input = 0;
    en_renew = 0;
    en_divide = 0;
    renew_flag = 0;
    ini_para = 0;
    in = 0;
    mu_ini = 0;
    sigma2_ini = 0;
    
    // reset
    #10
    rst = 1;
    #10
    rst = 0;
    
    // initialize mu, sigma2: 0.5, 1
    #10
    ini_para = 1;
    #10
    mu_ini = 8192;
    sigma2_ini = 16384;
    #10
    ini_para = 0;
    mu_ini = 0;
    sigma2_ini = 0;
    
    // 1st input:0
    #10
    in = 0;
    #10
    en_input = 1;
    #10
    en_input = 0;
    
    // 1st renew part
    #10
    renew_flag = 1;
    #10
    en_renew = 1;
    #10
    en_renew = 0;
    
    // 1st divide part
    #10
    en_divide = 1;
    #10
    en_divide = 0;
    #140
    
    
    // 2nd input:0
    #10
    in = 0;
    #10
    en_input = 1;
    #10
    en_input = 0;
    
    // 2nd renew part
    #10
    renew_flag = 0;
    #10
    en_renew = 1;
    #10
    en_renew = 0;
    
    // 2nd divide part at least #140
    #10
    en_divide = 1;
    #10
    en_divide = 0;
    #140
    
    // 3rd input:0.2
    #10
    in = 3277;
    #10
    en_input = 1;
    #10
    en_input = 0;
    
    // 3rd renew part
    #10
    renew_flag = 1;
    #10
    en_renew = 1;
    #10
    en_renew = 0;
    
    // 3rd divide part at least #140
    #10
    en_divide = 1;
    #10
    en_divide = 0;
    #140

    #100
    $stop;
  end
  
  //clock
  initial
  begin
  forever
    #5 clk = ~clk;
  end
endmodule
