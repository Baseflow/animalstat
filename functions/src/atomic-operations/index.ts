import {firestoreInstance} from "../index";

export function updateCurrentCageNumber(animalId: string, cage: Number) : Promise<any> {
    return firestoreInstance.collection('animals').doc(animalId).set({
        current_cage_number: cage
    }, { merge: true });
}

export function updateCurrentHealthStatus(animalId: string, health_status: any) : Promise<any> {
    return firestoreInstance.collection('animals').doc(animalId).set({
        current_health_status: health_status
    }, { merge: true });
}