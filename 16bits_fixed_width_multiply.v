module fixed_width_multiply_16bits(a,b,c);
	input signed[15:0] a,b;
	output signed [15:0] c;
	wire signed[31:0] d;
	wire saturation_pos,saturation_neg;
	assign d= a*b;
	assign saturation_pos = |d[30:29];
	assign saturation_neg = &d[30:29];
	assign c = (d[31]==0&&saturation_pos==1)?16'b0111_1111_1111_1111:((d[31]==1&&saturation_neg==0)?16'b1000_0000_0000_0000:d[29:14]);
endmodule