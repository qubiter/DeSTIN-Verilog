module cordic_div_smaller(cordic_div_flag, quotient, dividend, division, clk, rst, cordic_div_en);
  parameter M = 1 ; // dividend shift bits (<<) 
  parameter N = 13; // division shift bits (>>) M + N = FractionLength
  parameter COUNT = 14; //Maximum count number
  
  output reg signed [15:0] quotient;
  output reg cordic_div_flag;
  
  input signed [15:0] dividend;
  input signed [15:0] division;
  input clk;
  input rst;
  input cordic_div_en;
  
  reg signed [35:0] y; //if result collapsed,try to alloc more bits.
  wire signed [35:0] y_buf;
  wire signed [19:0] y_mv;
  wire signed [19:0] y_mv2;
  
  reg [19:0] x;
  wire signed [19:0] x_mv;
  wire signed [19:0] x_mv2;
  
  reg signed [15:0] z;
  
  integer count;
  integer state;
  
  //extend the dividend's bit number
  assign y_mv = {dividend, 4'h0};
  assign y_mv2 = y_mv <<< M;  // redifine y_mv to get a right representation of z
  assign x_mv = {division, 4'h0};
  assign x_mv2 = x_mv >>> N;  // redifine x_mv to get a right representation of z
  assign y_buf = (y_mv2[19])?{16'hffff, y_mv2}:{16'h0000, y_mv2}; 
  
  always@(posedge clk or negedge rst)
  begin
    if(rst)begin
      state <= 0;
      count <= COUNT;
      x <= 0;
      y <= 0;
      z <= 0;
    end
    else begin
      case(state)
        0: begin
          cordic_div_flag <= 0;
          if(cordic_div_en) begin
            x <= x_mv2;
            y <= y_buf;
            z <= 0;
            state <= 1;
          end
        end
        1: begin
          if(count >= 0)begin
            count <= count - 1;
            if(y==0)begin
              y <= y;
              z <= z;
            end
            else if(y<0)begin
              z <= z - (1<<count);
              y <= y + (x<<count);
            end
            else begin
              z <= z + (1<<count);
              y <= y - (x<<count);
            end 
          end
          else begin
            count <= COUNT;
            quotient <= z;
            cordic_div_flag <= 1;
            state <= 0;
          end
        end
      endcase
    end
  end
  
endmodule