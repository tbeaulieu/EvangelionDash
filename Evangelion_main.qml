/****************************************************************************
**
** Copyright (C) 2012 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
** $QT_END_LICENSE$
**
****************************************************************************/

//! [imports]
import QtQuick 2.3

import FileIO 1.0
//import QtGraphicalEffects 1.0
//! [imports]

//! [0]
Item{
    id:root

    property int udp_message:rpmtest.udp_packetdata
   // onUdp_messageChanged: console.log(" UDP is "+udp_message)

    property bool udp_up:udp_message&0x01
    property bool udp_down:udp_message&0x02
    property bool udp_left:udp_message&0x04
    property bool udp_right:udp_message&0x08
    property int odometer:if(speedunits==0)rpmtest.odometer0data;else rpmtest.odometer0data*0.62
    property int tripmeter:if(speedunits==0)rpmtest.tripmileage0data;else rpmtest.tripmileage0data*0.62
    property real rpm:rpmtest.rpmdata
    property real speed:rpmtest.speeddata
    property int speedunits:0
    property real watertemp:rpmtest.watertempdata
    property real fuel:rpmtest.fueldata
    property real o2:rpmtest.o2data
    property real map:rpmtest.mapdata
    property real maf:rpmtest.mafdata
    property real oilpressure:rpmtest.oilpressuredata
    property real oiltemp: rpmtest.oiltempdata
    property real batteryvoltage:rpmtest.batteryvoltagedata

    property real symbols:rpmtest.symbolsdata
    property real symbols2:rpmtest.symbols2data

    property real gearpos:rpmtest.geardata

    property real rpmlimit:4000
    property real shiftvalue:0
    property string colorscheme: "green"
    property int red: 255
    property int green: 128
    property int blue: 100

    property real rpmdamping:1
   // property real fueldamping:7
  //  onFueldampingChanged: if(fueldamping<7)fueldamping=7

    property real batterylow:0
    property real batteryhigh:0
    property real batteryunits:0

    property real afrlow:0
    property real afrhigh:0
    property real afrunits:0

    property int waterlow:0
    property int waterhigh:0
    property int waterunits:0
    property int fuellow:0
    property int fuelhigh:0
    property int fuelunits:1
    property int oiltemplow:0
    property int oiltemphigh:0
    property int oiltempunits:0
    property int oilpressurelow:0
    property int oilpressurehigh:0
    property int oilpressureunits:0
    property real night_time_hue:0

    property bool settings_on_off:false//put back to false
    property bool menu_on_off:rpmtest.settings_on_offdata&0x02

    onSettings_on_offChanged: {if(settings_on_off){rpmtest.settings_on_offdata=rpmtest.settings_on_offdata|0x01;}//console.log("settings are"+settings_on_off)}
                                else rpmtest.settings_on_offdata=rpmtest.settings_on_offdata&~0x01}

width:800
height:480
FontLoader{
        id:basicfont;
        source: "./fonts/GeistVariableVF.ttf"
    }
Item{
    x: 800
    y: 50

    opacity:if(settings_on_off&&dial.x==80)1.0;else 0
    Behavior on opacity{ NumberAnimation{duration: 2000}}

///////left column/////////



    Text {
        id: watertemp_
        x: -768
        y: -38
        color: "#0000ff"
        text: qsTr("Coolant")
        font.pixelSize: 17
        font.family: basicfont.name
        Text{x: 17;y: 26; width: 37; height: 17;color:if(currentindex.position===4)"green";else "#ffffff";text:"High"}
        Text{x: 17;y: 49; width: 37; height: 17;color:if(currentindex.position===5)"green";else "#ffffff";text:"Low"}
        Text{x: 17;y: 72; width: 37; height: 17;color:if(currentindex.position===6)"green";else "#ffffff";text:"Units"}
        Text{x: 82;y: 72; width: 37; height: 17;color:if(currentindex.position===7)"green";else "#ffffff";text:if(root.waterunits===1)"C";else "F"}
        Text{id: waterlowvalue;x: 82;y: 49; width: 37; height: 17;color: "#ffffff";text:root.waterlow}
        Text{id: waterhighvalue;x: 82;y: 26; width: 27;color: "#ffffff";text:root.waterhigh}
         }

    Text {
        id: fuel_
        x: -768
        y: 56
        color: "#0000ff"
        text: qsTr("Fuel")
        font.pixelSize: 17
        font.family: basicfont.name
        Text{x: 17;y: 26; width: 37; height: 17;color:if(currentindex.position===8)"green";else "#ffffff";text:"High"}
        Text{x: 17;y: 49; width: 37; height: 17;color:if(currentindex.position===9)"green";else "#ffffff";text:"Low"}
        Text{x: 17;y: 72; width: 37; height: 17;color:if(currentindex.position===10)"green";else "#ffffff";text:"Damp"}
      //  Text{x: 82;y: 72; width: 37; height: 17;color:if(currentindex.position===11)"green";else "#ffffff";text:root.fueldamping }
        Text {id: fuellowvalue;x: 82;y: 49;width: 37;height: 17;color: "#ffffff"; text: root.fuellow;  }
        Text {id: fuelhighvalue;x: 82;y: 26;width: 27;color: "#ffffff";text: root.fuelhigh;}
         }
    Text {
        id: oiltemp_
        x: -766
        y: 149
        color: "#0000ff"
        text: qsTr("Oiltemp")
        font.pixelSize: 17
        font.family: basicfont.name
        Text{x: 17;y: 26; width: 37; height: 17;color:if(currentindex.position===12)"green";else "#ffffff";text:"High"}
        Text{x: 17;y: 49; width: 37; height: 17;color:if(currentindex.position===13)"green";else "#ffffff";text:"Low"}
        Text{x: 17;y: 72; width: 37; height: 17;color:if(currentindex.position===14)"green";else"#ffffff";text:"Units"}
        Text{x: 82;y: 72; width: 37; height: 17;color:if(currentindex.position===15)"green";else "#ffffff";text:if(root.oiltempunits===1)"C";else "F"}
        Text {id: oiltemplowvalue;x: 82;y: 49;width: 37;height: 17;color: "#ffffff"; text: root.oiltemplow;  }
        Text {id: oiltemphighvalue;x: 82;y: 26;width: 27;color: "#ffffff";text: root.oiltemphigh;}
         }
    Text {
        id: oilpressure_
        x: -768
        y: 242
        color: "#0000ff"
        text: qsTr("Oilpressure")
        font.pixelSize: 17
        font.family: basicfont.name
        Text{x: 17;y: 26; width: 37; height: 17;color:if(currentindex.position===16)"green";else "#ffffff";text:"High"}
        Text{x: 17;y: 49; width: 37; height: 17;color:if(currentindex.position===17)"green";else "#ffffff";text:"Low"}
        Text{x: 17;y: 72; width: 37; height: 17;color:if(currentindex.position===18)"green";else "#ffffff";text:"Units"}
        Text{x: 82;y: 72; width: 37; height: 17;color:if(currentindex.position===19)"green";else "#ffffff";text:if(root.oilpressureunits===1)"Bar";else "Psi"}
        Text {id: oilpressurelowvalue;x: 82;y: 49;width: 37;height: 17;color: "#ffffff"; text: root.oilpressurelow;  }
        Text {id: oilpressurehighvalue;x: 82;y: 26;width: 27;color: "#ffffff";text: root.oilpressurehigh;}
         }
    Text {
        id: battery_
        x: -768
        y: 330
        color: "#0000ff"
        text: qsTr("Battery")
        font.pixelSize: 17
        font.family: basicfont.name
        Text{x: 17;y: 26; width: 37; height: 17;color:if(currentindex.position===20)"green";else "#ffffff";text:"High"}
        Text{x: 17;y: 49; width: 37; height: 17;color:if(currentindex.position===21)"green";else "#ffffff";text:"Low"}
        Text{x: 17;y: 72; width: 37; height: 17;color: "#ffffff";text:"Units"}
        Text{x: 82;y: 72; width: 37; height: 17;color: "#ffffff";text:"V"}
        Text{id: batterylowvalue;x: 82;y: 49; width: 37; height: 17;color: "#ffffff";text:root.batterylow.toFixed(1)}
        Text{id: batteryhighvalue;x: 82;y: 26; width: 27;color: "#ffffff";text:root.batteryhigh.toFixed(1)}
         }
    Text {
        id: afr_
        x: -649
        y: -45
        color: "#0000ff"
        text: qsTr("AFR")
        font.pixelSize: 17
        font.family: basicfont.name
        Text{x: 17;y: 26; width: 37; height: 17;color:if(currentindex.position===27)"green";else "#ffffff";text:"High"}
        Text{x: 17;y: 49; width: 37; height: 17;color:if(currentindex.position===28)"green";else "#ffffff";text:"Low"}
        Text{x: 17;y: 72; width: 37; height: 17;color: "#ffffff";text:"Units"}
        Text{x: 82;y: 72; width: 37; height: 17;color: "#ffffff";text:"L"}
        Text{id: afrlowvalue;x: 82;y: 49; width: 37; height: 17;color: "#ffffff";text:root.afrlow.toFixed(1)}
        Text{id: afrhighvalue;x: 82;y: 26; width: 27;color: "#ffffff";text:root.afrhigh.toFixed(1)}
         }

    /////////top row/////////

    Text {
        id: red
        x: -500
        y: -38
        color:if(currentindex.position===1)"green";else "#ffffff"
        text: qsTr("Red")
        font.pixelSize: 19
        font.family: basicfont.name
        Text{id: redvalue;x: 61;y: 0;color: "#ffffff";text:root.red ;font.pointSize: 15}
    }

    Text {
        id: green
        x: -500
        y: -10
        color:if(currentindex.position===2)"green";else "#ffffff"
        text: qsTr("Green")
        font.pixelSize: 19
        font.family: basicfont.name
        Text{id: greenvalue;x: 61;y: 0;color: "#ffffff";text:root.green ;font.pointSize: 15}
    }

    Text {
        id: blue
        x: -500
        y: 18
        color:if(currentindex.position===3)"green";else "#ffffff"
        text: qsTr("Blue")
        font.pixelSize: 19
        font.family: basicfont.name
        Text{id: bluevalue;x: 61;y: 0;color: "#ffffff";text:root.blue ;font.pointSize: 15}
    }

    Text {
        id: speedunit
        x: -391
        y: -38
        color:if(currentindex.position===22)"green";else "#ffffff"
        text: qsTr("Speed units")
        font.pixelSize: 19
        font.family: basicfont.name
        Text{id: speedunitvalue;x: 113;y: 0;color: "#ffffff";text:if(root.speedunits===1)"MPH";else if(root.speedunits===0) "KMH";else "BOTH";font.pointSize: 15}
    }

    Text {
        id: exit
        x: -80
        y: -38
        color:if(currentindex.position===0)"green";else "#ffffff"
        text: qsTr("Exit")
        font.pixelSize: 19
        font.family: basicfont.name
        
    }

    Text {
        id: rpmlimit_
        x: -391
        y: -10
        color: if(currentindex.position===23)"green";else "#ffffff"
        text: qsTr("Rpm limit")
        font.pixelSize: 19
        font.family: basicfont.name
        Text {id: rpmlimitvalue;x: 83;y: 0;color: "#ffffff";text: root.rpmlimit; font.pointSize: 15}



    }
    Text {
        id: shiftvalue_
        x: -391
        y: 18
        color: if(currentindex.position===24)"green";else "#ffffff"
        text: qsTr("Shift rpm")
        font.pixelSize: 19
        font.family: basicfont.name
        Text {id: shiftvaluevalue;x: 113;y: 0;color: "#ffffff";text: root.shiftvalue; font.pointSize: 15}

    }

    Text {
        id: nighthue
        x: -216
        y: -38
        color: if(currentindex.position===25)"green";else "#ffffff"
        text: qsTr("Nightlight")
        font.family: basicfont.name
        font.pixelSize: 19
        Text {
            id: nighthuevalue
            x: 113
            y: 0
            color: "#ffffff"
            text: root.night_time_hue
            font.pointSize: 15
        }
    }

    Text {
        id: rpmdamping_
        x: -235
        y: -10  
        color: if(currentindex.position===26)"green";else "#ffffff"
        text: qsTr("Rpm damping")
        font.pixelSize: 19
        font.family: basicfont.name
        Text {id: rpmdampvalue;x: 132;y: 0;color: "#ffffff";text: root.rpmdamping; font.pointSize: 15}



    }
     }

///////////////////////////////
//////////////////////////////


FileIO {
    id: config_file
    source: "/opt/Garw_IC7/screen_configs/evangelion_config.txt"
    onError: console.log(msg)
       }

 property int counter:0
 property var  configstring:[25]


    Component.onCompleted: {

    for(counter=0;counter<26;counter++){
    config_file.openforreading()
    root.configstring[counter]=config_file.readopenfile(counter)
    config_file.close()
    //console.log("config"+counter+" string for race screen is "+root.configstring[counter])
                                       }

    colorscheme=configstring_function(0)

     root.red=configstring_function(1)
//console.log("red "+root.red)

     root.green=configstring_function(2)
//console.log("green "+root.green)

     root.blue=configstring_function(3)
//console.log("blue "+root.blue)

    root.waterlow = configstring_function(4)
    //console.log("waterlow "+waterlow)
    root.waterhigh = configstring_function(5)
    //console.log("waterhigh "+waterhigh)
    root.waterunits= configstring_function(6)

   root.fuellow= configstring_function(7)
    //console.log("fuellow "+fuellow)
   root.fuelhigh= configstring_function(8)
    //console.log("fuelhigh "+fuelhigh)
                  // root.fuelunits=configstring_function(9)

   root.oiltemplow= configstring_function(10)
    //console.log("oiltemplow "+oiltemplow)
   root.oiltemphigh= configstring_function(11)
    //console.log("oiltemphigh "+oiltemphigh)
    root.oiltempunits=configstring_function(12)

   root.oilpressurelow= configstring_function(13)
    //console.log("oilpressurelow "+oilpressurelow)
   root.oilpressurehigh= configstring_function(14)
    //console.log("oilpressurehigh "+oilpressurehigh)
    root.oilpressureunits=configstring_function(15)

    root.speedunits=configstring_function(16)
    root.rpmlimit=configstring_function(17)
    root.shiftvalue=configstring_function(18)
    root.night_time_hue=configstring_function(19)

    root.batterylow=configstring_function(20)
    root.batteryhigh=configstring_function(21)

    root.rpmdamping=configstring_function(22)
  //  root.fueldamping=configstring_function(23)

    root.afrhigh=configstring_function(24)
    root.afrlow=configstring_function(25)
                            }



 function save_settings()
     {
     configstring[1]=root.red
     configstring[2]=root.green
     configstring[3]=root.blue
     configstring[4]=root.waterlow
     configstring[5]=root.waterhigh
     configstring[6]=root.waterunits
     configstring[7]=root.fuellow
     configstring[8]=root.fuelhigh
     configstring[9]=root.fuelunits
     configstring[10]=root.oiltemplow
     configstring[11]=root.oiltemphigh
     configstring[12]=root.oiltempunits
     configstring[13]=root.oilpressurelow
     configstring[14]=root.oilpressurehigh
     configstring[15]=root.oilpressureunits
     configstring[16]=root.speedunits
     configstring[17]=root.rpmlimit
      configstring[18]=root.shiftvalue
     configstring[19]=root.night_time_hue
     configstring[20]=root.batterylow
     configstring[21]=root.batteryhigh
     configstring[22]=root.rpmdamping
   //  configstring[23]=root.fueldamping
     configstring[24]=root.afrhigh
     configstring[25]=root.afrlow
          //////////
          config_file.open()
          for(counter=0;counter<26;counter++){

              config_file.writetoopenfile(root.configstring[counter])
              config_file.writetoopenfile("\n")

                                             }
          config_file.close()

          //console.log("config string "+configstring)

     }

    function configstring_function(config_number){

    //  console.log("config string for race screen is "+root.configstring[0] +" and "+ root.configstring[1]+" and "+ root.configstring[2]+" and "+ root.configstring[3])

    return   root.configstring[config_number]
                                                 }

    property int inputs:rpmtest.inputsdata

    //Inputs//31 max!!
    property bool ignition      :inputs&0x01
    property bool battery       :inputs&0x02
    property bool lapmarker     :inputs&0x04
    property bool rearfog       :inputs&0x08
    property bool mainbeam      :inputs&0x10
    property bool up_joystick   :inputs&0x20 || root.udp_up
    property bool leftindicator :inputs&0x40
    property bool rightindicator:inputs&0x80
    property bool brake         :inputs&0x100
    property bool oil           :inputs&0x200
    property bool seatbelt      :inputs&0x400
    property bool sidelight     :inputs&0x800
    property bool tripresetswitch     :inputs&0x1000
    property bool down_joystick :inputs&0x2000 || root.udp_down
    property bool doorswitch    :inputs&0x4000
    property bool airbag        :inputs&0x8000
    property bool tc            :inputs&0x10000
    property bool abs           :inputs&0x20000
    property bool mil           :inputs&0x40000
    property bool shift1_id     :inputs&0x80000
    property bool shift2_id     :inputs&0x100000
    property bool shift3_id     :inputs&0x200000
    property bool service_id    :inputs&0x400000
    property bool race_id       :inputs&0x800000
    property bool sport_id      :inputs&0x1000000
    property bool cruise_id     :inputs&0x2000000
    property bool reverse:inputs&0x4000000
    property bool handbrake :inputs&0x8000000
    property bool tc_off     :inputs&0x10000000
    property bool left_joystick :inputs&0x20000000 || root.udp_left
    property bool right_joystick:inputs&0x40000000 || root.udp_right

    onUp_joystickChanged: console.log("up")
    onDown_joystickChanged: console.log("down")
    onLeft_joystickChanged: console.log("left")
    onRight_joystickChanged: console.log("right")

  property bool movedown:left_joystick //p1_11//if((lamps&0x01)==0x01)true;else false   //left indicator

  property bool moveup:right_joystick// p1_12//if((lamps&0x02)==0x02)true;else false        //right indicator


  property bool increament:up_joystick//p1_9||p2_20

  property bool decreament:down_joystick
    x: 0//p1_18||p2_19



    onMovedownChanged: if(movedown&&settings_on_off)currentindex.position-=1
    onMoveupChanged: if(moveup&&settings_on_off)currentindex.position+=1

  //  onMovedownChanged:{ if(!movedown)savetimer.start();else savetimer.stop;settings_on_off=true}
  //  onMoveupChanged:{if(!moveup)savetimer.start();else savetimer.stop;settings_on_off=false}



    Timer{
        id:redtimer
        interval: 100
        onTriggered:{if(increament){ root.red+=1;if(root.red>255)root.red=0;}
            else if(decreament){root.red-=1;if(root.red<0)root.red=255}
           }

        repeat: true
    }
    Timer{
        id:greentimer
        interval: 100
        onTriggered: {if(increament){ root.green+=1;if(root.green>255)root.green=0;}
                      else if(decreament){root.green-=1;if(root.green<0)root.green=255}
                     }
        repeat: true
    }
    Timer{
        id:bluetimer
        interval: 100
        onTriggered: {if(increament){ root.blue+=1;if(root.blue>255)root.blue=0;}
            else if(decreament){root.blue-=1;if(root.blue<0)root.blue=255}
           }
        repeat: true
    }

    Timer{
        id:waterhightimer
        interval: 100
        onTriggered:{if(increament)root.waterhigh+=1
                else if(decreament)root.waterhigh-=1}
        repeat: true
    }
    Timer{
        id:waterlowtimer
        interval: 100
        onTriggered:{if(increament)root.waterlow+=1
            else if(decreament)root.waterlow-=1
                    if(root.waterlow<0)root.waterlow=0 }
        repeat: true
    }


    Timer{
        id:fuelhightimer
        interval: 100
        onTriggered:{if(increament)root.fuelhigh+=1
            else if(decreament)root.fuelhigh-=1}
        repeat: true
    }
    Timer{
        id:fuellowtimer
        interval: 100
        onTriggered:{if(increament)root.fuellow+=1
            else if(decreament)root.fuellow-=1}
        repeat: true
    }

    Timer{
        id:oiltemphightimer
        interval: 100
        onTriggered: {if(increament)root.oiltemphigh+=1
            else if(decreament)root.oiltemphigh-=1
              if(root.oiltemphigh<0)root.oiltemphigh =0 }
        repeat: true
    }
    Timer{
        id:oiltemplowtimer
        interval: 100
        onTriggered:{if(increament)root.oiltemplow+=1
            else if(decreament)root.oiltemplow-=1}
        repeat: true
    }

    Timer{
        id:oilpressurehightimer
        interval: 100
        onTriggered: {if(increament)root.oilpressurehigh+=1
            else if(decreament)root.oilpressurehigh-=1}
        repeat: true
    }
    Timer{
        id:oilpressurelowtimer
        interval: 100
        onTriggered: {if(increament)root.oilpressurelow+=1
            else if(decreament)root.oilpressurelow-=1
                if(root.oilpressurelow<0)root.oilpressurelow=0  }
        repeat: true
    }
    Timer{
        id:batterylowtimer
        interval: 100
        onTriggered: {if(increament)root.batterylow+=0.1
            else if(decreament)root.batterylow-=0.1
              if(root.batterylow<0)root.batterylow=0 }
        repeat: true
    }
    Timer{
        id:batteryhightimer
        interval: 100
        onTriggered: {if(increament)root.batteryhigh+=0.1
            else if(decreament)root.batteryhigh-=0.1}
        repeat: true
    }
    Timer{
        id:afrlowtimer
        interval: 100
        onTriggered: {if(increament)root.afrlow+=0.1
            else if(decreament)root.afrlow-=0.1
        if(root.afrlow<0)root.afrlow=0}
        repeat: true
    }
    Timer{
        id:afrhightimer
        interval: 100
        onTriggered: {if(increament)root.afrhigh+=0.1
            else if(decreament)root.afrhigh-=0.1
             }
        repeat: true
    }
    Timer{
        id:rpmlimittimer
        interval: 100
        onTriggered:{if(increament){root.rpmlimit+=100;if(root.rpmlimit>9000)root.rpmlimit=0 }
            else if(decreament){root.rpmlimit-=100;if(root.rpmlimit<0)root.rpmlimit=9000 }}
        repeat: true
    }
    Timer{
        id:shiftvaluetimer
        interval: 100
        onTriggered:{if(increament){root.shiftvalue+=100;if(root.shiftvalue>9000)root.shiftvalue=0 }
            else if(decreament){root.shiftvalue-=100;if(root.shiftvalue<0)root.shiftvalue=9000 }}
        repeat: true
    }
    Text{
         id:currentindex
         property real position:0
         x:0


         y: 0
         onPositionChanged:
                            {if(position>28)position=0;
                            else if(position<0)position=28;

                             }

          width: 40
         height: 36
         visible: false
         color: "#ff0000"
         text: "--->"
         font.pointSize: 23
          //font.family: sevensegfont.name


     }

    /////////////select button////
    onIncreamentChanged: if((increament)&&!settings_on_off&&!menu_on_off)settings_on_off=true

                               else if(increament&&!menu_on_off)
                               {
                                   if(currentindex.position===0){settings_on_off=false;save_settings()}//exit the sttings and save them to file

                                   else if(currentindex.position===1)redtimer.start()
                                   else if(currentindex.position===2)greentimer.start()
                                   else if(currentindex.position===3)bluetimer.start()
                                   else if(currentindex.position===3)bluetimer.start()

                                   else if(currentindex.position===4)waterhightimer.start()
                                   else if(currentindex.position===5)waterlowtimer.start()
                                   else if(currentindex.position===6){root.waterunits+=1;if(root.waterunits>1)root.waterunits=0}

                                   else if(currentindex.position===8)fuelhightimer.start()
                                   else if(currentindex.position===9)fuellowtimer.start()
                                 //  else if(currentindex.position===10){root.fueldamping+=1;if(root.fueldamping>15)root.fueldamping=15}

                                   else if(currentindex.position===12)oiltemphightimer.start()
                                   else if(currentindex.position===13)oiltemplowtimer.start()
                                   else if(currentindex.position===14){root.oiltempunits+=1;if(root.oiltempunits>1)root.oiltempunits=0}

                                   else if(currentindex.position===16)oilpressurehightimer.start()
                                   else if(currentindex.position===17)oilpressurelowtimer.start()
                                   else if(currentindex.position===18){root.oilpressureunits+=1;if(root.oilpressureunits>1)root.oilpressureunits=0}

                                   else if(currentindex.position===20)batteryhightimer.start()
                                   else if(currentindex.position===21)batterylowtimer.start()

                                   else if(currentindex.position===22){root.speedunits+=1;if(root.speedunits>2)root.speedunits=0}

                                   else if(currentindex.position===23)rpmlimittimer.start()
                                   else if(currentindex.position===24)shiftvaluetimer.start()

                                   else if(currentindex.position===25){root.night_time_hue+=0.05;if(root.night_time_hue>1)night_time_hue=1}

                                     else if(currentindex.position===26){root.rpmdamping+=1;if(root.rpmdamping>10)root.rpmdamping=0}

                                   else if(currentindex.position===27)afrhightimer.start()
                                   else if(currentindex.position===28)afrlowtimer.start()
                               }



                               else{redtimer.stop();greentimer.stop();bluetimer.stop();waterhightimer.stop();waterlowtimer.stop();
                                    fuelhightimer.stop();fuellowtimer.stop();oiltemphightimer.stop();oiltemplowtimer.stop();
                                     oilpressurehightimer.stop();oilpressurelowtimer.stop();rpmlimittimer.stop() ;shiftvaluetimer.stop()
                                                            ;batteryhightimer.stop();                batterylowtimer.stop();
                                                              afrlowtimer.stop(); afrhightimer.stop() }


    onDecreamentChanged: if(decreament&&settings_on_off)
                                        {
                                         if(currentindex.position===0){settings_on_off=false;save_settings()}//exit the sttings and save them to file
                                          else if(currentindex.position===1)redtimer.start()
                                          else if(currentindex.position===2)greentimer.start()
                                          else if(currentindex.position===3)bluetimer.start()
                                          else if(currentindex.position===3)bluetimer.start()

                                          else if(currentindex.position===4)waterhightimer.start()
                                          else if(currentindex.position===5)waterlowtimer.start()
                                          else if(currentindex.position===6){root.waterunits+=1;if(root.waterunits>1)root.waterunits=0}

                                          else if(currentindex.position===8)fuelhightimer.start()
                                          else if(currentindex.position===9)fuellowtimer.start()
                                         // else if(currentindex.position===10){root.fueldamping-=1;if(root.fueldamping<7)root.fueldamping=7}

                                          else if(currentindex.position===12)oiltemphightimer.start()
                                          else if(currentindex.position===13)oiltemplowtimer.start()
                                          else if(currentindex.position===14){root.oiltempunits+=1;if(root.oiltempunits>1)root.oiltempunits=0}

                                          else if(currentindex.position===16)oilpressurehightimer.start()
                                          else if(currentindex.position===17)oilpressurelowtimer.start()
                                          else if(currentindex.position===18){root.oilpressureunits+=1;if(root.oilpressureunits>1)root.oilpressureunits=0}




                                                else if(currentindex.position===20)batteryhightimer.start()
                                                  else if(currentindex.position===21)batterylowtimer.start()

                                           else if(currentindex.position===22){root.speedunits+=1;if(root.speedunits>2)root.speedunits=0}

                                         else if(currentindex.position===23)rpmlimittimer.start()
                                         else if(currentindex.position===24)shiftvaluetimer.start()

                                         else if(currentindex.position===25){root.night_time_hue-=0.05;if(root.night_time_hue<0.05)night_time_hue=0}

                                          else if(currentindex.position===26){root.rpmdamping-=1;if(root.rpmdamping<0)root.rpmdamping=10}

                                         else if(currentindex.position===27)afrhightimer.start()
                                         else if(currentindex.position===28)afrlowtimer.start()
                                        }

                                        else{redtimer.stop();greentimer.stop();bluetimer.stop();waterhightimer.stop();waterlowtimer.stop();
                                             fuelhightimer.stop();fuellowtimer.stop();oiltemphightimer.stop();oiltemplowtimer.stop();
                                              oilpressurehightimer.stop();oilpressurelowtimer.stop();rpmlimittimer.stop();shiftvaluetimer.stop();batteryhightimer.stop();
                                              batterylowtimer.stop();afrlowtimer.stop(); afrhightimer.stop()}

///////////////////////////////
////////////////////////////
///////////////////////////////
///////////////////////////////////
////////////////////////////////////
//////////////////////////////////

Evangelion{
        id: dial
        odometer:parent.odometer/10
        tripmeter:parent.tripmeter
        shiftvalue:parent.shiftvalue
        rpm:parent.rpm
        rpmlimit:parent.rpmlimit
        rpmdamping:parent.rpmdamping
        speed:parent.speed
        speedunits: parent.speedunits
        watertemp:parent.watertemp
        waterhigh:parent.waterhigh
        waterlow:parent.waterlow
        waterunits: parent.waterunits
        fuel:parent.fuel
        fuelhigh:parent.fuelhigh
        fuellow:parent.fuellow
        fuelunits: parent.fuelunits
      //  fueldamping:parent.fueldamping
        o2: parent.o2
        map: parent.map
        maf: parent.maf
        oilpressure: parent.oilpressure
        oilpressurehigh:parent.oilpressurehigh
        oilpressurelow:parent.oilpressurelow
        oilpressureunits: parent.oilpressureunits
        oiltemp: parent.oiltemp
        oiltemphigh:parent.oiltemphigh
        oiltemplow: parent.oiltemplow
        oiltempunits: parent.oiltempunits
        batteryvoltage: parent.batteryvoltage
        gearpos: parent.gearpos
        udp_message:parent.udp_message
        inputs: parent.inputs

        x:if(parent.settings_on_off) 80;else 0
        Behavior on x {NumberAnimation{duration: 500}}

        y:if(parent.settings_on_off) 50;else 0
        Behavior on y {NumberAnimation{duration: 500}}

        scale:if(parent.settings_on_off) 0.8;else 1.0

        Behavior on scale {NumberAnimation{duration: 500}}


      //  visible: false
        z: 0
        opacity: 1

        width: 800
        height: 480
        antialiasing: true
        clip: true

}

Rectangle {
    id: rectangle
    x: 0
    y: 0
    width: 800
    height: 480
    color: "#000000"
    z: -1
}



}
