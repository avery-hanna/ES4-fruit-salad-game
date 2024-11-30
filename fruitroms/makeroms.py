import argparse
from PIL import Image
import numpy as np

parser=argparse.ArgumentParser()

parser.add_argument("fname", type=str, help="nameofinputfile")
parser.add_argument("rname", type=str, help="nameofoutputromfile")

args=parser.parse_args()

filename= args.fname

def to_hex(number):
    hex1=int(number/16)
    hex2=int(number%16)
    if hex1<10:
        number1=chr(48 + hex1)
    elif hex1 < 16:
        number1=chr(66 + (hex1-10))
    if hex2<10:
        number2=chr(48 + hex2)
    elif hex2  < 16:
        number2=chr(66 + (hex2-10))
    return (number1 + number2)

def to_binary_helper(number):
    if number == 1:
        return '1'
    elif number == 0:
        return '0'
    else:
        if number % 2 == 1:
            return to_binary_helper(int(number/2)) + '1'
        else:
            return to_binary_helper(int(number/2)) + '0'
        

def to_binary(number):
    binarynum=to_binary_helper(number)
    while len(binarynum) < 5:
        binarynum='0'+binarynum
    return binarynum

image_path="/Users/elizabethpanner/Desktop/" + filename
image=Image.open(image_path)

image=image.convert('RGB')

width, height=image.size

r_array=np.zeros(shape=(int(width),int(height)))
g_array=np.zeros(shape=(int(width),int(height)))
b_array=np.zeros(shape=(int(width),int(height)))

r_final=np.zeros(shape=(31,31))
g_final=np.zeros(shape=(31,31))
b_final=np.zeros(shape=(31,31))


foundcolor=False

highwhite=0
lowwhite=-1

leftcolor=False

leftwhite=-1
rightwhite=-1
done=False

for y in range(int(height)):
    horizontalcounter=0
    leftcolor=False
    for x in range(int(width)):
        r, g, b=image.getpixel((x, y))
        r_array[x][y]=r
        g_array[x][y]=g
        b_array[x][y]=b
        if (r != 255 or b != 255 or g != 255) and foundcolor==False:
            highwhite=y
            foundcolor=True
        if (r==255 and b==255 and g==255) and foundcolor==True:
            horizontalcounter+=1
        if horizontalcounter==int(width) and not done:
            lowwhite=y
            done=True
        if (r!=255 or g != 255 or b != 255):
            if x < leftwhite or leftwhite==-1:
                leftwhite=x
            leftcolor=True
        if (r==255 and b==255 and g==255) and leftcolor==True:
            if x>rightwhite:
                rightwhite=x
            leftcolor=False


print("high white", highwhite, "low white", lowwhite, "leftwhite", leftwhite, "rightwhite", rightwhite)

highwhite=highwhite-10
lowwhite=lowwhite+10
leftwhite=leftwhite-10
rightwhite=rightwhite+10

totalx=rightwhite-leftwhite
totaly=lowwhite-highwhite

intervalx=int(totalx/31)
intervaly=int(totaly/31)

final_r=np.zeros(shape=(31, 31))
final_g=np.zeros(shape=(31, 31))
final_b=np.zeros(shape=(31, 31))

r_array=r_array[leftwhite:rightwhite, highwhite:lowwhite]
b_array=b_array[leftwhite:rightwhite, highwhite:lowwhite]
g_array=g_array[leftwhite:rightwhite, highwhite:lowwhite]

for pointx in range(31):
     for pointy in range(31):
         xstart=pointx*intervalx
         xend=(pointx+1)*intervalx-1

         ystart=pointy*intervaly
         yend=(pointy+1)*intervaly-1
         
         final_r[pointx][pointy]=int(np.mean(r_array[xstart:xend,ystart:yend]))
         final_g[pointx][pointy]=int(np.mean(g_array[xstart:xend, ystart:yend]))
         final_b[pointx][pointy]=int(np.mean(b_array[xstart:xend, ystart:yend]))
         
romfile=open(args.rname + ".vhd", "w")
romstartfile=open("romstart.txt")
for line in romstartfile:
    romfile.write(line)
    
for x in range(31):
    for y in range(31):
        if final_r[x][y] != 255 or final_b[x][y] != 255 or final_g[x][y]!= 255:
            towrite= "when " + to_binary(x) + to_binary(y) + "=> \n \t \t \t \t <= " + to_hex(final_r[x][y]) + to_hex(final_g[x][y]) + to_hex(final_b[x][y])
            romfile.write("\n \t \t \t" + towrite)
            
romfile.write(" \n \t \t end case; \n \
    \t end if;  \n \
    end process; \n address <= row & col; \n \
end;")

draw=Image.new("RGB", (31, 31))
pixels2=draw.load()
for y in range(31):
    for x in range(31):
        x=int(x)
        y=int(y)
        pixels2[x, y]=(int(final_r[x][y]), int(final_g[x][y]), int(final_b[x][y]))

draw.save("pixelated" + filename)