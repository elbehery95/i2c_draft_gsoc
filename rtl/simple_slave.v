/*
- This is a material implementd for google summer of code 2017.
- I built this module to be more familiar with the design required, start edit, re-implement the whole thing
- The mentor feedback would really help me getting more and more clear vision about this project
--------------------------------------------------------------------------------------------------------------
Written by: Abdelrahman Elbehery

*/
module simple_slave (                                                   //The module is implemented without an oversampling clock [for low dynamic power consumption]
  input SCK,                                                            //I2c SCL [pulled up by external R]
  output SDA,                                                           //I2c SDA [pulled up by external R]
  output reg [7:0] PWM_INTERFACE                                        //To be connected to the PWM Interface
  );

  //internal registers, signals and wire assignments are here
  parameter [7:0] moduleAddress=8'b10101011;                            //The module i2c address [to be given during the module instantiation]
  parameter [4:0] initialState=0, getAddr=1, isItMe=8, ackSent=9,
                  dataRecv=17, postSend=18, notMe=19;
  reg [4:0] eventCounter =0;                                            //The state register [Each point on the transaction has a unique number]
  reg sda_ack =0;                                                       //An internal signal uesd to send ACK when the correct address is sent, data transaction is over
  assign SDA = (sda_ack)? 0:1'bz;                                       //when sda_ack is asserted the module pulls down the SDA bus [i.e. sends an ACK]
  //reg busIsBusy =0;                                                   //An internal signal providing the bus status used to detect start(), stop() events
  wire busIsBusy;
  reg [7:0] addrDataBuff;                                               //8-bit registre holding addr, then reads data in case address matches.
  reg started =0, stopped =0;                                           //two internal registers to capture the start, stop events
  assign busIsBusy= started ^ stopped;                                  //if at any time started bit != to stopped bit, then we have already started a transaction
  reg startId;                                                          //An internal bit used to differentiate two different transactions

  //code body goes here
  always @ (negedge SDA) begin
    if(SCK==1 & !busIsBusy)                                             //Capture the start() event only if the bus was free
      started<=~started;
  end
  always @ (posedge SDA) begin
    if(SCK==1 & busIsBusy) begin                                        //Capture the stop() event only if the bus was already busy
      stopped<=~stopped;
      //startId<=started;
    end
  end

always @ (negedge SCK) begin
  if(busIsBusy) begin
    case(eventCounter)
      initialState:
        eventCounter<=getAddr;                                          //If start() the slave will start reading the serial address from the bus

      isItMe:                                                           //Once the data cycle is done, the slave checks if its being called or other device
        if(addrDataBuff==moduleAddress) begin
          sda_ack<=1;                                                   //If so, send and ack, then the next cycle store the serial data
          eventCounter<=ackSent;
        end
        else begin
          eventCounter<=notMe;                                          //IF not, stay idle till the next time the bus is free and a transaction starts
          startId<=started;
        end

      dataRecv: begin                                                   //Once data is recieved, send an ack, return to the idle state
        sda_ack<=1;
        PWM_INTERFACE<=addrDataBuff;                                    //output the data to the PWM_INTERFACE
        eventCounter<=postSend;
      end

      notMe:                                                            //If not this slave being called, once the last transct. is over and a new one starts, read address
        if(startId!=started)
          eventCounter<=getAddr;
      default: begin                                                    //Otherwise, keep incrementing the eventCounter state register
        sda_ack<=0;
        if(eventCounter==postSend)
          eventCounter<=initialState;
        else if(eventCounter!=notMe)
          eventCounter<=eventCounter+1;
      end
    endcase
  end
end

  always @ (posedge SCK) begin
    if(busIsBusy) begin
      if((eventCounter>initialState &eventCounter<ackSent) | (eventCounter>ackSent &eventCounter<postSend))
        addrDataBuff<={addrDataBuff[6:0],SDA};                        //Put the coming data at the right time
    end
  end
endmodule //simple_slave
