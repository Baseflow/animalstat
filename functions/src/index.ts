import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';
admin.initializeApp(functions.config().firebase);

import * as atomicFunctions from './atomic-operations/index';
import { REGION } from './constants';

export const firestoreInstance = admin.firestore();

export const createRecurringTreatments = functions
    .region(REGION)
    .firestore
    .document('animals/{animalId}/history/{timestamp}')
    .onCreate(async (snapshot, context) => {
        const oneDayInMiliseconds: number = 1000 * 60 * 60 * 24;
        const animalId : number = parseInt(context.params.animalId);
        const startDate: Date = ConvertDate(parseInt(context.params.timestamp));
        const startDateInMiliseconds: number = startDate.valueOf();
        const healthRecord = snapshot.data();

        console.log(`Create recurring treatments based on ${animalId} and ${startDateInMiliseconds}.`);
                        
        if(!healthRecord || !healthRecord.treatment_enddate) {
            console.log(`Not creating recurring treatmenst since no enddate was provided.`);
            return;
        }

        const endDate = healthRecord.treatment_enddate.toDate().valueOf();
        const amountOfRecurrences : number = Math.floor((endDate - startDateInMiliseconds) / oneDayInMiliseconds);

        console.log(`Parameters used to calculate period are, Enddate: ${endDate}, Startdate: ${startDateInMiliseconds}, Day in miliseconds: ${oneDayInMiliseconds}`);

        for(let i = 0; i <= amountOfRecurrences; i++) {
            const recurringItem = {
                animal_number: animalId,
                administration_date: new Date(startDateInMiliseconds + (oneDayInMiliseconds * i)),
                cage_number: healthRecord.cage,
                diagnosis: healthRecord.diagnosis,
                health_status: healthRecord.health_status,
                treatment: healthRecord.treatment,
                treatment_status: 0
            };

            await atomicFunctions.createRecurringTreatment(recurringItem);
        }
    });

function ConvertDate(timestamp: number) : Date {
    const dateFromTimeStamp = new Date(timestamp);
    return new Date(dateFromTimeStamp.getFullYear(), dateFromTimeStamp.getMonth(), dateFromTimeStamp.getDay());
}

export const updateCurrentHealthStatus = functions
    .region(REGION)
    .firestore
    .document('animals/{animalId}/history/{timestamp}')
    .onCreate((snapshot, context) => {
        const animalId : string = context.params.animalId;
        const newValue = snapshot.data();
        
        if(!newValue) return;

        const healthStatus = newValue.health_status;
        return atomicFunctions.updateCurrentHealthStatus(animalId, healthStatus);
    });

export const updateCurrentCageNumber = functions
    .region(REGION)
    .firestore
    .document('animals/{animalId}/history/{timestamp}')
    .onCreate((snapshot, context) => {
        const animalId : string = context.params.animalId;
        const newValue = snapshot.data();

        if(!newValue) return;

        const cageNumber = newValue.cage;
        return atomicFunctions.updateCurrentCageNumber(animalId, cageNumber);
    });