`timescale 1ns / 1ps

module FSM_(
    input CLK,
    input RST,
    input [7:0] DATA_IN,
    input DATA_IN_READY,
    output DATA_IN_CONSUME,
	 output DATA_OUT_READY,
    output [4:0] fsmstate,
    output WR_EN
    );

	localparam Idle = 0, Write = 1 , ADDRA = 2 , ADDRB=3, DATAA=4, DATAB=5, D2R=6, Read=7, RADDRA=8, RADDRB=9,OUT=10,OUT1=11;
	localparam S0=12,S1=13,S2=14,S3=15;
	localparam S4=16,S5=17;
	localparam W=8'b01010111, R=8'b01010010, KENO=8'b00100000, CR = 8'b00001101;
	
	reg [4:0] state_q;
	wire [4:0] state_d;	
	
	assign state_d = 	(state_q == Idle && DATA_IN == W && DATA_IN_READY) ? Write :
							(state_q == Write && DATA_IN != KENO && DATA_IN !=W && DATA_IN_READY) ? ADDRA :
							(state_q == ADDRA )? S0 :
							(state_q == S0 && DATA_IN_READY) ? ADDRB :
							(state_q == ADDRB)? S1 : 
							(state_q == S1 && DATA_IN_READY) ? DATAA :
							(state_q == DATAA)? S2 : 
							(state_q == S2 && DATA_IN_READY) ? DATAB :
							(state_q == DATAB) ? S3 : 
							(state_q == S3 && DATA_IN == CR && DATA_IN_READY) ? D2R :
							(state_q == D2R) ? Idle :
							(state_q == Idle && DATA_IN == R && DATA_IN_READY) ? Read :
							(state_q == Read && DATA_IN != KENO && DATA_IN !=R & DATA_IN_READY) ? RADDRA :
							(state_q == RADDRA )? S4 :
							(state_q == S4 && DATA_IN_READY) ? RADDRB :
							(state_q == RADDRB )? S5: 
							(state_q == S5 && DATA_IN == CR && DATA_IN_READY) ? OUT :
							(state_q == OUT) ? OUT1:
							(state_q == OUT1)? Idle : state_q;
	
	assign fsmstate = state_q;
	
	assign DATA_IN_CONSUME = (state_q != Idle);
	
	assign WR_EN = (state_q == D2R)?1:0;
	
	assign DATA_OUT_READY = (state_q == OUT || state_q == OUT1);
	
	always @(posedge CLK)begin
		if(RST) 
			state_q <= 0;
		else
			state_q <= state_d;		
	end
endmodule
