module fsk_modulation(out,Din,clk,reset_n,enable);                //FSK Modulator
	input logic Din, clk,reset_n,enable;
	output logic [15:0] out;

logic [10:0] clk_;
logic [15:0] w1;
logic data;

T_FF tff_1(clk_[0],1'b1,clk);
T_FF tff_2(clk_[1],1'b1,clk_[0]);
T_FF tff_3(clk_[2],1'b1,clk_[1]);
T_FF tff_4(clk_[3],1'b1,clk_[2]);
T_FF tff_5(clk_[4],1'b1,clk_[3]);
T_FF tff_6(clk_[5],1'b1,clk_[4]);
T_FF tff_7(clk_[6],1'b1,clk_[5]);
T_FF tff_8(clk_[7],1'b1,clk_[6]);
T_FF tff_9(clk_[8],1'b1,clk_[7]);
T_FF tff_10(clk_[9],1'b1,clk_[8]);
T_FF tff_11(clk_[10],1'b1,clk_[9]);



always_ff @(posedge clk_[8] or negedge reset_n) begin :datablock
	if(~reset_n)
	data <= 0;
	else
	data <= Din;
end

FSK fsk(w1,data,clk);                    //FSK Modulator

mux_16 mux(out,16'h03e8,w1,enable);

endmodule

module mux_16(o,i1,i2,s);           //2x1 MUX with 16-bit I/O
input [15:0]i1,i2;
input s;
output [15:0]o;
mux mux_1[15:0](o,i1,i2,s);
endmodule

module FSK(out,Din,clk);                //FSK Modulator
input Din,clk;                          //Din=input data stream 
output [15:0] out;                      //Modulated signal

wire clk_b2,clk_b4,CLK;                 
wire [5:0]t;

T_FF tff_1(clk_b2,1'b1,clk);            //clk_b2=clk/2
T_FF tff_2(clk_b4,1'b1,clk_b2);         //clk_b4=clk_b2/2=clk/4

mux mux_1(CLK,clk_b4,clk,Din);          //Din=1 => CLK=clk , Din=0 => CLK=clk_b4
counter count_1(t,CLK);                 //t counts 0->63 based on CLK
sine_wave_generator SWG(out,t);         //out=sine value corresponding to t
endmodule

module counter(out,clk);            //counter that counts from 0 to 63 (6-bit)
input clk;
output [5:0]out;
wire [5:0]out_;
T_FF tff_1(out_[0],1'b1,clk);
T_FF tff_2(out_[1],1'b1,out_[0]);
T_FF tff_3(out_[2],1'b1,out_[1]);
T_FF tff_4(out_[3],1'b1,out_[2]);
T_FF tff_5(out_[4],1'b1,out_[3]);
T_FF tff_6(out_[5],1'b1,out_[4]);

not(out[0],out_[0]);
not(out[1],out_[1]);
not(out[2],out_[2]);
not(out[3],out_[3]);
not(out[4],out_[4]);
not(out[5],out_[5]);

endmodule

module mux(o,i1,i2,s);                  //2x1 MUX
input i1,i2,s;
output o;
wire x1,x2,sc;
not(sc,s);
and(x1,i1,sc);
and(x2,i2,s);
or(o,x1,x2);
endmodule

module mux_16_4w(o,i1,i2,i3,i4,s);  //4x1 MUX with 16-bit I/O
input [15:0]i1,i2,i3,i4;
input [1:0]s;
output [15:0]o;
wire [15:0]w1,w2;

mux_16 mux_1(w1,i1,i2,s[0]);
mux_16 mux_2(w2,i3,i4,s[0]);
mux_16 mux_3(o,w1,w2,s[1]);
endmodule
module mux_16_8w(o,i1,i2,i3,i4,i5,i6,i7,i8,s);  //8x1 MUX with 16-bit I/O
input [15:0]i1,i2,i3,i4,i5,i6,i7,i8;
input [2:0]s;
output [15:0]o;
wire [15:0]x1,x2,x3,x4;
wire [15:0]y1,y2;

mux_16 mux_16_1(x1,i1,i2,s[0]);
mux_16 mux_16_2(x2,i3,i4,s[0]);
mux_16 mux_16_3(x3,i5,i6,s[0]);
mux_16 mux_16_4(x4,i7,i8,s[0]);

mux_16 mux_16_5(y1,x1,x2,s[1]);
mux_16 mux_16_6(y2,x3,x4,s[1]);

mux_16 mux_16_7(o,y1,y2,s[2]);

endmodule

/* 64x1 MUX with 16-bit I/O */

module mux_16_64w(o,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,i16,i17,i18,i19,i20,i21,i22,i23,i24,i25,i26,i27,i28,i29,i30,i31,i32,i33,i34,i35,i36,i37,i38,i39,i40,i41,i42,i43,i44,i45,i46,i47,i48,i49,i50,i51,i52,i53,i54,i55,i56,i57,i58,i59,i60,i61,i62,i63,i64,s);
input [15:0]i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,i16,i17,i18,i19,i20,i21,i22,i23,i24,i25,i26,i27,i28,i29,i30,i31,i32,i33,i34,i35,i36,i37,i38,i39,i40,i41,i42,i43,i44,i45,i46,i47,i48,i49,i50,i51,i52,i53,i54,i55,i56,i57,i58,i59,i60,i61,i62,i63,i64;
input [5:0]s;
output [15:0]o;
wire [15:0]x1,x2,x3,x4,x5,x6,x7,x8;

mux_16_8w mux_16_8w_1(x1,i1,i2,i3,i4,i5,i6,i7,i8,s[2:0]);
mux_16_8w mux_16_8w_2(x2,i9,i10,i11,i12,i13,i14,i15,i16,s[2:0]);
mux_16_8w mux_16_8w_3(x3,i17,i18,i19,i20,i21,i22,i23,i24,s[2:0]);
mux_16_8w mux_16_8w_4(x4,i25,i26,i27,i28,i29,i30,i31,i32,s[2:0]);
mux_16_8w mux_16_8w_5(x5,i33,i34,i35,i36,i37,i38,i39,i40,s[2:0]);
mux_16_8w mux_16_8w_6(x6,i41,i42,i43,i44,i45,i46,i47,i48,s[2:0]);
mux_16_8w mux_16_8w_7(x7,i49,i50,i51,i52,i53,i54,i55,i56,s[2:0]);
mux_16_8w mux_16_8w_8(x8,i57,i58,i59,i60,i61,i62,i63,i64,s[2:0]);

mux_16_8w mux_16_8w_9(o,x1,x2,x3,x4,x5,x6,x7,x8,s[5:3]);
endmodule
module sine_wave_generator(o,t);
input [5:0]t;
output [15:0]o;
reg [15:0] i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,i16,i17,i18,i19,i20,i21,i22,i23,i24,i25,i26,i27,i28,i29,i30,i31,i32,i33,i34,i35,i36,i37,i38,i39,i40,i41,i42,i43,i44,i45,i46,i47,i48,i49,i50,i51,i52,i53,i54,i55,i56,i57,i58,i59,i60,i61,i62,i63,i64;
mux_16_64w mux_1(o,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,i16,i17,i18,i19,i20,i21,i22,i23,i24,i25,i26,i27,i28,i29,i30,i31,i32,i33,i34,i35,i36,i37,i38,i39,i40,i41,i42,i43,i44,i45,i46,i47,i48,i49,i50,i51,i52,i53,i54,i55,i56,i57,i58,i59,i60,i61,i62,i63,i64,t);
initial
begin
i1=1000;               //1000*sin(t*360/64)+1000 values recorded in order
i2=1098;
i3=1195;
i4=1290;
i5=1383;
i6=1471;
i7=1556;
i8=1634;
i9=1707;
i10=1773;
i11=1831;
i12=1882;
i13=1924;
i14=1957;
i15=1981;
i16=1995;
i17=2000;
i18=1995;
i19=1981;
i20=1957;
i21=1924;
i22=1882;
i23=1831;
i24=1773;
i25=1707;
i26=1634;
i27=1556;
i28=1471;
i29=1383;
i30=1290;
i31=1195;
i32=1098;
i33=1000;
i34=902;
i35=805;
i36=710;
i37=617;
i38=529;
i39=444;
i40=366;
i41=293;
i42=227;
i43=169;
i44=118;
i45=76;
i46=43;
i47=19;
i48=5;
i49=0;
i50=5;
i51=19;
i52=43;
i53=76;
i54=118;
i55=169;
i56=227;
i57=293;
i58=366;
i59=444;
i60=529;
i61=617;
i62=710;
i63=805;
i64=902;
end
endmodule

module T_FF(q,t,clk);           //T-FlipFlop
input t,clk;
output q;
reg q;
initial
begin
    q=0;
end
always @(posedge clk)
begin
    if(t==1)
        q=~q; 
end
endmodule