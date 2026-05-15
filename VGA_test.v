`timescale 1ns/1ps
module VGA_test;
	reg clk;
	wire R, G, B, H_SYNC, V_SYNC;

	initial begin
		$stop;
		clk = 1'b0;
	end

	always #10 clk = ~clk;

	VGA dut (.clk_50(clk),
		.R(R),
		.G(G),
		.B(B),
		.H_SYNC(H_SYNC),
		.V_SYNC(V_SYNC)
	);

	initial begin
		#16000000
		$finish;
	end

endmodule

