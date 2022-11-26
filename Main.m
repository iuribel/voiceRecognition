clear all;
code=train('C:\Users\Daniel\Desktop\voiceRecognition\data\train');
names1=savenames('C:\Users\Daniel\Desktop\voiceRecognition\data\train\');
names2=savenames('C:\Users\Daniel\Desktop\voiceRecognition\data\test\');
test('C:\Users\Daniel\Desktop\voiceRecognition\data\test',code,names1, names2);