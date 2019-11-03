import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';
admin.initializeApp(functions.config().firebase);

import * as atomicFunctions from './atomic-operations/index';
import {REGION} from './constants';

export const firestoreInstance = admin.firestore();

export const updateCurrentDiagnosis = functions
    .region(REGION)
    .firestore
    .document('animals/{animalId}/history/{timestamp}')
    .onWrite((change, context) => {
        const animalId : string = context.params.animalId;
        const newValue = change.after.data();
        
        if(!newValue) return;

        const healthStatus = newValue.health_status;
        return atomicFunctions.updateCurrentDiagnosis(animalId, healthStatus);
    });