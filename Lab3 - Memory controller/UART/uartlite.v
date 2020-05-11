`timescale 1ns / 1ps

module uartlite( 
		// Clock/Rest Interface
		input			CLK,
		input			RST,
		
		// Serial Interface
		input			RX, 
		output		TX, 
		
		// Uart Interface
		output [7:0] UART_2_MEM_DATA, // Similar to lab3's DATA_IN [7:0]
		input	MEM_2_UART_READY,			// Similar to lab3's DATA_IN_READY
		input	MEM_2_UART_CONSUME,		// Similar to lab3's DATA_IN_CONSUME
		input [7:0] MEM_2_UART_DATA,	// Similar to lab3's DATA_OUT [7:0]
		output UART_2_MEM_READY,		// Similar to lab3's DATA_OUT_READY 		

		//Debug Interface
		output [6:0]	STATUS		
		);


	`define RATIO(clk,bdrate) clk / (bdrate*16) 
	parameter DATA_BITS = 8;
	parameter USE_PARITY = 1;
	parameter ODD_PARITY = 1;
//	parameter FAMILY = "zynq";
	parameter FAMILY = "spartan3e";	
	
	parameter CLOCK = 50000000;
	parameter BAUD_RATE = 9600;
	parameter SAMPLING_PERIOD = `RATIO(CLOCK,BAUD_RATE);

	wire RX_Data_Present;
	wire EN_16x_Baud;
	
	wire TX_Buffer_Full;
	wire RX_BUFFER_FULL;
	wire TX_Buffer_Empty;
	wire RX_Buffer_Empty;
	wire RX_Frame_Error;
	wire RX_Overrun_Error;
	wire RX_Parity_Error;

	assign STATUS = { TX_Buffer_Full, RX_BUFFER_FULL, TX_Buffer_Empty, RX_Buffer_Empty, RX_Frame_Error, RX_Overrun_Error, RX_Parity_Error};
	assign RX_Buffer_Empty = ~RX_Data_Present;
	assign UART_2_MEM_READY = RX_Data_Present;

/* Instantiations */
baudrate #( .C_RATIO(SAMPLING_PERIOD) ) BAUDRT_I(
    .Clk(CLK), 
    .EN_16x_Baud(EN_16x_Baud),
	 .Reset(RST)
    );

uartlite_tx #(.C_DATA_BITS(DATA_BITS), .C_USE_PARITY(USE_PARITY), .C_ODD_PARITY(ODD_PARITY), .C_FAMILY(FAMILY)) TX_I (
    .Clk(CLK), 
    .Reset(RST), 
    .EN_16x_Baud(EN_16x_Baud), 
    .TX(TX), 
    .TX_Data(MEM_2_UART_DATA), 	 
    .Write_TX_FIFO(MEM_2_UART_READY), 
    .Reset_TX_FIFO(RST), 
    .TX_Buffer_Full(TX_Buffer_Full), 
    .TX_Buffer_Empty(TX_Buffer_Empty)
    );
	 
	  
uartlite_rx #(.C_DATA_BITS(DATA_BITS), .C_USE_PARITY(USE_PARITY), .C_ODD_PARITY(ODD_PARITY), .C_FAMILY(FAMILY) ) RX_I (
    .Clk(CLK), 
    .Reset(RST), 
    .EN_16x_Baud(EN_16x_Baud), 
    .RX(RX), 
	 .RX_Data(UART_2_MEM_DATA), 
    .RX_Data_Present(RX_Data_Present), 
	 .Read_RX_FIFO(MEM_2_UART_CONSUME), 
    .Reset_RX_FIFO(RST), 
    .RX_BUFFER_FULL(RX_BUFFER_FULL), 
    .RX_Frame_Error(RX_Frame_Error), 
    .RX_Overrun_Error(RX_Overrun_Error), 
    .RX_Parity_Error(RX_Parity_Error)
    );

endmodule
