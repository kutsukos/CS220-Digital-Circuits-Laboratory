`timescale 1ns / 1ps

module toptop(
		input			CLK,
		input			RST,
		input			RX, 
		output		TX
    );

wire [7:0] DATA_IN;
wire DATA_IN_READY;
wire DATA_IN_CONSUME;
wire [7:0] DATA_OUT;
wire DATA_OUT_READY;

uartlite uart0(
	.CLK(CLK),
	.RST(RST),
	.RX(RX),
	.TX(TX),
	.UART_2_MEM_DATA(DATA_IN),	
	.MEM_2_UART_CONSUME(DATA_IN_CONSUME),
	.UART_2_MEM_READY(DATA_IN_READY),
	.MEM_2_UART_DATA(DATA_OUT),
	.MEM_2_UART_READY(DATA_OUT_READY)	
	);
	
FIFOModule FIF0(
		.CLK(CLK),
		.RST(RST),
		.DATA_IN_READY(DATA_IN_READY),
		.DATA_IN(DATA_IN), 
		.DATA_IN_CONSUME(DATA_IN_CONSUME),
		.DATA_OUT(DATA_OUT),
		.DATA_OUT_READY(DATA_OUT_READY)
);

endmodule
