# Google Summer Of Code 2017
# Apertus°: Axiom Beta Fan controller [T732]
## Contact info
+ **Name:** Abdelrahman Elbehery
+ **Email Address:** abdo.m7med.89@gmail.com
+ **IRC nick:** Elbehery
+ **Location:** Cairo, Egypt, UTC+2 hours

## About me
I’m Abdelrahman Elbehery, a 3rd year student at Ain Shams University - Faculty of Engineering in Egypt. 
I am interested in learning new things about computer hardware in general, learning new programming languages and building software/hardware solutions for real world problems. 
I am currently a member of two of my university's student activities and also an [active community member](http://electronics.stackexchange.com/users/93238/elbehery) of Stackexchange network.

## Project deliverables 
I have been working on [a few prototypes](https://github.com/ELBe7ery/i2c_draft_gsoc) related to the fan controller idea,
and currently in the stage of studying and building another prototype for the software part of this task. 

I will be using these prototypes as a reference to build upon while considering all the gathered mentors' feedback regarding them.

### Three main parts of the fan controller to be delivered 

+ **Hardware I2C slave**

![I2c_Block](https://github.com/ELBe7ery/i2c_draft_gsoc/blob/master/Proposal/i2c_Component.png)

The module interface will be adjusted to fit and connect to the virtual I2C connection, this includes 3 different ports
for each of `SCL`, `SDA` I2C pins, these ports are going to be [`SCL_i`, `SCL_o`, `SCL_t`, `SDA_i`, `SDA_o`, `SDA_t`]. 
The module's I2C address will be adjusted via the given parameters at the instantiation time.



+ **Hardware PWM module**

![PWM_Block](https://github.com/ELBe7ery/i2c_draft_gsoc/blob/master/Proposal/PWM_Component.png)

The module output frequency and bit resolution will be adjusted via the given parameters at the instantiation time. 
The resolution will be mainly chosen based on the cooling fan response. 
The current prototype I submitted includes an 8-bit module with an adjustable output frequency. 

+ **A software PID controller**

The software will use the control daemon [T757] interface to gather the temperature and the power sensors readings and 
decide the current state of the camera and based on this state it will adjust the set temperature to a proper value
ensuring that the system temperature is within the safe operating temperature,
that the fan is as quiet as possible during shots or other sensitive tasks that don't require the fan noise
and that the device is cooled when not being used on tasks that require minimum fan noise.


### Implementation notes

+ The current [I2C slave](https://github.com/ELBe7ery/i2c_draft_gsoc/tree/master/I2c%20slave) that was submitted as a prototype
doesn't use an oversampling clock, instead it's operated via the `SCK` input. This approach was chosen to ensure no power is consumed when the I2C bus is idle
but this might be changed if any of the leaders/mentors suggested another more efficient mechanism or the [T731 Protocol] requires such change. 

+ The Hardware design will include a chain of synchronization registers for metastability.

+ I will be submitting all the HDL designs in Verilog, I am already familiar with VHDL and can work in a mixed design that has modules written in both HDLs

+ All the HDL designs and the software will include a documentation, testbench and informative comments to enhance the readability.


**A high level diagram of the fan controller**

![Component Diagram](https://github.com/ELBe7ery/i2c_draft_gsoc/blob/master/Proposal/CTRL_TOP_4.png)

## Schedule 

Task | Description | From - To 
--- | --- | ---- 
Community bonding | Get familiar with the organization, study all the necessary schematics and interfaces that will be used |May 4 - Jun 11* 
I2C/PWM interface coding | Implementing the I2C/PWM top module, writing the testbench |Jun 12 <br/>-<br/> Jun 20
I2C/PWM synthesis and verification | Observing via scope/logic analyzer the module behaviour after synthesized including correct I2C behaviour and a valid PWM output, Fixing bugs |Jun 21 <br/>-<br/> Jun 24
Testing the I2C/PWM interface | Testing the I2C/PWM interface and the motor while observing the motor response for the current design and determining the proper PWM frequency | Jun 25 <br/>-<br/> Jun 27
Prepare for the 1st submission | | Jun 28 <br/>-<br/> Jun 29
Software implementation | Writing the software code, doing the necessary simulations on a simulation environment |Jul 1 <br/>-<br/> Jul 15
Using T757 interface | Implementing all the necessary calls in the software to ensure valid readings are recieved from the control daemon | Jul 16 <br/>-<br/> Jul 23
Prepare for the 2nd submission | | Jul 24 <br/>-<br/> Jul 27
Studying the FAN motor and the system response | This will include measuring all the necessary data to tune the PID controller parameters, integrating and observing the controller behaviour, fixing bugs | Jul 27 <br/>-<br/> Aug 6
Discussing Future Improvements | Discussing what needs to be improved and the impact of improving each of the delivered components | Aug 7 <br/>-<br/> Aug 13

*From May 18 to Jun 11 is my final exams period

A buffer of **7 days** has been kept for any unpredictable delays
___
## What interests me most about the apertus° AXIOM project
The uniqueness of the device, no one has took the step to introduce a flexible, modular and open source cinema camera into the market, 
AXIOM is the first product in this category. Its a challenging thing to build a robust product that competes with the current products in the market.

## What interests me outside of academic studies
+ Swimming
+ Basketball
+ Volunteering 

## My short and long term goals
In the near term I am trying to enhance my knowledge about my field of study [Computer systems hardware].
My long term goal is to join an international company where i can implement the knowledge i learned and improve myself.

## My greatest work-related achievement so far
It was something related to an online course on EDX [MIT 6.004x] that i was taking this mid-year vacation.
The course discussed building a full RISC processor from the gate level. 
After i finished the course i decided to design the whole processor in Verilog and to write down a small documentation so that other students can study it.
The design is posted on the course forum and many students started using it and building upon it.
This was also a chance for me to enhance my knowledge and work on a project related to my field of study.

## How can the mentors and project coordinators get the best out of me  
The most important thing for me when working in a project is leaders/mentors feedback and discussion.
I prefer the divide and conquer approach for solving/working on problems, so discussions and feedback make it very clear when working at the integration stage

## Is there anything that you’ll be studying or working on whilst working alongside us?
From May 18 to Jun 11 is my final exams period so i will be working on GSOC for about 14h/week, after Jun 11 i will be completely free and will spend from 6 to 8 hours daily for GSOC project

## If i were asked what would i like to improve upon, my answer would be
+ Improve the way I organize my time
+ Improve my presentation skills
+ Improve my proficiency in English

## Techniques and tools that keep me organized
I prefer graphical shapes and diagrams when describing problems or getting information about a problem/task
___
## My previous projects and experiences
+ Implementation of the BETA RISC processor from the gate level design and [in Verilog](https://github.com/ELBe7ery/BETA-processor)  

+ Part of the [Smart Oct](https://github.com/ELBe7ery/University-Projects/tree/master/SmartOct) team.
A hardware/software smart solution for home automation. 
This was a product we made for a competition made by [iHub](ihub.asu.edu.eg) in our university
. The product was ranked **5th** amongst all the proposed projects and was awarded the [best engineering design certificate](https://github.com/ELBe7ery/i2c_draft_gsoc/blob/master/Proposal/ihub_cirtfct.jpg)

+ Team member at [STP solar race Challange](http://stp-egypt.com/solar-race/evpage/). This was a solar cars race made at Cairo university.
Our car scored the 3rd place at this solar race. These are a few pictures of our car [pic1](https://github.com/ELBe7ery/i2c_draft_gsoc/blob/master/Proposal/car_dgn2.jpg),
 [pic2](https://github.com/ELBe7ery/i2c_draft_gsoc/blob/master/Proposal/car_dgn1.jpg), [pic3](https://github.com/ELBe7ery/i2c_draft_gsoc/blob/master/Proposal/car_race_day.jpg)
