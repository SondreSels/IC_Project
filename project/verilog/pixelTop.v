module pixelTop(
		input logic      clk,
                input logic      reset,
   		output logic [7:0]	 pixelDataOut
   		);
   		
  
   
   //Analog signals
   logic              anaBias1;
   logic              anaRamp;
   logic              anaReset;

   //Tie off the unused lines
   assign anaReset = 1;

   //Digital
   wire              erase;
   wire              expose;
   wire             read1;
   wire		    read2;
   wire		    read3;
   wire 	    read4;	
   wire             convert;

   tri[7:0]         pixData; //  We need this to be a wire, because we're tristating it

   //Instanciate the pixelArray
   
   PIXEL_ARRAY ps1(anaBias1, anaRamp, anaReset, erase,expose, read1, read2, read3, read4, pixData);

   pixelSensorFsm #(.c_erase(5),.c_expose(255),.c_convert(255),.c_read(5))
   fsm1(.clk(clk),.reset(reset),.erase(erase),.expose(expose),.read1(read1),.read2(read2),.read3(read3),.read4(read4),.convert(convert));


   //------------------------------------------------------------
   // DAC and ADC model
   //------------------------------------------------------------
   logic[7:0] data;

   // If we are to convert, then provide a clock via anaRamp
   // This does not model the real world behavior, as anaRamp would be a voltage from the ADC
   // however, we cheat
   assign anaRamp = convert ? clk : 0;

   // During expoure, provide a clock via anaBias1.
   // Again, no resemblence to real world, but we cheat.
   assign anaBias1 = expose ? clk : 0;

   // If we're not reading the pixData, then we should drive the bus
   assign pixData = ((read1 || read2) || (read3 || read4)) ? 8'bZ: data;
  
   

   // When convert, then run a analog ramp (via anaRamp clock) and digtal ramp via
   // data bus.
   always_ff @(posedge clk or posedge reset) begin
      if(reset) begin
         data =0;
      end
      if(convert) begin
         data +=  1;
      end
      else begin
         data = 0;
      end
   end // always @ (posedge clk or reset)

   //------------------------------------------------------------
   // Readout from databus
   //------------------------------------------------------------
   always_ff @(posedge clk or posedge reset) begin
      if(reset) begin
         pixelDataOut = 0;
      end
      else begin
         if((read1 || read2) || (read3 || read4))
           pixelDataOut <= pixData;
      end
   end


endmodule
