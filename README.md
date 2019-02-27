# Processor for Electronic Toll Collecting 

This is a simple processor I created for Processor Design Course (ECX-6236) at The Open University of Sri Lanka.
This is still in experimental level, if you finds and bug, please post it.
ISA for PETC and the example program in ROM is available in this document. 
please download it from my google drive. [https://drive.google.com/file/d/0B-ZUeZLrRXp1SjVCRFZYZE9fOHc/view?usp=sharing]
The block diagram of PETC will update later, I draw it by hand.so will have to scan and upload.

# Internal component of PETC

 ## Communication Mux
 
 An 8 to 1 Multiplexer. This selects correct input signal line according to the selection signal given by control unit of PETC. Output of Communication Mux is connected to Communication register.
 
 ## Communication Register
 
 A 16-bit register inside the PETC. This stores all the input data temporarily inside PETC. Then sends them to related output devices.
 
 ## Communication De-Mux
 
 Selects the correct output line according to the selection signal given by the control unit. Output lines are connected to server, internal X and Y registers and data width convertor. 
 
 ## Add Sub unit
 
 Calculated the new balance for a user after a journey completes. There are two 16-bits data lines connected to X and Y registers. 
 This unit works as an adder if the selection in 0 (postpaid cards) else as an substractor (for pre-paid cards).
 Final result is sent to communication mux and acknowledgement is sent to control unit after calculation complete.
 
 ## Data width convector
 
 An 16 bit data is changed into requested data width according to the selection from Control unit, and then output is sent to server.

 ## Code Memory
 
 Instructions that required for particular task is stored in code memory of the PETC. 
 Code memory should be filled with code by the program and PETC will work according to that program instructions.
 Code memory has 6- bit address bus and 14 bit data bus. Since program is pre stored in code memory, there is no way to write data into code memory using the PETC.
 
## Control Unit
 
 Each and every sub module in PESM are controlled by the Control unit according to instructions specified in code memory.
 After reading each instruction, Control unit sets control logics of sub modules. 
 Control unit fetching next instruction that is pointed by the program counter in control unit after getting related acknowledgement from those sub modules.
 
 ## X - register
 
 A 16-bit register inside the PETC. This stores card balance of a user. Then use for calculating the updated balance by add/sub unit it PETC.
 
## Y - register
 
 A 16-bit register inside the PETC. This stores fee for the journey. Then use for calculating the updated balance by add/sub unit it PETC.

# External components of PETC


 ## Vehical Identification Unit (VIU)
  This identifies users at Toll gate, It takes following data from vehical inbuild device.
    * User ID
    * Vehical Type
    * Plate number (only for illigal user)
    
   and Gate ID for the toll gate.
   
  ## Server 
   External Server is used for saving all data. And external system calculates fee for the journey and send it to the PETC.
   
 ##  Print Unit
   If the system runs on manual mode, a slip is printed at exit gate
   
  ## Warning Unit
   This unit is connected to highway police petrol unit. If an illigal user enters to the highway, the vehical number is sent to this unit.
   Here illigal means, a registered user who has pending toll bills.
   
# How this system works
  To use this system, users have to register by giving their personal data and vehical data. 
  A device with vehical data such as vehical type and plate number is installed at this process. (if in-built device not available)
  User data us placed in a magnetic card, which is placed inside the above device.
  User can select the payment method as pre-paid or post-paid.
  One card can be used in any vehical.
  
# Working procedure of PETC
 When a vehical is entered to a toll gate, system first takes the user ID and send it to the server.
 System checks whether user available in current user table.If user in current user table, it sends `CHK_CRT` signal =1 else `CHK_CRT=0`.
 
 If `CHK_CRT=1`, then PETC jumps to the instructions for exit gate, else PETC checks for `CHK_WRN` signal, which is set by the server, if the user is in warning table.
 If `CHK_WRN=1`, then PETC jumps to instructions for warning unit operations.
 
 If user in Current table, then PETC gets following data from server and saves them in X and Y registers
 Fee for the journey (`GET_FEE` and saves it in  Y regi using `SEND_FEE`)
 Card balanace (`GET_BAL` and saves it in X register using `SEND_BAL`)
 Card type (`GET_TYP` and sends it to add/sub unit)
 Then Update the balace (`UPD_BAL`)
 
You can download my full design report from here. [https://drive.google.com/file/d/0B-ZUeZLrRXp1LWpaQnVTMjZSRWM/view?usp=sharing]
I am new to Git.If there a mistake, please inform.

Thank you

