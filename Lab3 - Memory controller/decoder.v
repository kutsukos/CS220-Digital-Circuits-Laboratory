`timescale 1ns / 1ps

module decoder(
input [7:0] in,
output [7:0] out0,
output [7:0] out1
    );
assign out0 = 	(in[3:0] == 0) ? 8'h30:
					(in[3:0] == 1) ? 8'h31:
					(in[3:0] == 2) ? 8'h32:
					(in[3:0] == 3) ? 8'h33:
					(in[3:0] == 4) ? 8'h34:
					(in[3:0] == 5) ? 8'h35:
					(in[3:0] == 6) ? 8'h36:
					(in[3:0] == 7) ? 8'h37:
					(in[3:0] == 8) ? 8'h38:
					(in[3:0] == 9) ? 8'h39:
					(in[3:0] == 10) ? 8'h41:
					(in[3:0] == 11) ? 8'h42:
					(in[3:0] == 12) ? 8'h43:
					(in[3:0] == 13) ? 8'h44:
					(in[3:0] == 14) ? 8'h45:
					(in[3:0] == 15) ? 8'h46:8'h40;

assign out1 = 	(in[7:4] == 0) ? 8'h30:
					(in[7:4] == 1) ? 8'h31:
					(in[7:4] == 2) ? 8'h32:
					(in[7:4] == 3) ? 8'h33:
					(in[7:4] == 4) ? 8'h34:
					(in[7:4] == 5) ? 8'h35:
					(in[7:4] == 6) ? 8'h36:
					(in[7:4] == 7) ? 8'h37:
					(in[7:4] == 8) ? 8'h38:
					(in[7:4] == 9) ? 8'h39:
					(in[7:4] == 10) ? 8'h41:
					(in[7:4] == 11) ? 8'h42:
					(in[7:4] == 12) ? 8'h43:
					(in[7:4] == 13) ? 8'h44:
					(in[7:4] == 14) ? 8'h45:
					(in[7:4] == 15) ? 8'h46:8'h40;

endmodule
