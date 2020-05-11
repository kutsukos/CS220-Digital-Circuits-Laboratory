`timescale 1ns / 1ps

module encoder(
input [7:0] in0,
input [7:0] in1,
output [7:0] out
    );
assign out[3:0] = 	(in0 == 8'h30) ? 0:
			(in0 == 8'h31) ? 1:
			(in0 == 8'h32) ? 2:
			(in0 == 8'h33) ? 3:
			(in0 == 8'h34) ? 4:
			(in0 == 8'h35) ? 5:
			(in0 == 8'h36) ? 6:
			(in0 == 8'h37) ? 7:
			(in0 == 8'h38) ? 8:
			(in0 == 8'h39) ? 9:
			(in0 == 8'h41) ? 10:
			(in0 == 8'h42) ? 11:
			(in0 == 8'h43) ? 12:
			(in0 == 8'h44) ? 13:
			(in0 == 8'h45) ? 14:
			(in0 == 8'h46) ? 15:0;
			

assign out[7:4] = 	(in1 == 8'h30) ? 0:
							(in1 == 8'h31) ? 1:
							(in1 == 8'h32) ? 2:
							(in1 == 8'h33) ? 3:
							(in1 == 8'h34) ? 4:
							(in1 == 8'h35) ? 5:
							(in1 == 8'h36) ? 6:
							(in1 == 8'h37) ? 7:
							(in1 == 8'h38) ? 8:
							(in1 == 8'h39) ? 9:
							(in1 == 8'h41) ? 10:
							(in1 == 8'h42) ? 11:
							(in1 == 8'h43) ? 12:
							(in1 == 8'h44) ? 13:
							(in1 == 8'h45) ? 14:
							(in1 == 8'h46) ? 15:0;

endmodule