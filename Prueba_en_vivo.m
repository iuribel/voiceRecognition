function result = Prueba_en_vivo(r,code1,names1)
y = getaudiodata(r);
Fs = 48000;
audiowrite('C:\Users\Daniel\Desktop\voiceRecognition\En_vivo\prueba.wav',y,Fs);
names3=savenames('C:\Users\Daniel\Desktop\voiceRecognition\En_vivo');

test('C:\Users\Daniel\Desktop\voiceRecognition\En_vivo',code1,names1, names3);

delete('C:\Users\Daniel\Desktop\voiceRecognition\En_vivo\prueba.wav')
