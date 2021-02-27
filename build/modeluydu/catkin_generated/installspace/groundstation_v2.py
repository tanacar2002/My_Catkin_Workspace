#!/usr/bin/env python2
# coding=utf-8
import os
import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
import matplotlib.backends.backend_agg as agg
import time
from datetime import datetime
import cv2
import pygame
import serial
import serial.tools.list_ports
import threading
import csv
import urllib.error
import urllib.request
from classes.tangui import *
from classes.urlsigner import *
from classes.ObjLoader import ObjLoader
from classes.TextureLoader import load_texture,load_texture_pygame
import struct
from OpenGL.GL import *
from OpenGL.GLU import *
from OpenGL.GL.shaders import compileProgram, compileShader
import pyrr
import pdb
from tkinter import Tk
from tkinter.filedialog import askopenfilename
Tk().withdraw()

model_path = "assets/cube.obj"
texture_path = "assets/cube.jpg"
pos_vec = [8.7, 3.5, -9]

SECRET = "XgdCs5ynA2_YpMSImwo9mCKMPk0="
GOOGLE_API_KEY = "AIzaSyACej-uNjJkY2q9Z7eIsoeth698h_ivoz4"
GMAP_BASE_URL = "https://maps.googleapis.com/maps/api/staticmap"
telemetrystruct = "<HHBBHBBBHHhHBffhBbbbBB"

############## Background Texture ######################
# positions        colors               texture coords
rectangle = [-1.0, -1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0,
             1.0, -1.0, 0.0, 0.0, 1.0, 0.0, 1.0, 0.0,
             1.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0,
             -1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0]

# convert to 32bit float

rectangle = np.array(rectangle, dtype=np.float32)

indicesBackground = [0, 1, 2,
                     2, 3, 0]

indicesBackground = np.array(indicesBackground, dtype=np.uint32)

VERTEX_SHADER = """

       #version 330

       in vec3 position;
       in vec3 color;
       in vec2 InTexCoords;

       out vec3 newColor;
       out vec2 OutTexCoords;

       void main() {

        gl_Position = vec4(position, 1.0);
        gl_Position.z = gl_Position.w;
        newColor = color;
        OutTexCoords = InTexCoords;

         }


   """

FRAGMENT_SHADER = """
    #version 330

     in vec3 newColor;
     in vec2 OutTexCoords;

     out vec4 outColor;
     uniform sampler2D samplerTex;

    void main() {

       outColor = texture(samplerTex, OutTexCoords);

    }

"""

vertex_src = """
    # version 330

    layout(location = 0) in vec3 a_position;
    layout(location = 1) in vec2 a_texture;
    layout(location = 2) in vec3 a_normal;

    uniform mat4 model;
    uniform mat4 projection;
    uniform mat4 view;

    out vec2 v_texture;

    void main()
    {
        gl_Position = projection * view * model * vec4(a_position, 1.0);
        v_texture = a_texture;
    }
    """

fragment_src = """
    # version 330

    in vec2 v_texture;

    out vec4 out_color;

    uniform sampler2D s_texture;

    void main()
    {
        out_color = texture(s_texture, v_texture);
    }
    """

mpl.use("Agg")
mpl.rcParams["text.color"] = 'white'
mpl.rcParams['axes.labelcolor'] = 'white'
mpl.rcParams['xtick.color'] = 'white'
mpl.rcParams['ytick.color'] = 'white'

pygame.init()
pygame.font.init()

p = 1080
resolution = (16*p//9,p)

background1 = cv2.imread("assets/1.png")
background1 = cv2.cvtColor(background1,cv2.COLOR_BGR2RGB)
background1 = cv2.resize(background1,resolution)
background2 = cv2.imread("assets/2.png")
background2 = cv2.cvtColor(background2,cv2.COLOR_BGR2RGB)
background2 = cv2.resize(background2,resolution)

texts = []
buttons = []
selectors = []
progressbars = []
port = None
cmd_send_state = True
cmd_send = []

VIDEO_BUFFER_SIZE = 64                  # MAX: 80, limited by the AltSerialLib RX_BUFFER_SIZE
TELEMETRY_DATA_BYTE = bytes([0b00010011])
ACTIVATE_VIDEO_TRANSMISSION_CMD = bytes([0b00000001])
DEACTIVATE_VIDEO_TRANSMISSON_CMD = bytes([0b00000010])
ACTIVATE_EJECTION_CMD = bytes([0b00000100])
ACTIVATE_RESET_CMD = bytes([0b00001000])
VIDEO_TRANSMISSION_CMPLTD = bytes([0b00100000])      # To ACK Ground Station (State Change @ GS)

#Create the graphs
fig, ax = plt.subplots(3,2,figsize=(resolution[0]*(5.5/1920),resolution[1]*(5.5/1080)));
ax[0,0].set_title("Pressure (Pa)")
ax[0,1].set_title("Altitude (m)")
ax[1,0].set_title("Downward Speed ($m/s^2$)")
ax[1,1].set_title("Temperature (C degrees)")
ax[2,0].set_title("Battery Voltage (V)")
ax[2,1].set_title("Revolutions Around Z Axis")
for a in ax.flatten():
    a.set_xlabel("Mission Time(s)",color='w')
    a.patch.set_facecolor('gray')
    a.patch.set_alpha(0.2)
    a.grid(True,c="gray")
plt.subplots_adjust(hspace=1)
fig.suptitle("Graphs", fontsize=int(resolution[1]*(14/1080)))
fig.patch.set_alpha(0)
canvas = agg.FigureCanvasAgg(fig)
plot_data = {"packageCounter":[],"pressure":[],"altitude":[],"speed":[],"temperature":[],"batteryVoltage":[],"revolution":[]}
plot_length = 20
main = False
mapsize = int(resolution[1]*(400/1080))

units = ["","","","","","","","","Pa","m","cm/s","C degrees","V","degrees","degrees","m","","degrees","degrees","degrees","",""]

telemetry = {"teamNumber":0,"packageCounter":0,"day":0,"month":0,"year":0,"hour":0,"minute":0,"second":0,"pressure":0,"altitude":0,"speed":0,"temperature":0,
            "batteryVoltage":0,"GPS_Latitude":0,"GPS_Longitude":0,"GPS_Altitude":0,
            "status":0,"pitch":0,"roll":0,"yaw":0,"revolution":0,"videoTransmission":0}

if not os.path.exists('Data'):
    os.makedirs("Data")
now = datetime.now().strftime("%Y_%m_%d_%H_%M_%S")
datapath = 'Data/Tele_' + now + '.csv'
videopath = 'Data/SampleVideo_1280x720_1mb.mp4'

def getvideobytes(path):
    vbytes =[]
    with open(path,'rb') as f:
        b = f.read(1)
        while b:
            vbytes.append(b)
            b = f.read(1)
        print("Size of the video file is %d bytes" % len(vbytes))
    return vbytes

f = open(datapath,'w+',newline='')
writer = csv.DictWriter(f,fieldnames=[key for key in telemetry])
writer.writeheader()

def convert8bitu(data):
    return (data & 0b01111111)-(data>>7)*128

def convert16bitu(data):
    return (data & 0x7fff)-(data>>15)*(2**15)

def convert32bitu(data):
    return (data & 0x7fffffff)-(data>>31)*(2**31)

def convert32bitf(data):
    exp = ((data >> 23)&0x0ff)-127 #k-excess
    mantissa = (data & 0x007fffff)/(2**23) + (0 if exp == -127 else 1)
    sign = -1 if (data >> 31) else 1
    exp = -126 if exp == -127 else exp
    if exp == 128 :
        if mantissa == 1:
            return sign*float('inf')
        else:
            return float('nan')
    return sign*mantissa*(2**exp)

def rotate_image(image, angle):
  image_center = tuple(np.array(image.shape[1::-1]) / 2)
  rot_mat = cv2.getRotationMatrix2D(image_center, angle, 1.0)
  result = cv2.warpAffine(image, rot_mat, image.shape[1::-1], flags=cv2.INTER_LINEAR,borderValue=(0,0,0,0))
  return result

def plot():
    for a in ax.flatten():
        a.set_xlim(plot_data["packageCounter"][0],plot_data["packageCounter"][-1])
    ax[0,0].plot(plot_data["packageCounter"],plot_data["pressure"],'b')
    ax[0,1].plot(plot_data["packageCounter"],plot_data["altitude"],'g')
    ax[1,0].plot(plot_data["packageCounter"],plot_data["speed"],'b')
    ax[1,1].plot(plot_data["packageCounter"],plot_data["temperature"],'g')
    ax[2,0].plot(plot_data["packageCounter"],plot_data["batteryVoltage"],'b')
    ax[2,1].plot(plot_data["packageCounter"],plot_data["revolution"],'g')

def plotsurf():
    canvas.draw()
    renderer = canvas.get_renderer()
    raw_data = bytes(canvas.buffer_rgba()[:])
    size = canvas.get_width_height()
    return pygame.image.fromstring(raw_data, size, "RGBA")

def openglinit():
    global VAO,VBO,EBO,textures,model_loc,obj_indices,obj_pos,shader,shaderBackground,backgroundVAO,texture,pos_vec
    #Load 3D object for simulation
    obj_indices, obj_buffer = ObjLoader.load_model(model_path)
    #Set GL shaders
    shader = compileProgram(compileShader(vertex_src, GL_VERTEX_SHADER),compileShader(fragment_src, GL_FRAGMENT_SHADER))
    shaderBackground = compileProgram(compileShader(VERTEX_SHADER, GL_VERTEX_SHADER), compileShader(FRAGMENT_SHADER, GL_FRAGMENT_SHADER))

    # VAO and VBO
    VAO = glGenVertexArrays(1)
    VBO = glGenBuffers(2)
    EBO = glGenBuffers(1)

    # obj VAO
    glBindVertexArray(VAO)
    # obj Vertex Buffer Object
    glBindBuffer(GL_ARRAY_BUFFER, VBO[0])
    glBufferData(GL_ARRAY_BUFFER, obj_buffer.nbytes, obj_buffer, GL_STATIC_DRAW)

    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO)
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, obj_indices.nbytes, obj_indices, GL_STATIC_DRAW)

    # obj vertices
    glEnableVertexAttribArray(0)
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, obj_buffer.itemsize * 8, ctypes.c_void_p(0))
    # obj textures
    glEnableVertexAttribArray(1)
    glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, obj_buffer.itemsize * 8, ctypes.c_void_p(12))
    # obj normals
    glVertexAttribPointer(2, 3, GL_FLOAT, GL_FALSE, obj_buffer.itemsize * 8, ctypes.c_void_p(20))
    glEnableVertexAttribArray(2)

    ############### Background Texture #################################
    backgroundVAO = glGenVertexArrays(1)
    glBindVertexArray(backgroundVAO)

    # Bind the buffer
    glBindBuffer(GL_ARRAY_BUFFER, VBO[1])
    glBufferData(GL_ARRAY_BUFFER, 128, rectangle, GL_STATIC_DRAW)

    # Create EBO
    EBO = glGenBuffers(1)
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO)
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, indicesBackground, GL_STATIC_DRAW)

    # get the position from  shader
    position = glGetAttribLocation(shaderBackground, 'position')
    glVertexAttribPointer(position, 3, GL_FLOAT, GL_FALSE, 32, ctypes.c_void_p(0))
    glEnableVertexAttribArray(position)

    # get the color from  shader
    color = glGetAttribLocation(shaderBackground, 'color')
    #glVertexAttribPointer(color, 3, GL_FLOAT, GL_FALSE, 32, ctypes.c_void_p(12))
    #glEnableVertexAttribArray(color)

    texCoords = glGetAttribLocation(shaderBackground, "InTexCoords")
    glVertexAttribPointer(texCoords, 2, GL_FLOAT, GL_FALSE, 32, ctypes.c_void_p(24))
    glEnableVertexAttribArray(texCoords)

    # Creating Texture
    texture = glGenTextures(1)
    glBindTexture(GL_TEXTURE_2D, texture)
    # texture wrapping params
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT)
    # texture filtering params
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
    ######

    textures = glGenTextures(2)
    load_texture_pygame(texture_path, textures[0])
    glUseProgram(shader)

    glEnable(GL_TEXTURE_2D)
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST)
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST)
    glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_DECAL)

    projection = pyrr.matrix44.create_perspective_projection_matrix(45, resolution[0]/resolution[1], 0.1, 100)
    obj_pos = pyrr.matrix44.create_from_translation(pyrr.Vector3(pos_vec))
    # eye, target, up
    view = pyrr.matrix44.create_look_at(pyrr.Vector3([0, 0, 8]), pyrr.Vector3([0, 0, 0]), pyrr.Vector3([0, 1, 0]))

    model_loc = glGetUniformLocation(shader, "model")
    proj_loc = glGetUniformLocation(shader, "projection")
    view_loc = glGetUniformLocation(shader, "view")

    glUniformMatrix4fv(proj_loc, 1, GL_FALSE, projection)
    glUniformMatrix4fv(view_loc, 1, GL_FALSE, view)

    glEnable(GL_DEPTH_TEST)
    glEnable(GL_BLEND)
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
    gluPerspective(45, (resolution[0]/resolution[1]), 0.1, 100.0)
    glTranslatef(0.0, 0.0, -5)

def eventcheck():
    for event in pygame.event.get():
        global port,videobytes
        #print(event.type)
        if event.type==pygame.QUIT:
            pygame.quit()
            exit()
        elif event.type == pygame.VIDEORESIZE:
            pass
        elif event.type == pygame.MOUSEBUTTONDOWN:
            # print(event.button)
            #Check for left mouse click
            if event.button == 1:
                for button in buttons:
                    if button.checkHover(event.pos):
                        #get which button is pressed
                        result = button.clickFunction()
                        if result[:4] == "port":
                            texts.append(Text(resolution[0]*(1400/1920),resolution[1]*(2/16),'Establishing...',midfont))
                            port = result[4:]
                            try:
                                if not videobytes:
                                    videobytes = getvideobytes(videopath)
                            except:
                                videobytes = getvideobytes(videopath)
                            return True
                        elif result == "selectVideo":
                            pathinput = askopenfilename()
                            if pathinput != "":
                                videobytes = getvideobytes(pathinput)
                        elif result == "eject":
                            buttons[0].setColor((200,0,0))
                            cmd_send.append(ACTIVATE_EJECTION_CMD)
                        elif result == "startVideoSend":
                            videoProgressBar.toggleEta(True)
                            cmd_send.append(ACTIVATE_VIDEO_TRANSMISSION_CMD)
                        elif result == "stopVideoSend":
                            videoProgressBar.toggleEta(False)
                            cmd_send.append(DEACTIVATE_VIDEO_TRANSMISSON_CMD)
                        elif result == "resetVideoSend":
                            videoProgressBar.toggleEta(False)
                            #Reset the video_send counter to start sending from beginning of the video file
                            global video_send_counter
                            video_send_counter = 0
                        elif result == "motorTest":
                            # cmd_send.append(_command_)
                            pass
                        elif result == "resetSatellite":
                            cmd_send.append(ACTIVATE_RESET_CMD)
                            global plot_data,start_location,f,writer
                            #Reset start_location to update starting point in map
                            start_location = None
                            #Reset the telemetry data history for graphs
                            for key in plot_data:
                                plot_data[key] = []
                            #Close the csv file and open a new one
                            f.close()
                            f = open(datapath,'w+',newline='')
                            writer = csv.DictWriter(f,fieldnames=[key for key in telemetry])
                            writer.writeheader()
                for selector in selectors:
                    if selector.checkHover(event.pos):
                        selector.clickFunction()
    return False

def render(display):
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
    if main:
        surface = pygame.surfarray.make_surface(background2.swapaxes(0, 1))
        display.blit(surface, (0,0))
        #Draw the Graphs
        surface = plotsurf()
        display.blit(surface, (resolution[0]*(10/1920),resolution[1]*(530/1080)))
        #Draw the Map
        surface = pygame.surfarray.make_surface(map_image.swapaxes(0, 1))
        display.blit(surface, (resolution[0]-mapsize*(120/100),resolution[1]-mapsize*(110/100)))
        #Rotate Object
        rot_y = pyrr.matrix44.create_from_y_rotation(telemetry["yaw"])
        rot_z = pyrr.matrix44.create_from_z_rotation(telemetry["pitch"])
        rot_x = pyrr.matrix44.create_from_x_rotation(telemetry["roll"])
        model = pyrr.matrix44.multiply(rot_y, obj_pos)
        model = pyrr.matrix44.multiply(rot_z, model)
        model = pyrr.matrix44.multiply(rot_x, model)
        #Draw Simulation
        glUseProgram(shader)
        glBindVertexArray(VAO)
        glBindTexture(GL_TEXTURE_2D, textures[0])
        glUniformMatrix4fv(model_loc, 1, GL_FALSE, model)
        glDrawArrays(GL_TRIANGLES, 0, len(obj_indices))
        glDrawElements(GL_TRIANGLES, len(obj_indices), GL_UNSIGNED_INT, None)
    else:
        surface = pygame.surfarray.make_surface(background1.swapaxes(0, 1))
        display.blit(surface, (0,0))
    #Draw GUI elements to surface
    surface = pygame.display.get_surface()
    for obj in texts + buttons + selectors + progressbars:
        obj.draw(surface)
    #Draw surface to screen OpenGL style
    surdata = pygame.image.tostring(surface, "RGBA", True)
    glUseProgram(shaderBackground)
    glDepthFunc(GL_LEQUAL)
    glBindVertexArray(backgroundVAO)
    glBindTexture(GL_TEXTURE_2D, texture)
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, surface.get_width(), surface.get_height(), 0, GL_RGBA, GL_UNSIGNED_BYTE, surdata)
    glDrawElements(GL_TRIANGLES, len(obj_indices), GL_UNSIGNED_INT, None)

    pygame.display.flip()

try:
    #Setting display
    display = pygame.display.set_mode(
        resolution,
        pygame.HWSURFACE | pygame.DOUBLEBUF | pygame.OPENGL | pygame.RESIZABLE)

    openglinit()
    pygame.display.set_caption('Ground Station')
    #Determening fonts
    bigfont = pygame.font.SysFont(pygame.font.get_fonts()[0], int(resolution[1]*(30/1080)))
    midfont = pygame.font.SysFont(pygame.font.get_fonts()[0], int(resolution[1]*(26/1080)))
    smallfont = pygame.font.SysFont(pygame.font.get_fonts()[0], int(resolution[1]*(20/1080)))
    telemetrytitlefont = pygame.font.SysFont('consolas', int(resolution[1]*(24/1080)))
    telemetryfont = pygame.font.SysFont('consolas', int(resolution[1]*(18/1080)))
    #For Selecting Serial Port
    selectors.append(Selector(resolution[0]*(1800/1920),resolution[1]*(1/16),width=80,height=20,choices=[9600,19200,38400,57600,74880,115200]))
    texts.append(Text(resolution[0]*(1400/1920),resolution[1]*(1/16),'Select a COM Port',bigfont))
    texts.append(Text(resolution[0]*(1700/1920),resolution[1]*(1/16),'Baudrate:',bigfont))
    #Loop for Port Selection
    serialPort = None
    done = False
    while not done:
        done = eventcheck()
        #Get available Serial Ports for selection
        ports = serial.tools.list_ports.comports()
        buttons = [Button("selectVideo",resolution[0]*(1100/1920),resolution[1]*(70/1080),text="Select Video File")]
        for i,(_port, desc, hwid) in enumerate(sorted(ports)):
            #print("{}: {} [{}]".format(port, desc, hwid))
            buttons.append(Button("port"+_port,resolution[0]*(1400/1920),resolution[1]*((3+i)/16),text="{}: {} [{}]".format(_port, desc, hwid)))

        render(display)
    baudrate = selectors[0].getValue()
    buttons = []
    selectors = []
    #Check Serial Port
    print(baudrate)
    serialPort = serial.Serial(port=port, baudrate=baudrate, bytesize=8, timeout=2, stopbits=serial.STOPBITS_ONE)
    time.sleep(2)                 #wait to connect
    serialPort.flushInput()       #clear rx buffer
    #Creating Buttons for GUI
    texts = []
    for i in range(len(telemetry)):
        texts.append(Text(resolution[0]*(5/32),resolution[1]*((30+7*i)/400),"",telemetryfont,allign = 'center'))
    texts.append(Text(resolution[0]*(280/1920),resolution[1]*(35/1080),"Telemetry Data",telemetrytitlefont))
    texts.append(Text(resolution[0]*(960/1920),resolution[1]*(190/1080),"Live Feed",midfont))
    texts.append(Text(resolution[0]*(960/1920),resolution[1]*(664/1080),"Command Console",midfont))
    texts.append(Text(resolution[0]*(1640/1920),resolution[1]*(550/1080),"Location",midfont))
    texts.append(Text(resolution[0]*(1640/1920),resolution[1]*(30/1080),"Orientation",midfont))
    buttonwh = (resolution[0]*(120/1920),resolution[1]*(35/1080))
    buttons.append(Button("eject",resolution[0]*(750/1920),resolution[1]*(750/1080),width=buttonwh[0],height=buttonwh[1],text="Eject Satellite"))
    buttons.append(Button("resetSatellite",resolution[0]*(750/1920),resolution[1]*(950/1080),width=buttonwh[0],height=buttonwh[1],text="Reset Satellite"))
    buttons.append(Button("motorTest",resolution[0]*(750/1920),resolution[1]*(850/1080),width=buttonwh[0],height=buttonwh[1],text="Motor Test"))
    buttons.append(Button("startVideoSend",resolution[0]*(1100/1920),resolution[1]*(750/1080),text="Start Video Transmission"))
    buttons.append(Button("stopVideoSend",resolution[0]*(1100/1920),resolution[1]*(890/1080),text="Stop Video Transmission"))
    buttons.append(Button("resetVideoSend",resolution[0]*(1100/1920),resolution[1]*(950/1080),text="Reset Video Transmission"))
    videoProgressBar = ProgressBar(resolution[0]*(1100/1920),resolution[1]*(820/1080),max=len(videobytes))
    progressbars.append(videoProgressBar)
    video_send_counter = 0
    main = True
    telemetry_update = False
    map_image = np.zeros((0,0,3), np.uint8)
    start_location = None
    t1 = time.time()
    #Preparing the Loop
    done = False
    #Create a thread for handling incoming data and sending file at the background
    def serialThread(id):
        global serialPort,telemetry,writer,texts,cmd_send_state,video_send_counter,plot_data,plot_length,telemetry_update,data_buffer
        while True:
            if(serialPort.in_waiting > 0):
                data = serialPort.read()
                if data == TELEMETRY_DATA_BYTE:
                    data_buffer = struct.unpack(telemetrystruct,serialPort.read(36))
                    telemetry_update = True
                elif (data == ACTIVATE_VIDEO_TRANSMISSION_CMD) and (len(videobytes)>video_send_counter):
                    #Send one packet of videobytes, meanwhile block sending commands
                    cmd_send_state = False
                    serialPort.write(b''.join([bytes([0 if ((video_send_counter+VIDEO_BUFFER_SIZE) < len(videobytes)) else (len(videobytes)-video_send_counter)])] + videobytes[video_send_counter:(video_send_counter+VIDEO_BUFFER_SIZE)]))
                    ## TODO: Video göndermeyi test et ve hızlandır
                elif data == VIDEO_TRANSMISSION_CMPLTD:
                    #We successfully transmitted the data, increase the counter and enable sending commands
                    video_send_counter += VIDEO_BUFFER_SIZE
                    cmd_send_state = True
                elif data == DEACTIVATE_VIDEO_TRANSMISSON_CMD:
                    #not used at the moment
                    cmd_send_state = True
    #Create a thread for requesting a map from GOOGLE MAPS API and wait for the response
    def mapThread(id):
        global map_image,start_location,telemetry
        #Use GMAP API to get the map
        url = "{}?size={}x{}&markers=color:green%7Clabel:S%7C{},{}&markers=color:red%7Clabel:F%7C{},{}&key={}".format(GMAP_BASE_URL,mapsize,mapsize,start_location[0],start_location[1],telemetry["GPS_Latitude"],telemetry["GPS_Longitude"],GOOGLE_API_KEY)
        if not ((SECRET == None or SECRET == "") or SECRET == " "):
            url = sign_url(url, SECRET)
        try:
            response = urllib.request.urlopen(url,timeout=10)####
        except urllib.error.URLError as error:
            print('Data of map is not retrieved because {}\nURL: {}'.format(error, url))
        except:
            print("Unknown map error! (Possibly a socket timeout)")
        else:
            #If we didn't get an IOError then parse the result
            image = np.asarray(bytearray(response.read()), dtype="uint8")
            map_image = cv2.imdecode(image, cv2.IMREAD_COLOR)

    #Start the threads that we created
    x1 = threading.Thread(target=serialThread,args=(1,), daemon=True)
    x1.start()
    while not done:
        #Manipulate user input end exit as requested
        done = eventcheck()
        #Update the value of ProgressBar for video sending process
        videoProgressBar.setValue(video_send_counter)
        #If we recieved new telemetry data from the thread, update values accordingly
        if telemetry_update:
            telemetry_update = False
            #t1 = time.time()
            #Cast the data buffered into the dict
            for i,key in enumerate(telemetry):
                telemetry[key] = data_buffer[i]
            #Re-scale some data
            telemetry["temperature"] /= 10.0
            telemetry["batteryVoltage"] /= 10.0

            #Keep last n data as a history for graphs
            for key in plot_data:
                plot_data[key].append(telemetry[key])
                if len(plot_data[key]) > plot_length:
                    plot_data[key].pop(0)
            plot()
            #Record first geo data for the map
            if start_location == None:
                start_location = telemetry["GPS_Latitude"],telemetry["GPS_Longitude"]

            if telemetry["packageCounter"]%10 == 0:
                x2 = threading.Thread(target=mapThread,args=(1,))
                x2.start()
            #Save new data into the .csv file
            writer.writerow(telemetry)
            #Create Text objects to display the telemetry data in pygame gui
            for i,key in enumerate(telemetry):
                if type(telemetry[key]) == float:
                    texts[i].setText("{:20}:{:10.5f} {:9}".format(key, telemetry[key],units[i]))
                elif type(telemetry[key]) == bool:
                    texts[i].setText("{:20}:{:>10} {:9}".format(key, telemetry[key].__str__(),units[i]))
                elif type(telemetry[key]) == int:
                    texts[i].setText("{:20}:{:10d} {:9}".format(key, telemetry[key],units[i]))
                else:
                    texts[i].setText("{:20}: {:19}".format(key, telemetry[key]))

        #If not transmitting video file, send the buffered commands
        if cmd_send_state:
            for cmd in cmd_send:
                serialPort.write(cmd)
            cmd_send = []
        #Do drawings for the pygame gui
        render(display)

finally:
    #Release resources at exit
    f.close()
    pygame.quit()
