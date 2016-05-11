module cordic_div(cordic_div_flag,quotient,divident,division,clk,rst,cordic_div_en);
  
  output reg signed [15:0]quotient;
  output reg cordic_div_flag;
  
  input signed[15:0]divident;
  input [15:0]division;
  input clk;
  input rst;
  input cordic_div_en;
  
  reg signed[27:0]y; //if result collapsed,try to alloc more bits.
  wire signed[27:0]y_buf;
  reg [15:0]x;
  reg signed[23:0]z;
  
  integer count;
  integer state;
  
  assign y_buf = (divident[15])?{12'hfff,divident}:{12'h000,divident};
  
  always@(posedge clk or negedge rst)
  begin
    if(!rst)begin
      state <= 0;
      count <= 15;
      x <= 0;
      y <= 0;
      z <= 0;
    end
    else begin
      case(state)
        0: begin
          cordic_div_flag <= 0;
          if(cordic_div_en) begin
            x <= division;
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
            count <= 15;
            quotient <= z;
            cordic_div_flag <= 1;
            state <= 0;
          end
        end
      endcase
    end
  end
  
endmodule