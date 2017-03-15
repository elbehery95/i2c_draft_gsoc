`timescale 1ns / 1ps

module virtual_master(
  /*
  - This is just done for simultion purposes, the module implements a task that sends data over the I2C bus
  */
  output reg SDA,
  output reg SCL,
  output reg dbg=0
  );
  reg [7:0] dataSent = 8'bz0zzz0zz, addressSent=8'bzzz0000z; //DATA BB, ADD E1
  integer i=0;
  task sendData;
    input [7:0] addressSent,dataSent;
    begin
      #5;
      SDA=1;SCL=1;
      #1;
      SDA=0;
      #1;
      SCL=0;
      //SDA=dataSent[0];#1;

      for(i=7;i>=0;i--) begin
        SCL=0;SDA=addressSent[i];#1;SCL=1;#1;
      end
      SDA=1'bz;
      SCL=0;
      #1;
      SCL=1;#1;
      for(i=7;i>=0;i--) begin
        SCL=0;SDA=dataSent[i];#1;SCL=1;#1;
        end
      SCL=0;#1;SCL=1;#1;SCL=0;#1;
      SDA=0;#1;SCL=1;#2;SDA=1'bz;
      #10;
    end
  endtask

endmodule

module TB ();
  //Signals, and internal registers are declared here
  pullup(SDA);
  pullup(SCK);
  reg CLK_IN=0;
  wire PWM_OUT_1,PWM_OUT_2,PWM_OUT_3;
  parameter [7:0] dev1 = 8'bzzz0000z,dev2 = 8'bzzzz000z, dev3 = 8'bz0z0000z;
  //Devices instantiation here

//-----------I2CPWM slaves-----------------------

//this is dev1
  I2C_PWM_INTERFACE #(8'hE1,6,1) uut_1(
       .SDA(SDA),
       .SCK(SCK),
       .CLK_IN(CLK_IN),
       .PWM_OUT(PWM_OUT_1)
    );

//this is dev2
  I2C_PWM_INTERFACE #(8'hF1,6,1) uut_2(
       .SDA(SDA),
       .SCK(SCK),
       .CLK_IN(CLK_IN),
       .PWM_OUT(PWM_OUT_2)
    );

//this is dev3
  I2C_PWM_INTERFACE #(8'hA1,6,1) uut_3(
       .SDA(SDA),
       .SCK(SCK),
       .CLK_IN(CLK_IN),
       .PWM_OUT(PWM_OUT_3)
    );
//-----------------------------------------------

  //Master starting the i2c communication
  virtual_master master(.SDA(SDA),.SCL(SCK));

  initial begin
    $dumpfile("testing.dump");
    $dumpvars;

    master.sendData(dev1,8'b0zzzzzzz);    //Set dev1 duty cycle to 127
    master.sendData(dev2,8'b00zz00z0);    //Set dev2 duty cycle to 50
    master.sendData(dev3,8'bzz00z000);    //Set dev3 duty cycle to 200
  end
  always begin
    CLK_IN=~CLK_IN;
    #1;
    if($time==500us)$finish();
  end
endmodule // TB
