module kbInput(KB_clk, data, direction, reset);

	input KB_clk, data;
	output reg [4:0] direction;
	output reg reset = 0; 
	reg [7:0] code;
	reg [10:0]keyCode, previousCode;
	reg recordNext = 0;
	integer count = 0;

always@(negedge KB_clk)
	begin
		keyCode[count] = data;
		count = count + 1;			
		if(count == 11)
		begin
			if(previousCode == 8'hF0)
			begin
				code <= keyCode[8:1];
			end
			previousCode = keyCode[8:1];
			count = 0;
		end
	end
	
	always@(code)
	begin
		if(code == 8'h1D)
			direction = 5'b00010;
		else if(code == 8'h1C)
			direction = 5'b00100;
		else if(code == 8'h1B)
			direction = 5'b01000;
		else if(code == 8'h23)
			direction = 5'b10000;
		else if(code == 8'h5A)
			reset <= ~reset;
		else direction <= direction;
	end	
endmodule
