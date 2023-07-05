import warnings
import serial as serial
import serial.tools.list_ports

arduino_ports = [
    p.device
    for p in serial.tools.list_ports.comports()
    #if 'Arduino' in p.description
]

if not arduino_ports:
    raise IOError("No Arduino Found")
if len(arduino_ports) > 1:
    warnings.warn('Multiple Arduinos Found so Using the First One')
    
ser = serial.Serial(arduino_ports[0], 115200, timeout = 1)
    
global initialized


def initialize():
    if initialized == 0:
        ser.write(str.encode('INITIALIZE\r'))
        initialized = 1
        print("Initialized")
    else:
        print("Already Initialized!")

def setVoltage(voltage, channel):
    #ser.write(str.encode('SET,0,'+str(voltage)+'\r'))
    ser.write(str.encode('SET,' + str(channel) + ','+str(voltage)+'\r'))
    print(ser.write(str.encode('SET,0,'+str(voltage)+'\r')))


def readline():
    ser.readline()

