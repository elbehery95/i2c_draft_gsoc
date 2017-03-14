
/*
- This is a material implementd for google summer of code 2017.
- I built this module to be more familiar with the design required, start edit, re-implement the whole thing
- The mentor feedback would really help me getting more and more clear vision about this project
--------------------------------------------------------------------------------------------------------------
Written by: Abdelrahman Elbehery
*/


module I2C_PWM_INTERFACE (
  input SCK,                                                            //I2c SCL [pulled up by external R]
  input CLK_IN,                                                         //High freq. -> PWM_CLK=CLK_IN/const
  output SDA,                                                           //I2c SDA [pulled up by external R]
  output PWM_OUT                                                        //module pulse width modulated output
  );

  //internal registers, signals and wire assignments are here
  parameter moduleAddress=8'b10101011,N = 31, K=1;                    //pass the module unique I2C address, followed by clk pre-scaling constants
  wire [7:0] PWM_INTERFACE;

  //Internal sub-modules here
  simple_slave #(moduleAddress) i2c_slave(
    .SDA(SDA),
    .SCK(SCK),
    .PWM_INTERFACE(PWM_INTERFACE));

  PWM_INTERFACE #(N,K) pwm(
    .CLK_IN(CLK_IN),
    .PWM_DCycle(PWM_INTERFACE),
    .PWM_OUT(PWM_OUT)
    );
endmodule // I2C_PWM_INTERFACE
