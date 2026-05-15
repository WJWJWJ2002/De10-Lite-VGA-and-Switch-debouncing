module VGA (input clk_50, rst,
	output reg[7:0] R, G, B,
	output wire H_SYNC, V_SYNC
);
	
	wire clk_25;
	PLL vga_pll (.inclk0(clk_50),
		.c0(clk_25)
	);

	reg[9:0] h_count;
	reg[9:0] v_count;

	initial begin
		h_count <= 10'd0;
		v_count <= 10'd0;
	end
	always @(posedge clk_25) begin
		if (!rst) begin
			h_count <= 10'd0;
			v_count <= 10'd0;
		end
		else begin
			h_count <= (h_count == 10'd799) ? 10'd0 : h_count + 1'b1;
			v_count <= (h_count == 10'd799) ? ((v_count == 10'd524) ? 10'd0 : v_count + 1'b1) : v_count;
		end
	end

	always @(*) begin
		if (!rst) begin
			R = 8'd0;
			G = 8'd0;
			B = 8'd0;
		end
		else if (v_count < 10'd100 && h_count <= 10'd639) begin
			R = 8'd255;
			G = 8'd255;
			B = 8'd0;
		end
		else if (v_count < 10'd222 && h_count <= 10'd639) begin
			R = 8'd255;
			G = 8'd255;
			B = 8'd0;
		end
		else if (v_count < 10'd480 && h_count <= 10'd639) begin
			R = 8'd255;
			G = 8'd255;
			B = 8'd0;
		end
		else begin
			R = 8'd0;
			G = 8'd0;
			B = 8'd0;
		end
	end

	assign H_SYNC = (h_count <= 10'd655 || h_count > 10'd751 && rst) ? (1'b1) : (1'b0);
	assign V_SYNC = (v_count <= 10'd489 || v_count > 10'd491 && rst) ? (1'b1) : (1'b0);
endmodule

