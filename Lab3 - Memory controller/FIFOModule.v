`timescale 1ns / 1ps

module FIFOModule(
    input CLK,
    input RST,
    input [7:0] DATA_IN,
    input DATA_IN_READY,
    output DATA_IN_CONSUME,
    output [7:0] DATA_OUT,
    output DATA_OUT_READY
    );

wire WR_EN;
wire [7:0] C2R;
wire [7:0] R2C;
wire [7:0] ADDR;
wire [3:0] fsm_state;

FSM_ FSM0(
	.CLK(CLK),
	.RST(RST),
	.DATA_IN(DATA_IN),
	.DATA_IN_READY(DATA_IN_READY),
	.DATA_IN_CONSUME(DATA_IN_CONSUME),
	.DATA_OUT_READY(DATA_OUT_READY),
	.fsmstate(fsm_state),
	.WR_EN(WR_EN)
);

FIFOController FIFOCTRL0(
	.CLK(CLK),
	.RST(RST),
	.DATA_IN(DATA_IN),
	.fsmstate(fsm_state),
	.DATA_OUT(DATA_OUT),
	.RADDR(ADDR),
	.C2R(C2R),
	.R2C(R2C),
	.DATA_IN_READY(DATA_IN_READY)
);


RAM MARCI (
  .clka(CLK), // input clka
  .rsta(RST), // input rsta
  .wea(WR_EN), // input [0 : 0] wea
  .addra(ADDR), // input [7 : 0] addra
  .dina(C2R), // input [7 : 0] dina
  .douta(R2C) // output [7 : 0] douta
);


endmodule
