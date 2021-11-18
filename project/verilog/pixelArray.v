module PIXEL_ARRAY(
		input logic      VBN1,
   		input logic      RAMP,
   		input logic      RESET,
   		input logic      ERASE,
   		input logic      EXPOSE,
   		input logic      READ1,
   		input logic      READ2,
   		input logic      READ3,
   		input logic      READ4,
   		inout [7:0] 	 DATA
   		);
   parameter real    dv_pixel1 = 0.2;
   parameter real    dv_pixel2 = 0.4;
   parameter real    dv_pixel3 = 0.6;
   parameter real    dv_pixel4 = 0.8;
   
   PIXEL_SENSOR #(.dv_pixel(dv_pixel1)) P0 (.VBN1(VBN1), .RAMP(RAMP), .RESET(RESET), .ERASE(ERASE), .EXPOSE(EXPOSE), .READ(READ1), .DATA(DATA));
   PIXEL_SENSOR #(.dv_pixel(dv_pixel2)) P1 (.VBN1(VBN1), .RAMP(RAMP), .RESET(RESET), .ERASE(ERASE), .EXPOSE(EXPOSE), .READ(READ2), .DATA(DATA));
   PIXEL_SENSOR #(.dv_pixel(dv_pixel3)) P2 (.VBN1(VBN1), .RAMP(RAMP), .RESET(RESET), .ERASE(ERASE), .EXPOSE(EXPOSE), .READ(READ3), .DATA(DATA));
   PIXEL_SENSOR #(.dv_pixel(dv_pixel4)) P3 (.VBN1(VBN1), .RAMP(RAMP), .RESET(RESET), .ERASE(ERASE), .EXPOSE(EXPOSE), .READ(READ4), .DATA(DATA));
   

endmodule
