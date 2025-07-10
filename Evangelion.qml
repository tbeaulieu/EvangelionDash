import QtQuick 2.3
import QtGraphicalEffects 1.0

import "images"                                                
                                                                                 
        //                                   --#############-                       
        //                               ###################                        
        //                              ###++++++++++++++#                          
        //                 #            ##+++++++++++++++######                     
        //               -###           ##+++++++++++++++++########                 
        //                 -##          ##++++++++++++++++++++++#####               
        //                   ##.       ###+++++++++++++++++++++++++###              
        //                     ##     ###+++++++++++++++++++++++++++###-            
        //                       #######+++++++++++++++++++++++++++#####            
        //                         ###++++++++++++++++++#############               
        //       ##+      .+### +-  ####++++++++++++++++#-  ######+                 
        //         ####      #    ### +###++++++++++++++###                         
        //         # ####    #    ###   ###+++++++++++++++######                    
        //         #  ####   #    ###   + ###+++++++++++++++++###                   
        //         #    #### #    #######  +###++++++++++++++++##                   
        //         #     #####    ###   #    ####+++++++++++++++##                  
        //         #       ###    ###      .#  ###+++++++++++++++#-                 
        //       .##--.     ##   .##########.    ###+++++++++++++##+                
        //                                         #++++++++++++++##                
        //                          .#########    ###+++++++++++++###               
        //                           ###    .###   #######+++++++++#.               
        //                           ###     ###    ### ###++++++++##               
        //                           ###    ###     .##-  ###++++++##               
        //                           ###  ###        ###- #####++++##               
        //                           ###   ####       ####   ###+++##               
        //      -                    ###    ####       ##      ###+##               
        //    +# #                 ########   ####.    .#        ####               
        //      ###                                               ###               
        //        ++                                                #               
        //         ###                                          .#.                 
        //          . ##                                      ##--#                 
        //            ###                                   .####                   
        //               ###                             .# #+                      
        //                  #####                    - ####+                        
        //                    # # +# # # #   .####-#+##                             
        //                        .# # # ######  -.                                 
                                                                                 
//Author note: Evangelion/Asuka/ETC are copyright of Studio KHARA/Gainax etc. Consider this dash "Fan Art"                                                

Item {
    /*#########################################################################
      #############################################################################
      Imported Values From GAWR inits
      #############################################################################
      #############################################################################
     */
    id: root

    ////////// IC7 LCD RESOLUTION ////////////////////////////////////////////
    width: 800
    height: 480
    
    z: 0
    
    property int myyposition: 0
    property int udp_message: rpmtest.udp_packetdata

    property bool udp_up: udp_message & 0x01
    property bool udp_down: udp_message & 0x02
    property bool udp_left: udp_message & 0x04
    property bool udp_right: udp_message & 0x08

    property int membank2_byte7: rpmtest.can203data[10]
    property int inputs: rpmtest.inputsdata

    //Inputs//31 max!!
    property bool ignition: inputs & 0x01
    property bool battery: inputs & 0x02
    property bool lapmarker: inputs & 0x04
    property bool rearfog: inputs & 0x08
    property bool mainbeam: inputs & 0x10
    property bool up_joystick: inputs & 0x20 || root.udp_up
    property bool leftindicator: inputs & 0x40
    property bool rightindicator: inputs & 0x80
    property bool brake: inputs & 0x100
    property bool oil: inputs & 0x200
    property bool seatbelt: inputs & 0x400
    property bool sidelight: inputs & 0x800
    property bool tripresetswitch: inputs & 0x1000
    property bool down_joystick: inputs & 0x2000 || root.udp_down
    property bool doorswitch: inputs & 0x4000
    property bool airbag: inputs & 0x8000
    property bool tc: inputs & 0x10000
    property bool abs: inputs & 0x20000
    property bool mil: inputs & 0x40000
    property bool shift1_id: inputs & 0x80000
    property bool shift2_id: inputs & 0x100000
    property bool shift3_id: inputs & 0x200000
    property bool service_id: inputs & 0x400000
    property bool race_id: inputs & 0x800000
    property bool sport_id: inputs & 0x1000000
    property bool cruise_id: inputs & 0x2000000
    property bool reverse: inputs & 0x4000000
    property bool handbrake: inputs & 0x8000000
    property bool tc_off: inputs & 0x10000000
    property bool left_joystick: inputs & 0x20000000 || root.udp_left
    property bool right_joystick: inputs & 0x40000000 || root.udp_right

    property int odometer: rpmtest.odometer0data/10*0.62 //Need to div by 10 to get 6 digits with leading 0
    property int tripmeter: rpmtest.tripmileage0data*0.62
    property real value: 0
    property real shiftvalue: 0

    property real rpm: rpmtest.rpmdata
    property real rpmlimit: 8000 
    property real rpmdamping: 5
    property real speed: rpmtest.speeddata
    property int speedunits: 2

    property real watertemp: rpmtest.watertempdata
    property real waterhigh: 0
    property real waterlow: 80
    property real waterunits: 1

    property real fuel: rpmtest.fueldata
    property real fuelhigh: 0
    property real fuellow: 0
    property real fuelunits
    property real fueldamping

    property real o2: rpmtest.o2data
    property real map: rpmtest.mapdata
    property real maf: rpmtest.mafdata

    property real oilpressure: rpmtest.oilpressuredata
    property real oilpressurehigh: 0
    property real oilpressurelow: 0
    property real oilpressureunits: 0

    property real oiltemp: rpmtest.oiltempdata
    property real oiltemphigh: 90
    property real oiltemplow: 90
    property real oiltempunits: 1
    property real oiltemppeak: 0

    property real batteryvoltage: rpmtest.batteryvoltagedata

    property int mph: (speed * 0.62)

    property int gearpos: rpmtest.geardata

    property real speed_spring: 1
    property real speed_damping: 1

    property real rpm_needle_spring: 3.0 //if(rpm<1000)0.6 ;else 3.0
    property real rpm_needle_damping: 0.2 //if(rpm<1000).15; else 0.2

    property bool changing_page: rpmtest.changing_pagedata


    property string white_color: "#FFFFFF"
    property string primary_color: "#FFFF00" //Strong Yellow
    property string lit_primary_color: "#F59713" //lit orange
    property string warning_color: "#FF1100" //Warning Red
    property string salmon_warning_color: "#FA6464"
    property string engine_warmup_color: "#eb7500"
    property string background_color: "#000000"
    property string display_grey: "#313331"
    property string digital_gauge_grey: "#282028"

    property string mainline_orange: "#EF5622"
    property string high_rev_red: "#DE2526"
    property string sidelight_yellow: "#E6A523"
    property string tick_green: "#70BF44"
    
    property int timer_time: 1

    //Peak Values

    property int peak_rpm: 0
    property int peak_speed: 0
    property int peak_water: 0
    property int peak_oil: 0
    property bool car_movement: false
    x: 0
    y: 0

    FontLoader {
        id: evangelionDigital
        source: "./fonts/EvangelionDigital.ttf"
    }


    //Master Function/Timer for Peak values
    function checkPeaks(){
        if(root.rpm > root.peak_rpm){
            root.peak_rpm = root.rpm
        }
        if(root.speed > root.peak_speed){
            root.peak_speed = root.speed
        }
        if(root.watertemp > root.peak_water){
            root.peak_water = root.watertemp
        }
        if(root.oiltemp > root.peak_oil){
            root.peak_oil = root.oiltemp
        }
        if(root.speed > 10 && !root.car_movement){
            root.car_movement = true
        }
    }
   
    //Utilities  

    function delay(delayTime, cb) {
        timer.interval = delayTime;
        timer.repeat = false;
        timer.triggered.connect(cb);
        timer.start();
    }

    function easyFtemp(degreesC){
        return ((((degreesC.toFixed(0))*9)/5)+32).toFixed(0)
    }
    
    function getPeakSpeed(){
        if (root.speedunits === 0) return root.peak_speed.toFixed(0); else return (root.peak_speed*.62).toFixed(0)
    }

    function getTemp(fluid){
        if(fluid == "COOLANT"){
            if(root.seatbelt && root.car_movement && root.speed === 0){ 
                 if(root.waterunits !== 1)
                    return easyFtemp(root.peak_water) + "F"
                else 
                    return root.peak_water.toFixed(0) + "C"
            }
            else{
                if(root.waterunits !== 1)
                    return easyFtemp(root.watertemp) + "F"
                else 
                    return root.watertemp.toFixed(0) + "C"
            }
        }
        else{
            if(root.seatbelt && root.car_movement && root.speed === 0){
                 if(root.oiltempunits !== 1)
                    return easyFtemp(root.peak_oil) + "F"
                else 
                    return root.peak_oil.toFixed(0) + "C"
            }
            else{
                if(root.oiltempunits !== 1)
                    return easyFtemp(root.oiltemp) + "F"
                else 
                    return root.oiltemp.toFixed(0) + "C"
            }
        }
    }
    function padStart(str, targetLength, padString) {
        while (str.length < targetLength) {
            str = padString + str;
        }
        return str;
    }
    function getGear(){
        switch(rpmtest.geardata){
            case 0:
                return 252
            case 1:
                return 302
            case 2:
                return 352
            case 3:
                return 402
            case 4:
                return 452
            case 5:
                return 502
            case 6:
                return 552
            case 10:
                return 202
            default:
                return 252
        }
    }

    function getAsukaFace(){
        if(root.rpm < 4000){
            return "./images/asuka/start.png"
        }
        if(root.rpm < 6000 && root.rpm >= 4000){
            return "./images/asuka/4000.png"
        }
        if(root.rpm < 7000 && root.rpm >= 6000){
            return "./images/asuka/6000.png"
        }
        if(root.rpm < 7500 && root.rpm >= 7000){
            return "./images/asuka/7000.png"
        }
        if(root.rpm >= 7500){
            return "./images/asuka/7500.png"
        }
    }

    function giveRevDirectoryColor(){
        if(root.rpm >= root.rpmlimit){
            return "red"
        }
        else if (root.sidelight){
            return "yellow"
        }
        else{
            return "orange"
        }
    }
    function giveRevHexColor(){
        if(root.rpm >= root.rpmlimit){
            return root.high_rev_red
        }
        else if (root.sidelight){
            return root.sidelight_yellow
        }
        else{
            return root.mainline_orange
        }
    }

    //Master Timer 
    Timer{
        interval: 2; running: true; repeat: true //Maybe we need to change interval time depending on potential lag, shouldn"t be that much though
        onTriggered: {checkPeaks()
                    if(root.rpm === 0 && root.car_movement===false){
                        asukaTimer.start()
                    }
                    if((root.rpm > 3900 && root.rpm < 4100) || (root.rpm > 5900 && root.rpm < 6100) || (root.rpm > 6950 && root.rpm < 7100) || (root.rpm > 7150 && root.rpm < 7600)){
                        asukaTimer.start()
                    }
            }
    }

    /* ########################################################################## */
    /* Main Layout items */
    /* ########################################################################## */
    Rectangle {
        id: background_rect
        x: 0
        y: 0
        width: 800
        height: 480
        color: root.background_color
        border.width: 0
        z: 0
    }
    Image{
        id: gradientbkg
        x:0;y:0;z:1
        source: "./images/gradient.png"
        NumberAnimation{target: gradientbkg; property: "opacity"; from: 0.00; to: 1.00; duration: 2000; running: true}
    }
    
    //Top + Left Borders
        Item{
            z: 2
            Rectangle{
                x: 0; y:0
                width: 800
                height: 16
                color: "#000000"
                clip: true
                Row{
                    x:43;y:5
                    Repeater{
                        property int index
                        NumberAnimation on model { to: 8; duration: 3000}
                        Row{
                            Rectangle{
                                width: 2; height: 6
                                color: root.tick_green
                            }
                            Rectangle{
                                width:10;height: 1
                                color: "#000000"
                            }
                            Rectangle{
                                width: 2; height: 6
                                color: root.tick_green
                            }
                            Rectangle{
                                width:86;height: 1
                                color: "#000000"
                            }
                        }
                    }
                }
            }
            Row{
                x:49;y:21
                Repeater{
                    property int index
                    NumberAnimation on model {to: 8; duration: 3000}
                    Row{
                        Rectangle{
                            width: 2; height: 10
                            color: "#000000"
                        }
                        Rectangle{
                            width: 98; height:10
                            opacity:0
                        }
                    }
                }
            }
            Row{
                x:7;y:49;z:2
                transform: Rotation{
                    angle:90
                }

                Repeater{
                    NumberAnimation on model { to: 8; duration: 3000 }
                    Row{
                        Rectangle{
                            width: 2; height: 6
                            color: root.tick_green
                        }
                        Rectangle{
                            width: 49; height:6
                            opacity:0
                        }
                    }
                }
            }
            Row{
                x:32;y:49
                transform: Rotation{
                    angle:90
                }
                Repeater{
                    NumberAnimation on model { to: 8; duration: 3000 }
                    Row{
                        Rectangle{
                            width: 2; height: 10
                            color: "#000000"
                        }
                        Rectangle{
                            width: 49; height:10
                            opacity:0
                        }
                    }
                }
            }
            Rectangle{
                x: 0; y:0
                width: 11
                height: 480
                color: "#000000"
            }
            Rectangle{
                x: 14; y:0
                width: 4
                height: 480
                color: "#000000"
            }
        }
    Image{ 
        x:18;y:143;z:2
        source: "./images/bottom_left_angle.png"
    }

    Image{
        x:108;y:394;z:2
        source: "./images/bottom_frame.png"
    }
    Rectangle{
        x:600;y:338;z:2
        height: 72;width: 190
        color: "#000000"
    }
    Row{
        x: 198;y:402;z:5
        width: 390
        Repeater{
            NumberAnimation on model { to: 8; duration: 900 }
            Row{
                Rectangle{
                    color: "#FFFFFF"
                    height: 4;width: 2
                }
                Rectangle{
                    color: "#00000000"
                    height: 4;width: 38
                }
                Rectangle{
                    color: "#FFFFFF"
                    height: 4;width: 2
                }
                Rectangle{
                    color: "#00000000"
                    height: 4;width: 8
                }
            }
        }
    }

    Image{
        x:103;y:40;z:2
        source: "./images/"+giveRevDirectoryColor()+"/main_container.png"
    }
    Image{
        x: 113;y:47;z:3
        source: "./images/"+giveRevDirectoryColor()+"/revolutions.png"
    }
    //More Tics
        //Top
        Item{
            z:5
            Row{
                x:299;y:57
                Repeater{
                    model: 4
                    Row{
                        Rectangle{
                            height:4;width:2;
                            color: "#000000"
                        }
                        Rectangle{
                            height:4;width:98
                            opacity:0
                        }
                    }
                }
                Rectangle{
                            height:4;width:2;
                            color: "#000000"
                        }
            }
        }
        Image{
            x: 98;y:34;z:2
            source: "./images/top_left_trim.png"
        }

    //Shift Alert
        Item{
            id: shiftAlert
            z:9999
            visible: root.rpm >= root.rpmlimit
            Image{
                id: shiftImage
                x:0;y:140;
                source: "./images/shift_alert.png"
            }
            Item{
                z:99
                Rectangle{
                    x:281;y:184
                    width: 237;height:108
                    color: "#E22725"
                }
                Timer{
                    id: shiftAnimate
                        running: root.rpm >= root.rpmlimit
                        interval: 50
                        repeat: true
                        onTriggered: if(parent.opacity === 0){
                            parent.opacity = 100
                        }
                        else{
                            parent.opacity = 0
                        } 
                }
            }
        }
    //Face Fly-In
    Item{
        z: 999
        Rectangle{
            id: asukaFlyIn
            x: -180; y:324;
            height:145;width:145
            state: "CLOSED"
            opacity: 0
            clip: true
            Image{
                source: getAsukaFace()
            }
            Timer{
                id: asukaTimer
                property int initialDelay: 5000 
                property int currentDelay: initialDelay
                property bool waitForIt: false
                running: false
                onTriggered:{
                    if(asukaFlyIn.state==="CLOSED" && !waitForIt){
                        asukaFlyIn.state="OPEN"; 
                        delay(5000, function(){
                            asukaFlyIn.state="CLOSED"
                            waitForIt=true
                            delay(2000, function(){
                                waitForIt=false
                            })
                        })
                    }
                }
            }
            states: [
                State{
                    name: "OPEN"
                    PropertyChanges{target: asukaFlyIn; x:35; height: 145; opacity:1}
                },
                State{
                    name: "CLOSED"
                    PropertyChanges{target: asukaFlyIn; x:-180; height: 0; opacity:0}
                }
            ]
            transitions: Transition {
                NumberAnimation { properties: "x,opacity,height"; easing.type: Easing.InOutQuad }
                }
            }
        }
    
    //Rev Information
        Item{
            z: 3
            Row{
                x:182;y:80
                Repeater{
                    NumberAnimation on model { to: 11; duration: 2000 }
                    Row{
                        Rectangle{
                            width: 2; height: 8
                            color: "#FFFFFF"
                        }
                        Rectangle{
                            width: 38; height: 8
                            opacity: 0
                        }
                    }
                }
            }
            Rectangle{
                id: revbars
                x:184;y:90
                height: 100
                width: Math.floor(root.rpm * .005) * 8 
                clip: true
                color: "#000000"
                SequentialAnimation{
                    running: root.rpm === 0 && root.car_movement === false
                    NumberAnimation{target: revbars; property: "width"; to: 400; duration: 500; easing.type: Easing.inCubic}
                    NumberAnimation{target: revbars; property: "width"; to: 0; duration: 1500; easing.type: Easing.inQuad}
                }
                Image{
                    source: "./images/rpm_bar.png"
                }
            }
            Image{
                x:182;y:192
                source: "./images/rpm_markers_bottom.png"
            }
        }
    //Speed Information
        Item{
            z: 3
            Image{
                id:speedLabel
                x:184; y:246
                opacity: 0
                source: if(root.speedunits===0)
                    "./images/"+giveRevDirectoryColor()+"/velocity_km.png" 
                    else 
                        "./images/"+giveRevDirectoryColor()+"/velocity_mi.png"
                Timer{
                    repeat: false;
                    running: true;
                    interval: 1000
                    onTriggered: fadeSpeedLabel.start()
                }
                NumberAnimation{
                    id:fadeSpeedLabel;
                    running: false;
                    target: speedLabel
                    property: "opacity"
                    to: 1.0;
                    duration: 500
                }
            }
            Text{
                id: speedonum
                x: 346; y:241
                width: 149
                color: giveRevHexColor()
                font.family: evangelionDigital.name
                font.pixelSize: 116
                text: if (root.speedunits === 0) {
                    padStart(root.speed.toFixed(0),3,"0")
                } else {
                    padStart(root.mph.toFixed(0),3,"0")
                }
                horizontalAlignment: Text.AlignRight
            }
            Image{
                x:500;y:239
                source: "./images/speed_green.png"
            }
        }
    //Third Column
        //Green Tic Marks
            //top
            Rectangle{
                x: 599; y:84; z:3
                width: 2;height: 4;
                color: root.tick_green
            }
            Rectangle{
                x: 779; y:84; z:3
                width: 2; height: 4;
                color: root.tick_green
            }

            //split
            Rectangle{
                x: 599; y:213; z:3
                width: 2;height: 4;
                color: root.tick_green
            }
            Rectangle{
                x: 779; y:213; z:3
                width: 2; height: 4;
                color: root.tick_green
            }

            //split
            Rectangle{
                x: 599; y:263;z:3
                width: 2;height: 4;
                color: root.tick_green
            }
            Rectangle{
                x: 779; y:263; z:3
                width: 2; height: 4;
                color: root.tick_green
            }

            //bottom
            Rectangle{
                x: 599; y:330;z:3
                width: 2;height: 4;
                color: root.tick_green
            }
            Rectangle{
                x: 779; y:330; z:3
                width: 2; height: 4;
                color: root.tick_green
            }
            Rectangle{
                x: 159;y: 346;z:3
                width: 2; height: 4
                color: "#000000"
            }
            Rectangle{
                x: 172;y: 346;z:3
                width: 2; height: 4
                color: "#000000"
            }
            
        Image{
            id: zzlabel
            x:599;y:88;z:2
            source: "./images/"+giveRevDirectoryColor()+"/2zzge.png"
            opacity: 0
            NumberAnimation{
                running: true;
                target: zzlabel
                property: "opacity"
                to: 1.0;
                duration: 500
            }
        }
        Image{
            id: enginetype
            x:599;y:218;z:2
            //change this to supercharged.png if you have a supercharger 
            source: "./images/"+giveRevDirectoryColor()+"/naturallyaspirated.png" 
            opacity: 0
            Timer{
                repeat: false;
                running: true;
                interval: 500
                onTriggered: fadeEngineType.start()
            }
            NumberAnimation{
                id:fadeEngineType;
                running: false;
                target: enginetype
                property: "opacity"
                to: 1.0;
                duration: 500
            }
        }


        //Water and Oil Temps
            Item{
                z:2
                id: waterandoil
                Image{
                    id: waterandoillabel
                    x:599;y:268;
                    source: "./images/"+giveRevDirectoryColor()+"/wateroil.png"
                    opacity: 0
                     Timer{
                        repeat: false;
                        running: true;
                        interval: 1000
                        onTriggered: fadeoilwaterin.start()
                    }
                    NumberAnimation{
                        id:fadeoilwaterin;
                        running: false;
                        target: waterandoillabel
                        property: "opacity"
                        to: 1.0;
                        duration: 500
                    }
                }
                Text{
                    text: getTemp("COOLANT")
                    font.family: evangelionDigital.name
                    font.pixelSize: 26
                    x:734;y:274;
                    width: 39;height:21.6
                    color: giveRevHexColor()
                    horizontalAlignment: Text.AlignRight
                }
                Text{
                    text: getTemp("OIL")
                    font.family: evangelionDigital.name
                    font.pixelSize: 26
                    x:734;y:301;
                    width: 39;height:21.6
                    color: giveRevHexColor()
                    horizontalAlignment: Text.AlignRight
                }
            }
        
        //Oil Pressure
            Item{
                z:2
                visible: root.oilpressurelow > 0
                Image{
                    id: oilPressureLabel
                    x:605;y:345;
                    source: if(root.oilpressureunits !== 1) "./images/"+giveRevDirectoryColor()+"/oilpressurepsi.png";else "./images/"+giveRevDirectoryColor()+"/oilpressurebar.png"
                    opacity: 0
                    Timer{
                        repeat: false;
                        running: true;
                        interval: 1500
                        onTriggered: fadeOilPressure.start()
                    }
                    NumberAnimation{
                        id:fadeOilPressure;
                        running: false;
                        target: oilPressureLabel
                        property: "opacity"
                        to: 1.0;
                        duration: 500
                    }
                }
                Text{
                    text: if(root.oilpressureunits === 1) root.oilpressure.toFixed(1); else (root.oilpressure.toFixed(1) * 14.504).toFixed(0)
                    font.family: evangelionDigital.name
                    font.pixelSize: 40
                    x:682;y:370
                    width: 58
                    color: giveRevHexColor()
                    horizontalAlignment: Text.AlignRight

                }
                Rectangle{
                    x:747;y:347;
                    height: 7;width: 2
                    color: giveRevHexColor()
                }
                Rectangle{
                    x:753;y:347;
                    height: 7;width: 2
                    color: giveRevHexColor()
                }
            }
        //Mileage
            Item{
                z:2
                Image{
                    id: mileagelabel
                    x:600;y:420
                    source: "./images/"+giveRevDirectoryColor()+"/mileage.png"
                    opacity: 0
                    Timer{
                        repeat: false;
                        running: true;
                        interval: 2000
                        onTriggered: fademileagein.start()
                    }
                    NumberAnimation{
                        id:fademileagein;
                        running: false;
                        target: mileagelabel
                        property: "opacity"
                        to: 1.0;
                        duration: 500
                    }
                }
                Text{
                    text: if (root.speedunits === 0)
                        padStart((root.odometer/.62).toFixed(0), 6, "0")
                    else 
                        padStart(root.odometer, 6, "0")
                    font.family: evangelionDigital.name
                    font.pixelSize: 22
                    x:715;y:425
                    width: 58
                    color: giveRevHexColor()
                    horizontalAlignment: Text.AlignRight

                }
            }

        
    //Fuel System
        Item{
            z: 2
            Image{
                id: fuelLabel
                x:250; y:422
                source: "./images/"+giveRevDirectoryColor()+"/fuelsystem.png"
                opacity: 0
            }
            Timer{
                repeat: false;
                running: true;
                interval: 2000
                onTriggered: fadeFuelLabel.start()
            }
            NumberAnimation{
                id:fadeFuelLabel;
                running: false;
                target: fuelLabel
                property: "opacity"
                to: 1.0;
                duration: 500
            }
            Rectangle{
                x: 362; y: 428
                width: 180; height: 2
                color: root.mainline_orange
            }
            Row{
                x: 340; y:421; z: 2
                Repeater{
                    model: 10
                    property int index
                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: index*20
                        Image{
                            source: if (Math.floor(root.fuel / 10) > index) "./images/greendiagonal.png";else "./images/reddiagonal.png"
                            
                        }
                    }
                }
            }
        }
    //Shift Boxes
        Item{
            z: 2
            Rectangle{
                clip: true;
                x:198;y:350;
                height:43;width:0;
                color: "#00000000"
                Image{
                    id: shiftBoxImage
                    source: "./images/"+giveRevDirectoryColor()+"/shift_boxes.png"
                    z:1
                }
                Timer{
                        repeat: true;
                        running: parent.width<400
                        interval: 100
                        onTriggered: parent.width = parent.width + 50
                    }
            }
             Rectangle{
                    color: if(!root.sidelight) "#E02825"; else "#EF5965"        
                    x: getGear(); y:376; z:999
                    height: 10; width: 34;
                }
        }
    //Idiot Lights
    Image{
        visible: root.oil && root.rpm > 0
        x:0; y:140; z: 999
        source: "./images/oilpressurelow.png"
    }
    Image{
            x:118; y: 208.4; z: 2
            source: "./images/brights.png"
            visible: root.mainbeam
        }
    Image{
            x:118; y: 240; z: 2
            source: "./images/abs.png"
            visible: root.abs
        }
        
    Image{
            x:90; y: 291
            z: 2
            source: "./images/airbag.png"
            visible: root.airbag
        }
    Image{
            x: 90; y: 224.5; z: 2
            source: "./images/blinkers.png"
            visible: root.leftindicator || root.rightindicator
        }
    Image{
            x:64.7; y: 312
            z: 2
            source: "./images/battery.png"
            visible: root.battery
        }
    Image{
            x: 500; y: 253.5; z: 2
            source: "./images/"+giveRevDirectoryColor()+"/handbrake.png"
            visible: root.brake
        }
    Image{
            x: 90; y: 258; z: 2
            source: "./images/seatbelt.png"
            visible: root.seatbelt
        }
    
    Image{
            x:118; y: 273; z: 2
            source: "./images/cel.png"
            visible: root.mil
        }
    

} //End Evangelion Item



