`timescale 1ns/1ps
module rst_tb;
	reg clk, rst_sync;
	wire rst;
	
	initial begin
		clk = 1'b0;
		rst_sync = 1'b0;
		$stop;
		#120
		rst_sync = 1'b1;
		#5000
		rst_sync = 1'b0;
		#2000
		rst_sync = 1'b1;
		#10_000_000
		rst_sync = 1'b0;
		#100
		$finish;
	end
	
	rst_debounce DUT (.clk(clk),
		.rst_sync(rst_sync),
		.rst(rst)
		);
		
	always #5 clk = ~clk;
	
endmodule
