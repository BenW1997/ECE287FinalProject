//===========================================//
//====================VGA====================//
//===========================================//
/*


MINESWEEPER implementation module by Collin Gardner and Ben Wong

Our VGA Module: Modified by Collin Gardner and Ben Wong
VGA MODULE: Modified by Parth Patel, Ian Baker, and Yi Zhan

Most of all the code here is modified to basic VGA Displaying capabilities,

VGA MODULE adopted from BEN SHAFFER...
Utilized Ben's VGA module that he borrowed from OAKLEY KATTERHEINRICH.
Parameters were set by Ben.

*/
//===========================================//
//====================VGA====================//
//===========================================//
module test(clk, button1, button2, button3, button4, resetGame, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15,  VGA_R, VGA_B, VGA_G, VGA_BLANK_N, VGA_SYNC_N , VGA_HS, VGA_VS, rst, VGA_CLK, kbCLK, data);

//outputs the colors, determined from the color module.
output [7:0] VGA_R, VGA_B, VGA_G;
input button1, button2, button3, button4;//select
input in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15; //these are all the switches for the bombs
//Makes sure the screen is synced right.
output VGA_HS, VGA_VS, VGA_BLANK_N, VGA_CLK, VGA_SYNC_N;
input kbCLK, data;
input clk, rst; //clk is taken from the onboard clock 50MHz. rst is taken from a switch, SW[17].
//input testEn; 
wire CLK108; //Clock for the VGA

/*
Coordinates of the pixel being assigned. Moves top to bottom, left to right.
*/
wire [30:0]X, Y;
input resetGame;
wire reset; 
 //needs pins

wire [4:0]direction;
wire update;



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

//reg that tells to erase the box
reg erasebox2 = 0;reg erasebox3 = 0; reg erasebox4 = 0;reg erasebox5 = 0; reg erasebox6 = 0; reg erasebox7 = 0; reg erasebox8 = 0; reg erasebox9 = 0; reg erasebox10 = 0; reg erasebox11 = 0; reg erasebox12 = 0; reg erasebox13 = 0; reg erasebox14 = 0; reg erasebox15 = 0; reg erasebox16 = 0; reg erasebox17 = 0; reg erasebox18 = 0; reg erasebox19 = 0; reg erasebox20 = 0; reg erasebox21 = 0; reg erasebox22 = 0; reg erasebox23 = 0; reg erasebox24 = 0; reg erasebox25 = 0; reg erasebox26 = 0; reg erasebox27 = 0; reg erasebox28 = 0; reg erasebox29 = 0; reg erasebox30 = 0; reg erasebox31 = 0; reg erasebox32 = 0; reg erasebox33 = 0; reg erasebox34 = 0; reg erasebox35 = 0; reg erasebox36 = 0; reg erasebox37 = 0; 
//reg that gives caution signal that space is touching one space with a bomb
reg caution2 = 0; reg caution3 = 0; reg caution4 = 0; reg caution5 = 0; reg caution6 = 0; reg caution7 = 0; reg caution8 = 0; reg caution9 = 0; reg caution10 = 0; reg caution11 = 0; reg caution12 = 0; reg caution13 = 0; reg caution14 = 0; reg caution15 = 0; reg caution16 = 0; reg caution17 = 0; reg caution18 = 0; reg caution19 = 0; reg caution20 = 0; reg caution21 = 0; reg caution22 = 0; reg caution23 = 0; reg caution24 = 0; reg caution25 = 0; reg caution26 = 0; reg caution27 = 0; reg caution28 = 0; reg caution29 = 0; reg caution30 = 0; reg caution31 = 0; reg caution32 = 0; reg caution33 = 0; reg caution34 = 0; reg caution35 = 0; reg caution36 = 0; reg caution37 = 0; 
//tells uswhere teh bombs would be at
reg bombAT2 = 0; reg bombAT3 = 0; reg bombAT4 = 0; reg bombAT5 = 0; reg bombAT6 = 0; reg bombAT7 = 0; reg bombAT8 = 0; reg bombAT9 = 0; reg bombAT10 = 0; reg bombAT11 = 0; reg bombAT12 = 0; reg bombAT13 = 0; reg bombAT14 = 0; reg bombAT15 = 0; reg bombAT16 = 0; reg bombAT17 = 0; reg bombAT18 = 0; reg bombAT19 = 0; reg bombAT20 = 0; reg bombAT21 = 0; reg bombAT22 = 0; reg bombAT23 = 0; reg bombAT24 = 0; reg bombAT25 = 0; reg bombAT26 = 0; reg bombAT27 = 0; reg bombAT28 = 0; reg bombAT29 = 0; reg bombAT30 = 0; reg bombAT31 = 0; reg bombAT32 = 0; reg bombAT33 = 0; reg bombAT34 = 0; reg bombAT35 = 0; reg bombAT36 = 0; reg bombAT37 = 0; 

//reg that gives signal that space is touching spaces with two or more bombs
reg warning2 = 0;  reg warning3 = 0;  reg warning4 = 0;  reg warning5 = 0;  reg warning6 = 0;  reg warning7 = 0;  reg warning8 = 0;  reg warning9 = 0;  reg warning10 = 0;  reg warning11 = 0;  reg warning12 = 0;  reg warning13 = 0;  reg warning14 = 0;  reg warning15 = 0;  reg warning16 = 0;  reg warning17 = 0;  reg warning18 = 0;  reg warning19 = 0;  reg warning20 = 0;  reg warning21 = 0;  reg warning22 = 0;  reg warning23 = 0;  reg warning24 = 0;  reg warning25 = 0;  reg warning26 = 0;  reg warning27 = 0;  reg warning28 = 0;  reg warning29 = 0;  reg warning30 = 0;  reg warning31 = 0;  reg warning32 = 0;  reg warning33 = 0;  reg warning34 = 0;  reg warning35 = 0;  reg warning36 = 0;  reg warning37 = 0; 

//this tells us if there is bomb there or not
wire isBomb2, isBomb3, isBomb4, isBomb5, isBomb6, isBomb7, isBomb8, isBomb9, isBomb10, isBomb11, isBomb12, isBomb13, isBomb14, isBomb15, isBomb16, isBomb17, isBomb18, isBomb19, isBomb20, isBomb21, isBomb22, isBomb23, isBomb24, isBomb25, isBomb26, isBomb27, isBomb28, isBomb29, isBomb30, isBomb31, isBomb32, isBomb33, isBomb34, isBomb35, isBomb36, isBomb37;

//THIS WILL TELL IF GAME IS WON
reg ccount;
reg win;

//this module generates the bombs
randomGen bombGeneration(in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, isBomb2, isBomb3, isBomb4, isBomb5, isBomb6, isBomb7, isBomb8, isBomb9, isBomb10, isBomb11, isBomb12, isBomb13, isBomb14, isBomb15, isBomb16, isBomb17, isBomb18, isBomb19, isBomb20, isBomb21, isBomb22, isBomb23, isBomb24, isBomb25, isBomb26, isBomb27, isBomb28, isBomb29, isBomb30, isBomb31, isBomb32, isBomb33, isBomb34, isBomb35, isBomb36, isBomb37);
 
////SELECTOR MOUDLE //this Module Controls us selecting the each grid in the field, and tells us what will change
always @ (posedge clk)
	begin
	//ccount <= ccount +1;
		if(resetGame == 1'b1) //this would reset the whole game 
		begin
			erasebox2 = 0; erasebox3 = 0; erasebox4 = 0; erasebox5 = 0; erasebox6 = 0; erasebox7 = 0; erasebox8 = 0; erasebox9 = 0; erasebox10 = 0; erasebox11 = 0; erasebox12 = 0; erasebox13 = 0; erasebox14 = 0; erasebox15 = 0; erasebox16 = 0; erasebox17 = 0; erasebox18 = 0; erasebox19 = 0; erasebox20 = 0; erasebox21 = 0; erasebox22 = 0; erasebox23 = 0; erasebox24 = 0; erasebox25 = 0; erasebox26 = 0; erasebox27 = 0; erasebox28 = 0; erasebox29 = 0; erasebox30 = 0; erasebox31 = 0; erasebox32 = 0; erasebox33 = 0; erasebox34 = 0; erasebox35 = 0; erasebox36 = 0; erasebox37 = 0; 
			bombAT2 = 0; bombAT3 = 0; bombAT4 = 0; bombAT5 = 0; bombAT6 = 0; bombAT7 = 0; bombAT8 = 0; bombAT9 = 0; bombAT10 = 0; bombAT11 = 0; bombAT12 = 0; bombAT13 = 0; bombAT14 = 0; bombAT15 = 0; bombAT16 = 0; bombAT17 = 0; bombAT18 = 0; bombAT19 = 0; bombAT20 = 0; bombAT21 = 0; bombAT22 = 0; bombAT23 = 0; bombAT24 = 0; bombAT25 = 0; bombAT26 = 0; bombAT27 = 0; bombAT28 = 0; bombAT29 = 0; bombAT30 = 0; bombAT31 = 0; bombAT32 = 0; bombAT33 = 0; bombAT34 = 0; bombAT35 = 0; bombAT36 = 0; bombAT37 = 0; 
			caution2 = 0; caution3 = 0; caution4 = 0; caution5 = 0; caution6 = 0; caution7 = 0; caution8 = 0; caution9 = 0; caution10 = 0; caution11 = 0; caution12 = 0; caution13 = 0; caution14 = 0; caution15 = 0; caution16 = 0; caution17 = 0; caution18 = 0; caution19 = 0; caution20 = 0; caution21 = 0; caution22 = 0; caution23 = 0; caution24 = 0; caution25 = 0; caution26 = 0; caution27 = 0; caution28 = 0; caution29 = 0; caution30 = 0; caution31 = 0; caution32 = 0; caution33 = 0; caution34 = 0; caution35 = 0; caution36 = 0; caution37 = 0; 
		   warning2 = 0; warning3 = 0; warning4 = 0; warning5 = 0; warning6 = 0; warning7 = 0; warning8 = 0; warning9 = 0; warning10 = 0; warning11 = 0; warning12 = 0; warning13 = 0; warning14 = 0; warning15 = 0; warning16 = 0; warning17 = 0; warning18 = 0; warning19 = 0; warning20 = 0; warning21 = 0; warning22 = 0; warning23 = 0; warning24 = 0; warning25 = 0; warning26 = 0; warning27 = 0; warning28 = 0; warning29 = 0; warning30 = 0; warning31 = 0; warning32 = 0; warning33 = 0; warning34 = 0; warning35 = 0; warning36 = 0; warning37 = 0; 
			ccount = 0;
			win = 0;
		end
	
		if(object38X >= 31'd256 && object38X <= 31'd406 - 31'd100 && object38Y <= 31'd166 -31'd100 && object38Y >= 31'd000 && select == 8'h14 && isBomb2 == 1'b0) 
		begin
			erasebox2 = 1;
			ccount = ccount + 1'b1;
	   end
	 	else if(object38X >= 31'd256 && object38X <= 31'd406 - 31'd100 && object38Y <= 31'd166 -31'd100 && object38Y >= 31'd000 && select ==8'h14 && isBomb2 == 1'b1) 
		begin
			bombAT2 = 1; //this would just change it to red, then change the color module down below
	   end
		//square3
		if(object38X >= 31'd422 && object38X <= 31'd572 - 31'd100 && object38Y <= 31'd166 -31'd100 && object38Y >= 31'd000 && select == 8'h14&& isBomb3 == 1'b0)
		begin
			erasebox3= 1;
			ccount = ccount + 1'b1;
		end
			if(object38X >= 31'd422 && object38X <= 31'd572 - 31'd100 && object38Y <= 31'd150 -31'd100 && object38Y >= 31'd000 && select == 8'h14&& isBomb3 == 1'b1)
				begin
					bombAT3 = 1;
			end
			//square4
			if(object38X >= 31'd588 && object38X <= 31'd738 - 31'd100 && object38Y <= 31'd150 -31'd100 && object38Y >= 31'd000 && select == 8'h14&& isBomb4 == 1'b0)
					begin
						erasebox4= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd588 && object38X <= 31'd738 - 31'd100 && object38Y <= 31'd150 -31'd100 && object38Y >= 31'd000 && select == 8'h14&& isBomb4 == 1'b1)
					begin
						bombAT4 = 1;
			end
			//square5
			if(object38X >= 31'd754 && object38X <= 31'd904 - 31'd100 && object38Y <= 31'd150 -31'd100 && object38Y >= 31'd000 && select == 8'h14&& isBomb5 == 1'b0)
					begin
						erasebox5= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd754 && object38X <= 31'd904 - 31'd100 && object38Y <= 31'd150 -31'd100 && object38Y >= 31'd000 && select ==8'h14&& isBomb5 == 1'b1)
					begin
						bombAT5 = 1;
			end
			//square6
			if(object38X >= 31'd920 && object38X <= 31'd1070 - 31'd100 && object38Y <= 31'd150 -31'd100 && object38Y >= 31'd000 && select ==8'h14 && isBomb6 == 1'b0)
					begin
						erasebox6= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd920 && object38X <= 31'd1070 - 31'd100 && object38Y <= 31'd150 -31'd100 && object38Y >= 31'd000 && select == 8'h14 && isBomb6 == 1'b1)
					begin
						bombAT6 = 1;
						
			end
			//square7
			if(object38X >= 31'd1086 && object38X <= 31'd1236 - 31'd100 && object38Y <= 31'd150 -31'd100 && object38Y >= 31'd000 && select == 8'h14 && isBomb7 == 1'b0)
					begin
						erasebox7= 1;
					end
			if(object38X >= 31'd1086 && object38X <= 31'd1236 - 31'd100 && object38Y <= 31'd150 -31'd100 && object38Y >= 31'd000 && select == 8'h14 && isBomb7 == 1'b1)
					begin
						bombAT7 = 1;
			end
			//newSquare
			if(object38X >= 31'd256 && object38X <= 31'd406 - 31'd100 && object38Y <= 31'd316 -31'd100 && object38Y >= 31'd166 && select == 8'h14 && isBomb8 == 1'b0)
					begin
						erasebox8= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd256 && object38X <= 31'd406 - 31'd100 && object38Y <= 31'd316 -31'd100 && object38Y >= 31'd166 && select == 8'h14&& isBomb8 == 1'b1)
					begin
						bombAT8 = 1;
			end
			//newSquare
			if(object38X >= 31'd422 && object38X <= 31'd572 - 31'd100 && object38Y <= 31'd316 -31'd100 && object38Y >= 31'd166 && select == 8'h14&& isBomb9 == 1'b0)
					begin
						erasebox9= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd422 && object38X <= 31'd572 - 31'd100 && object38Y <= 31'd316 -31'd100 && object38Y >= 31'd166 && select == 8'h14 && isBomb9 == 1'b1)
					begin
						bombAT9 = 1;
			end
			//newSquare
			if(object38X >= 31'd588 && object38X <= 31'd738 - 31'd100 && object38Y <= 31'd316 -31'd100 && object38Y >= 31'd166 && select == 8'h14 && isBomb10 == 1'b0)
					begin
						erasebox10= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd588 && object38X <= 31'd738 - 31'd100 && object38Y <= 31'd316 -31'd100 && object38Y >= 31'd166 && select == 8'h14 && isBomb10 == 1'b1)
					begin
						bombAT10 = 1;
			end
			//newSquare
			if(object38X >= 31'd754 && object38X <= 31'd904 - 31'd100 && object38Y <= 31'd316 -31'd100 && object38Y >= 31'd166 && select == 8'h14&& isBomb11 == 1'b0)
					begin
						erasebox11= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd754 && object38X <= 31'd904 - 31'd100 && object38Y <= 31'd316 -31'd100 && object38Y >= 31'd166 && select == 8'h14 && isBomb11 == 1'b1)
					begin
						bombAT11 = 1;
			end
			//newSquare
			if(object38X >= 31'd920 && object38X <= 31'd1070 - 31'd100 && object38Y <= 31'd316 -31'd100 && object38Y >= 31'd166 && select == 8'h14&& isBomb12 == 1'b0)
					begin
						erasebox12= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd920 && object38X <= 31'd1070 - 31'd100 && object38Y <= 31'd316 -31'd100 && object38Y >= 31'd166 && select == 8'h14 && isBomb12 == 1'b1)
					begin
						bombAT12 = 1;
			end
			//newSquare
			if(object38X >= 31'd1086 && object38X <= 31'd1236 - 31'd100 && object38Y <= 31'd316 -31'd100 && object38Y >= 31'd166 && select ==8'h14&& isBomb13 == 1'b0)
					begin
						erasebox13= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd1086 && object38X <= 31'd1236 - 31'd100 && object38Y <= 31'd316 -31'd100 && object38Y >= 31'd166 && select == 8'h14 && isBomb13 == 1'b1)
					begin
						bombAT13 = 1;
			end
			//newSquare and new Row
			if(object38X >= 31'd256 && object38X <= 31'd406 - 31'd100 && object38Y <= 31'd482 -31'd100 && object38Y >= 31'd332 && select == 8'h14 && isBomb14 == 1'b0)
					begin
						erasebox14= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd256 && object38X <= 31'd406 - 31'd100 && object38Y <= 31'd482 -31'd100 && object38Y >= 31'd332 && select == 8'h14&& isBomb14 == 1'b1)
					begin
						bombAT14 = 1;
			end
			//newSquare
			if(object38X >= 31'd422 && object38X <= 31'd572 - 31'd100 && object38Y <= 31'd482 -31'd100 && object38Y >= 31'd332 && select ==8'h14 && isBomb15 == 1'b0)
					begin
						erasebox15= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd422 && object38X <= 31'd572 - 31'd100 && object38Y <= 31'd482 -31'd100 && object38Y >= 31'd332 && select == 8'h14&& isBomb15 == 1'b1)
					begin
						bombAT15 = 1;
			end
			//newSquare
			if(object38X >= 31'd588 && object38X <= 31'd738 - 31'd100 && object38Y <= 31'd482 -31'd100 && object38Y >= 31'd332 && select == 8'h14 && isBomb16 == 1'b0)
					begin
						erasebox16= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd588 && object38X <= 31'd738 - 31'd100 && object38Y <= 31'd482 -31'd100 && object38Y >= 31'd332 && select == 8'h14&& isBomb16 == 1'b1)
					begin
						bombAT16 = 1;
			end
			//newSquare
			if(object38X >= 31'd754 && object38X <= 31'd904 - 31'd100 && object38Y <= 31'd482 -31'd100 && object38Y >= 31'd332 && select == 8'h14 && isBomb17 == 1'b0)
					begin
						erasebox17= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd754 && object38X <= 31'd904 - 31'd100 && object38Y <= 31'd482 -31'd100 && object38Y >= 31'd332 && select == 8'h14 && isBomb17 == 1'b1)
					begin
						bombAT17 = 1;
			end
			//newSquare
			if(object38X >= 31'd920 && object38X <= 31'd1070 - 31'd100 && object38Y <= 31'd482 -31'd100 && object38Y >= 31'd332 && select == 8'h14&& isBomb18 == 1'b0)
					begin
						erasebox18= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd920 && object38X <= 31'd1070 - 31'd100 && object38Y <= 31'd482 -31'd100 && object38Y >= 31'd332 && select == 8'h14&& isBomb18 == 1'b1)
					begin
						bombAT18 = 1;
			end
			//newSquare
			if(object38X >= 31'd1086 && object38X <= 31'd1236 - 31'd100 && object38Y <= 31'd482 -31'd100 && object38Y >= 31'd332 && select == 8'h14&& isBomb19 == 1'b0)
					begin
						erasebox19= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd1086 && object38X <= 31'd1236 - 31'd100 && object38Y <= 31'd482 -31'd100 && object38Y >= 31'd332 && select == 8'h14 && isBomb19 == 1'b1)
					begin
						bombAT19 = 1;
			end
			//newSquare
			if(object38X >= 31'd256 && object38X <= 31'd406 - 31'd100 && object38Y <= 31'd648-31'd100 && object38Y >= 31'd498 && select == 8'h14 && isBomb20 == 1'b0)
					begin
						erasebox20= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd256 && object38X <= 31'd406 - 31'd100 && object38Y <= 31'd648 -31'd100 && object38Y >= 31'd498 && select == 8'h14 && isBomb20 == 1'b1)
					begin
						bombAT20 = 1;
			end
			//newSquare
			if(object38X >= 31'd422 && object38X <= 31'd572 - 31'd100 && object38Y <= 31'd648 -31'd100 && object38Y >= 31'd498 && select == 8'h14 && isBomb21 == 1'b0)
					begin
						erasebox21= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd422 && object38X <= 31'd572 - 31'd100 && object38Y <= 31'd648 -31'd100 && object38Y >= 31'd498 && select == 8'h14 && isBomb21 == 1'b1)
					begin
						bombAT21 = 1;
			end
			//newSquare
			if(object38X >= 31'd588 && object38X <= 31'd738 - 31'd100 && object38Y <= 31'd648 -31'd100 && object38Y >= 31'd498 && select == 8'h14 && isBomb22 == 1'b0)
					begin
						erasebox22= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd588 && object38X <= 31'd738 - 31'd100 && object38Y <= 31'd648 -31'd100 && object38Y >= 31'd498 && select == 8'h14 && isBomb22 == 1'b1)
					begin
						bombAT22 = 1;
			end
			//newSquare
			if(object38X >= 31'd754 && object38X <= 31'd904 - 31'd100 && object38Y <= 31'd648 -31'd100 && object38Y >= 31'd498 && select == 8'h14 && isBomb23 == 1'b0)
					begin
						erasebox23= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd754 && object38X <= 31'd904 - 31'd100 && object38Y <= 31'd648 -31'd100 && object38Y >= 31'd498 && select == 8'h14&& isBomb23 == 1'b1)
					begin
						bombAT23 = 1;
			end
			//newSquare
			if(object38X >= 31'd920 && object38X <= 31'd1070 - 31'd100 && object38Y <= 31'd648 -31'd100 && object38Y >= 31'd498 && select == 8'h14 && isBomb24 == 1'b0)
					begin
						erasebox24= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd920 && object38X <= 31'd1070 - 31'd100 && object38Y <= 31'd648 -31'd100 && object38Y >= 31'd498 && select ==8'h14&& isBomb24 == 1'b1)
					begin
						bombAT24 = 1;
			end
			//newSquare
			if(object38X >= 31'd1086 && object38X <= 31'd1236 - 31'd100 && object38Y <= 31'd648 -31'd100 && object38Y >= 31'd498 && select == 8'h14 && isBomb25 == 1'b0)
					begin
						erasebox25= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd1086 && object38X <= 31'd1236 - 31'd100 && object38Y <= 31'd648 -31'd100 && object38Y >= 31'd498 && select == 8'h14 && isBomb25 == 1'b1)
					begin
						bombAT25 = 1;
			end
			//newSquare
			if(object38X >= 31'd256 && object38X <= 31'd406 - 31'd100 && object38Y <= 31'd814 -31'd100 && object38Y >= 31'd664 && select == 8'h14 && isBomb26 == 1'b0)
					begin
						erasebox26= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd256 && object38X <= 31'd406 - 31'd100 && object38Y <= 31'd814 -31'd100 && object38Y >= 31'd664 && select == 8'h14 && isBomb26 == 1'b1)
					begin
						bombAT26 = 1;
			end
			//newSquare
			if(object38X >= 31'd422 && object38X <= 31'd572 - 31'd100 && object38Y <= 31'd814 -31'd100 && object38Y >= 31'd664 && select == 8'h14 && isBomb27 == 1'b0)
					begin
						erasebox27= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd422 && object38X <= 31'd572 - 31'd100 && object38Y <= 31'd814 -31'd100 && object38Y >= 31'd664 && select == 8'h14 && isBomb27 == 1'b1)
					begin
						bombAT27 = 1;
			end
			//newSquare
			if(object38X >= 31'd588 && object38X <= 31'd738 - 31'd100 && object38Y <= 31'd814 -31'd100 && object38Y >= 31'd664 && select == 8'h14 && isBomb28 == 1'b0)
					begin
						erasebox28= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd588 && object38X <= 31'd738 - 31'd100 && object38Y <= 31'd814 -31'd100 && object38Y >= 31'd664 && select == 8'h14 && isBomb28 == 1'b1)
					begin
						bombAT28 = 1;
			end
			//newSquare
			if(object38X >= 31'd754 && object38X <= 31'd904 - 31'd100 && object38Y <= 31'd814 -31'd100 && object38Y >= 31'd664 && select == 8'h14 && isBomb29 == 1'b0)
					begin
						erasebox29= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd754 && object38X <= 31'd904 - 31'd100 && object38Y <= 31'd814 -31'd100 && object38Y >= 31'd664 && select == 8'h14&& isBomb29 == 1'b1)
					begin
						bombAT29 = 1;
			end
			//newSquare
			if(object38X >= 31'd920 && object38X <= 31'd1070 - 31'd100 && object38Y <= 31'd814 -31'd100 && object38Y >= 31'd664 && select == 8'h14 && isBomb30 == 1'b0)
					begin
						erasebox30= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd920 && object38X <= 31'd1070 - 31'd100 && object38Y <= 31'd814 -31'd100 && object38Y >= 31'd664 && select == 8'h14 && isBomb30 == 1'b1)
					begin
						bombAT30 = 1;
			end
			//newSquare
			if(object38X >= 31'd1086 && object38X <= 31'd1236 - 31'd100 && object38Y <= 31'd814 -31'd100 && object38Y >= 31'd664 && select == 8'h14 && isBomb31 == 1'b0)
					begin
						erasebox31= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd1086 && object38X <= 31'd1236 - 31'd100 && object38Y <= 31'd814 -31'd100 && object38Y >= 31'd664 && select == 8'h14&& isBomb31 == 1'b1)
					begin
						bombAT31 = 1;
			end
			//newSquare
			if(object38X >= 31'd256 && object38X <= 31'd406 - 31'd100 && object38Y <= 31'd980 -31'd100 && object38Y >= 31'd830 && select ==8'h14 && isBomb32 == 1'b0)
					begin
						erasebox32= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd256 && object38X <= 31'd406 - 31'd100 && object38Y <= 31'd980 -31'd100 && object38Y >= 31'd830 && select == 8'h14&& isBomb32 == 1'b1)
					begin
						bombAT32 = 1;
			end
			//newSquare
			if(object38X >= 31'd422 && object38X <= 31'd572 - 31'd100 && object38Y <= 31'd980 -31'd100 && object38Y >= 31'd830 && select == 8'h14 && isBomb33 == 1'b0)
					begin
						erasebox33= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd422 && object38X <= 31'd572 - 31'd100 && object38Y <= 31'd980 -31'd100 && object38Y >= 31'd830 && select == 8'h14 && isBomb33 == 1'b1)
					begin
						bombAT33 = 1;
			end
			//newSquare
			if(object38X >= 31'd588 && object38X <= 31'd738 - 31'd100 && object38Y <= 31'd980 -31'd100 && object38Y >= 31'd830 && select == 8'h14&& isBomb34 == 1'b0)
					begin
						erasebox34= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd588 && object38X <= 31'd738 - 31'd100 && object38Y <= 31'd980 -31'd100 && object38Y >= 31'd830 && select == 8'h14 && isBomb34 == 1'b1)
					begin
						bombAT34 = 1;
			end
			if(object38X >= 31'd754 && object38X <= 31'd904 - 31'd100 && object38Y <= 31'd980 -31'd100 && object38Y >= 31'd830 && select == 8'h14 && isBomb35 == 1'b0)
					begin
						erasebox35= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd754 && object38X <= 31'd904 - 31'd100 && object38Y <= 31'd980 -31'd100 && object38Y >= 31'd830 && select == 8'h14 && isBomb35 == 1'b1)
					begin
						bombAT35 = 1;
			end
			if(object38X >= 31'd920 && object38X <= 31'd1070 - 31'd100 && object38Y <= 31'd980 -31'd100 && object38Y >= 31'd830 && select == 8'h14 && isBomb36 == 1'b0)
					begin
						erasebox36= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd920 && object38X <= 31'd1070 - 31'd100 && object38Y <= 31'd980 -31'd100 && object38Y >= 31'd830 && select ==8'h14 && isBomb36 == 1'b1)
					begin
						bombAT36 = 1;
			end
			if(object38X >= 31'd1086 && object38X <= 31'd1236 - 31'd100 && object38Y <= 31'd980 -31'd100 && object38Y >= 31'd830 && select == 8'h14 && isBomb37 == 1'b0)
					begin
						erasebox37= 1;
						ccount = ccount + 1'b1;
					end
			if(object38X >= 31'd1086 && object38X <= 31'd1236 - 31'd100 && object38Y <= 31'd980 -31'd100 && object38Y >= 31'd830 && select == 8'h14 && isBomb37 == 1'b1)
					begin
						bombAT37 = 1;
			end
			
			///end of telling use whether space is empty or bomb occupied
			//NOW TO TELL IF SPACE HAS BOMB AROUND IT, YELLOW(CAUTION REG "bOOLEAN")  = SPACE IS TOUCHING 1 BOMB AND (WARNING "BOOLEAN")ORANGE = SPACE IS TOUCHING 2 OR MORE BOMBS 
			//THIS PART LOOKS AT THE SQUARES IN THE MIDDLE OF THE BOARD,4 CASES FOR EACH
			if(erasebox2 == 1 && (isBomb4 == 1 ^ isBomb9 == 1))//tells if one bomb by space  3, turns yellow
				begin
						caution3 = 1;
				end
			if(erasebox2 ==1 && (isBomb4 ==1 && isBomb9 ==1)) //tells if 2 bombs by space 3
				begin	
					warning3 = 1;
			 	end	
			
			
			if(erasebox2 == 1 && (isBomb4 == 1 ^ isBomb9 == 1))//tells if one bomb by space  3
				begin
						caution3 = 1;
				end
			if(erasebox2 ==1 && (isBomb4 ==1 && isBomb9 ==1)) //tells if 2 bombs by space 3
				begin	
					warning3 = 1;
			 	end		
			//generating caution and warning for box9, and box left of it is selected
		if(erasebox8 == 1 && (isBomb3 == 1 ^ isBomb10 == 1 ^ isBomb15 ==1 ) )
			begin
				caution9 = 1;
			end
		if(erasebox8 ==1 && ((isBomb3 ==1 && isBomb10 ==1) | (isBomb3 ==1 && isBomb15 ==1) | (isBomb10 ==1 | isBomb15 ==1)))
			begin
				warning9 = 1;
			end
		//generating caution and warning for box10, and box left of it is selected
				if(erasebox9 == 1 && (isBomb4 == 1 ^ isBomb11 == 1 ^ isBomb16 ==1 ) )
					begin
						caution10 = 1;
					end
				if(erasebox9 ==1 && ((isBomb4 ==1 && isBomb11 ==1) | (isBomb4 ==1 && isBomb16 ==1) | (isBomb11 ==1 | isBomb16 ==1)))
					begin
						warning10 = 1;
					end
		//generating caution and warning for box11, and box left of it is selected
				if(erasebox10 == 1 && (isBomb5 == 1 ^ isBomb12 == 1 ^ isBomb17 ==1 ) )
					begin
						caution11 = 1;
					end
				if(erasebox10 ==1 && ((isBomb5 ==1 && isBomb12 ==1) | (isBomb5 ==1 && isBomb17 ==1) | (isBomb12 ==1 | isBomb17 ==1)))
					begin
						warning11 = 1;
					end
		//generating caution and warning for box12, and box left of it is selected
				if(erasebox11 == 1 && (isBomb6 == 1 ^ isBomb13 == 1 ^ isBomb18 ==1 ) )
					begin
						caution12 = 1;
					end
				if(erasebox11 ==1 && ((isBomb6 ==1 && isBomb13 ==1) | (isBomb6 ==1 && isBomb18 ==1) | (isBomb13 ==1 | isBomb18 ==1)))
					begin
						warning12 = 1;
					end
		//generating caution and warning for box15, and box left of it is selected
				if(erasebox14 == 1 && (isBomb9 == 1 ^ isBomb16 == 1 ^ isBomb21 ==1 ) )
					begin
						caution15 = 1;
					end
				if(erasebox14 ==1 && ((isBomb9 ==1 && isBomb16 ==1) | (isBomb9 ==1 && isBomb21 ==1) | (isBomb16 ==1 | isBomb21 ==1)))
					begin
						warning15 = 1;
					end
		//generating caution and warning for box16, and box left of it is selected
				if(erasebox15 == 1 && (isBomb10 == 1 ^ isBomb17 == 1 ^ isBomb22 ==1 ) )
					begin
						caution16 = 1;
					end
				if(erasebox15 ==1 && ((isBomb10 ==1 && isBomb17 ==1) | (isBomb10 ==1 && isBomb22 ==1) | (isBomb17 ==1 | isBomb22 ==1)))
					begin
						warning16 = 1;
					end
		//generating caution and warning for box17, and box left of it is selected
				if(erasebox16 == 1 && (isBomb11 == 1 ^ isBomb18 == 1 ^ isBomb23 ==1 ) )
					begin
						caution17 = 1;
					end
				if(erasebox16 ==1 && ((isBomb11 ==1 && isBomb18 ==1) | (isBomb11 ==1 && isBomb23 ==1) | (isBomb18 ==1 | isBomb23 ==1)))
					begin
						warning17 = 1;
					end
		//generating caution and warning for box18, and box left of it is selected
				if(erasebox17 == 1 && (isBomb12 == 1 ^ isBomb19 == 1 ^ isBomb24 ==1 ) )
					begin
						caution18 = 1;
					end
				if(erasebox17 ==1 && ((isBomb12 ==1 && isBomb19 ==1) | (isBomb12 ==1 && isBomb24 ==1) | (isBomb19 ==1 | isBomb24 ==1)))
					begin
						warning18 = 1;
					end
		//generating caution and warning for box21, and box left of it is selected
				if(erasebox20 == 1 && (isBomb15 == 1 ^ isBomb22 == 1 ^ isBomb27 ==1 ) )
					begin
						caution21 = 1;
					end
				if(erasebox20 ==1 && ((isBomb15 ==1 && isBomb22 ==1) | (isBomb15 ==1 && isBomb27 ==1) | (isBomb22 ==1 | isBomb27 ==1)))
					begin
						warning21 = 1;
					end
		//generating caution and warning for box22, and box left of it is selected
				if(erasebox21 == 1 && (isBomb16 == 1 ^ isBomb23 == 1 ^ isBomb28 ==1 ) )
					begin
						caution22 = 1;
					end
				if(erasebox21 ==1 && ((isBomb16 ==1 && isBomb23 ==1) | (isBomb16 ==1 && isBomb28 ==1) | (isBomb23 ==1 | isBomb28 ==1)))
					begin
						warning22 = 1;
					end
		//generating caution and warning for box23, and box left of it is selected
				if(erasebox22 == 1 && (isBomb17 == 1 ^ isBomb24 == 1 ^ isBomb29 ==1 ) )
					begin
						caution23 = 1;
					end
				if(erasebox22 ==1 && ((isBomb17 ==1 && isBomb24 ==1) | (isBomb17 ==1 && isBomb29 ==1) | (isBomb24 ==1 | isBomb29 ==1)))
					begin
						warning23 = 1;
					end
		//generating caution and warning for box24, and box left of it is selected
				if(erasebox23 == 1 && (isBomb18 == 1 ^ isBomb25 == 1 ^ isBomb30 ==1 ) )
					begin
						caution24 = 1;
					end
				if(erasebox23 ==1 && ((isBomb18 ==1 && isBomb25 ==1) | (isBomb18 ==1 && isBomb30 ==1) | (isBomb25 ==1 | isBomb30 ==1)))
					begin
						warning24 = 1;
					end
		//generating caution and warning for box27, and box left of it is selected
				if(erasebox26 == 1 && (isBomb21 == 1 ^ isBomb28 == 1 ^ isBomb33 ==1 ) )
					begin
						caution27 = 1;
					end
				if(erasebox26 ==1 && ((isBomb21 ==1 && isBomb28 ==1) | (isBomb21 ==1 && isBomb33 ==1) | (isBomb28 ==1 | isBomb33 ==1)))
					begin
						warning27 = 1;
					end
		//generating caution and warning for box28, and box left of it is selected
				if(erasebox27 == 1 && (isBomb22 == 1 ^ isBomb29 == 1 ^ isBomb34 ==1 ) )
					begin
						caution28 = 1;
					end
				if(erasebox27 ==1 && ((isBomb22 ==1 && isBomb29 ==1) | (isBomb22 ==1 && isBomb34 ==1) | (isBomb29 ==1 | isBomb34 ==1)))
					begin
						warning28 = 1;
					end
		//generating caution and warning for box29, and box left of it is selected
				if(erasebox28 == 1 && (isBomb23 == 1 ^ isBomb30 == 1 ^ isBomb35 ==1 ) )
					begin
						caution29 = 1;
					end
				if(erasebox28 ==1 && ((isBomb23 ==1 && isBomb30 ==1) | (isBomb23 ==1 && isBomb35 ==1) | (isBomb30 ==1 | isBomb35 ==1)))
					begin
						warning29 = 1;
					end
		//generating caution and warning for box30, and box left of it is selected
				if(erasebox29 == 1 && (isBomb24 == 1 ^ isBomb31 == 1 ^ isBomb36 ==1 ) )
					begin
						caution30 = 1;
					end
				if(erasebox29 ==1 && ((isBomb24 ==1 && isBomb31 ==1) | (isBomb24 ==1 && isBomb36 ==1) | (isBomb31 ==1 | isBomb36 ==1)))
					begin
						warning30 = 1;
					end


		// this is if the left block is selected 







		//this looks at the box above

		//generating caution and warning for box9, and box above of it is selected
				if(erasebox3 == 1 && (isBomb8 == 1 ^ isBomb10 == 1 ^ isBomb15 ==1 ) )
					begin
						caution9 = 1;
					end
				if(erasebox3 ==1 && ((isBomb8 ==1 && isBomb10 ==1) | (isBomb8 ==1 && isBomb15 ==1) | (isBomb10 ==1 | isBomb15 ==1)))
					begin
						warning9 = 1;
					end
		//generating caution and warning for box10, and box above of it is selected
				if(erasebox4 == 1 && (isBomb9 == 1 ^ isBomb11 == 1 ^ isBomb16 ==1 ) )
					begin
						caution10 = 1;
					end
				if(erasebox4 ==1 && ((isBomb9 ==1 && isBomb11 ==1) | (isBomb9 ==1 && isBomb16 ==1) | (isBomb11 ==1 | isBomb16 ==1)))
					begin
						warning10 = 1;
					end
		//generating caution and warning for box11, and box above of it is selected
				if(erasebox5 == 1 && (isBomb10 == 1 ^ isBomb12 == 1 ^ isBomb17 ==1 ) )
					begin
						caution11 = 1;
					end
				if(erasebox5 ==1 && ((isBomb10 ==1 && isBomb12 ==1) | (isBomb10 ==1 && isBomb17 ==1) | (isBomb12 ==1 | isBomb17 ==1)))
					begin
						warning11 = 1;
					end
		//generating caution and warning for box12, and box above of it is selected
				if(erasebox6 == 1 && (isBomb11 == 1 ^ isBomb13 == 1 ^ isBomb18 ==1 ) )
					begin
						caution12 = 1;
					end
				if(erasebox6 ==1 && ((isBomb11 ==1 && isBomb13 ==1) | (isBomb11 ==1 && isBomb18 ==1) | (isBomb13 ==1 | isBomb18 ==1)))
					begin
						warning12 = 1;
					end
		//generating caution and warning for box15, and box above of it is selected
				if(erasebox9 == 1 && (isBomb14 == 1 ^ isBomb16 == 1 ^ isBomb21 ==1 ) )
					begin
						caution15 = 1;
					end
				if(erasebox9 ==1 && ((isBomb14 ==1 && isBomb16 ==1) | (isBomb14 ==1 && isBomb21 ==1) | (isBomb16 ==1 | isBomb21 ==1)))
					begin
						warning15 = 1;
					end
		//generating caution and warning for box16, and box above of it is selected
				if(erasebox10 == 1 && (isBomb15 == 1 ^ isBomb17 == 1 ^ isBomb22 ==1 ) )
					begin
						caution16 = 1;
					end
				if(erasebox10 ==1 && ((isBomb15 ==1 && isBomb17 ==1) | (isBomb15 ==1 && isBomb22 ==1) | (isBomb17 ==1 | isBomb22 ==1)))
					begin
						warning16 = 1;
					end
		//generating caution and warning for box17, and box above of it is selected
				if(erasebox11 == 1 && (isBomb16 == 1 ^ isBomb18 == 1 ^ isBomb23 ==1 ) )
					begin
						caution17 = 1;
					end
				if(erasebox11 ==1 && ((isBomb16 ==1 && isBomb18 ==1) | (isBomb16 ==1 && isBomb23 ==1) | (isBomb18 ==1 | isBomb23 ==1)))
					begin
						warning17 = 1;
					end
		//generating caution and warning for box18, and box above of it is selected
				if(erasebox12 == 1 && (isBomb17 == 1 ^ isBomb19 == 1 ^ isBomb24 ==1 ) )
					begin
						caution18 = 1;
					end
				if(erasebox12 ==1 && ((isBomb17 ==1 && isBomb19 ==1) | (isBomb17 ==1 && isBomb24 ==1) | (isBomb19 ==1 | isBomb24 ==1)))
					begin
						warning18 = 1;
					end
		//generating caution and warning for box21, and box above of it is selected
				if(erasebox15 == 1 && (isBomb20 == 1 ^ isBomb22 == 1 ^ isBomb27 ==1 ) )
					begin
						caution21 = 1;
					end
				if(erasebox15 ==1 && ((isBomb20 ==1 && isBomb22 ==1) | (isBomb20 ==1 && isBomb27 ==1) | (isBomb22 ==1 | isBomb27 ==1)))
					begin
						warning21 = 1;
					end
		//generating caution and warning for box22, and box above of it is selected
				if(erasebox16 == 1 && (isBomb21 == 1 ^ isBomb23 == 1 ^ isBomb28 ==1 ) )
					begin
						caution22 = 1;
					end
				if(erasebox16 ==1 && ((isBomb21 ==1 && isBomb23 ==1) | (isBomb21 ==1 && isBomb28 ==1) | (isBomb23 ==1 | isBomb28 ==1)))
					begin
						warning22 = 1;
					end
		//generating caution and warning for box23, and box above of it is selected
				if(erasebox17 == 1 && (isBomb22 == 1 ^ isBomb24 == 1 ^ isBomb29 ==1 ) )
					begin
						caution23 = 1;
					end
				if(erasebox17 ==1 && ((isBomb22 ==1 && isBomb24 ==1) | (isBomb22 ==1 && isBomb29 ==1) | (isBomb24 ==1 | isBomb29 ==1)))
					begin
						warning23 = 1;
					end
		//generating caution and warning for box24, and box above of it is selected
				if(erasebox18 == 1 && (isBomb23 == 1 ^ isBomb25 == 1 ^ isBomb30 ==1 ) )
					begin
						caution24 = 1;
					end
				if(erasebox18 ==1 && ((isBomb23 ==1 && isBomb25 ==1) | (isBomb23 ==1 && isBomb30 ==1) | (isBomb25 ==1 | isBomb30 ==1)))
					begin
						warning24 = 1;
					end
		//generating caution and warning for box27, and box above of it is selected
				if(erasebox21 == 1 && (isBomb26 == 1 ^ isBomb28 == 1 ^ isBomb33 ==1 ) )
					begin
						caution27 = 1;
					end
				if(erasebox21 ==1 && ((isBomb26 ==1 && isBomb28 ==1) | (isBomb26 ==1 && isBomb33 ==1) | (isBomb28 ==1 | isBomb33 ==1)))
					begin
						warning27 = 1;
					end
		//generating caution and warning for box28, and box above of it is selected
				if(erasebox22 == 1 && (isBomb27 == 1 ^ isBomb29 == 1 ^ isBomb34 ==1 ) )
					begin
						caution28 = 1;
					end
				if(erasebox22 ==1 && ((isBomb27 ==1 && isBomb29 ==1) | (isBomb27 ==1 && isBomb34 ==1) | (isBomb29 ==1 | isBomb34 ==1)))
					begin
						warning28 = 1;
					end
		//generating caution and warning for box29, and box above of it is selected
				if(erasebox23 == 1 && (isBomb28 == 1 ^ isBomb30 == 1 ^ isBomb35 ==1 ) )
					begin
						caution29 = 1;
					end
				if(erasebox23 ==1 && ((isBomb28 ==1 && isBomb30 ==1) | (isBomb28 ==1 && isBomb35 ==1) | (isBomb30 ==1 | isBomb35 ==1)))
					begin
						warning29 = 1;
					end
		//generating caution and warning for box30, and box above of it is selected
				if(erasebox24 == 1 && (isBomb29 == 1 ^ isBomb31 == 1 ^ isBomb36 ==1 ) )
					begin
						caution30 = 1;
					end
				if(erasebox24 ==1 && ((isBomb29 ==1 && isBomb31 ==1) | (isBomb29 ==1 && isBomb36 ==1) | (isBomb31 ==1 | isBomb36 ==1)))
					begin
						warning30 = 1;
					end
		//looking at the box above


		//looking at the box to the right

		//generating caution and warning for box9, and box to right of it is selected
				if(erasebox10 == 1 && (isBomb8 == 1 ^ isBomb3 == 1 ^ isBomb15 ==1 ) )
					begin
						caution9 = 1;
					end
				if(erasebox10 ==1 && ((isBomb8 ==1 && isBomb3 ==1) | (isBomb8 ==1 && isBomb15 ==1) | (isBomb3 ==1 | isBomb15 ==1)))
					begin
						warning9 = 1;
					end
		//generating caution and warning for box10, and box to right of it is selected
				if(erasebox11 == 1 && (isBomb9 == 1 ^ isBomb4 == 1 ^ isBomb16 ==1 ) )
					begin
						caution10 = 1;
					end
				if(erasebox11 ==1 && ((isBomb9 ==1 && isBomb4 ==1) | (isBomb9 ==1 && isBomb16 ==1) | (isBomb4 ==1 | isBomb16 ==1)))
					begin
						warning10 = 1;
					end
		//generating caution and warning for box11, and box to right of it is selected
				if(erasebox12 == 1 && (isBomb10 == 1 ^ isBomb5 == 1 ^ isBomb17 ==1 ) )
					begin
						caution11 = 1;
					end
				if(erasebox12 ==1 && ((isBomb10 ==1 && isBomb5 ==1) | (isBomb10 ==1 && isBomb17 ==1) | (isBomb5 ==1 | isBomb17 ==1)))
					begin
						warning11 = 1;
					end
		//generating caution and warning for box12, and box to right of it is selected
				if(erasebox13 == 1 && (isBomb11 == 1 ^ isBomb6 == 1 ^ isBomb18 ==1 ) )
					begin
						caution12 = 1;
					end
				if(erasebox13 ==1 && ((isBomb11 ==1 && isBomb6 ==1) | (isBomb11 ==1 && isBomb18 ==1) | (isBomb6 ==1 | isBomb18 ==1)))
					begin
						warning12 = 1;
					end
		//generating caution and warning for box15, and box to right of it is selected
				if(erasebox16 == 1 && (isBomb14 == 1 ^ isBomb9 == 1 ^ isBomb21 ==1 ) )
					begin
						caution15 = 1;
					end
				if(erasebox16 ==1 && ((isBomb14 ==1 && isBomb9 ==1) | (isBomb14 ==1 && isBomb21 ==1) | (isBomb9 ==1 | isBomb21 ==1)))
					begin
						warning15 = 1;
					end
		//generating caution and warning for box16, and box to right of it is selected
				if(erasebox17 == 1 && (isBomb15 == 1 ^ isBomb10 == 1 ^ isBomb22 ==1 ) )
					begin
						caution16 = 1;
					end
				if(erasebox17 ==1 && ((isBomb15 ==1 && isBomb10 ==1) | (isBomb15 ==1 && isBomb22 ==1) | (isBomb10 ==1 | isBomb22 ==1)))
					begin
						warning16 = 1;
					end
		//generating caution and warning for box17, and box to right of it is selected
				if(erasebox18 == 1 && (isBomb16 == 1 ^ isBomb11 == 1 ^ isBomb23 ==1 ) )
					begin
						caution17 = 1;
					end
				if(erasebox18 ==1 && ((isBomb16 ==1 && isBomb11 ==1) | (isBomb16 ==1 && isBomb23 ==1) | (isBomb11 ==1 | isBomb23 ==1)))
					begin
						warning17 = 1;
					end
		//generating caution and warning for box18, and box to right of it is selected
				if(erasebox19 == 1 && (isBomb17 == 1 ^ isBomb12 == 1 ^ isBomb24 ==1 ) )
					begin
						caution18 = 1;
					end
				if(erasebox19 ==1 && ((isBomb17 ==1 && isBomb12 ==1) | (isBomb17 ==1 && isBomb24 ==1) | (isBomb12 ==1 | isBomb24 ==1)))
					begin
						warning18 = 1;
					end
		//generating caution and warning for box21, and box to right of it is selected
				if(erasebox22 == 1 && (isBomb20 == 1 ^ isBomb15 == 1 ^ isBomb27 ==1 ) )
					begin
						caution21 = 1;
					end
				if(erasebox22 ==1 && ((isBomb20 ==1 && isBomb15 ==1) | (isBomb20 ==1 && isBomb27 ==1) | (isBomb15 ==1 | isBomb27 ==1)))
					begin
						warning21 = 1;
					end
		//generating caution and warning for box22, and box to right of it is selected
				if(erasebox23 == 1 && (isBomb21 == 1 ^ isBomb16 == 1 ^ isBomb28 ==1 ) )
					begin
						caution22 = 1;
					end
				if(erasebox23 ==1 && ((isBomb21 ==1 && isBomb16 ==1) | (isBomb21 ==1 && isBomb28 ==1) | (isBomb16 ==1 | isBomb28 ==1)))
					begin
						warning22 = 1;
					end
		//generating caution and warning for box23, and box to right of it is selected
				if(erasebox24 == 1 && (isBomb22 == 1 ^ isBomb17 == 1 ^ isBomb29 ==1 ) )
					begin
						caution23 = 1;
					end
				if(erasebox24 ==1 && ((isBomb22 ==1 && isBomb17 ==1) | (isBomb22 ==1 && isBomb29 ==1) | (isBomb17 ==1 | isBomb29 ==1)))
					begin
						warning23 = 1;
					end
		//generating caution and warning for box24, and box to right of it is selected
				if(erasebox25 == 1 && (isBomb23 == 1 ^ isBomb18 == 1 ^ isBomb30 ==1 ) )
					begin
						caution24 = 1;
					end
				if(erasebox25 ==1 && ((isBomb23 ==1 && isBomb18 ==1) | (isBomb23 ==1 && isBomb30 ==1) | (isBomb18 ==1 | isBomb30 ==1)))
					begin
						warning24 = 1;
					end
		//generating caution and warning for box27, and box to right of it is selected
				if(erasebox28 == 1 && (isBomb26 == 1 ^ isBomb21 == 1 ^ isBomb33 ==1 ) )
					begin
						caution27 = 1;
					end
				if(erasebox28 ==1 && ((isBomb26 ==1 && isBomb21 ==1) | (isBomb26 ==1 && isBomb33 ==1) | (isBomb21 ==1 | isBomb33 ==1)))
					begin
						warning27 = 1;
					end
		//generating caution and warning for box28, and box to right of it is selected
				if(erasebox29 == 1 && (isBomb27 == 1 ^ isBomb22 == 1 ^ isBomb34 ==1 ) )
					begin
						caution28 = 1;
					end
				if(erasebox29 ==1 && ((isBomb27 ==1 && isBomb22 ==1) | (isBomb27 ==1 && isBomb34 ==1) | (isBomb22 ==1 | isBomb34 ==1)))
					begin
						warning28 = 1;
					end
		//generating caution and warning for box29, and box to right of it is selected
				if(erasebox30 == 1 && (isBomb28 == 1 ^ isBomb23 == 1 ^ isBomb35 ==1 ) )
					begin
						caution29 = 1;
					end
				if(erasebox30 ==1 && ((isBomb28 ==1 && isBomb23 ==1) | (isBomb28 ==1 && isBomb35 ==1) | (isBomb23 ==1 | isBomb35 ==1)))
					begin
						warning29 = 1;
					end
		//generating caution and warning for box30, and box to right of it is selected
				if(erasebox31 == 1 && (isBomb29 == 1 ^ isBomb24 == 1 ^ isBomb36 ==1 ) )
					begin
						caution30 = 1;
					end
				if(erasebox31 ==1 && ((isBomb29 ==1 && isBomb24 ==1) | (isBomb29 ==1 && isBomb36 ==1) | (isBomb24 ==1 | isBomb36 ==1)))
					begin
						warning30 = 1;
					end
		// looking at the box to the right

		// looking at the box below it 

		//generating caution and warning for box9, and box to right of it is selected
				if(erasebox10 == 1 && (isBomb8 == 1 ^ isBomb3 == 1 ^ isBomb15 ==1 ) )
					begin
						caution9 = 1;
					end
				if(erasebox10 ==1 && ((isBomb8 ==1 && isBomb3 ==1) | (isBomb8 ==1 && isBomb15 ==1) | (isBomb3 ==1 | isBomb15 ==1)))
					begin
						warning9 = 1;
					end
		//generating caution and warning for box10, and box to right of it is selected
				if(erasebox11 == 1 && (isBomb9 == 1 ^ isBomb4 == 1 ^ isBomb16 ==1 ) )
					begin
						caution10 = 1;
					end
				if(erasebox11 ==1 && ((isBomb9 ==1 && isBomb4 ==1) | (isBomb9 ==1 && isBomb16 ==1) | (isBomb4 ==1 | isBomb16 ==1)))
					begin
						warning10 = 1;
					end
		//generating caution and warning for box11, and box to right of it is selected
				if(erasebox12 == 1 && (isBomb10 == 1 ^ isBomb5 == 1 ^ isBomb17 ==1 ) )
					begin
						caution11 = 1;
					end
				if(erasebox12 ==1 && ((isBomb10 ==1 && isBomb5 ==1) | (isBomb10 ==1 && isBomb17 ==1) | (isBomb5 ==1 | isBomb17 ==1)))
					begin
						warning11 = 1;
					end
		//generating caution and warning for box12, and box to right of it is selected
				if(erasebox13 == 1 && (isBomb11 == 1 ^ isBomb6 == 1 ^ isBomb18 ==1 ) )
					begin
						caution12 = 1;
					end
				if(erasebox13 ==1 && ((isBomb11 ==1 && isBomb6 ==1) | (isBomb11 ==1 && isBomb18 ==1) | (isBomb6 ==1 | isBomb18 ==1)))
					begin
						warning12 = 1;
					end
		//generating caution and warning for box15, and box to right of it is selected
				if(erasebox16 == 1 && (isBomb14 == 1 ^ isBomb9 == 1 ^ isBomb21 ==1 ) )
					begin
						caution15 = 1;
					end
				if(erasebox16 ==1 && ((isBomb14 ==1 && isBomb9 ==1) | (isBomb14 ==1 && isBomb21 ==1) | (isBomb9 ==1 | isBomb21 ==1)))
					begin
						warning15 = 1;
					end
		//generating caution and warning for box16, and box to right of it is selected
				if(erasebox17 == 1 && (isBomb15 == 1 ^ isBomb10 == 1 ^ isBomb22 ==1 ) )
					begin
						caution16 = 1;
					end
				if(erasebox17 ==1 && ((isBomb15 ==1 && isBomb10 ==1) | (isBomb15 ==1 && isBomb22 ==1) | (isBomb10 ==1 | isBomb22 ==1)))
					begin
						warning16 = 1;
					end
		//generating caution and warning for box17, and box to right of it is selected
				if(erasebox18 == 1 && (isBomb16 == 1 ^ isBomb11 == 1 ^ isBomb23 ==1 ) )
					begin
						caution17 = 1;
					end
				if(erasebox18 ==1 && ((isBomb16 ==1 && isBomb11 ==1) | (isBomb16 ==1 && isBomb23 ==1) | (isBomb11 ==1 | isBomb23 ==1)))
					begin
						warning17 = 1;
					end
		//generating caution and warning for box18, and box to right of it is selected
				if(erasebox19 == 1 && (isBomb17 == 1 ^ isBomb12 == 1 ^ isBomb24 ==1 ) )
					begin
						caution18 = 1;
					end
				if(erasebox19 ==1 && ((isBomb17 ==1 && isBomb12 ==1) | (isBomb17 ==1 && isBomb24 ==1) | (isBomb12 ==1 | isBomb24 ==1)))
					begin
						warning18 = 1;
					end
		//generating caution and warning for box21, and box to right of it is selected
				if(erasebox22 == 1 && (isBomb20 == 1 ^ isBomb15 == 1 ^ isBomb27 ==1 ) )
					begin
						caution21 = 1;
					end
				if(erasebox22 ==1 && ((isBomb20 ==1 && isBomb15 ==1) | (isBomb20 ==1 && isBomb27 ==1) | (isBomb15 ==1 | isBomb27 ==1)))
					begin
						warning21 = 1;
					end
		//generating caution and warning for box22, and box to right of it is selected
				if(erasebox23 == 1 && (isBomb21 == 1 ^ isBomb16 == 1 ^ isBomb28 ==1 ) )
					begin
						caution22 = 1;
					end
				if(erasebox23 ==1 && ((isBomb21 ==1 && isBomb16 ==1) | (isBomb21 ==1 && isBomb28 ==1) | (isBomb16 ==1 | isBomb28 ==1)))
					begin
						warning22 = 1;
					end
		//generating caution and warning for box23, and box to right of it is selected
				if(erasebox24 == 1 && (isBomb22 == 1 ^ isBomb17 == 1 ^ isBomb29 ==1 ) )
					begin
						caution23 = 1;
					end
				if(erasebox24 ==1 && ((isBomb22 ==1 && isBomb17 ==1) | (isBomb22 ==1 && isBomb29 ==1) | (isBomb17 ==1 | isBomb29 ==1)))
					begin
						warning23 = 1;
					end
		//generating caution and warning for box24, and box to right of it is selected
				if(erasebox25 == 1 && (isBomb23 == 1 ^ isBomb18 == 1 ^ isBomb30 ==1 ) )
					begin
						caution24 = 1;
					end
				if(erasebox25 ==1 && ((isBomb23 ==1 && isBomb18 ==1) | (isBomb23 ==1 && isBomb30 ==1) | (isBomb18 ==1 | isBomb30 ==1)))
					begin
						warning24 = 1;
					end
		//generating caution and warning for box27, and box to right of it is selected
				if(erasebox28 == 1 && (isBomb26 == 1 ^ isBomb21 == 1 ^ isBomb33 ==1 ) )
					begin
						caution27 = 1;
					end
				if(erasebox28 ==1 && ((isBomb26 ==1 && isBomb21 ==1) | (isBomb26 ==1 && isBomb33 ==1) | (isBomb21 ==1 | isBomb33 ==1)))
					begin
						warning27 = 1;
					end
		//generating caution and warning for box28, and box to right of it is selected
				if(erasebox29 == 1 && (isBomb27 == 1 ^ isBomb22 == 1 ^ isBomb34 ==1 ) )
					begin
						caution28 = 1;
					end
				if(erasebox29 ==1 && ((isBomb27 ==1 && isBomb22 ==1) | (isBomb27 ==1 && isBomb34 ==1) | (isBomb22 ==1 | isBomb34 ==1)))
					begin
						warning28 = 1;
					end
		//generating caution and warning for box29, and box to right of it is selected
				if(erasebox30 == 1 && (isBomb28 == 1 ^ isBomb23 == 1 ^ isBomb35 ==1 ) )
					begin
						caution29 = 1;
					end
				if(erasebox30 ==1 && ((isBomb28 ==1 && isBomb23 ==1) | (isBomb28 ==1 && isBomb35 ==1) | (isBomb23 ==1 | isBomb35 ==1)))
					begin
						warning29 = 1;
					end
		//generating caution and warning for box30, and box to right of it is selected
				if(erasebox31 == 1 && (isBomb29 == 1 ^ isBomb24 == 1 ^ isBomb36 ==1 ) )
					begin
						caution30 = 1;
					end
				if(erasebox31 ==1 && ((isBomb29 ==1 && isBomb24 ==1) | (isBomb29 ==1 && isBomb36 ==1) | (isBomb24 ==1 | isBomb36 ==1)))
					begin
						warning30 = 1;
					end
		// looking at the box below it


				
			//generating caution and warning for box9, and box left of it is selected	
			if(erasebox8 == 1 && (isBomb3 == 1 ^ isBomb10 == 1 ^ isBomb15 ==1 ) )
					begin
						caution9 = 1;
					end
			if(erasebox8 ==1 && ((isBomb3 ==1 && isBomb10 ==1) | (isBomb3==1 && isBomb15 ==1) | (isBomb10 ==1 | isBomb15 ==1)))
					begin
						warning9 = 1;
					end

			//generates caution and warning for the top row of boxes					
			if(erasebox4  == 1 && (isBomb2  == 1 ^ isBomb9  == 1))
			begin
			caution3 = 1;
			end
			if(erasebox4  == 1 && (isBomb2  == 1 && isBomb9  == 1))
			begin
			warning3 = 1;
			end

			if(erasebox9  == 1 && (isBomb2  == 1 ^ isBomb4  == 1))
			begin
			caution3 = 1;
			end
			if(erasebox9  == 1 && (isBomb2 == 1 && isBomb4  == 1))
			begin
			warning3 = 1;
			end

			if(erasebox3  == 1 && (isBomb5  == 1 ^ isBomb10  == 1))
			begin
			caution4 = 1;
			end
			if(erasebox3  == 1 && (isBomb5  == 1 && isBomb10  == 1))
			begin
			warning4 = 1;
			end

			if(erasebox5  == 1 && (isBomb3  == 1 ^ isBomb10  == 1))
			begin
			caution4 = 1;
			end
			if(erasebox5  == 1 && (isBomb3  == 1 && isBomb10  == 1))
			begin
			warning4 = 1;
			end

			if(erasebox10  == 1 && (isBomb5  == 1 ^ isBomb3  == 1))
			begin
			caution4 = 1;
			end
			if(erasebox10  == 1 && (isBomb5  == 1 && isBomb3  == 1))
			begin
			warning4 = 1;
			end

			if(erasebox4  == 1 && (isBomb6  == 1 ^ isBomb11  == 1))
			begin
			caution5 = 1;
			end
			if(erasebox4  == 1 && (isBomb6  == 1 && isBomb11  == 1))
			begin
			warning5 = 1;
			end

			if(erasebox6  == 1 && (isBomb4  == 1 ^ isBomb11  == 1))
			begin
			caution5 = 1;
			end
			if(erasebox6  == 1 && (isBomb4  == 1 && isBomb11  == 1))
			begin
			warning5 = 1;
			end

			if(erasebox11  == 1 && (isBomb6  == 1 ^ isBomb4  == 1))
			begin
			caution5 = 1;
			end
			if(erasebox11  == 1 && (isBomb6  == 1 && isBomb4  == 1))
			begin
			warning5 = 1;
			end

			if(erasebox5  == 1 && (isBomb7  == 1 ^ isBomb12  == 1))
			begin
			caution6 = 1;
			end
			if(erasebox5  == 1 && (isBomb7  == 1 && isBomb12  == 1))
			begin
			warning6 = 1;
			end

			if(erasebox7  == 1 && (isBomb5  == 1 ^ isBomb12  == 1))
			begin
			caution6 = 1;
			end
			if(erasebox7  == 1 && (isBomb5  == 1 && isBomb12  == 1))
			begin
			warning6 = 1;
			end

			if(erasebox12  == 1 && (isBomb7  == 1 ^ isBomb5  == 1))
			begin
			caution6 = 1;
			end
			if(erasebox12  == 1 && (isBomb7  == 1 && isBomb5  == 1))
			begin
			warning6 = 1;
			end

			if(erasebox6  == 1 && (isBomb13  == 1))
			begin
			caution7 = 1;
			end
			if(erasebox13  == 1 && (isBomb6 == 1))
			begin
			warning7 = 1;
			end
			//more of the code for side caution and warnings
			if(erasebox4  == 1 && (isBomb2  == 1 ^ isBomb9  == 1))
			begin
			caution3 = 1;
			end
			if(erasebox4  == 1 && (isBomb2  == 1 && isBomb9  == 1))
			begin
			warning3 = 1;
			end

			if(erasebox9  == 1 && (isBomb2  == 1 ^ isBomb4  == 1))
			begin
			caution3 = 1;
			end
			if(erasebox9  == 1 && (isBomb2 == 1 && isBomb4  == 1))
			begin
			warning3 = 1;
			end

			if(erasebox3  == 1 && (isBomb5  == 1 ^ isBomb10  == 1))
			begin
			caution4 = 1;
			end
			if(erasebox3  == 1 && (isBomb5  == 1 && isBomb10  == 1))
			begin
			warning4 = 1;
			end

			if(erasebox5  == 1 && (isBomb3  == 1 ^ isBomb10  == 1))
			begin
			caution4 = 1;
			end
			if(erasebox5  == 1 && (isBomb3  == 1 && isBomb10  == 1))
			begin
			warning4 = 1;
			end

			if(erasebox10  == 1 && (isBomb5  == 1 ^ isBomb3  == 1))
			begin
			caution4 = 1;
			end
			if(erasebox10  == 1 && (isBomb5  == 1 && isBomb3  == 1))
			begin
			warning4 = 1;
			end

			if(erasebox4  == 1 && (isBomb6  == 1 ^ isBomb11  == 1))
			begin
			caution5 = 1;
			end
			if(erasebox4  == 1 && (isBomb6  == 1 && isBomb11  == 1))
			begin
			warning5 = 1;
			end

			if(erasebox6  == 1 && (isBomb4  == 1 ^ isBomb11  == 1))
			begin
			caution5 = 1;
			end
			if(erasebox6  == 1 && (isBomb4  == 1 && isBomb11  == 1))
			begin
			warning5 = 1;
			end

			if(erasebox11  == 1 && (isBomb6  == 1 ^ isBomb4  == 1))
			begin
			caution5 = 1;
			end
			if(erasebox11  == 1 && (isBomb6  == 1 && isBomb4  == 1))
			begin
			warning5 = 1;
			end

			if(erasebox5  == 1 && (isBomb7  == 1 ^ isBomb12  == 1))
			begin
			caution6 = 1;
			end
			if(erasebox5  == 1 && (isBomb7  == 1 && isBomb12  == 1))
			begin
			warning6 = 1;
			end

			if(erasebox7  == 1 && (isBomb5  == 1 ^ isBomb12  == 1))
			begin
			caution6 = 1;
			end
			if(erasebox7  == 1 && (isBomb5  == 1 && isBomb12  == 1))
			begin
			warning6 = 1;
			end

			if(erasebox12  == 1 && (isBomb7  == 1 ^ isBomb5  == 1))
			begin
			caution6 = 1;
			end
			if(erasebox12  == 1 && (isBomb7  == 1 && isBomb5  == 1))
			begin
			warning6 = 1;
			end

			// end of top row

			if(erasebox32  == 1 && (isBomb27  == 1 ^ isBomb34  == 1))
			begin
			caution33 = 1;
			end
			if(erasebox32  == 1 && (isBomb27  == 1 && isBomb34  == 1))
			begin
			warning33 = 1;
			end

			if(erasebox27  == 1 && (isBomb32  == 1 ^ isBomb34  == 1))
			begin
			caution33 = 1;
			end
			if(erasebox27  == 1 && (isBomb32  == 1 && isBomb34  == 1))
			begin
			warning33 = 1;
			end

			if(erasebox34  == 1 && (isBomb32  == 1 ^ isBomb27  == 1))
			begin
			caution33 = 1;
			end
			if(erasebox34  == 1 && (isBomb32 == 1 && isBomb27  == 1))
			begin
			warning33 = 1;
			end

			if(erasebox33  == 1 && (isBomb35  == 1 ^ isBomb28  == 1))
			begin
			caution34 = 1;
			end
			if(erasebox33  == 1 && (isBomb35  == 1 && isBomb28  == 1))
			begin
			warning34 = 1;
			end

			if(erasebox35  == 1 && (isBomb33  == 1 ^ isBomb28  == 1))
			begin
			caution34 = 1;
			end
			if(erasebox35  == 1 && (isBomb33  == 1 && isBomb28  == 1))
			begin
			warning34 = 1;
			end

			if(erasebox28  == 1 && (isBomb35  == 1 ^ isBomb33  == 1))
			begin
			caution34 = 1;
			end
			if(erasebox28  == 1 && (isBomb35  == 1 && isBomb33  == 1))
			begin
			warning34 = 1;
			end

			if(erasebox34  == 1 && (isBomb36  == 1 ^ isBomb29  == 1))
			begin
			caution35 = 1;
			end
			if(erasebox4  == 1 && (isBomb6  == 1 && isBomb29  == 1))
			begin
			warning35 = 1;
			end

			if(erasebox36  == 1 && (isBomb34  == 1 ^ isBomb29  == 1))
			begin
			caution35 = 1;
			end
			if(erasebox36  == 1 && (isBomb34  == 1 && isBomb29  == 1))
			begin
			warning35 = 1;
			end

			if(erasebox29  == 1 && (isBomb36  == 1 ^ isBomb34  == 1))
			begin
			caution35 = 1;
			end
			if(erasebox29  == 1 && (isBomb36  == 1 && isBomb34  == 1))
			begin
			warning35 = 1;
			end

			if(erasebox35  == 1 && (isBomb37  == 1 ^ isBomb30  == 1))
			begin
			caution36 = 1;
			end
			if(erasebox35  == 1 && (isBomb37  == 1 && isBomb30  == 1))
			begin
			warning36 = 1;
			end

			if(erasebox37  == 1 && (isBomb35  == 1 ^ isBomb30  == 1))
			begin
			caution36 = 1;
			end
			if(erasebox37  == 1 && (isBomb35  == 1 && isBomb30  == 1))
			begin
			warning36 = 1;
			end

			if(erasebox30  == 1 && (isBomb35  == 1 ^ isBomb37  == 1))
			begin
			caution36 = 1;
			end
			if(erasebox30  == 1 && (isBomb35  == 1 && isBomb37  == 1))
			begin
			warning36 = 1;
			end

			//end of bottom row

			if(erasebox2  == 1 && (isBomb9  == 1 ^ isBomb14  == 1))
			begin
			caution8 = 1;
			end
			if(erasebox2  == 1 && (isBomb9  == 1 && isBomb14  == 1))
			begin
			warning8 = 1;
			end

			if(erasebox9  == 1 && (isBomb2  == 1 ^ isBomb14  == 1))
			begin
			caution8 = 1;
			end
			if(erasebox9  == 1 && (isBomb2  == 1 && isBomb14  == 1))
			begin
			warning8 = 1;
			end

			if(erasebox14  == 1 && (isBomb2  == 1 ^ isBomb9  == 1))
			begin
			caution8 = 1;
			end
			if(erasebox14  == 1 && (isBomb2 == 1 && isBomb9  == 1))
			begin
			warning8 = 1;
			end

			if(erasebox8  == 1 && (isBomb15  == 1 ^ isBomb20  == 1))
			begin
			caution14 = 1;
			end
			if(erasebox8  == 1 && (isBomb15  == 1 && isBomb20  == 1))
			begin
			warning14 = 1;
			end

			if(erasebox15  == 1 && (isBomb8  == 1 ^ isBomb20  == 1))
			begin
			caution14 = 1;
			end
			if(erasebox15  == 1 && (isBomb8  == 1 && isBomb20  == 1))
			begin
			warning14 = 1;
			end

			if(erasebox20  == 1 && (isBomb15  == 1 ^ isBomb8  == 1))
			begin
			caution14 = 1;
			end
			if(erasebox20  == 1 && (isBomb15  == 1 && isBomb8  == 1))
			begin
			warning14 = 1;
			end

			if(erasebox14  == 1 && (isBomb26  == 1 ^ isBomb21  == 1))
			begin
			caution20 = 1;
			end
			if(erasebox14  == 1 && (isBomb26  == 1 && isBomb21  == 1))
			begin
			warning20 = 1;
			end

			if(erasebox26  == 1 && (isBomb14  == 1 ^ isBomb21  == 1))
			begin
			caution20 = 1;
			end
			if(erasebox26  == 1 && (isBomb14  == 1 && isBomb21  == 1))
			begin
			warning20 = 1;
			end

			if(erasebox21  == 1 && (isBomb26  == 1 ^ isBomb14  == 1))
			begin
			caution20 = 1;
			end
			if(erasebox21  == 1 && (isBomb26  == 1 && isBomb14  == 1))
			begin
			warning20 = 1;
			end

			if(erasebox20  == 1 && (isBomb27  == 1 ^ isBomb32  == 1))
			begin
			caution26 = 1;
			end
			if(erasebox20  == 1 && (isBomb27  == 1 && isBomb32  == 1))
			begin
			warning26 = 1;
			end

			if(erasebox27  == 1 && (isBomb32  == 1 ^ isBomb20  == 1))
			begin
			caution26 = 1;
			end
			if(erasebox27  == 1 && (isBomb32  == 1 && isBomb20  == 1))
			begin
			warning26 = 1;
			end

			if(erasebox32  == 1 && (isBomb27  == 1 ^ isBomb20  == 1))
			begin
			caution26 = 1;
			end
			if(erasebox32  == 1 && (isBomb27  == 1 && isBomb20  == 1))
			begin
			warning26 = 1;
			end

			//end of left row

			if(erasebox12  == 1 && (isBomb7  == 1 ^ isBomb19  == 1))
			begin
			caution13 = 1;
			end
			if(erasebox12  == 1 && (isBomb7  == 1 && isBomb19  == 1))
			begin
			warning13 = 1;
			end

			if(erasebox7  == 1 && (isBomb12  == 1 ^ isBomb19  == 1))
			begin
			caution13 = 1;
			end
			if(erasebox7  == 1 && (isBomb12  == 1 && isBomb19  == 1))
			begin
			warning13 = 1;
			end

			if(erasebox19  == 1 && (isBomb12  == 1 ^ isBomb7  == 1))
			begin
			caution13 = 1;
			end
			if(erasebox19  == 1 && (isBomb12 == 1 && isBomb7  == 1))
			begin
			warning13 = 1;
			end

			if(erasebox13  == 1 && (isBomb25  == 1 ^ isBomb18  == 1))
			begin
			caution19 = 1;
			end
			if(erasebox13  == 1 && (isBomb25  == 1 && isBomb18  == 1))
			begin
			warning19 = 1;
			end

			if(erasebox25  == 1 && (isBomb13  == 1 ^ isBomb18  == 1))
			begin
			caution19 = 1;
			end
			if(erasebox25  == 1 && (isBomb13  == 1 && isBomb18  == 1))
			begin
			warning19 = 1;
			end

			if(erasebox18  == 1 && (isBomb25  == 1 ^ isBomb13  == 1))
			begin
			caution19 = 1;
			end
			if(erasebox18  == 1 && (isBomb25  == 1 && isBomb13  == 1))
			begin
			warning19 = 1;
			end

			if(erasebox31  == 1 && (isBomb26  == 1 ^ isBomb19  == 1))
			begin
			caution25 = 1;
			end
			if(erasebox31  == 1 && (isBomb26  == 1 && isBomb19  == 1))
			begin
			warning25 = 1;
			end

			if(erasebox24  == 1 && (isBomb31  == 1 ^ isBomb19  == 1))
			begin
			caution25 = 1;
			end
			if(erasebox24  == 1 && (isBomb31  == 1 && isBomb19  == 1))
			begin
			warning25 = 1;
			end

			if(erasebox19  == 1 && (isBomb26  == 1 ^ isBomb31  == 1))
			begin
			caution25 = 1;
			end
			if(erasebox19  == 1 && (isBomb26  == 1 && isBomb14  == 1))
			begin
			warning25 = 1;
			end

			if(erasebox25  == 1 && (isBomb37  == 1 ^ isBomb29  == 1))
			begin
			caution31 = 1;
			end
			if(erasebox25  == 1 && (isBomb37  == 1 && isBomb29  == 1))
			begin
			warning31 = 1;
			end

			if(erasebox37  == 1 && (isBomb25  == 1 ^ isBomb29  == 1))
			begin
			caution31 = 1;
			end
			if(erasebox37  == 1 && (isBomb25  == 1 && isBomb29  == 1))
			begin
			warning31 = 1;
			end

			if(erasebox29  == 1 && (isBomb25  == 1 ^ isBomb37  == 1))
			begin
			caution31 = 1;
			end
			if(erasebox29  == 1 && (isBomb25  == 1 && isBomb37  == 1))
			begin
			warning31 = 1;
			end
			//end of right row

			if(erasebox30  == 1 && (isBomb37  == 1 ^ isBomb35  == 1))
			begin
			caution36 = 1;
			end
			if(erasebox30  == 1 && (isBomb37  == 1 && isBomb35  == 1))
			begin
			warning36 = 1;
			end

			if(erasebox6  == 1 && (isBomb13  == 1))
			begin
			caution7 = 1;
			end
			if(erasebox13  == 1 && (isBomb6 == 1))
			begin
			caution7 = 1;
			end

			if(erasebox3  == 1 && (isBomb8  == 1))
			begin
			caution2 = 1;
			end
			if(erasebox8  == 1 && (isBomb3 == 1))
			begin
			caution2 = 1;
			end

			if(erasebox26  == 1 && (isBomb33  == 1))
			begin
			caution32 = 1;
			end
			if(erasebox33  == 1 && (isBomb26 == 1))
			begin
			caution32 = 1;
			end

			if(erasebox32  == 1 && (isBomb36  == 1))
			begin
			caution37 = 1;
			end
			if(erasebox36  == 1 && (isBomb32 == 1))
			begin
			caution37 = 1;
			end
			
			if(ccount == 6'd27)
				begin
					win = 1;
				end

			//end of corners			 
		end //end of the always BLOCK
//END OF GIVING SQUARES WARNINGS AND CAUTIONS

//WINNER MODULE
	always @(posedge clk)
		begin
		if(ccount == 6'd27)begin
				win = 1;
			end
		end

//KEYBOARD 	
wire [7:0]select;
keyboard myKeyBoard(clk, data, kbCLK, select);
// MOVEMENT OF THE SELECTOR BLOck
	reg [19:0]count;	
	//this moves our selector block  
		always@(posedge clk)
			begin
				count <= count + 1;
				if(count == 833334 && select ==8'h1C)// this has to be like this
					begin
						if(object38X >= 10) //restrictions to movement
							begin
								object38X=object38X-32'd10;
							end
					end
				if(count == 833334&& select ==8'h1D)
					begin
						if(object38Y >= 10)
						begin
							object38Y=object38Y-32'd10;
						end
					end
				if(count==833334 && select ==8'h1B)
					begin
						if(object38Y <= 914)
						begin
							object38Y=object38Y+32'd10;
						end
					end
				if(count==833334 && select ==8'h23)
					begin
						if(object38X <= 1170)
						begin
							object38X=object38X+32'd10; 
						end
					end 
			end
//END OF MOVEMENT BLOCK



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
		box1 = 1'b0; box2 = 1'b0;	box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;	box6 = 1'b0;		box7 = 1'b0; box8 = 1'b0;		box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;		box37 = 1'b0;	box38= 1'b1;
		end

	else if(Object1) begin
		box1 = 1'b1;box2 = 1'b0;box3 = 1'b0;box4 = 1'b0;box5 = 1'b0;box6 = 1'b0;box7 = 1'b0;box8 = 1'b0;box9 = 1'b0;box10 = 1'b0;box11 = 1'b0;box12 = 1'b0;box13 = 1'b0;box14 = 1'b0;box15 = 1'b0;box16 = 1'b0;box17 = 1'b0;box18 = 1'b0;box19 = 1'b0;box20 = 1'b0;box21 = 1'b0;box22 = 1'b0;box23 = 1'b0;box24 = 1'b0;box25 = 1'b0;box26 = 1'b0;box27 = 1'b0;box28 = 1'b0;box29 = 1'b0;box30 = 1'b0;box31 = 1'b0;box32 = 1'b0;box33 = 1'b0;box34 = 1'b0;box35 = 1'b0;box36 = 1'b0;box37 = 1'b0;
		end
	else if(Object2) begin
		box1 = 1'b0;box2 = 1'b1;box3 = 1'b0;box4 = 1'b0;box5 = 1'b0;box6 = 1'b0;box7 = 1'b0;box8 = 1'b0;box9 = 1'b0;box10 = 1'b0;box11 = 1'b0;box12 = 1'b0;	box13 = 1'b0; box14 = 1'b0;box15 = 1'b0;box16 = 1'b0;box17 = 1'b0;box18 = 1'b0;box19 = 1'b0;box20 = 1'b0;box21 = 1'b0;box22 = 1'b0;box23 = 1'b0;box24 = 1'b0;box25 = 1'b0;box26 = 1'b0;box27 = 1'b0;box28 = 1'b0;box29 = 1'b0;box30 = 1'b0;box31 = 1'b0;box32 = 1'b0;box33 = 1'b0;box34 = 1'b0;box35 = 1'b0;box36 = 1'b0;box37 = 1'b0;
		end
	else if(Object3) begin
		box1 = 1'b0;box2 = 1'b0;box3 = 1'b1;box4 = 1'b0;box5 = 1'b0;box6 = 1'b0;box7 = 1'b0;box8 = 1'b0;box9 = 1'b0;box10 = 1'b0;box11 = 1'b0;box12 = 1'b0;box13 = 1'b0;box14 = 1'b0;box15 = 1'b0;box16 = 1'b0;box17 = 1'b0;box18 = 1'b0;box19 = 1'b0;box20 = 1'b0;box21 = 1'b0;box22 = 1'b0;box23 = 1'b0;box24 = 1'b0;box25 = 1'b0;box26 = 1'b0;box27 = 1'b0;box28 = 1'b0;box29 = 1'b0;box30 = 1'b0;box31 = 1'b0;box32 = 1'b0;box33 = 1'b0;box34 = 1'b0;box35 = 1'b0;box36 = 1'b0;box37 = 1'b0;
		end
	else if(Object4) begin 
		box1 = 1'b0;box2 = 1'b0;box3 = 1'b0;box4 = 1'b1;box5 = 1'b0;box6 = 1'b0;box7 = 1'b0;box8 = 1'b0;box9 = 1'b0;box10 = 1'b0;box11 = 1'b0;box12 = 1'b0;box13 = 1'b0;box14 = 1'b0;box15 = 1'b0;box16 = 1'b0;box17 = 1'b0;box18 = 1'b0;box19 = 1'b0;box20 = 1'b0;box21 = 1'b0;box22 = 1'b0;box23 = 1'b0;box24 = 1'b0;box25 = 1'b0;box26 = 1'b0;box27 = 1'b0;box28 = 1'b0;box29 = 1'b0;box30 = 1'b0;box31 = 1'b0;box32 = 1'b0;box33 = 1'b0;box34 = 1'b0;box35 = 1'b0;box36 = 1'b0;box37 = 1'b0;
		end
	else if(Object5) begin 
		box1 = 1'b0;box2 = 1'b0;box3 = 1'b0;box4 = 1'b0;box5 = 1'b1;box6 = 1'b0;box7 = 1'b0;box8 = 1'b0;box9 = 1'b0;box10 = 1'b0;box11 = 1'b0;box12 = 1'b0;box13 = 1'b0;box14 = 1'b0;	box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;box37 = 1'b0;
		end
	else if(Object6) begin 
		box1 = 1'b0;box2 = 1'b0;box3 = 1'b0;box4 = 1'b0;box5 = 1'b0;box6 = 1'b1;box7 = 1'b0;box8 = 1'b0;box9 = 1'b0;box10 = 1'b0;box11 = 1'b0;box12 = 1'b0;box13 = 1'b0;box14 = 1'b0;box15 = 1'b0;box16 = 1'b0;box17 = 1'b0;box18 = 1'b0;box19 = 1'b0;box20 = 1'b0;box21 = 1'b0;box22 = 1'b0;box23 = 1'b0;box24 = 1'b0;box25 = 1'b0;box26 = 1'b0;box27 = 1'b0;box28 = 1'b0;box29 = 1'b0;box30 = 1'b0;box31 = 1'b0;box32 = 1'b0;box33 = 1'b0;box34 = 1'b0;box35 = 1'b0;box36 = 1'b0;box37 = 1'b0;
		end
	else if(Object7) begin 
		box1 = 1'b0;box2 = 1'b0;box3 = 1'b0;box4 = 1'b0;box5 = 1'b0;box6 = 1'b0;box7 = 1'b1;box8 = 1'b0;box9 = 1'b0;box10 = 1'b0;box11 = 1'b0;box12 = 1'b0;box13 = 1'b0;box14 = 1'b0;box15 = 1'b0;box16 = 1'b0;box17 = 1'b0;box18 = 1'b0;box19 = 1'b0;box20 = 1'b0;box21 = 1'b0;box22 = 1'b0;	box23 = 1'b0;box24 = 1'b0;box25 = 1'b0;box26 = 1'b0;box27 = 1'b0;box28 = 1'b0;box29 = 1'b0;box30 = 1'b0;box31 = 1'b0;box32 = 1'b0;box33 = 1'b0;box34 = 1'b0;box35 = 1'b0;box36 = 1'b0;box37 = 1'b0;
		end
		else if(Object8) begin 
		box1 = 1'b0;		box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b1;		box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;		box37 = 1'b0;
		end
		else if(Object9) begin 
		box1 = 1'b0;		box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b0;		box9 = 1'b1;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;box37 = 1'b0;
		end
		else if(Object10) begin 
		box1 = 1'b0;		box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b0;		box9 = 1'b0;		box10 = 1'b1;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;		box37 = 1'b0;
		end
		else if(Object11) begin 
		box1 = 1'b0;		box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b0;		box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b1;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;		box37 = 1'b0;
		end
		else if(Object12) begin 
		box1 = 1'b0;		box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b0;		box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b1;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b0;box19 = 1'b0;		box20 = 1'b0;	box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;box37 = 1'b0;
		end
		else if(Object13) begin 
		box1 = 1'b0;		box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b0;		box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b1;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;		box37 = 1'b0;
		end
		else if(Object14) begin 
		box1 = 1'b0;		box2 = 1'b0;	box3 = 1'b0;		box4 = 1'b0;	box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b0;box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;box13 = 1'b0;		box14 = 1'b1;		box15 = 1'b0;		box16 = 1'b0;box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;	box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;	box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;	box37 = 1'b0;
	  end
		else if(Object15) begin 
		box1 = 1'b0;		box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b0;		box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b1;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;	box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b0;	box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;		box37 = 1'b0;
		end
		else if(Object16) begin 
		box1 = 1'b0;		box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b0;		box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b1;		box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;	box37 = 1'b0;
		end
		else if(Object17) begin 
		box1 = 1'b0;		box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b0;		box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b1;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;	box37 = 1'b0;
		end
		else if(Object18) begin 
		box1 = 1'b0;		box2 = 1'b0; box3 = 1'b0;		box4 = 1'b0;box5 = 1'b0;		box6 = 1'b0; box7 = 1'b0;		box8 = 1'b0;		box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b1;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b0;box36 = 1'b0;box37 = 1'b0;
		end
		else if(Object19) begin 
		box1 = 1'b0;		box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b0;		box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;	box15 = 1'b0;		box16 = 1'b0;	box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b1;		box20 = 1'b0;		box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;	box33 = 1'b0;	box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;		box37 = 1'b0;
		end
		else if(Object20) begin 
		box1 = 1'b0;	box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;	box7 = 1'b0;		box8 = 1'b0;		box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b1;		box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;	box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;	box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;		box37 = 1'b0;
		end
		else if(Object21) begin 
		box1 = 1'b0;		box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b0;		box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b1;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;box32 = 1'b0;		box33 = 1'b0;box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;		box37 = 1'b0;
		end
		else if(Object22) begin 
		box1 = 1'b0;		box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b0;	box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;	box16 = 1'b0;box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b0;		box22 = 1'b1;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;		box37 = 1'b0;
		end
		else if(Object23) begin 
		box1 = 1'b0;		box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;box8 = 1'b0;		box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b0;	box22 = 1'b0;		box23 = 1'b1;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;		box37 = 1'b0;
		end
		else if(Object24) begin 
		box1 = 1'b0;		box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b0;		box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b1;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;		box37 = 1'b0;
		end
		else if(Object25) begin 
		box1 = 1'b0;		box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b0;		box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b1;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;		box37 = 1'b0;
		end
		else if(Object26) begin 
		box1 = 1'b0;		box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b0;		box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b1;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;box37 = 1'b0;
		end
		else if(Object27) begin 
		box1 = 1'b0;		box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b0;		box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b1;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;		box37 = 1'b0;
		end
		else if(Object28) begin 
		box1 = 1'b0;		box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;	box8 = 1'b0;box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b1;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;		box37 = 1'b0;
		end
		else if(Object29) begin 
		box1 = 1'b0;		box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b0;		box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b1;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;		box37 = 1'b0;
		end
		else if(Object30) begin 
		box1 = 1'b0;		box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b0;		box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b1;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;		box37 = 1'b0;
		end
		else if(Object31) begin 
		box1 = 1'b0;		box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b0;		box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b1;		box32 = 1'b0;		box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;		box37 = 1'b0;
		end
		else if(Object32) begin 
		box1 = 1'b0;		box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b0;		box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b1;		box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;		box37 = 1'b0;
		end
		else if(Object33) begin 
		box1 = 1'b0;		box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b0;box9 = 1'b0;box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b1;		box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;box37 = 1'b0;
		end
		else if(Object34) begin 
		box1 = 1'b0;	box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b0;		box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;	box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b0;		box34 = 1'b1;		box35 = 1'b0;		box36 = 1'b0;		box37 = 1'b0;
		end
		else if(Object35) begin 
		box1 = 1'b0;	box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b0;		box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;	box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b1;		box36 = 1'b0;		box37 = 1'b0;
		end
		else if(Object36) begin 
		box1 = 1'b0;		box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b0;		box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;	box33 = 1'b0;box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b1;box37 = 1'b0;
		end
		else if(Object37) begin 
		box1 = 1'b0;		box2 = 1'b0;		box3 = 1'b0;		box4 = 1'b0;		box5 = 1'b0;		box6 = 1'b0;		box7 = 1'b0;		box8 = 1'b0;		box9 = 1'b0;		box10 = 1'b0;		box11 = 1'b0;		box12 = 1'b0;		box13 = 1'b0;		box14 = 1'b0;		box15 = 1'b0;		box16 = 1'b0;		box17 = 1'b0;		box18 = 1'b0;		box19 = 1'b0;		box20 = 1'b0;		box21 = 1'b0;		box22 = 1'b0;		box23 = 1'b0;		box24 = 1'b0;		box25 = 1'b0;		box26 = 1'b0;		box27 = 1'b0;		box28 = 1'b0;		box29 = 1'b0;		box30 = 1'b0;		box31 = 1'b0;		box32 = 1'b0;		box33 = 1'b0;		box34 = 1'b0;		box35 = 1'b0;		box36 = 1'b0;box37 = 1'b1;
		end

	else begin
		box1 = 1'b0;box2 = 1'b0;box3 = 1'b0;box4 = 1'b0;box5 = 1'b0;box6 = 1'b0; box7 = 1'b0; box8 = 1'b0;box9 = 1'b0;box10 = 1'b0;box11 = 1'b0;box12 = 1'b0;box13 = 1'b0;box14 = 1'b0;box15 = 1'b0;box16 = 1'b0;box17 = 1'b0;box18 = 1'b0;box19 = 1'b0;box20 = 1'b0;box21 = 1'b0;box22 = 1'b0;box23 = 1'b0;box24 = 1'b0;box25 = 1'b0;box26 = 1'b0;box27 = 1'b0;box28 = 1'b0;	box29 = 1'b0;box30 = 1'b0; box31 = 1'b0;box32 = 1'b0; box33 = 1'b0; box34 = 1'b0; box35 = 1'b0; box36 = 1'b0;	box37 = 1'b0;
		end
	end 

//======Modified Borrowed Code======//
//Determines the color output based on the decision from the priority block
color(clk, VGA_R, VGA_B, VGA_G, box1, box2, erasebox2, bombAT2, caution2, box3, erasebox3, bombAT3, caution3, box4, erasebox4, bombAT4, caution4, box5, erasebox5, bombAT5, caution5, box6, erasebox6, bombAT6, caution6, box7, erasebox7, bombAT7, caution7, box8, erasebox8, bombAT8, caution8, box9, erasebox9, bombAT9, caution9, box10, erasebox10, bombAT10, caution10, box11, erasebox11, bombAT11, caution11, box12, erasebox12, bombAT12, caution12, box13, erasebox13, bombAT13, caution13, box14, erasebox14, bombAT14, caution14, box15, erasebox15, bombAT15, caution15, box16, erasebox16, bombAT16, caution16, box17, erasebox17, bombAT17, caution17, box18, erasebox18, bombAT18, caution18, box19, erasebox19, bombAT19, caution19, box20, erasebox20, bombAT20, caution20, box21, erasebox21, bombAT21, caution21, box22, erasebox22, bombAT22, caution22, box23, erasebox23, bombAT23, caution23, box24, erasebox24, bombAT24, caution24, box25, erasebox25, bombAT25, caution25, box26, erasebox26, bombAT26, caution26, box27, erasebox27, bombAT27, caution27, box28, erasebox28, bombAT28, caution28, box29, erasebox29, bombAT29, caution29, box30, erasebox30, bombAT30, caution30, box31, erasebox31, bombAT31, caution31, box32, erasebox32, bombAT32, caution32, box33, erasebox33, bombAT33, caution33, box34, erasebox34, bombAT34, caution34, box35, erasebox35, bombAT35, caution35, box36, erasebox36, bombAT36, caution36, box37, erasebox37, bombAT37, caution37, box38, warning2,  warning3,  warning4,  warning5,  warning6,  warning7,  warning8,  warning9,  warning10,  warning11,  warning12,  warning13,  warning14,  warning15,  warning16,  warning17,  warning18,  warning19,  warning20,  warning21,  warning22,  warning23,  warning24,  warning25,  warning26,  warning27,  warning28,  warning29,  warning30,  warning31,  warning32,  warning33,  warning34,  warning35,  warning36,  warning37, win);//ADD here

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
//============================//  look below at this design, be very careful with it
module color(clk, red, blue, green, box1, box2, erase2, bomb2, caution2, box3, erase3, bomb3, caution3, box4, erase4, bomb4, caution4, box5, erase5, bomb5, caution5, box6, erase6, bomb6, caution6, box7, erase7, bomb7, caution7, box8, erase8, bomb8, caution8, box9, erase9, bomb9, caution9, box10, erase10, bomb10, caution10, box11, erase11, bomb11, caution11, box12, erase12, bomb12, caution12, box13, erase13, bomb13, caution13, box14, erase14, bomb14, caution14, box15, erase15, bomb15, caution15, box16, erase16, bomb16, caution16, box17, erase17, bomb17, caution17, box18, erase18, bomb18, caution18, box19, erase19, bomb19, caution19, box20, erase20, bomb20, caution20, box21, erase21, bomb21, caution21, box22, erase22, bomb22, caution22, box23, erase23, bomb23, caution23, box24, erase24, bomb24, caution24, box25, erase25, bomb25, caution25, box26, erase26, bomb26, caution26, box27, erase27, bomb27, caution27, box28, erase28, bomb28, caution28, box29, erase29, bomb29, caution29, box30, erase30, bomb30, caution30, box31, erase31, bomb31, caution31, box32, erase32, bomb32, caution32, box33, erase33, bomb33, caution33, box34, erase34, bomb34, caution34, box35, erase35, bomb35, caution35, box36, erase36, bomb36, caution36, box37, erase37, bomb37, caution37, box38, warning2,  warning3,  warning4,  warning5,  warning6,  warning7,  warning8,  warning9,  warning10,  warning11,  warning12,  warning13,  warning14,  warning15,  warning16,  warning17,  warning18,  warning19,  warning20,  warning21,  warning22,  warning23,  warning24,  warning25,  warning26,  warning27,  warning28,  warning29,  warning30,  warning31,  warning32,  warning33,  warning34,  warning35,  warning36,  warning37, win);
input clk, box1, box2, box3, box4, box5, box6, box7, box8, box9, box10, box11, box12, box13, box14, box15, box16, box17, box18, box19, box20, box21, box22, box23, box24, box25, box26, box27, box28, box29, box30, box31, box32, box33, box34, box35, box36, box37, box38;
input win; 
input erase2, erase3, erase4, erase5, erase6, erase7, erase8, erase9, erase10, erase11, erase12, erase13, erase14, erase15, erase16, erase17, erase18, erase19, erase20, erase21, erase22, erase23, erase24, erase25, erase26, erase27, erase28, erase29, erase30, erase31, erase32, erase33, erase34, erase35, erase36, erase37; 
input bomb2, bomb3, bomb4, bomb5, bomb6, bomb7, bomb8, bomb9, bomb10, bomb11, bomb12, bomb13, bomb14, bomb15, bomb16, bomb17, bomb18, bomb19, bomb20, bomb21, bomb22, bomb23, bomb24, bomb25, bomb26, bomb27, bomb28, bomb29, bomb30, bomb31, bomb32, bomb33, bomb34, bomb35, bomb36, bomb37;
input caution2, caution3, caution4, caution5, caution6, caution7, caution8, caution9, caution10, caution11, caution12, caution13, caution14, caution15, caution16, caution17, caution18, caution19, caution20, caution21, caution22, caution23, caution24, caution25, caution26, caution27, caution28, caution29, caution30, caution31, caution32, caution33, caution34, caution35, caution36, caution37;
input warning2,  warning3,  warning4,  warning5,  warning6,  warning7,  warning8,  warning9,  warning10,  warning11,  warning12,  warning13,  warning14,  warning15,  warning16,  warning17,  warning18,  warning19,  warning20,  warning21,  warning22,  warning23,  warning24,  warning25,  warning26,  warning27,  warning28,  warning29,  warning30,  warning31,  warning32,  warning33,  warning34,  warning35,  warning36,  warning37;  
output [7:0] red, blue, green;
reg[7:0] red, green, blue;

always@(*)  //just add color change to yellow also
begin
	if(box1) begin
		red = 8'd255;
		blue = 8'd255;
		green = 8'd255;
		end
	
	else if(box2) begin
 if(erase2 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb2 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution2 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning2 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end //else if here
end
else if(box3) begin
  if(erase3 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb3 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution3 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning3 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box4) begin
  if(erase4 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb4 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution4 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning4 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box5) begin
  if(erase5 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb5 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution5 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning5 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box6) begin
  if(erase6 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb6 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution6 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning6 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box7) begin
  if(erase7 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb7 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution7 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning7 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box8) begin
  if(erase8 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb8 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution8 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning8 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box9) begin
  if(erase9 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb9 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution9 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning9 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box10) begin
  if(erase10 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb10 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution10 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning10 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box11) begin
  if(erase11 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb11 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution11 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning11 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
else if(win == 1) begin
			 red = 8'd255;
          blue = 8'd255;
          green = 8'd255;
		end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box12) begin
  if(erase12 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb12 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution12 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning12 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box13) begin
  if(erase13 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb13 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution13 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning13 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box14) begin
  if(erase14 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb14 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution14 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning14 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box15) begin
  if(erase15 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb15 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution15 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning15 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box16) begin
  if(erase16 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb16 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution16 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning16 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box17) begin
  if(erase17 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb17 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution17 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning17 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box18) begin
  if(erase18 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb18 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution18 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning18 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box19) begin
  if(erase19 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb19 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution19 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning19 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box20) begin
  if(erase20 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb20 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution20 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning20 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box21) begin
  if(erase21 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb21 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution21 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning21 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box22) begin
  if(erase22 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb22 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution22 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning22 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box23) begin
  if(erase23 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb23 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution23 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning23 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box24) begin
  if(erase24 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb24 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution24 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning24 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box25) begin
  if(erase25 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb25 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution25 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning25 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box26) begin
  if(erase26 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb26 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution26 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning26 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box27) begin
  if(erase27 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb27 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution27 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning27 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box28) begin
  if(erase28 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb28 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution28 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning28 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box29) begin
  if(erase29 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb29 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution29 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning29 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box30) begin
  if(erase30 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb30 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution30 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning30 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box31) begin
  if(erase31 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb31 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution31 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning31 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box32) begin
  if(erase32 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb32 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution32 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning32 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box33) begin
  if(erase33 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb33 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution33 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning33 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box34) begin
  if(erase34 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb34 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution34 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning34 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box35) begin
  if(erase35 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb35 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution35 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning35 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box36) begin
  if(erase36 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb36 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution36 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning36 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end
else if(box37) begin
  if(erase37 == 1'b1) begin
        red = 8'd000;
        blue = 8'd000;
        green = 8'd000;
 end
 else if(bomb37 == 1'b1) begin
          red = 8'd255;
          blue = 8'd000;
          green = 8'd000;
    end
else if(caution37 == 1'b1) begin
          red = 8'd255;  //makes it yellow
          blue = 8'd000;
          green = 8'd255;
    end
else if(warning37 == 1'b1) begin
          red = 8'd250;
          blue = 8'd255;
          green = 8'd51;
    end
    else begin
        red = 8'd000;
        blue = 8'd000;
       green = 8'd255;
    end
end


	
	
	
	
		 else if(box38) begin
		red = 8'd150;
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