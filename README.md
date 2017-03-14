#I2C/PWM interface

This is the top module including the PWM, i2c slave [this is a prototype just to gain understaning about the big picture of the system]

###NOTES
1- The PWM module is connected to the i2c slave output, but both circuits are not synchronized with each other, so far the design didn't include metastability handling 

2- The PWM module divide the input fast clock by `2^8 * 2^n *k`. Where `n` and `k` are given parameters during the module instantiation, and the output divided frequency is the PWM freq.

3- The PWM module uses 8-bit resolution 

#The module testbench

First three I2cPWM interfaces are connected to an I2C bus, with a master setting each one duty cycle

![tb1](https://github.com/ELBe7ery/i2c_draft_gsoc/blob/master/Top%20module/Screenshots/TB_DEVs.png)

Each one of them is given an address

Then the tb master starts setting each one duty cycle by sending 8-bit on the i2c bus

![tb2](https://github.com/ELBe7ery/i2c_draft_gsoc/blob/master/Top%20module/Screenshots/sendTask.png)

This is the waveform results

![ise](https://github.com/ELBe7ery/i2c_draft_gsoc/blob/master/Top%20module/Screenshots/ISE.png)

###System big picture from my point of view

![bd](https://github.com/ELBe7ery/i2c_draft_gsoc/blob/master/Top%20module/Screenshots/BLOCK_DIAGRAM_enhanced.png)

