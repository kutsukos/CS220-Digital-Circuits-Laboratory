`timescale 1ns / 1ps

module FIFOController(
    input CLK,
    input RST,
    input [7:0] DATA_IN,
    input [4:0] fsmstate,
    output [7:0] DATA_OUT,
    output [7:0] C2R,
	 output [7:0] RADDR,
    input [7:0] R2C,
	 input DATA_IN_READY
    );

	localparam Idle = 0, Write = 1 , ADDRA = 2 , ADDRB=3, DATAA=4, DATAB=5, D2R=6, Read=7, RADDRA=8, RADDRB=9,OUT=10,OUT1=11;
	localparam S0=12,S1=13,S2=14,S3=15;
	//REGS FOR INPUTS AND SOME WIRES. MKAY?
	reg [7:0] addrA_q;
	reg [7:0] addrB_q;
	reg [7:0] dataA_q;
	reg [7:0] dataB_q;
	wire [7:0] addrA_d;
	wire [7:0] addrB_d;
	wire [7:0] dataA_d;
	wire [7:0] dataB_d;
	reg [7:0] fresh_q;
	wire [7:0] fresh_d;
	//SOME WIRES FOR OUTPUT YOU KNOW. MKAY
	wire [7:0] o1;
	wire [7:0] o0;
	
	assign fresh_d =(fsmstate!=D2R)?DATA_IN:fresh_q;	
		
	assign addrA_d =(fsmstate == ADDRA  || fsmstate == RADDRA )? fresh_q : addrA_q;
	assign addrB_d =(fsmstate == ADDRB  || fsmstate == RADDRB )? fresh_q : addrB_q;
	assign dataA_d =(fsmstate == DATAA )? fresh_q : dataA_q;
	assign dataB_d =(fsmstate == DATAB )? fresh_q : dataB_q;
	
	//When OUT send out0, when OUT1 send out1
	assign DATA_OUT = (fsmstate==OUT)? o0 : o1;	
		//assign DATA_OUT=R2C;
	
	always@(posedge CLK) begin
		if(RST) begin
		  addrA_q <= 0;
		  addrB_q <= 0;
		  dataA_q <= 0;
		  dataB_q <= 0;
		  fresh_q <= 0;
		end
		else begin
			addrA_q <= addrA_d;
			addrB_q <= addrB_d;
			dataA_q <= dataA_d;
			dataB_q <= dataB_d;
			fresh_q <= fresh_d;
		end
	end
	
	
	encoder encoder0_data(
		.in0(dataA_q),
		.in1(dataB_q),
		.out(C2R)
	);
	
	encoder encoder1_addr(
		.in0(addrA_q),
		.in1(addrB_q),
		.out(RADDR)
	);
	
	decoder decoder0(
	.in(R2C), 
	.out0(o0),
	.out1(o1)
);


endmodule
