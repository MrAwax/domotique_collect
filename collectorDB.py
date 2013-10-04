#!/opt/bin/python2.6
# -*- coding: cp1252 -*-
#

import serial
import time
import datetime
import MySQLdb as mdb

conn = None


# Close on ctrl+C
def signal_handler(signal, frame):
    print("Exiting on Ctrl+C")
    ser.close()
    sys.exit(0)

def now():
    return datetime.datetime.utcnow().isoformat('T')

def accumulate(buffer, offset, nbr):
    accu = 0
    for i in range(0,nbr):
        accu = accu*256 + buffer[offset + i]
    return accu

def processInterfaceMessage(msg, data):
    if data["packetLength"] != 13:
        print("Message with invalid length, got " + str(data["packetLength"]) + " expected 10")
        return data
    data["subType"] = msg[2]
    data["seqNbr"] = msg[3]

    data["deviceType"] = msg[5]
    data["fwVersion"] = msg[6]
    data["operationMode"] = msg[7]
    msg4 = msg[8]
    msg5 = msg[9]

    data["protoRFU"] = (msg4 & 0x80) != 0
    data["protoRollerTrol"] = (msg4 & 0x40) != 0
    data["protoProGuard"] = (msg4 & 0x20) != 0
    data["protoFS20"] = (msg4 & 0x10) != 0
    data["protoLaCrosse"] = (msg4 & 0x08) != 0
    data["protoHideki"] = (msg4 & 0x04) != 0
    data["protoLightwaveRF"] = (msg4 & 0x02) != 0
    data["protoMertik"] = (msg4 & 0x01) != 0
    data["protoVisonic"] = (msg5 & 0x80) != 0
    data["protoATI"] = (msg5 & 0x40) != 0
    data["protoOregonScientific"] = (msg5 & 0x20) != 0
    data["protoIkea"] = (msg5 & 0x10) != 0
    data["protoHomeEasy"] = (msg5 & 0x08) != 0
    data["protoAC"] = (msg5 & 0x04) != 0
    data["protoARC"] = (msg5 & 0x02) != 0
    data["protoX10"] = (msg5 & 0x01) != 0

    print "Firmware version " + str(data["fwVersion"])
    print "Operation mode " + str(data["operationMode"])
    print "Proto RFU " + str(data["protoRFU"])
    print "Proto RollerTrol " + str(data["protoRollerTrol"])
    print "Proto ProGuard " + str(data["protoProGuard"])
    print "Proto FS20 " + str(data["protoFS20"])
    print "Proto LaCrosse " + str(data["protoLaCrosse"])
    print "Proto Hideki " + str(data["protoHideki"])
    print "Proto LightwaveRF " + str(data["protoLightwaveRF"])
    print "Proto Mertik " + str(data["protoMertik"])
    print "Proto Visonic " + str(data["protoVisonic"])
    print "Proto ATI " + str(data["protoATI"])
    print "Proto Oregon Scientific " + str(data["protoOregonScientific"])
    print "Proto Ikea " + str(data["protoIkea"])
    print "Proto HomeEasy " + str(data["protoHomeEasy"])
    print "Proto AC " + str(data["protoAC"])
    print "Proto ARC " + str(data["protoARC"])
    print "Proto X10 " + str(data["protoX10"])
    return data


def processTempHumBaroSensor(msg, data):
    

    data["subType"] = msg[2]
    data["seqNbr"] = msg[3]
    data["id1"] = msg[4]
    data["id2"] = msg[5]
    
    print("ID " + str(data["id1"]) + "-" + str(data["id2"]))
    print("SubType " + str(data["subType"]) + " / Seq " + str(data["seqNbr"]))

    position = 6
    if data["packetType"] in [80,82,84]:
        temperature = accumulate(msg, position, 2)
        if temperature >= 32768:
            temperature = -(temperature - 32768)
        temperature /= float(10)
        data["temperature"] = temperature
        print("Temperature " + str(data["temperature"]) +"C")
        position += 2

    if data["packetType"] in [81,82,84]:
        data["humidity"] = msg[position]
        data["humidityStatus"] = msg[position+1]
        print("Humidity " + str(data["humidity"]) +"%")
        print("Humidity status " + str(data["humidityStatus"]))
        position += 2

    if data["packetType"] in [83,84]:
        data["baro"] = accumulate(msg, position, 2)
        data["forecast"] = msg[position+2]
        print("Barometre " + str(data["baro"]) + "hPa")
        print("Forecast " + str(data["forecast"]))
        position += 3

    data["battery"] = (msg[position] & 0xF0) >> 4
    data["RSSI"] = msg[position] & 0x0F
    print("Battery " + str(data["battery"]))
    print("RSSI " + str(data["RSSI"]))
    
    
    
    x = conn.cursor()
    #try:
    
    x.execute("""INSERT into weather (event, id1, id2, temp, humi, humi_level,battery, signal) values (%s, %s, %s, %s, %s, %s, %s, %s)""",(datetime.datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S'), data["id1"], data["id2"], data["temperature"], data["humidity"], data["humidityStatus"], data["battery"], data["RSSI"]))
    conn.commit()
    #except:
#        conn.rollback()
    #    print "Unknown error- rollback"
    
    return data

def processWindSensor(msg, data):
    

    data["subType"] = msg[2]
    data["seqNbr"] = msg[3]
    data["id1"] = msg[4]
    data["id2"] = msg[5]
    
    print("ID " + str(data["id1"]) + "-" + str(data["id2"]))
    print("SubType " + str(data["subType"]) + " / Seq " + str(data["seqNbr"]))

    position = 6
    
    direction = accumulate(msg, position, 2)
    if direction >= 32768:
        direction = -(direction - 32768)
    data["direction"] = direction
    print("Direction " + str(data["direction"]) +" ¡")
    position += 2

    wind = accumulate(msg, position, 2)
    if wind >= 32768:
        wind = -(wind - 32768)
    wind /= float(10)
    data["wind"] = wind
    print("Wind " + str(data["wind"]) +" m/s")
    position += 2
	
    gust = accumulate(msg, position, 2)
    if gust >= 32768:
        gust = -(gust)
    gust /= float(10)
    data["gust"] = gust
    print("Gust " + str(data["gust"]) +" m/s")
    position += 2
	
    temp = accumulate(msg, position, 2)
    if temp >= 32768:
        temp = -(temp - 32768)
    temp /= float(10)
    data["temp"] = temp
    print("Temperature " + str(data["temp"]) +" C")
    position += 2
    
    chill = accumulate(msg, position, 2)
    if chill >= 32768:
        chill = -(chill - 32768)
    chill /= float(10)
    data["chill"] = chill
    print("Chill " + str(data["chill"]) +" C")
    position += 2

    data["battery"] = (msg[position] & 0xF0) >> 4
    data["RSSI"] = msg[position] & 0x0F
    print("Battery " + str(data["battery"]))
    print("RSSI " + str(data["RSSI"]))
    
    
    
    x = conn.cursor()
    #try:
    
    x.execute("""INSERT into wind (event, id1, id2, direction, wind, gust, battery, signal) values (%s, %s, %s, %s, %s, %s, %s, %s)""",(datetime.datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S'), data["id1"], data["id2"], data["direction"], data["wind"], data["gust"], data["battery"], data["RSSI"]))
    conn.commit()
    #except:
#        conn.rollback()
    #    print "Unknown error- rollback"
    
    return data
    
def processRainSensor(msg, data):
    

    data["subType"] = msg[2]
    data["seqNbr"] = msg[3]
    data["id1"] = msg[4]
    data["id2"] = msg[5]
    
    print("ID " + str(data["id1"]) + "-" + str(data["id2"]))
    print("SubType " + str(data["subType"]) + " / Seq " + str(data["seqNbr"]))

    position = 6
    
    rate = accumulate(msg, position, 2)
    rate /= float(100)
    data["rate"] = rate
    print("Rate " + str(data["rate"]) +" mm/hr")
    position += 2

    total = accumulate(msg, position, 3)
    total /= float(10)
    data["total"] = total
    print("Total " + str(data["total"]) +" mm")
    position += 3

    data["battery"] = (msg[position] & 0xF0) >> 4
    data["RSSI"] = msg[position] & 0x0F
    print("Battery " + str(data["battery"]))
    print("RSSI " + str(data["RSSI"]))
    
    
    
    x = conn.cursor()
    #try:
    
    x.execute("""INSERT into rain (event, id1, id2, rate, total, battery, signal) values (%s, %s, %s, %s, %s, %s, %s)""",(datetime.datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S'), data["id1"], data["id2"], data["rate"], data["total"], data["battery"], data["RSSI"]))
    conn.commit()
    #except:
#        conn.rollback()
    #    print "Unknown error- rollback"
    
    return data
    
    
def processEnergyUsageSensor(msg, data):
    global status
    global conn
    
    if data["packetLength"] != 17:
        print("Message with invalid length, got " + str(data["packetLength"]) + " expected 17")
        return data
    
    data["subType"] = msg[2]
    data["seqNbr"] = msg[3]
    data["id1"] = msg[4]
    data["id2"] = msg[5]
    data["count"] = msg[6]
    data["instant"] = accumulate(msg, 7,4)
    data["total"] = float(accumulate(msg, 11,6)) / float(223666) # To get kWh cf doc from rfxcom
    data["battery"] = (msg[17] & 0xF0) >> 4
    data["RSSI"] = msg[17] & 0x0F
    
    print("ID " + str(data["id1"]) + "-" + str(data["id2"]))
    print("Instant power " + str(data["instant"]) + "W")
    print("Total power " + str(data["total"]) + "kWh")
    print("Battery " + str(data["battery"]))
    print("RSSI " + str(data["RSSI"]))
    
    data["state"] = "Power: " + str(data["instant"]) + "W - " + str(data["total"]) + "kWh (" + str(data["battery"]) + "/" + str(data["RSSI"]) + ")"
    
    x = conn.cursor()
    try:
    
        x.execute("""INSERT into power (event, id1, id2, power, total, battery, signal) values (%s, %s, %s, %s, %s, %s, %s)""",(datetime.datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S'), data["id1"], data["id2"], data["instant"], data["total"], data["battery"], data["RSSI"]))
        conn.commit()
    except:
        conn.rollback()
        print "Unknown error- rollback"
    
    return data

def writeState(stateArg):
    for v in stateArg.values():
     print " >>> " + v
    return

def processLighting2Sensor(msg, data):
    if data["packetLength"] != 11:
        print("Message with invalid length, got " + str(data["packetLength"]) + " expected 11")
        return data

    data["subType"] = msg[2]
    data["seqNbr"] = msg[3]
    id = accumulate(msg, 4, 4) & 0x03FFFFFF
    data["id"] = id
    data["unitCode"] = msg[8]
    data["command"] = msg[9]
    data["level"] = msg[10]
    data["RSSI"] = msg[11] & 0x0F

    print("ID " + str(data["id"]))
    print("Unit code " + str(data["unitCode"]))
    print("Command " + str(data["command"]))
    print("Level " + str(data["level"]))
    print("RSSI " + str(data["RSSI"]))
    return data

def parseMessage(msg):
    print('Packet length ' + str(msg[0]))
    packetLength = msg[0]
    packetType = msg[1]
    
    print(bytearray.tohex(msg))

    data = {'packetType': packetType, 'packetLength': packetLength}

    if packetType == 1:
        print("Received interface control (0x01) message")
        data = processInterfaceMessage(msg, data)
    elif packetType == 2:
        print("Received Receiver/Transmitter (0x02) message")
    elif packetType == 3:
        print("Received undecoded RF (0x03) message")
    elif packetType == 17:
        print("Received Lighting2 (0x11) message")
        data = processLighting2Sensor(msg, data)
    elif packetType == 80:
        print("Received Temperature sensor (0x50) message")
        data = processTempHumBaroSensor(msg, data)
    elif packetType == 81:
        print("Received Humidy sensor (0x51) message")
        data = processTempHumBaroSensor(msg, data)
    elif packetType == 82:
        print("Received Temp & Humidity sensor (0x52) message")
        data = processTempHumBaroSensor(msg, data)
    elif packetType == 83:
        print("Received Barometric sensor (0x53) message")
        data = processTempHumBaroSensor(msg, data)
    elif packetType == 84:
        print("Received Temp, Hum, Baro sensor (0x54) message")
        data = processTempHumBaroSensor(msg, data)
    elif packetType == 85:
        print("Received Rain sensor (0x55) message")
        data = processRainSensor(msg, data)
    elif packetType == 86:
        print("Received Wind sensor (0x56) message")
        data = processWindSensor(msg, data)
    elif packetType == 87:
        print("Received UV sensor (0x57) message")
    elif packetType == 90:
        print("Received Energy usage sensor (0x5A) message")
        data = processEnergyUsageSensor(msg, data)
    else:
        print("Unsupported packet type " + str(packetType))
    return data

def sendData(data, url):
    try:
        params = json.dumps([{'type': 'rfxcom' + str(data['packetType']),'time': now(), 'data': data}])
        headers = {'Content-Type': 'application/json'}
        req = urllib.request.Request(url, params.encode('utf-8'), headers)
        urllib.request.urlopen(req)
    except urllib.error.URLError as err:
        print(err)

    return

def main():
    global ser
    global conn
    
    conn = None
    try:
        conn = mdb.connect('server', 'user', 'password', 'databse')
        
        cur = conn.cursor()
        cur.execute("SELECT VERSION()")
        data = cur.fetchone()
        print "Database version : %s " % data
        
        currentState = {}
        # parser = argparse.ArgumentParser(description='Collect home automation events from RFXCOM')
        # parser.add_argument("-t", "--tty-port", dest="ttyport", help="open port TTY", metavar="TTY", required=True)
        # parser.add_argument("-u", "--url", dest="url", help = "post data to URL", metavar="URL", required=True)
    
        # args = parser.parse_args()
    
        # signal.signal(signal.SIGINT, signal_handler)
    
        #ser = serial.Serial(args.ttyport, 38400, timeout = 0.2)
        ser = serial.Serial('/dev/ttyUSB0', 38400, timeout=0.25) 
        print ser
    
        # Reset command
        reset = bytearray.fromhex(unicode("0D00000000000000000000000000"))
        # GetStatus command
        status = bytearray.fromhex(unicode("0D00000102000000000000000000"))
    
        ser.write(reset)
        time.sleep(0.1)
        ser.flushInput()
        ser.write(status)
    
        buffer = bytearray(b'')
    
        while True:
            data = bytearray(ser.read(32))
            buffer += data
            if len(buffer) > 0:
                packetLength = buffer[0]
                if len(buffer) > packetLength:
                    if packetLength == 0:
                        print "Got actual message with length 0 - discarding"
                        del buffer[0:1]
                    else:
                        msg = buffer[0:packetLength+1] #size does not include size byte (so actual size is +1)
                        del buffer[0:packetLength+1] #remove message
                        data = parseMessage(msg)
                        #currentState[data["id1"]] = data["state"]
                        #writeState(currentState)
                        # sendData(data, args.url)
     
    finally:    
			
		if conn:    
			conn.close()



if __name__ == "__main__":
    main()