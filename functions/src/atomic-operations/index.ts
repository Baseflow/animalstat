import {firestoreInstance} from "../index";

export function updateCurrentDiagnosis(animalId: string, diagnosis: any) : Promise<any> {
    return firestoreInstance.collection('animals').doc(animalId).set({
        current_diagnosis: diagnosis
    }, { merge: true });
}