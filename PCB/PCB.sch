EESchema Schematic File Version 5
LIBS:PCB-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Ringphone controller"
Date "2019-06-19"
Rev "v1"
Comp "https://www.stderr.nl"
Comment1 "CERN Open Hardware Licence v1.2"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Amplifier_Operational:LM358 U1
U 2 1 5CFA6B63
P 2100 5500
F 0 "U1" H 2100 5867 50  0000 C CNN
F 1 "LM358" H 2100 5776 50  0000 C CNN
F 2 "Package_DIP:DIP-8_W7.62mm_Socket_LongPads" H 2100 5500 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/lm2904-n.pdf" H 2100 5500 50  0001 C CNN
	2    2100 5500
	1    0    0    1   
$EndComp
$Comp
L Amplifier_Operational:LM358 U1
U 3 1 5CFA6BDF
P 3650 7050
F 0 "U1" H 3608 7096 50  0000 L CNN
F 1 "LM358" H 3608 7005 50  0000 L CNN
F 2 "Package_DIP:DIP-8_W7.62mm_Socket_LongPads" H 3650 7050 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/lm2904-n.pdf" H 3650 7050 50  0001 C CNN
	3    3650 7050
	1    0    0    -1  
$EndComp
$Comp
L Components:REGULATOR_MODULE REG1
U 1 1 5CFA7230
P 1750 7000
F 0 "REG1" H 1750 7281 60  0000 C CNN
F 1 "REGULATOR_MODULE" H 1750 6700 60  0001 C CNN
F 2 "Footprints:MT3608" H 1750 6800 60  0001 C CNN
F 3 "" H 1750 6800 60  0000 C CNN
	1    1750 7000
	1    0    0    -1  
$EndComp
NoConn ~ 5550 3100
NoConn ~ 5550 3300
Text GLabel 4550 2900 0    50   Input ~ 0
+5V
Text GLabel 4550 2500 0    50   Input ~ 0
BRIDGE_IN_1
Text GLabel 4550 2700 0    50   Input ~ 0
BRIDGE_IN_2
$Comp
L Device:R R3
U 1 1 5CFB22E8
P 4800 1450
F 0 "R3" V 4593 1450 50  0000 C CNN
F 1 "1k" V 4684 1450 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 4730 1450 50  0001 C CNN
F 3 "~" H 4800 1450 50  0001 C CNN
	1    4800 1450
	0    1    1    0   
$EndComp
$Comp
L Device:R R1
U 1 1 5CFB2A4E
P 3650 1450
F 0 "R1" V 3443 1450 50  0000 C CNN
F 1 "10k" V 3534 1450 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 3580 1450 50  0001 C CNN
F 3 "~" H 3650 1450 50  0001 C CNN
	1    3650 1450
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR02
U 1 1 5CFB5200
P 3650 2150
F 0 "#PWR02" H 3650 1900 50  0001 C CNN
F 1 "GND" H 3655 1977 50  0000 C CNN
F 2 "" H 3650 2150 50  0001 C CNN
F 3 "" H 3650 2150 50  0001 C CNN
	1    3650 2150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 5CFB52D0
P 3650 1850
F 0 "R2" V 3443 1850 50  0000 C CNN
F 1 "10k" V 3534 1850 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 3580 1850 50  0001 C CNN
F 3 "~" H 3650 1850 50  0001 C CNN
	1    3650 1850
	-1   0    0    1   
$EndComp
Text GLabel 4200 1450 0    50   Input ~ 0
DAC
$Comp
L Device:C C2
U 1 1 5CFB6E6C
P 4000 1850
F 0 "C2" H 4118 1896 50  0000 L CNN
F 1 "330nF" H 4118 1805 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D7.0mm_W2.5mm_P5.00mm" H 4038 1700 50  0001 C CNN
F 3 "~" H 4000 1850 50  0001 C CNN
	1    4000 1850
	1    0    0    -1  
$EndComp
$Comp
L power:Vdrive #PWR01
U 1 1 5CFB4B5D
P 3650 1200
F 0 "#PWR01" H 3450 1050 50  0001 C CNN
F 1 "Vdrive" H 3667 1373 50  0000 C CNN
F 2 "" H 3650 1200 50  0001 C CNN
F 3 "" H 3650 1200 50  0001 C CNN
	1    3650 1200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3650 2150 3650 2100
Wire Wire Line
	4000 2000 4000 2100
Wire Wire Line
	4000 2100 3650 2100
Connection ~ 3650 2100
Wire Wire Line
	3650 2100 3650 2000
Wire Wire Line
	3650 1700 3650 1650
Wire Wire Line
	3650 1650 4000 1650
Wire Wire Line
	4000 1650 4000 1700
Connection ~ 3650 1650
Wire Wire Line
	3650 1650 3650 1600
Wire Wire Line
	3650 1200 3650 1300
Text GLabel 4500 1800 3    50   Input ~ 0
VGND
Connection ~ 4000 1650
$Comp
L power:+5V #PWR07
U 1 1 5CFB4F24
P 4950 2100
F 0 "#PWR07" H 4950 1950 50  0001 C CNN
F 1 "+5V" H 4900 2250 50  0000 C CNN
F 2 "" H 4950 2100 50  0001 C CNN
F 3 "" H 4950 2100 50  0001 C CNN
	1    4950 2100
	1    0    0    -1  
$EndComp
$Comp
L power:Vdrive #PWR09
U 1 1 5CFBA2C5
P 5150 2100
F 0 "#PWR09" H 4950 1950 50  0001 C CNN
F 1 "Vdrive" H 5250 2250 50  0000 C CNN
F 2 "" H 5150 2100 50  0001 C CNN
F 3 "" H 5150 2100 50  0001 C CNN
	1    5150 2100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR08
U 1 1 5CFBC06A
P 5050 4000
F 0 "#PWR08" H 5050 3750 50  0001 C CNN
F 1 "GND" H 5055 3827 50  0000 C CNN
F 2 "" H 5050 4000 50  0001 C CNN
F 3 "" H 5050 4000 50  0001 C CNN
	1    5050 4000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4850 3900 4850 3950
Wire Wire Line
	4850 3950 4950 3950
Wire Wire Line
	5050 3950 5050 4000
Wire Wire Line
	5050 3950 5150 3950
Wire Wire Line
	5250 3950 5250 3900
Connection ~ 5050 3950
Wire Wire Line
	5150 3900 5150 3950
Connection ~ 5150 3950
Wire Wire Line
	5150 3950 5250 3950
Wire Wire Line
	4950 3900 4950 3950
Connection ~ 4950 3950
Wire Wire Line
	4950 3950 5050 3950
Wire Wire Line
	1550 5600 1800 5600
Wire Wire Line
	1800 5400 1700 5400
Wire Wire Line
	1700 5400 1700 5200
Wire Wire Line
	1700 5200 2500 5200
Wire Wire Line
	2500 5200 2500 5500
Wire Wire Line
	2500 5500 2400 5500
$Comp
L Device:R R7
U 1 1 5CFBD80E
P 2750 5500
F 0 "R7" V 2543 5500 50  0000 C CNN
F 1 "10k" V 2634 5500 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 2680 5500 50  0001 C CNN
F 3 "~" H 2750 5500 50  0001 C CNN
	1    2750 5500
	0    1    1    0   
$EndComp
$Comp
L Device:R R8
U 1 1 5CFBDC46
P 3050 5750
F 0 "R8" V 2843 5750 50  0000 C CNN
F 1 "1k" V 2934 5750 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 2980 5750 50  0001 C CNN
F 3 "~" H 3050 5750 50  0001 C CNN
	1    3050 5750
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR012
U 1 1 5CFBE1BE
P 3050 6000
F 0 "#PWR012" H 3050 5750 50  0001 C CNN
F 1 "GND" H 3055 5827 50  0000 C CNN
F 2 "" H 3050 6000 50  0001 C CNN
F 3 "" H 3050 6000 50  0001 C CNN
	1    3050 6000
	1    0    0    -1  
$EndComp
Wire Wire Line
	3050 6000 3050 5900
Wire Wire Line
	3050 5600 3050 5500
Wire Wire Line
	3050 5500 2900 5500
Wire Wire Line
	2600 5500 2500 5500
Connection ~ 2500 5500
Connection ~ 3050 5500
$Comp
L Device:CP C1
U 1 1 5CFBE4D7
P 4500 1450
F 0 "C1" V 4250 1250 50  0000 L CNN
F 1 "10uF 50V" V 4350 1250 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.00mm" H 4538 1300 50  0001 C CNN
F 3 "~" H 4500 1450 50  0001 C CNN
	1    4500 1450
	0    1    1    0   
$EndComp
Wire Wire Line
	4200 1450 4350 1450
$Comp
L Device:R_POT RV1
U 1 1 5CFBF2CC
P 5350 1250
F 0 "RV1" V 5250 1250 50  0000 C CNN
F 1 "10k" V 5350 1250 50  0000 C CNN
F 2 "Potentiometer_THT:Potentiometer_Piher_PC-16_Single_Horizontal" H 5350 1250 50  0001 C CNN
F 3 "~" H 5350 1250 50  0001 C CNN
	1    5350 1250
	0    1    -1   0   
$EndComp
NoConn ~ 5200 1250
$Comp
L power:+5V #PWR03
U 1 1 5CFC1ECF
P 1050 6750
F 0 "#PWR03" H 1050 6600 50  0001 C CNN
F 1 "+5V" H 1065 6923 50  0000 C CNN
F 2 "" H 1050 6750 50  0001 C CNN
F 3 "" H 1050 6750 50  0001 C CNN
	1    1050 6750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR04
U 1 1 5CFC21F8
P 1050 7250
F 0 "#PWR04" H 1050 7000 50  0001 C CNN
F 1 "GND" H 1055 7077 50  0000 C CNN
F 2 "" H 1050 7250 50  0001 C CNN
F 3 "" H 1050 7250 50  0001 C CNN
	1    1050 7250
	1    0    0    -1  
$EndComp
Wire Wire Line
	1050 7250 1050 7200
Wire Wire Line
	1050 7100 1150 7100
Wire Wire Line
	1150 6900 1050 6900
Wire Wire Line
	1050 6900 1050 6800
$Comp
L power:Vdrive #PWR05
U 1 1 5CFC2435
P 2450 6750
F 0 "#PWR05" H 2250 6600 50  0001 C CNN
F 1 "Vdrive" H 2467 6923 50  0000 C CNN
F 2 "" H 2450 6750 50  0001 C CNN
F 3 "" H 2450 6750 50  0001 C CNN
	1    2450 6750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR06
U 1 1 5CFC29D7
P 2450 7250
F 0 "#PWR06" H 2450 7000 50  0001 C CNN
F 1 "GND" H 2455 7077 50  0000 C CNN
F 2 "" H 2450 7250 50  0001 C CNN
F 3 "" H 2450 7250 50  0001 C CNN
	1    2450 7250
	1    0    0    -1  
$EndComp
Wire Wire Line
	2450 7250 2450 7200
Wire Wire Line
	2450 7100 2350 7100
Wire Wire Line
	2350 6900 2450 6900
Wire Wire Line
	2450 6900 2450 6800
$Comp
L power:GND #PWR011
U 1 1 5CFC666B
P 3550 7450
F 0 "#PWR011" H 3550 7200 50  0001 C CNN
F 1 "GND" H 3555 7277 50  0000 C CNN
F 2 "" H 3550 7450 50  0001 C CNN
F 3 "" H 3550 7450 50  0001 C CNN
	1    3550 7450
	1    0    0    -1  
$EndComp
$Comp
L power:Vdrive #PWR010
U 1 1 5CFC68E8
P 3550 6650
F 0 "#PWR010" H 3350 6500 50  0001 C CNN
F 1 "Vdrive" H 3567 6823 50  0000 C CNN
F 2 "" H 3550 6650 50  0001 C CNN
F 3 "" H 3550 6650 50  0001 C CNN
	1    3550 6650
	1    0    0    -1  
$EndComp
$Comp
L Device:C C4
U 1 1 5CFA6CFB
P 4000 7100
F 0 "C4" H 4115 7146 50  0000 L CNN
F 1 "100nF" H 4115 7055 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D7.0mm_W2.5mm_P5.00mm" H 4038 6950 50  0001 C CNN
F 3 "~" H 4000 7100 50  0001 C CNN
	1    4000 7100
	1    0    0    -1  
$EndComp
Wire Wire Line
	3550 7350 3550 7400
Wire Wire Line
	3550 6750 3550 6700
Wire Wire Line
	3550 6700 4000 6700
Wire Wire Line
	4000 6700 4000 6950
Connection ~ 3550 6700
Wire Wire Line
	3550 6700 3550 6650
Wire Wire Line
	4000 7250 4000 7400
Wire Wire Line
	4000 7400 3550 7400
Connection ~ 3550 7400
Wire Wire Line
	3550 7400 3550 7450
$Comp
L Device:C C5
U 1 1 5D03F351
P 3450 5750
F 0 "C5" H 3565 5796 50  0000 L CNN
F 1 "10nF" H 3565 5705 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D7.0mm_W2.5mm_P5.00mm" H 3488 5600 50  0001 C CNN
F 3 "~" H 3450 5750 50  0001 C CNN
	1    3450 5750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR013
U 1 1 5D03FBF2
P 3450 6000
F 0 "#PWR013" H 3450 5750 50  0001 C CNN
F 1 "GND" H 3455 5827 50  0000 C CNN
F 2 "" H 3450 6000 50  0001 C CNN
F 3 "" H 3450 6000 50  0001 C CNN
	1    3450 6000
	1    0    0    -1  
$EndComp
Text GLabel 3550 5500 2    50   Input ~ 0
CURRENT_SENSE
$Comp
L power:+5V #PWR0101
U 1 1 5D0B0582
P 2000 950
F 0 "#PWR0101" H 2000 800 50  0001 C CNN
F 1 "+5V" H 2015 1123 50  0000 C CNN
F 2 "" H 2000 950 50  0001 C CNN
F 3 "" H 2000 950 50  0001 C CNN
	1    2000 950 
	1    0    0    -1  
$EndComp
Text GLabel 2400 2150 2    50   Input ~ 0
CURRENT_SENSE
Text GLabel 2400 2050 2    50   Input ~ 0
DAC
$Comp
L power:GND #PWR0102
U 1 1 5D0B0D1A
P 1850 3150
F 0 "#PWR0102" H 1850 2900 50  0001 C CNN
F 1 "GND" H 1855 2977 50  0000 C CNN
F 2 "" H 1850 3150 50  0001 C CNN
F 3 "" H 1850 3150 50  0001 C CNN
	1    1850 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	1900 3100 1850 3100
Wire Wire Line
	1850 3100 1850 3150
Wire Wire Line
	1850 3100 1800 3100
Connection ~ 1850 3100
Wire Wire Line
	3550 5500 3450 5500
Wire Wire Line
	3450 5500 3450 5600
Wire Wire Line
	3450 5900 3450 6000
$Comp
L Device:CP C6
U 1 1 5D15FF02
P 850 7000
F 0 "C6" H 650 6950 50  0000 L CNN
F 1 "DNP" H 600 7050 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.00mm" H 888 6850 50  0001 C CNN
F 3 "~" H 850 7000 50  0001 C CNN
	1    850  7000
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C8
U 1 1 5D16092E
P 2700 7000
F 0 "C8" H 2800 7100 50  0000 L CNN
F 1 "DNP" H 2800 7000 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.00mm" H 2738 6850 50  0001 C CNN
F 3 "~" H 2700 7000 50  0001 C CNN
	1    2700 7000
	1    0    0    -1  
$EndComp
Wire Wire Line
	850  6850 850  6800
Wire Wire Line
	850  6800 1050 6800
Connection ~ 1050 6800
Wire Wire Line
	1050 6800 1050 6750
Wire Wire Line
	850  7150 850  7200
Wire Wire Line
	850  7200 1050 7200
Connection ~ 1050 7200
Wire Wire Line
	1050 7200 1050 7100
Wire Wire Line
	2700 7150 2700 7200
Wire Wire Line
	2700 7200 2450 7200
Connection ~ 2450 7200
Wire Wire Line
	2450 7200 2450 7100
Wire Wire Line
	2700 6850 2700 6800
Wire Wire Line
	2700 6800 2450 6800
Connection ~ 2450 6800
Wire Wire Line
	2450 6800 2450 6750
$Comp
L Device:CP C7
U 1 1 5D163B91
P 4800 7050
F 0 "C7" H 4900 7150 50  0000 L CNN
F 1 "DNP" H 4900 7050 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.00mm" H 4838 6900 50  0001 C CNN
F 3 "~" H 4800 7050 50  0001 C CNN
	1    4800 7050
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0103
U 1 1 5D164C85
P 4800 6800
F 0 "#PWR0103" H 4800 6650 50  0001 C CNN
F 1 "+5V" H 4815 6973 50  0000 C CNN
F 2 "" H 4800 6800 50  0001 C CNN
F 3 "" H 4800 6800 50  0001 C CNN
	1    4800 6800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0104
U 1 1 5D164ED6
P 4800 7300
F 0 "#PWR0104" H 4800 7050 50  0001 C CNN
F 1 "GND" H 4805 7127 50  0000 C CNN
F 2 "" H 4800 7300 50  0001 C CNN
F 3 "" H 4800 7300 50  0001 C CNN
	1    4800 7300
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 7300 4800 7200
Wire Wire Line
	4800 6900 4800 6800
$Comp
L power:GND #PWR0105
U 1 1 5D0FFC3F
P 4400 3600
F 0 "#PWR0105" H 4400 3350 50  0001 C CNN
F 1 "GND" H 4405 3427 50  0000 C CNN
F 2 "" H 4400 3600 50  0001 C CNN
F 3 "" H 4400 3600 50  0001 C CNN
	1    4400 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	4400 3600 4400 3500
Wire Wire Line
	4400 3500 4550 3500
$Comp
L Driver_Motor:L293D U2
U 1 1 5CFA69F4
P 5050 3100
F 0 "U2" H 4700 4050 50  0000 C CNN
F 1 "L293D" H 5350 4050 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_Socket_LongPads" H 5300 2350 50  0001 L CNN
F 3 "http://www.ti.com/lit/ds/symlink/l293.pdf" H 4750 3800 50  0001 C CNN
	1    5050 3100
	1    0    0    -1  
$EndComp
Wire Wire Line
	4400 3500 4400 3300
Wire Wire Line
	4400 3300 4550 3300
Connection ~ 4400 3500
Wire Wire Line
	4400 3300 4400 3100
Wire Wire Line
	4400 3100 4550 3100
Connection ~ 4400 3300
Text GLabel 1300 1750 0    50   Input ~ 0
BRIDGE_IN_2
Text GLabel 1300 1850 0    50   Input ~ 0
BRIDGE_IN_1
Text GLabel 1300 1650 0    50   Input ~ 0
MOTION
$Comp
L Connector:TestPoint_Alt TP6
U 1 1 5D0A5CCE
P 7750 5350
F 0 "TP6" H 7808 5468 50  0000 L CNN
F 1 "GND" H 7808 5377 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_2.0x2.0mm_Drill1.0mm" H 7950 5350 50  0001 C CNN
F 3 "~" H 7950 5350 50  0001 C CNN
	1    7750 5350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0106
U 1 1 5D0A628A
P 7750 5350
F 0 "#PWR0106" H 7750 5100 50  0001 C CNN
F 1 "GND" H 7755 5177 50  0000 C CNN
F 2 "" H 7750 5350 50  0001 C CNN
F 3 "" H 7750 5350 50  0001 C CNN
	1    7750 5350
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0108
U 1 1 5D0A68A3
P 8750 5300
F 0 "#PWR0108" H 8750 5150 50  0001 C CNN
F 1 "+5V" H 8765 5473 50  0000 C CNN
F 2 "" H 8750 5300 50  0001 C CNN
F 3 "" H 8750 5300 50  0001 C CNN
	1    8750 5300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0109
U 1 1 5D0A81B8
P 7450 5350
F 0 "#PWR0109" H 7450 5100 50  0001 C CNN
F 1 "GND" H 7455 5177 50  0000 C CNN
F 2 "" H 7450 5350 50  0001 C CNN
F 3 "" H 7450 5350 50  0001 C CNN
	1    7450 5350
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint_Alt TP4
U 1 1 5D0A81C3
P 7450 5350
F 0 "TP4" H 7508 5468 50  0000 L CNN
F 1 "GND" H 7508 5377 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_2.0x2.0mm_Drill1.0mm" H 7650 5350 50  0001 C CNN
F 3 "~" H 7650 5350 50  0001 C CNN
	1    7450 5350
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint_Alt TP1
U 1 1 5D0A853A
P 7150 5350
F 0 "TP1" H 7208 5468 50  0000 L CNN
F 1 "GND" H 7208 5377 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_2.0x2.0mm_Drill1.0mm" H 7350 5350 50  0001 C CNN
F 3 "~" H 7350 5350 50  0001 C CNN
	1    7150 5350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0110
U 1 1 5D0A8545
P 7150 5350
F 0 "#PWR0110" H 7150 5100 50  0001 C CNN
F 1 "GND" H 7155 5177 50  0000 C CNN
F 2 "" H 7150 5350 50  0001 C CNN
F 3 "" H 7150 5350 50  0001 C CNN
	1    7150 5350
	1    0    0    -1  
$EndComp
Text GLabel 7200 5950 2    50   Input ~ 0
DAC
$Comp
L Connector:TestPoint_Alt TP2
U 1 1 5D0A8B0A
P 7150 5850
F 0 "TP2" H 7200 5950 50  0000 L CNN
F 1 "DAC" H 7200 5850 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_2.0x2.0mm_Drill1.0mm" H 7350 5850 50  0001 C CNN
F 3 "~" H 7350 5850 50  0001 C CNN
	1    7150 5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	7200 5950 7150 5950
Wire Wire Line
	7150 5950 7150 5850
Wire Wire Line
	7550 5950 7500 5950
$Comp
L Connector:TestPoint_Alt TP5
U 1 1 5D0AD440
P 7500 5850
F 0 "TP5" H 7550 5950 50  0000 L CNN
F 1 "AMP" H 7550 5850 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_2.0x2.0mm_Drill1.0mm" H 7700 5850 50  0001 C CNN
F 3 "~" H 7700 5850 50  0001 C CNN
	1    7500 5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	7500 5950 7500 5850
Text GLabel 7200 6350 2    50   Input ~ 0
CURRENT_SENSE
Wire Wire Line
	7200 6350 7150 6350
Wire Wire Line
	7150 6350 7150 6250
$Comp
L Connector:TestPoint_Alt TP3
U 1 1 5D0AD82D
P 7150 6250
F 0 "TP3" H 7200 6350 50  0000 L CNN
F 1 "ADC" H 7200 6250 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_2.0x2.0mm_Drill1.0mm" H 7350 6250 50  0001 C CNN
F 3 "~" H 7350 6250 50  0001 C CNN
	1    7150 6250
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint_Alt TP7
U 1 1 5D0AE6B4
P 8350 5300
F 0 "TP7" H 8300 5300 50  0000 R CNN
F 1 "VDRIVE" H 8300 5400 50  0000 R CNN
F 2 "TestPoint:TestPoint_THTPad_2.0x2.0mm_Drill1.0mm" H 8550 5300 50  0001 C CNN
F 3 "~" H 8550 5300 50  0001 C CNN
	1    8350 5300
	-1   0    0    1   
$EndComp
$Comp
L Connector:TestPoint_Alt TP10
U 1 1 5D0B01D7
P 8750 5300
F 0 "TP10" H 8700 5300 50  0000 R CNN
F 1 "5V" H 8700 5400 50  0000 R CNN
F 2 "TestPoint:TestPoint_THTPad_2.0x2.0mm_Drill1.0mm" H 8950 5300 50  0001 C CNN
F 3 "~" H 8950 5300 50  0001 C CNN
	1    8750 5300
	-1   0    0    1   
$EndComp
Wire Wire Line
	8050 5950 8050 5850
Text GLabel 8100 5950 2    50   Input ~ 0
VGND
Wire Wire Line
	8100 5950 8050 5950
Text GLabel 7550 5950 2    50   Input ~ 0
AMP_OUT
$Comp
L Connector:TestPoint_Alt TP8
U 1 1 5D0B0D13
P 8050 5850
F 0 "TP8" H 8100 5950 50  0000 L CNN
F 1 "VGND" H 8100 5850 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_2.0x2.0mm_Drill1.0mm" H 8250 5850 50  0001 C CNN
F 3 "~" H 8250 5850 50  0001 C CNN
	1    8050 5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	8100 6350 8050 6350
$Comp
L Connector:TestPoint_Alt TP9
U 1 1 5D0B248E
P 8050 6250
F 0 "TP9" H 8100 6350 50  0000 L CNN
F 1 "MOTION" H 8100 6250 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_2.0x2.0mm_Drill1.0mm" H 8250 6250 50  0001 C CNN
F 3 "~" H 8250 6250 50  0001 C CNN
	1    8050 6250
	1    0    0    -1  
$EndComp
Text GLabel 8100 6350 2    50   Input ~ 0
MOTION
Wire Wire Line
	8050 6250 8050 6350
Wire Wire Line
	8500 5850 8500 5950
Wire Wire Line
	8550 5950 8500 5950
$Comp
L Connector:TestPoint_Alt TP11
U 1 1 5D0C5E63
P 8500 5850
F 0 "TP11" H 8550 5950 50  0000 L CNN
F 1 "A" H 8550 5850 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_2.0x2.0mm_Drill1.0mm" H 8700 5850 50  0001 C CNN
F 3 "~" H 8700 5850 50  0001 C CNN
	1    8500 5850
	1    0    0    -1  
$EndComp
$Comp
L power:Vdrive #PWR0107
U 1 1 5D0A66E8
P 8350 5300
F 0 "#PWR0107" H 8150 5150 50  0001 C CNN
F 1 "Vdrive" H 8367 5473 50  0000 C CNN
F 2 "" H 8350 5300 50  0001 C CNN
F 3 "" H 8350 5300 50  0001 C CNN
	1    8350 5300
	1    0    0    -1  
$EndComp
Text GLabel 8550 5950 2    50   Input ~ 0
TELEPHONE_A
Wire Wire Line
	8500 6250 8500 6350
Wire Wire Line
	8550 6350 8500 6350
$Comp
L Connector:TestPoint_Alt TP13
U 1 1 5D0C638E
P 8500 6250
F 0 "TP13" H 8550 6350 50  0000 L CNN
F 1 "B" H 8550 6250 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_2.0x2.0mm_Drill1.0mm" H 8700 6250 50  0001 C CNN
F 3 "~" H 8700 6250 50  0001 C CNN
	1    8500 6250
	1    0    0    -1  
$EndComp
Text GLabel 8550 6350 2    50   Input ~ 0
TELEPHONE_B
$Comp
L power:GND #PWR0111
U 1 1 5D0DDB10
P 8050 5350
F 0 "#PWR0111" H 8050 5100 50  0001 C CNN
F 1 "GND" H 8055 5177 50  0000 C CNN
F 2 "" H 8050 5350 50  0001 C CNN
F 3 "" H 8050 5350 50  0001 C CNN
	1    8050 5350
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint_Alt TP12
U 1 1 5D0DDB1B
P 8050 5350
F 0 "TP12" H 8108 5468 50  0000 L CNN
F 1 "GND" H 8108 5377 50  0000 L CNN
F 2 "TestPoint:TestPoint_THTPad_2.0x2.0mm_Drill1.0mm" H 8250 5350 50  0001 C CNN
F 3 "~" H 8250 5350 50  0001 C CNN
	1    8050 5350
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H1
U 1 1 5D12D58A
P 9450 5250
F 0 "H1" H 9550 5296 50  0000 L CNN
F 1 "MountingHole" H 9550 5205 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.7mm_M2.5" H 9450 5250 50  0001 C CNN
F 3 "~" H 9450 5250 50  0001 C CNN
	1    9450 5250
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 5D12DA5B
P 9450 5450
F 0 "H2" H 9550 5496 50  0000 L CNN
F 1 "MountingHole" H 9550 5405 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.7mm_M2.5" H 9450 5450 50  0001 C CNN
F 3 "~" H 9450 5450 50  0001 C CNN
	1    9450 5450
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 5D12DBC9
P 9450 5650
F 0 "H3" H 9550 5696 50  0000 L CNN
F 1 "MountingHole" H 9550 5605 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.7mm_M2.5" H 9450 5650 50  0001 C CNN
F 3 "~" H 9450 5650 50  0001 C CNN
	1    9450 5650
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H4
U 1 1 5D12DC83
P 9450 5850
F 0 "H4" H 9550 5896 50  0000 L CNN
F 1 "MountingHole" H 9550 5805 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.7mm_M2.5" H 9450 5850 50  0001 C CNN
F 3 "~" H 9450 5850 50  0001 C CNN
	1    9450 5850
	1    0    0    -1  
$EndComp
Text GLabel 2300 2350 2    50   Input ~ 0
STRIP1
Text GLabel 2300 2450 2    50   Input ~ 0
STRIP2
Text GLabel 2300 2550 2    50   Input ~ 0
STRIP3
Text GLabel 1300 2550 0    50   Input ~ 0
STRIP4
Text GLabel 1300 2650 0    50   Input ~ 0
STRIP5
Text GLabel 1300 2750 0    50   Input ~ 0
STRIP6
Text GLabel 1300 1450 0    50   Input ~ 0
STRIP7
Text GLabel 1300 1550 0    50   Input ~ 0
STRIP8
$Comp
L Connector_Generic:Conn_01x08 J5
U 1 1 5D19E098
P 9650 3400
F 0 "J5" H 9730 3346 50  0000 L CNN
F 1 "Conn_01x08" H 9730 3301 50  0001 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x08_P2.54mm_Vertical" H 9650 3400 50  0001 C CNN
F 3 "~" H 9650 3400 50  0001 C CNN
	1    9650 3400
	1    0    0    -1  
$EndComp
Text GLabel 9450 3100 0    50   Input ~ 0
STRIP1
Text GLabel 9450 3200 0    50   Input ~ 0
STRIP2
Text GLabel 9450 3300 0    50   Input ~ 0
STRIP3
Text GLabel 9450 3400 0    50   Input ~ 0
STRIP4
Text GLabel 9450 3500 0    50   Input ~ 0
STRIP5
Text GLabel 9450 3600 0    50   Input ~ 0
STRIP6
Text GLabel 9450 3700 0    50   Input ~ 0
STRIP7
Text GLabel 9450 3800 0    50   Input ~ 0
STRIP8
$Comp
L Connector_Generic:Conn_02x03_Odd_Even J7
U 1 1 5D1A0654
P 10250 3200
F 0 "J7" H 10300 3425 50  0000 C CNN
F 1 "Conn_02x03_Odd_Even" H 10300 3426 50  0001 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x03_P2.54mm_Vertical" H 10250 3200 50  0001 C CNN
F 3 "~" H 10250 3200 50  0001 C CNN
	1    10250 3200
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x08_Odd_Even J4
U 1 1 5D1A41CD
P 8700 3400
F 0 "J4" H 8750 3825 50  0000 C CNN
F 1 "Conn_02x08_Odd_Even" H 8750 3926 50  0001 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x08_P2.54mm_Vertical" H 8700 3400 50  0001 C CNN
F 3 "~" H 8700 3400 50  0001 C CNN
	1    8700 3400
	1    0    0    -1  
$EndComp
NoConn ~ 9000 3100
NoConn ~ 9000 3200
NoConn ~ 9000 3300
NoConn ~ 9000 3400
NoConn ~ 9000 3500
NoConn ~ 9000 3600
NoConn ~ 9000 3700
NoConn ~ 9000 3800
NoConn ~ 8500 3800
NoConn ~ 8500 3700
NoConn ~ 8500 3600
NoConn ~ 8500 3500
NoConn ~ 8500 3400
NoConn ~ 8500 3300
NoConn ~ 8500 3200
NoConn ~ 8500 3100
$Comp
L Connector_Generic:Conn_01x04 J6
U 1 1 5D1CFC06
P 10250 3600
F 0 "J6" H 10330 3592 50  0000 L CNN
F 1 "Conn_01x04" H 10330 3501 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 10250 3600 50  0001 C CNN
F 3 "~" H 10250 3600 50  0001 C CNN
	1    10250 3600
	1    0    0    -1  
$EndComp
Text GLabel 1300 2450 0    50   Input ~ 0
SCL
Text GLabel 1300 2350 0    50   Input ~ 0
SDA
Text GLabel 10050 3600 0    50   Input ~ 0
SDA
Text GLabel 10050 3500 0    50   Input ~ 0
SCL
Text GLabel 10050 3700 0    50   Input ~ 0
+5V
Text GLabel 10050 3800 0    50   Input ~ 0
GND
Wire Wire Line
	1800 3100 1800 3050
Wire Wire Line
	1900 3050 1900 3100
Wire Wire Line
	2000 1050 2000 1000
Wire Wire Line
	2400 2150 2300 2150
Wire Wire Line
	2400 2050 2300 2050
$Comp
L MCU_Module:Adafruit_Feather_M0 A1
U 1 1 5D08D469
P 1800 2050
F 0 "A1" H 1800 2050 50  0000 C CNN
F 1 "Adafruit Feather M0" H 1300 1100 50  0000 C CNN
F 2 "Module:Adafruit_Feather" H 1950 1100 50  0001 L CNN
F 3 "https://learn.adafruit.com/adafruit-feather-m0-basic-proto" H 1800 1050 50  0001 C CNN
	1    1800 2050
	1    0    0    -1  
$EndComp
Connection ~ 4950 1450
$Comp
L Amplifier_Operational:LM358 U1
U 1 1 5CFA6AEC
P 5250 1550
F 0 "U1" H 5450 1650 50  0000 C CNN
F 1 "LM358" H 5300 1750 50  0000 C CNN
F 2 "Package_DIP:DIP-8_W7.62mm_Socket_LongPads" H 5250 1550 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/lm2904-n.pdf" H 5250 1550 50  0001 C CNN
	1    5250 1550
	1    0    0    1   
$EndComp
Text GLabel 1550 5600 0    50   Input ~ 0
TELEPHONE_B
Text GLabel 5800 1400 1    50   Input ~ 0
AMP_OUT
$Comp
L Device:R R5
U 1 1 5CFA7854
P 6100 2150
F 0 "R5" V 6350 2150 50  0000 C CNN
F 1 "470R" V 6250 2150 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 6030 2150 50  0001 C CNN
F 3 "~" H 6100 2150 50  0001 C CNN
	1    6100 2150
	0    1    1    0   
$EndComp
Wire Wire Line
	6250 2700 7050 2700
$Comp
L Device:R R6
U 1 1 5CFA789C
P 6100 2700
F 0 "R6" V 6300 2700 50  0000 C CNN
F 1 "470R" V 6200 2700 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 6030 2700 50  0001 C CNN
F 3 "~" H 6100 2700 50  0001 C CNN
	1    6100 2700
	0    1    1    0   
$EndComp
$Comp
L Diode:1N4148 D1
U 1 1 5CFA6EAF
P 6550 1550
F 0 "D1" H 6550 1334 50  0000 C CNN
F 1 "1N4148" H 6550 1425 50  0000 C CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 6550 1375 50  0001 C CNN
F 3 "https://assets.nexperia.com/documents/data-sheet/1N4148_1N4448.pdf" H 6550 1550 50  0001 C CNN
	1    6550 1550
	-1   0    0    1   
$EndComp
$Comp
L Device:R R4
U 1 1 5CFA780C
P 6100 1550
F 0 "R4" V 5893 1550 50  0000 C CNN
F 1 "470R" V 5984 1550 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 6030 1550 50  0001 C CNN
F 3 "~" H 6100 1550 50  0001 C CNN
	1    6100 1550
	0    1    1    0   
$EndComp
Wire Wire Line
	6250 2150 6400 2150
Wire Wire Line
	6900 1850 7050 1850
Wire Wire Line
	6900 1550 6700 1550
Wire Wire Line
	6400 1550 6250 1550
$Comp
L Device:CP C3
U 1 1 5CFA904C
P 6550 2150
F 0 "C3" V 6800 2100 50  0000 L CNN
F 1 "33μF 50V" V 6700 2000 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.00mm" H 6588 2000 50  0001 C CNN
F 3 "~" H 6550 2150 50  0001 C CNN
	1    6550 2150
	0    1    1    0   
$EndComp
Text GLabel 7050 1850 2    50   Input ~ 0
TELEPHONE_A
Text GLabel 7050 2700 2    50   Input ~ 0
TELEPHONE_B
Wire Wire Line
	5550 2700 5950 2700
Wire Wire Line
	5550 2500 5750 2500
Wire Wire Line
	5750 2500 5750 2150
Wire Wire Line
	5750 2150 5950 2150
Wire Wire Line
	6700 2150 6900 2150
Connection ~ 6900 1850
Wire Wire Line
	6900 1850 6900 2150
Wire Wire Line
	6900 1550 6900 1850
Wire Wire Line
	5800 1400 5800 1550
Connection ~ 5800 1550
Wire Wire Line
	5800 1550 5950 1550
Wire Wire Line
	4000 1650 4500 1650
Wire Wire Line
	4500 1800 4500 1650
Connection ~ 4500 1650
Wire Wire Line
	4500 1650 4950 1650
Wire Wire Line
	3050 5500 3450 5500
Connection ~ 3450 5500
Text GLabel 10050 3300 0    50   Input ~ 0
GND
Text GLabel 10050 3200 0    50   Input ~ 0
GND
Text GLabel 10050 3100 0    50   Input ~ 0
GND
Text GLabel 10550 3100 2    50   Input ~ 0
+5V
Text GLabel 10550 3200 2    50   Input ~ 0
+5V
Text GLabel 10550 3300 2    50   Input ~ 0
+5V
Text Notes 8450 2850 0    50   ~ 0
Experimenting area
Text Notes 7050 4950 0    50   ~ 0
Testpoints
$Comp
L Graphic:Logo_Open_Hardware_Small LOGO1
U 1 1 5D27CBF8
P 10950 6850
F 0 "LOGO1" H 10950 7125 50  0001 C CNN
F 1 "Logo_Open_Hardware_Small" H 10950 6625 50  0001 C CNN
F 2 "Symbol:OSHW-Logo2_7.3x6mm_SilkScreen" H 10950 6850 50  0001 C CNN
F 3 "~" H 10950 6850 50  0001 C CNN
	1    10950 6850
	1    0    0    -1  
$EndComp
Text Notes 9350 5000 0    50   ~ 0
Misc
Text Notes 550  4950 0    50   ~ 0
Hook detection
Text Notes 550  6450 0    50   ~ 0
Power
Text Notes 550  600  0    50   ~ 0
Microcontroller
Text Notes 3500 600  0    50   ~ 0
Line output stage
Wire Notes Line
	6950 7800 6950 4800
Wire Notes Line
	450  4800 11200 4800
Wire Notes Line
	450  6300 6950 6300
Wire Notes Line
	8350 4800 8350 450 
Text GLabel 9200 1000 0    50   Input ~ 0
GND
Text GLabel 9200 800  0    50   Input ~ 0
+5V
Text Notes 8450 600  0    50   ~ 0
Connectors\n
NoConn ~ 9250 2350
NoConn ~ 9250 1850
Text GLabel 9200 900  0    50   Input ~ 0
MOTION
$Comp
L Connector_Generic:Conn_01x03 J3
U 1 1 5D079A7B
P 9400 900
F 0 "J3" H 9480 942 50  0000 L CNN
F 1 "Conn_01x03" H 9480 851 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 9400 900 50  0001 C CNN
F 3 "~" H 9400 900 50  0001 C CNN
	1    9400 900 
	1    0    0    -1  
$EndComp
NoConn ~ 9250 2250
NoConn ~ 9250 1950
Wire Wire Line
	9000 2050 9250 2050
Wire Wire Line
	9250 2150 9000 2150
Text GLabel 9000 2150 0    50   Input ~ 0
TELEPHONE_B
Text GLabel 9000 2050 0    50   Input ~ 0
TELEPHONE_A
$Comp
L Connector:6P6C J2
U 1 1 5D078C21
P 9650 2050
F 0 "J2" H 9320 2054 50  0000 R CNN
F 1 "6P4C" H 9320 2145 50  0000 R CNN
F 2 "Connector_RJ:RJ12_Amphenol_54601" V 9650 2075 50  0001 C CNN
F 3 "~" V 9650 2075 50  0001 C CNN
	1    9650 2050
	-1   0    0    1   
$EndComp
Text GLabel 9200 1500 0    50   Input ~ 0
TELEPHONE_B
Text GLabel 9200 1400 0    50   Input ~ 0
TELEPHONE_A
$Comp
L Connector_Generic:Conn_01x02 J1
U 1 1 5CFA8578
P 9400 1400
F 0 "J1" H 9480 1392 50  0000 L CNN
F 1 "Conn_01x02" H 9480 1301 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 9400 1400 50  0001 C CNN
F 3 "~" H 9400 1400 50  0001 C CNN
	1    9400 1400
	1    0    0    -1  
$EndComp
Wire Notes Line
	8350 2650 11250 2650
Wire Notes Line
	3450 450  3450 4800
Wire Notes Line
	9250 4800 9250 6550
Wire Wire Line
	5550 1550 5600 1550
Wire Wire Line
	4950 1000 5350 1000
Wire Wire Line
	5350 1000 5350 1100
Wire Wire Line
	4950 1000 4950 1450
Wire Wire Line
	5500 1250 5600 1250
Wire Wire Line
	5600 1250 5600 1550
Connection ~ 5600 1550
Wire Wire Line
	5600 1550 5800 1550
NoConn ~ 1300 1950
NoConn ~ 1300 2050
NoConn ~ 1300 2150
NoConn ~ 1300 2250
NoConn ~ 2300 1450
NoConn ~ 2300 1550
NoConn ~ 2300 1850
NoConn ~ 2300 2250
NoConn ~ 1900 1050
NoConn ~ 1700 1050
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 5D2DD8BE
P 2000 3150
F 0 "#FLG0101" H 2000 3225 50  0001 C CNN
F 1 "PWR_FLAG" H 1750 3200 50  0000 C CNN
F 2 "" H 2000 3150 50  0001 C CNN
F 3 "~" H 2000 3150 50  0001 C CNN
	1    2000 3150
	-1   0    0    1   
$EndComp
$Comp
L power:PWR_FLAG #FLG0102
U 1 1 5D2DCD69
P 2100 950
F 0 "#FLG0102" H 2100 1025 50  0001 C CNN
F 1 "PWR_FLAG" H 2350 1000 50  0000 C CNN
F 2 "" H 2100 950 50  0001 C CNN
F 3 "~" H 2100 950 50  0001 C CNN
	1    2100 950 
	1    0    0    -1  
$EndComp
Wire Wire Line
	2100 950  2100 1000
Wire Wire Line
	2100 1000 2000 1000
Wire Wire Line
	2000 1000 2000 950 
Connection ~ 2000 1000
Wire Wire Line
	2000 3150 2000 3100
Wire Wire Line
	2000 3100 1900 3100
Connection ~ 1900 3100
Text Notes 5250 6550 0    50   ~ 0
DNP capacitors are probably not needed,\nbut add a footprint just in case.\n
$EndSCHEMATC
