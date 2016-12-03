//===========================================//
//====================VGA====================//
//===========================================//
/*

Our VGA Module: modifiec by Ben Wong, and Collin Gardner to 

VGA MODULE: Modified by Parth Patel, Ian Baker, and Yi Zhan

Most of all the code here is modified to basic VGA Displaying capabilities,

VGA MODULE adopted from BEN SHAFFER...
Utilized Ben's VGA module that he borrowed from OAKLEY KATTERHEINRICH.
Parameters were set by Ben.

*/
//===========================================//
//====================VGA====================//
//===========================================//
module test(clk, VGA_R, VGA_B, VGA_G, VGA_BLANK_N, VGA_SYNC_N , VGA_HS, VGA_VS, rst, VGA_CLK);

//outputs the colors, determined from the color module.
output [7:0] VGA_R, VGA_B, VGA_G;

//Makes sure the screen is synced right.
output VGA_HS, VGA_VS, VGA_BLANK_N, VGA_CLK, VGA_SYNC_N;

input clk, rst; //clk is taken from the onboard clock 50MHz. rst is taken from a switch, SW[17].

wire CLK108; //Clock for the VGA

/*
Coordinates of the pixel being assigned. Moves top to bottom, left to right.
*/
wire [30:0]X, Y;

wire reset; 
//input KB_clk; //needs pins
//input data;
wire [4:0]direction;


//kbInput kbIn(KB_clk, data, direction, reset);
//Not sure what these are, probably have to do with the display output system.
wire [7:0]countRef;
wire [31:0]countSample;

/*COORDINATES, (X,Y) Starting at the top left hand corner of the monitor. True for all coordinates
in this code block.*/
//"object1" //top row of blocks

reg [31:0] object38X = 31'd0, object38Y = 31'd0;

reg [31:0] object1X = 31'd0, object1Y = 31'd0;
//"object2"
reg [31:0] object2X = 31'd256, object2Y = 31'd0;
//"object3"
reg [31:0] object3X = 31'd422, object3Y = 31'd0;
reg [31:0] object4X = 31'd588, object4Y = 31'd0;
reg [31:0] object5X = 31'd754, object5Y = 31'd0;
reg [31:0] object6X = 31'd920, object6Y = 31'd0;
reg [31:0] object7X = 31'd1086, object7Y = 31'd0;

//2nd Row of blocks

reg [31:0] object8X = 31'd256, object8Y = 31'd166;
reg [31:0] object9X = 31'd422, object9Y = 31'd166;
reg [31:0] object10X = 31'd588, object10Y = 31'd166;
reg [31:0] object11X = 31'd754, object11Y = 31'd166;
reg [31:0] object12X = 31'd920, object12Y = 31'd166;
reg [31:0] object13X = 31'd1086, object13Y = 31'd166;

//3rd Row of blocks

reg [31:0] object14X = 31'd256, object14Y = 31'd332;
reg [31:0] object15X = 31'd422, object15Y = 31'd332;
reg [31:0] object16X = 31'd588, object16Y = 31'd332;
reg [31:0] object17X = 31'd754, object17Y = 31'd332;
reg [31:0] object18X = 31'd920, object18Y = 31'd332;
reg [31:0] object19X = 31'd1086, object19Y = 31'd332;

//4th Row of blocks

reg [31:0] object20X = 31'd256, object20Y = 31'd498;
reg [31:0] object21X = 31'd422, object21Y = 31'd498;
reg [31:0] object22X = 31'd588, object22Y = 31'd498;
reg [31:0] object23X = 31'd754, object23Y = 31'd498;
reg [31:0] object24X = 31'd920, object24Y = 31'd498;
reg [31:0] object25X = 31'd1086, object25Y = 31'd498;

//5th Row of blocks

reg [31:0] object26X = 31'd256, object26Y = 31'd664;
reg [31:0] object27X = 31'd422, object27Y = 31'd664;
reg [31:0] object28X = 31'd588, object28Y = 31'd664;
reg [31:0] object29X = 31'd754, object29Y = 31'd664;
reg [31:0] object30X = 31'd920, object30Y = 31'd664;
reg [31:0] object31X = 31'd1086, object31Y = 31'd664;

//6th Row of blocks
reg [31:0] object32X = 31'd256, object32Y = 31'd830;
reg [31:0] object33X = 31'd422, object33Y = 31'd830;
reg [31:0] object34X = 31'd588, object34Y = 31'd830;
reg [31:0] object35X = 31'd754, object35Y = 31'd830;
reg [31:0] object36X = 31'd920, object36Y = 31'd830;
reg [31:0] object37X = 31'd1086, object37Y = 31'd830;



/* T = Top,  B = Bottom, L = Left, R = Right,  all with respect to the coordinate of where 
your "object" is placed.
T and L params are set to the object's upper lefthand.  
Best if you leave the Left hand side parameters to 0, i.e: Object1_L = 31'd0;
This will determine the available usable display space you have left.
*/

//======== Object1 =======//     //Each one of these draws a box on the screen for each box in the MineSweeper field
//object1_localParams
localparam Object1_L = 31'd0;
localparam Object1_R = Object1_L + 31'd240; //this goes the whole screen size, so 1280 is whole screen size
localparam Object1_T = 31'd0;
localparam Object1_B = Object1_T + 31'd1024; //was 100 -Collin this can cut the screen in half
assign Object1 =((X >= Object1_L + object1X)&&(X <= Object1_R + object1X)&&(Y >= Object1_T+ object1Y)&&(Y <= Object1_B+ object1Y));

///////////////////// Object 2 //////////////////////////////////////
//object2_localParams
localparam Object2_L = 31'd0;
localparam Object2_R = Object2_L + 31'd150;
localparam Object2_T = 31'd0;
localparam Object2_B = Object2_T + 31'd150;
assign Object2 =((X >= Object2_L + object2X)&&(X <= Object2_R + object2X)&&(Y >= Object2_T+ object2Y)&&(Y <= Object2_B + object2Y));

///////////////////// Object 3 //////////////////////////////////////
//object3_localParams
localparam Object3_L = 31'd0;
localparam Object3_R = Object3_L + 31'd150;  // 31'd50 when changed from 50 it doesnt work
localparam Object3_T = 31'd0;
localparam Object3_B = Object3_T + 31'd150;
assign Object3 =((X >= Object3_L + object3X)&&(X <= Object3_R + object3X)&&(Y >= Object3_T+ object3Y)&&(Y <= Object3_B + object3Y));
///////////////////// Object4//////////////////////////////////////
//object4_localParams
localparam Object4_L = 31'd0;
localparam Object4_R = Object4_L + 31'd150;
localparam Object4_T = 31'd0;
localparam Object4_B = Object4_T + 31'd150;
assign Object4 =((X >= Object4_L + object4X)&&(X <= Object4_R + object4X)&&(Y >= Object4_T+ object4Y)&&(Y <= Object4_B + object4Y));
///////////////////// Object5//////////////////////////////////////
//object5_localParams
localparam Object5_L = 31'd0;
localparam Object5_R = Object5_L + 31'd150;
localparam Object5_T = 31'd0;
localparam Object5_B = Object5_T + 31'd150;
assign Object5 =((X >= Object5_L + object5X)&&(X <= Object5_R + object5X)&&(Y >= Object5_T+ object5Y)&&(Y <= Object5_B + object5Y));
///////////////////// Object6//////////////////////////////////////
//object6_localParams
localparam Object6_L = 31'd0;
localparam Object6_R = Object6_L + 31'd150;
localparam Object6_T = 31'd0;
localparam Object6_B = Object6_T + 31'd150;
assign Object6 =((X >= Object6_L + object6X)&&(X <= Object6_R + object6X)&&(Y >= Object6_T+ object6Y)&&(Y <= Object6_B + object6Y));
///////////////////// Object7//////////////////////////////////////
//object7_localParams
localparam Object7_L = 31'd0;
localparam Object7_R = Object7_L + 31'd150;
localparam Object7_T = 31'd0;
localparam Object7_B = Object7_T + 31'd150;
assign Object7 =((X >= Object7_L + object7X)&&(X <= Object7_R + object7X)&&(Y >= Object7_T+ object7Y)&&(Y <= Object7_B + object7Y));
///////////////////// Object8//////////////////////////////////////
//object8_localParams
localparam Object8_L = 31'd0;
localparam Object8_R = Object8_L + 31'd150;
localparam Object8_T = 31'd0;
localparam Object8_B = Object8_T + 31'd150;
assign Object8 =((X >= Object8_L + object8X)&&(X <= Object8_R + object8X)&&(Y >= Object8_T+ object8Y)&&(Y <= Object8_B + object8Y));
///////////////////// Object9//////////////////////////////////////
//object9_localParams
localparam Object9_L = 31'd0;
localparam Object9_R = Object9_L + 31'd150;
localparam Object9_T = 31'd0;
localparam Object9_B = Object9_T + 31'd150;
assign Object9 =((X >= Object9_L + object9X)&&(X <= Object9_R + object9X)&&(Y >= Object9_T+ object9Y)&&(Y <= Object9_B + object9Y));
///////////////////// Object10//////////////////////////////////////
//object10_localParams
localparam Object10_L = 31'd0;
localparam Object10_R = Object10_L + 31'd150;
localparam Object10_T = 31'd0;
localparam Object10_B = Object10_T + 31'd150;
assign Object10 =((X >= Object10_L + object10X)&&(X <= Object10_R + object10X)&&(Y >= Object10_T+ object10Y)&&(Y <= Object10_B + object10Y));
///////////////////// Object11//////////////////////////////////////
//object11_localParams
localparam Object11_L = 31'd0;
localparam Object11_R = Object11_L + 31'd150;
localparam Object11_T = 31'd0;
localparam Object11_B = Object11_T + 31'd150;
assign Object11 =((X >= Object11_L + object11X)&&(X <= Object11_R + object11X)&&(Y >= Object11_T+ object11Y)&&(Y <= Object11_B + object11Y));
///////////////////// Object12//////////////////////////////////////
//object12_localParams
localparam Object12_L = 31'd0;
localparam Object12_R = Object12_L + 31'd150;
localparam Object12_T = 31'd0;
localparam Object12_B = Object12_T + 31'd150;
assign Object12 =((X >= Object12_L + object12X)&&(X <= Object12_R + object12X)&&(Y >= Object12_T+ object12Y)&&(Y <= Object12_B + object12Y));
///////////////////// Object13//////////////////////////////////////
//object13_localParams
localparam Object13_L = 31'd0;
localparam Object13_R = Object13_L + 31'd150;
localparam Object13_T = 31'd0;
localparam Object13_B = Object13_T + 31'd150;
assign Object13 =((X >= Object13_L + object13X)&&(X <= Object13_R + object13X)&&(Y >= Object13_T+ object13Y)&&(Y <= Object13_B + object13Y));
///////////////////// Object14//////////////////////////////////////
//object14_localParams
localparam Object14_L = 31'd0;
localparam Object14_R = Object14_L + 31'd150;
localparam Object14_T = 31'd0;
localparam Object14_B = Object14_T + 31'd150;
assign Object14 =((X >= Object14_L + object14X)&&(X <= Object14_R + object14X)&&(Y >= Object14_T+ object14Y)&&(Y <= Object14_B + object14Y));
///////////////////// Object15//////////////////////////////////////
//object15_localParams
localparam Object15_L = 31'd0;
localparam Object15_R = Object15_L + 31'd150;
localparam Object15_T = 31'd0;
localparam Object15_B = Object15_T + 31'd150;
assign Object15 =((X >= Object15_L + object15X)&&(X <= Object15_R + object15X)&&(Y >= Object15_T+ object15Y)&&(Y <= Object15_B + object15Y));
///////////////////// Object16//////////////////////////////////////
//object16_localParams
localparam Object16_L = 31'd0;
localparam Object16_R = Object16_L + 31'd150;
localparam Object16_T = 31'd0;
localparam Object16_B = Object16_T + 31'd150;
assign Object16 =((X >= Object16_L + object16X)&&(X <= Object16_R + object16X)&&(Y >= Object16_T+ object16Y)&&(Y <= Object16_B + object16Y));
///////////////////// Object17//////////////////////////////////////
//object17_localParams
localparam Object17_L = 31'd0;
localparam Object17_R = Object17_L + 31'd150;
localparam Object17_T = 31'd0;
localparam Object17_B = Object17_T + 31'd150;
assign Object17 =((X >= Object17_L + object17X)&&(X <= Object17_R + object17X)&&(Y >= Object17_T+ object17Y)&&(Y <= Object17_B + object17Y));
///////////////////// Object18//////////////////////////////////////
//object18_localParams
localparam Object18_L = 31'd0;
localparam Object18_R = Object18_L + 31'd150;
localparam Object18_T = 31'd0;
localparam Object18_B = Object18_T + 31'd150;
assign Object18 =((X >= Object18_L + object18X)&&(X <= Object18_R + object18X)&&(Y >= Object18_T+ object18Y)&&(Y <= Object18_B + object18Y));
///////////////////// Object19//////////////////////////////////////
//object19_localParams
localparam Object19_L = 31'd0;
localparam Object19_R = Object19_L + 31'd150;
localparam Object19_T = 31'd0;
localparam Object19_B = Object19_T + 31'd150;
assign Object19 =((X >= Object19_L + object19X)&&(X <= Object19_R + object19X)&&(Y >= Object19_T+ object19Y)&&(Y <= Object19_B + object19Y));
///////////////////// Object20//////////////////////////////////////
//object20_localParams
localparam Object20_L = 31'd0;
localparam Object20_R = Object20_L + 31'd150;
localparam Object20_T = 31'd0;
localparam Object20_B = Object20_T + 31'd150;
assign Object20 =((X >= Object20_L + object20X)&&(X <= Object20_R + object20X)&&(Y >= Object20_T+ object20Y)&&(Y <= Object20_B + object20Y));
///////////////////// Object21//////////////////////////////////////
//object21_localParams
localparam Object21_L = 31'd0;
localparam Object21_R = Object21_L + 31'd150;
localparam Object21_T = 31'd0;
localparam Object21_B = Object21_T + 31'd150;
assign Object21 =((X >= Object21_L + object21X)&&(X <= Object21_R + object21X)&&(Y >= Object21_T+ object21Y)&&(Y <= Object21_B + object21Y));
///////////////////// Object22//////////////////////////////////////
//object22_localParams
localparam Object22_L = 31'd0;
localparam Object22_R = Object22_L + 31'd150;
localparam Object22_T = 31'd0;
localparam Object22_B = Object22_T + 31'd150;
assign Object22 =((X >= Object22_L + object22X)&&(X <= Object22_R + object22X)&&(Y >= Object22_T+ object22Y)&&(Y <= Object22_B + object22Y));
///////////////////// Object23//////////////////////////////////////
//object23_localParams
localparam Object23_L = 31'd0;
localparam Object23_R = Object23_L + 31'd150;
localparam Object23_T = 31'd0;
localparam Object23_B = Object23_T + 31'd150;
assign Object23 =((X >= Object23_L + object23X)&&(X <= Object23_R + object23X)&&(Y >= Object23_T+ object23Y)&&(Y <= Object23_B + object23Y));
///////////////////// Object24//////////////////////////////////////
//object24_localParams
localparam Object24_L = 31'd0;
localparam Object24_R = Object24_L + 31'd150;
localparam Object24_T = 31'd0;
localparam Object24_B = Object24_T + 31'd150;
assign Object24 =((X >= Object24_L + object24X)&&(X <= Object24_R + object24X)&&(Y >= Object24_T+ object24Y)&&(Y <= Object24_B + object24Y));
///////////////////// Object25//////////////////////////////////////
//object25_localParams
localparam Object25_L = 31'd0;
localparam Object25_R = Object25_L + 31'd150;
localparam Object25_T = 31'd0;
localparam Object25_B = Object25_T + 31'd150;
assign Object25 =((X >= Object25_L + object25X)&&(X <= Object25_R + object25X)&&(Y >= Object25_T+ object25Y)&&(Y <= Object25_B + object25Y));
///////////////////// Object26//////////////////////////////////////
//object26_localParams
localparam Object26_L = 31'd0;
localparam Object26_R = Object26_L + 31'd150;
localparam Object26_T = 31'd0;
localparam Object26_B = Object26_T + 31'd150;
assign Object26 =((X >= Object26_L + object26X)&&(X <= Object26_R + object26X)&&(Y >= Object26_T+ object26Y)&&(Y <= Object26_B + object26Y));
///////////////////// Object27//////////////////////////////////////
//object27_localParams
localparam Object27_L = 31'd0;
localparam Object27_R = Object27_L + 31'd150;
localparam Object27_T = 31'd0;
localparam Object27_B = Object27_T + 31'd150;
assign Object27 =((X >= Object27_L + object27X)&&(X <= Object27_R + object27X)&&(Y >= Object27_T+ object27Y)&&(Y <= Object27_B + object27Y));
///////////////////// Object28//////////////////////////////////////
//object28_localParams
localparam Object28_L = 31'd0;
localparam Object28_R = Object28_L + 31'd150;
localparam Object28_T = 31'd0;
localparam Object28_B = Object28_T + 31'd150;
assign Object28 =((X >= Object28_L + object28X)&&(X <= Object28_R + object28X)&&(Y >= Object28_T+ object28Y)&&(Y <= Object28_B + object28Y));
///////////////////// Object29//////////////////////////////////////
//object29_localParams
localparam Object29_L = 31'd0;
localparam Object29_R = Object29_L + 31'd150;
localparam Object29_T = 31'd0;
localparam Object29_B = Object29_T + 31'd150;
assign Object29 =((X >= Object29_L + object29X)&&(X <= Object29_R + object29X)&&(Y >= Object29_T+ object29Y)&&(Y <= Object29_B + object29Y));
///////////////////// Object30//////////////////////////////////////
//object30_localParams
localparam Object30_L = 31'd0;
localparam Object30_R = Object30_L + 31'd150;
localparam Object30_T = 31'd0;
localparam Object30_B = Object30_T + 31'd150;
assign Object30 =((X >= Object30_L + object30X)&&(X <= Object30_R + object30X)&&(Y >= Object30_T+ object30Y)&&(Y <= Object30_B + object30Y));
///////////////////// Object31//////////////////////////////////////
//object31_localParams
localparam Object31_L = 31'd0;
localparam Object31_R = Object31_L + 31'd150;
localparam Object31_T = 31'd0;
localparam Object31_B = Object31_T + 31'd150;
assign Object31 =((X >= Object31_L + object31X)&&(X <= Object31_R + object31X)&&(Y >= Object31_T+ object31Y)&&(Y <= Object31_B + object31Y));
///////////////////// Object32//////////////////////////////////////
//object32_localParams
localparam Object32_L = 31'd0;
localparam Object32_R = Object32_L + 31'd150;
localparam Object32_T = 31'd0;
localparam Object32_B = Object32_T + 31'd150;
assign Object32 =((X >= Object32_L + object32X)&&(X <= Object32_R + object32X)&&(Y >= Object32_T+ object32Y)&&(Y <= Object32_B + object32Y));
///////////////////// Object33//////////////////////////////////////
//object33_localParams
localparam Object33_L = 31'd0;
localparam Object33_R = Object33_L + 31'd150;
localparam Object33_T = 31'd0;
localparam Object33_B = Object33_T + 31'd150;
assign Object33 =((X >= Object33_L + object33X)&&(X <= Object33_R + object33X)&&(Y >= Object33_T+ object33Y)&&(Y <= Object33_B + object33Y));
///////////////////// Object34//////////////////////////////////////
//object34_localParams
localparam Object34_L = 31'd0;
localparam Object34_R = Object34_L + 31'd150;
localparam Object34_T = 31'd0;
localparam Object34_B = Object34_T + 31'd150;
assign Object34 =((X >= Object34_L + object34X)&&(X <= Object34_R + object34X)&&(Y >= Object34_T+ object34Y)&&(Y <= Object34_B + object34Y));
///////////////////// Object35//////////////////////////////////////
//object35_localParams
localparam Object35_L = 31'd0;
localparam Object35_R = Object35_L + 31'd150;
localparam Object35_T = 31'd0;
localparam Object35_B = Object35_T + 31'd150;
assign Object35 =((X >= Object35_L + object35X)&&(X <= Object35_R + object35X)&&(Y >= Object35_T+ object35Y)&&(Y <= Object35_B + object35Y));
///////////////////// Object36//////////////////////////////////////
//object36_localParams
localparam Object36_L = 31'd0;
localparam Object36_R = Object36_L + 31'd150;
localparam Object36_T = 31'd0;
localparam Object36_B = Object36_T + 31'd150;
assign Object36 =((X >= Object36_L + object36X)&&(X <= Object36_R + object36X)&&(Y >= Object36_T+ object36Y)&&(Y <= Object36_B + object36Y));
///////////////////// Object37//////////////////////////////////////
//object37_localParams
localparam Object37_L = 31'd0;
localparam Object37_R = Object37_L + 31'd150;
localparam Object37_T = 31'd0;
localparam Object37_B = Object37_T + 31'd150;
assign Object37 =((X >= Object37_L + object37X)&&(X <= Object37_R + object37X)&&(Y >= Object37_T+ object37Y)&&(Y <= Object37_B + object37Y));

//object38_localParams



localparam Object38_L = 31'd0;
localparam Object38_R = Object38_L + 31'd100;
localparam Object38_T = 31'd0;
localparam Object38_B = Object38_T + 31'd100;
assign Object38 =((X >= Object38_L + object38X)&&(X <= Object38_R + object38X)&&(Y >= Object38_T+ object38Y)&&(Y <= Object38_B + object38Y));



//======Borrowed Code======//
//==========DO NOT EDIT BELOW==========//
countingRefresh(X, Y, clk, countRef );
clock108(rst, clk, CLK_108, locked);

wire hblank, vblank, clkLine, blank;

//Sync the display
H_SYNC(CLK_108, VGA_HS, hblank, clkLine, X);
V_SYNC(clkLine, VGA_VS, vblank, Y);
//==========DO NOT EDIT ABOVE==========//


//======DISPLAY CODE IN ORDER OF LAYER IMPORTANCE======//
/*This block sets the priority of what to display in order, best to list in order of importance.
The lowercase variables translate the object-to-be-displayed decision to the color module.
*/    //gonna add a box3 reg
reg box1, box2, box3, box4, box5, box6, box7, box8, box9, box10, box11, box12, box13, box14, box15, box16, box17, box18, box19, box20, box21, box22, box23, box24, box25, box26, box27, box28, box29, box30, box31, box32, box33, box34, box35, box36, box37, box38;//ADD HERE

//drawing shapes	
always@(*)
begin
	if(Object38) begin
		box1 = 1'b0;
		box2 = 1'b0; //changed
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		box38= 1'b1;
		end

	else if(Object1) begin
		box1 = 1'b1;
		box2 = 1'b0; //changed
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
				box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
	else if(Object2) begin
		box1 = 1'b0;//changed
		box2 = 1'b1;//changed
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
				box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
	else if(Object3) begin
		box1 = 1'b0;//changed
		box2 = 1'b0;//changed
		box3 = 1'b1;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
				box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
	else if(Object4) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b1;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
				box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
	else if(Object5) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b1;
		box6 = 1'b0;
		box7 = 1'b0;
				box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
	else if(Object6) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b1;
		box7 = 1'b0;
				box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
	else if(Object7) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b1;
				box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object8) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b1;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object9) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b1;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object10) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b1;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object11) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b1;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object12) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b1;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object13) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b1;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object14) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b1;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object15) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b1;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object16) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b1;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object17) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b1;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object18) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b1;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object19) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b1;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object20) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b1;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object21) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b1;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object22) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b1;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object23) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b1;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object24) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b1;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object25) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b1;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object26) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b1;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object27) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b1;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object28) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b1;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object29) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b1;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object30) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b1;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object31) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b1;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object32) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b1;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object33) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b1;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object34) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b1;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object35) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b1;
		box36 = 1'b0;
		box37 = 1'b0;
		end
		else if(Object36) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b1;
		box37 = 1'b0;
		end
		else if(Object37) begin 
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
		box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b1;
		end

	else begin
		box1 = 1'b0;
		box2 = 1'b0;
		box3 = 1'b0;
		box4 = 1'b0;
		box5 = 1'b0;
		box6 = 1'b0;
		box7 = 1'b0;
			box8 = 1'b0;
		box9 = 1'b0;
		box10 = 1'b0;
		box11 = 1'b0;
		box12 = 1'b0;
		box13 = 1'b0;
		box14 = 1'b0;
		box15 = 1'b0;
		box16 = 1'b0;
		box17 = 1'b0;
		box18 = 1'b0;
		box19 = 1'b0;
		box20 = 1'b0;
		box21 = 1'b0;
		box22 = 1'b0;
		box23 = 1'b0;
		box24 = 1'b0;
		box25 = 1'b0;
		box26 = 1'b0;
		box27 = 1'b0;
		box28 = 1'b0;
		box29 = 1'b0;
		box30 = 1'b0;
		box31 = 1'b0;
		box32 = 1'b0;
		box33 = 1'b0;
		box34 = 1'b0;
		box35 = 1'b0;
		box36 = 1'b0;
		box37 = 1'b0;
		end
	end 


//======Modified Borrowed Code======//
//Determines the color output based on the decision from the priority block
color(clk, VGA_R, VGA_B, VGA_G, box1, box2, box3, box4, box5, box6, box7, box8, box9, box10, box11, box12, box13, box14, box15, box16, box17, box18, box19, box20, box21, box22, box23, box24, box25, box26, box27, box28, box29, box30, box31, box32, box33, box34, box35, box36, box37);//ADD HERE

//======Borrowed code======//
//======DO NOT EDIT========//
assign VGA_CLK = CLK_108;
assign VGA_BLANK_N = VGA_VS&VGA_HS;
assign VGA_SYNC_N = 1'b0;
endmodule


//Controls the counter
module countingRefresh(X, Y, clk, count);
input [31:0]X, Y;
input clk;
output [7:0]count;
reg[7:0]count;
always@(posedge clk)
begin
	if(X==0 &&Y==0)
		count<=count+1;
	else if(count==7'd11)
		count<=0;
	else
		count<=count;
end

endmodule



//======Formatted like Borrowed code, adjust you own parameters======//
//============================//
//========== COLOR ===========//
//============================//
module color(clk, red, blue, green, box1, box2, box3, box4, box5, box6, box7, box8, box9, box10, box11, box12, box13, box14, box15, box16, box17, box18, box19, box20, box21, box22, box23, box24, box25, box26, box27, box28, box29, box30, box31, box32, box33, box34, box35, box36, box37, box38);//ADD HERE

input clk, box1, box2, box3, box4, box5, box6, box7, box8, box9, box10, box11, box12, box13, box14, box15, box16, box17, box18, box19, box20, box21, box22, box23, box24, box25, box26, box27, box28, box29, box30, box31, box32, box33, box34, box35, box36, box37, box38;

output [7:0] red, blue, green;
reg[7:0] red, green, blue;

always@(*)
begin
	if(box1) begin
		red = 8'd255;
		blue = 8'd255;
		green = 8'd255;
		end
	else if(box2) begin
		red = 8'd000;
		blue = 8'd000;
		green = 8'd255;
		end
		else if(box3) begin
		red = 8'd000;
		blue = 8'd000;
		green = 8'd255;
		end
		else if(box4) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box5) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box6) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box7) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		end
		else if(box8) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box9) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box10) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box11) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box12) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box13) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box14) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box15) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box16) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box17) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box18) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box19) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box20) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box21) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box22) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box23) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box24) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box25) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box26) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box27) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box28) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box29) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box30) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box31) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box32) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box33) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box34) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box35) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box36) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		else if(box37) begin 
		 red = 8'd000; 
		 blue = 8'd000; 
		 green = 8'd255; 
		 end
		 else if(box38) begin
		red = 8'd255;
		blue = 8'd255;
		green = 8'd000;
		end
		/* I have no idea why this block below won't work.
		its supposed to be the block that displays the background color, however any values other than 000 for R,G, and B
		will mess eveything up... 
		*/
	else begin
		red = 8'd0;
		blue = 8'd0;
		green = 8'd0;
		end
	end
	
endmodule





//====================================//
//========DO NOT EDIT PAST HERE=======//
//====================================//
/* --VGA CONTROLLER MODULES--
 * Controls vga output syncs and clk
 */
module H_SYNC(clk, hout, bout, newLine, Xcount);

input clk;
output hout, bout, newLine;
output [31:0] Xcount;
	
reg [31:0] count = 32'd0;
reg hsync, blank, new1;

always @(posedge clk) 
begin
	if (count <  1688)
		count <= Xcount + 1;
	else 
      count <= 0;
   end 

always @(*) 
begin
	if (count == 0)
		new1 = 1;
	else
		new1 = 0;
   end 

always @(*) 
begin
	if (count > 1279) 
		blank = 1;
   else 
		blank = 0;
   end

always @(*) 
begin
	if (count < 1328)
		hsync = 1;
   else if (count > 1327 && count < 1440)
		hsync = 0;
   else    
		hsync = 1;
	end

assign Xcount=count;
assign hout = hsync;
assign bout = blank;
assign newLine = new1;

endmodule


module V_SYNC(clk, vout, bout, Ycount);

input clk;
output vout, bout;
output [31:0]Ycount; 
	  
reg [31:0] count = 32'd0;
reg vsync, blank;

always @(posedge clk) 
begin
	if (count <  1066)
		count <= Ycount + 1;
   else 
            count <= 0;
   end 

always @(*) 
begin
	if (count < 1024) 
		blank = 1;
   else 
		blank = 0;
   end

always @(*) 
begin
	if (count < 1025)
		vsync = 1;
	else if (count > 1024 && count < 1028)
		vsync = 0;
	else    
		vsync = 1;
	end

assign Ycount=count;
assign vout = vsync;
assign bout = blank;

endmodule

//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module clock108 (areset, inclk0, c0, locked);

input     areset;
input     inclk0;
output    c0;
output    locked;

`ifndef ALTERA_RESERVED_QIS
 //synopsys translate_off
`endif

tri0      areset;

`ifndef ALTERA_RESERVED_QIS
 //synopsys translate_on
`endif

wire [0:0] sub_wire2 = 1'h0;
wire [4:0] sub_wire3;
wire  sub_wire5;
wire  sub_wire0 = inclk0;
wire [1:0] sub_wire1 = {sub_wire2, sub_wire0};
wire [0:0] sub_wire4 = sub_wire3[0:0];
wire  c0 = sub_wire4;
wire  locked = sub_wire5;
	 
altpll  altpll_component (
            .areset (areset),
            .inclk (sub_wire1),
            .clk (sub_wire3),
            .locked (sub_wire5),
            .activeclock (),
            .clkbad (),
            .clkena ({6{1'b1}}),
            .clkloss (),
            .clkswitch (1'b0),
            .configupdate (1'b0),
            .enable0 (),
            .enable1 (),
            .extclk (),
            .extclkena ({4{1'b1}}),
            .fbin (1'b1),
            .fbmimicbidir (),
            .fbout (),
            .fref (),
            .icdrclk (),
            .pfdena (1'b1),
            .phasecounterselect ({4{1'b1}}),
            .phasedone (),
            .phasestep (1'b1),
            .phaseupdown (1'b1),
            .pllena (1'b1),
            .scanaclr (1'b0),
            .scanclk (1'b0),
            .scanclkena (1'b1),
            .scandata (1'b0),
            .scandataout (),
            .scandone (),
            .scanread (1'b0),
            .scanwrite (1'b0),
            .sclkout0 (),
            .sclkout1 (),
            .vcooverrange (),
            .vcounderrange ());
defparam
    altpll_component.bandwidth_type = "AUTO",
    altpll_component.clk0_divide_by = 25,
    altpll_component.clk0_duty_cycle = 50,
    altpll_component.clk0_multiply_by = 54,
    altpll_component.clk0_phase_shift = "0",
    altpll_component.compensate_clock = "CLK0",
    altpll_component.inclk0_input_frequency = 20000,
    altpll_component.intended_device_family = "Cyclone IV E",
    altpll_component.lpm_hint = "CBX_MODULE_PREFIX=clock108",
    altpll_component.lpm_type = "altpll",
    altpll_component.operation_mode = "NORMAL",
    altpll_component.pll_type = "AUTO",
    altpll_component.port_activeclock = "PORT_UNUSED",
    altpll_component.port_areset = "PORT_USED",
    altpll_component.port_clkbad0 = "PORT_UNUSED",
    altpll_component.port_clkbad1 = "PORT_UNUSED",
    altpll_component.port_clkloss = "PORT_UNUSED",
    altpll_component.port_clkswitch = "PORT_UNUSED",
    altpll_component.port_configupdate = "PORT_UNUSED",
    altpll_component.port_fbin = "PORT_UNUSED",
    altpll_component.port_inclk0 = "PORT_USED",
    altpll_component.port_inclk1 = "PORT_UNUSED",
    altpll_component.port_locked = "PORT_USED",
    altpll_component.port_pfdena = "PORT_UNUSED",
    altpll_component.port_phasecounterselect = "PORT_UNUSED",
    altpll_component.port_phasedone = "PORT_UNUSED",
    altpll_component.port_phasestep = "PORT_UNUSED",
    altpll_component.port_phaseupdown = "PORT_UNUSED",
    altpll_component.port_pllena = "PORT_UNUSED",
    altpll_component.port_scanaclr = "PORT_UNUSED",
    altpll_component.port_scanclk = "PORT_UNUSED",
    altpll_component.port_scanclkena = "PORT_UNUSED",
    altpll_component.port_scandata = "PORT_UNUSED",
    altpll_component.port_scandataout = "PORT_UNUSED",
    altpll_component.port_scandone = "PORT_UNUSED",
    altpll_component.port_scanread = "PORT_UNUSED",
    altpll_component.port_scanwrite = "PORT_UNUSED",
    altpll_component.port_clk0 = "PORT_USED",
    altpll_component.port_clk1 = "PORT_UNUSED",
    altpll_component.port_clk2 = "PORT_UNUSED",
    altpll_component.port_clk3 = "PORT_UNUSED",
    altpll_component.port_clk4 = "PORT_UNUSED",
    altpll_component.port_clk5 = "PORT_UNUSED",
    altpll_component.port_clkena0 = "PORT_UNUSED",
    altpll_component.port_clkena1 = "PORT_UNUSED",
    altpll_component.port_clkena2 = "PORT_UNUSED",
    altpll_component.port_clkena3 = "PORT_UNUSED",
    altpll_component.port_clkena4 = "PORT_UNUSED",
    altpll_component.port_clkena5 = "PORT_UNUSED",
    altpll_component.port_extclk0 = "PORT_UNUSED",
    altpll_component.port_extclk1 = "PORT_UNUSED",
    altpll_component.port_extclk2 = "PORT_UNUSED",
    altpll_component.port_extclk3 = "PORT_UNUSED",
    altpll_component.self_reset_on_loss_lock = "OFF",
    altpll_component.width_clock = 5;

endmodule