import {firestoreInstance} from "../index";

export function updateCurrentDiagnosis(animalId: string, health_status: any) : Promise<any> {
    return firestoreInstance.collection('animals').doc(animalId).set({
        current_health_status: health_status
    }, { merge: true });
}