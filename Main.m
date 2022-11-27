%Empezar de 0
clear all;
%Función de entrenamiento
code=train('C:\Users\Daniel\Desktop\voiceRecognition\data\train');
%Listas de audios de entrenamiento y testeo
names1=savenames('C:\Users\Daniel\Desktop\voiceRecognition\data\train\');
names2=savenames('C:\Users\Daniel\Desktop\voiceRecognition\data\test\');
%Testeo
test('C:\Users\Daniel\Desktop\voiceRecognition\data\test',code,names1, names2);