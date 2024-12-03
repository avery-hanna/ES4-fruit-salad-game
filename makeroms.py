import argparse
from PIL import Image
import numpy as np

parser=argparse.ArgumentParser()

parser.add_argument("fname", type=str, help="nameofinputfile")
parser.add_argument("rname", type=str, help="nameofoutputromfile")

args=parser.parse_args()

filename= args.fname

# def to_hex(number):
#     hex1=int(number/16)
#     hex2=int(number%16)
#     if hex1<10:
#         number1=chr(48 + hex1)
#     elif hex1 < 16:
#         number1=chr(66 + (hex1-10))
#     if hex2<10:
#         number2=chr(48 + hex2)
#     elif hex2  < 16:
#         number2=chr(66 + (hex2-10))
#     return (number1 + number2)

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
        

def to_binary(number, length):
    binarynum=to_binary_helper(number)
    while len(binarynum) < length:
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

highblack=0
lowblack=-1

leftcolor=False

leftblack=-1
rightblack=-1
done=False

for y in range(int(height)):
    horizontalcounter=0
    leftcolor=False
    for x in range(int(width)):
        r, g, b=image.getpixel((x, y))
        r_array[x][y]=r
        g_array[x][y]=g
        b_array[x][y]=b
        if (r != 0 or b != 0 or g != 0) and foundcolor==False:
            highblack=y
            foundcolor=True
        if (r==0 and b==0 and g==0) and foundcolor==True:
            horizontalcounter+=1
        if horizontalcounter==int(width) and not done:
            lowblack=y
            done=True
        if (r!=0 or g != 0 or b != 0):
            if x < leftblack or leftblack==-1:
                leftblack=x
            leftcolor=True
        if (r==0 and b==0 and g==0) and leftcolor==True:
            if x>rightblack:
                rightblack=x
            leftcolor=False


print("high black", highblack, "low black", lowblack, "left black", leftblack, "right black", rightblack)

highwhite=highblack-10
lowwhite=leftblack+10
leftwhite=leftblack-10
rightwhite=rightblack+10

totalx=rightblack-leftblack
totaly=lowblack-highblack

intervalx=int(totalx/31)
intervaly=int(totaly/31)

print(intervalx)
print(intervaly)

final_r=np.zeros(shape=(31, 31))
final_g=np.zeros(shape=(31, 31))
final_b=np.zeros(shape=(31, 31))

r_array=r_array[leftblack:rightblack, highblack:lowblack]
b_array=b_array[leftblack:rightblack, highblack:lowblack]
g_array=g_array[leftblack:rightblack, highblack:lowblack]

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
        if final_r[x][y] != 0 or final_b[x][y] != 0 or final_g[x][y]!= 0:
            r_rgb=to_binary(int(final_r[x][y]/64), 2)
            b_rgb=to_binary(int(final_b[x][y]/64), 2)
            g_rgb=to_binary(int(final_g[x][y]/64), 2)
            
            if r_rgb=="00" and b_rgb=="00" and g_rgb=="00":
                if (x >= 3 and x <= 28) and (y >= 3 and y <=28):
                    print("here" , x, y)
                    b_rgb="01"

                    towrite= "when \"" + to_binary(x, 5) + to_binary(y, 5) + "\" => \n \t \t \t \t color <= " + '\"' + r_rgb + g_rgb + b_rgb +  '\";'
                    romfile.write("\n \t \t \t" + towrite)
            else:
                towrite= "when \"" + to_binary(x, 5) + to_binary(y, 5) + "\" => \n \t \t \t \t color <= " + '\"' + r_rgb + g_rgb + b_rgb +  '\";'
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