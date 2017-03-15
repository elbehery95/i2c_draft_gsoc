#Very simple, low power I2C slave
I am building this simple prototype to understand more about the project and get the mentor feedback, re-implement and enhance this thing more and more

The module doesn't use an oversampling clock, instead its operated via the `SCK` input which makes it more power efficient than an oversampling clock version.
This is pretty much might be changeable based on the design parameters which i am trying to know more by doing this prototype

#The module testbench

First three slaves are connected to an I2C bus, with a master sending data to all of them one by one

1- Send `0xBB` to the first slave

2- Send `0xCC` to the second slave

3- Send `0xDD` to the third slave

4- Send `0xEF` to the second slave

A snapshot of the written testbench 
 
  ```verilog
module TB ();
  pullup(SDA);
  pullup(SCK);
  simple_slave #(8'hE1) uut(   //Data expected [BB]
    .SDA(SDA),
    .SCK(SCK));
  simple_slave #(8'hF1) uut_1( //Data expected [CC], then [EF]
    .SDA(SDA),
    .SCK(SCK));
  simple_slave #(8'hA1) uut_2( //Data expected [DD]
    .SDA(SDA),
    .SCK(SCK));
  virtual_master tsk(.SDA(SDA),.SCL(SCK));
  ...
```
This is the waveform results
![wave](https://github.com/ELBe7ery/i2c_draft_gsoc/blob/master/screen_shot/simulation_result.png)


#State diagram representing this module 

####NOTE: State 19 is the `notMe` state, where the slave ignore any transaction untill the bus is free again

![state_diagram](https://github.com/ELBe7ery/i2c_draft_gsoc/blob/master/screen_shot/state_diagram.png)

