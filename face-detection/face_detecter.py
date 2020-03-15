from os import listdir
from os.path import isfile, join
import face_recognition
import cv2
import numpy as np
from sklearn import svm

face_dir = "./data/faces/"

print("Starting to train model.")

# Training the SVC classifier

# The training data would be all the face encodings from all the known images and the labels are their names
encodings = []
names = []

# Used for simple matching
known_encodings = {}

# Training directory
train_dir = listdir(face_dir)

# Loop through each person in the training directory
for person in train_dir:
    pix = listdir(join(face_dir, person))

    # Loop through each training image for the current person
    for person_img in pix:
        # Get the face encodings for the face in each image file
        face = face_recognition.load_image_file(
            join(face_dir, person, person_img))
        face_bounding_boxes = face_recognition.face_locations(face)

        # If training image contains exactly one face
        if len(face_bounding_boxes) == 1:
            face_enc = face_recognition.face_encodings(face)[0]
            # Add face encoding for current image with corresponding label (name) to the training data
            encodings.append(face_enc)
            names.append(person)
            if (person not in known_encodings):
                known_encodings[person] = face_enc
        else:
            print(person + "/" + person_img +
                  " was skipped and can't be used for training")

# Create and train the SVC classifier
clf = svm.SVC(gamma='scale')
clf.fit(encodings, names)

known_names, known_encodings = zip(*list(known_encodings.items()))
known_names = np.array(known_names)

print("Trained on the following people", clf.classes_)

# Initialize some variables
face_locations = []
face_encodings = []
face_names = []
process_this_frame = True

# Get a reference to webcam #0 (the default one)
video_capture = cv2.VideoCapture(0)

print("Ready to identify people now.")

while True:
    # Grab a single frame of video
    ret, frame = video_capture.read()

    # Resize frame of video to 1/4 size for faster face recognition processing
    small_frame = cv2.resize(frame, (0, 0), fx=0.25, fy=0.25)

    # Convert the image from BGR color (which OpenCV uses) to RGB color (which face_recognition uses)
    rgb_small_frame = small_frame[:, :, ::-1]

    # Only process every other frame of video to save time
    if process_this_frame:
        # Find all the faces and face encodings in the current frame of video
        face_locations = face_recognition.face_locations(rgb_small_frame)
        if (len(face_locations) == 1): 
            face_encoding = face_recognition.face_encodings(rgb_small_frame, face_locations)[0]

            matches = face_recognition.compare_faces(known_encodings, face_encoding)
            matching_persons = known_names[matches]
            if (len(matching_persons) == 0):
                name = "Unknown"
            elif (len(matching_persons) == 1):
                name = matching_persons[0]
            else:
                prediction = clf.predict([face_encoding])[0]
                if prediction in matching_persons:
                    name = prediction
                else: 
                    name = "Unsure"
                    
            print(name)

    process_this_frame = not process_this_frame

# Release handle to the webcam
video_capture.release()