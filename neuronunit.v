`timescale 1ns / 100ps

module neuronunit(dist, norm_dist, divider_flag, in, mu_ini, sigma2_ini, en_input, en_renew, en_divide, renew_flag, ini_para, clk, rst)
  output signed [15:0] dist;
  output signed [15:0] norm_dist;
  output divider_flag; //divider_flag
  input signed [15:0] in;
  input signed [15:0] mu_ini;
  input signed [15:0] sigma2_ini;
  input en_input; //sample input control
  input en_renew; //renew process indicator
  input en_divide; //divider work signal
  input renew_flag; //whether new value or old one
  input ini_para; //for mu sigma2 initialization
  input clk;
  input rst;
  
  reg signed [15:0] in_reg;
  reg signed [15:0] mu;
  reg signed [15:0] sigma2;
  reg signed [15:0] diff_reg;
  reg signed [15:0] diff2_reg;
  reg signed [15:0] dist;
  reg signed [15:0] norm_dist;
  reg divider_flag; //divider flag
  
  wire signed [15:0] diff;
  wire signed [15:0] diff2;
  wire signed [15:0] mu0;
  wire signed [15:0] sigma20;
  wire signed [15:0] mu_new;
  wire signed [15:0] sigma2_new;
  
  //mu,sigma2 data input control
  assign mu0 = ini_para? mu_ini : mu_new;
  assign sigma20 = ini_para? sigma2_ini ; sigma2_new;
  
  //pure logical calculation
  assign diff = in_reg - mu;
  assign diff2 = diff[15]? (-diff) * (-diff) : diff * diff;
  assign dist = diff2;
  
  //renew rule execution
  assign mu_new = renew_flag? (mu + (diff_reg>>3)) : mu;
  assign sigma2_new = renew_flag? (sigma2 + (diff2_reg - sigma2)>>3)) : sigma2;
  
  //examplify the divider
  cordic_div divider(.cordic_div_flag(divider_flag),.quotient(norm_dist),.divident(diff2_reg),.division(sigma2),.clk(clk),.rst(rst),.cordic_div_en(en_divide));
  
  //register transition description
  always @(posedge clk or posedge rst)
  begin
    if (rst) begin in_reg = 16'd0; mu = 16'd0; sigma2 = 16'd0; diff_reg = 16'd0; diff2_reg = 16'd0; norm_dist = 16'd0; eninput = 0; end
    else
      begin
        //diff,diff2 to register
        diff_reg <= diff;
        diff2_reg <= diff2;
        
        //input register renew
        if (en_input) in_reg <= in;
        
        //mu sigma2 register renew
        if (en_renew) begin mu <= mu0; sigma2 <= sigma20; end
      end
    end
  end
end module



