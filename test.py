import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'
from keras.applications.resnet50 import ResNet50
from keras.preprocessing import image
from keras.applications.resnet50 import preprocess_input, decode_predictions
import numpy as np

input='/home/ak/Documents/Projects/qcon/vol/test_data_flickr8k/'
model = ResNet50(weights='imagenet',include_top=False)
dict={}
lst=os.listdir(input)
dict2=[]
for i in range(0,len(lst)):
    img_path = input+str(lst[i])
    img = image.load_img(img_path, target_size=(224, 224))
    x = image.img_to_array(img)
    x = np.expand_dims(x, axis=0)
    x = preprocess_input(x)
    preds = model.predict(x)
    dict[str(lst[i])]=preds
    os.remove(img_path)
dict2.append(dict)
fin=np.array(dict2)
np.save('test',fin)