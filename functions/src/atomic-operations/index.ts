import { firestoreInstance } from "../index";

export function createRecurringTreatment(companyId: string, recurringTreatment: any): Promise<any> {
    return firestoreInstance
        .collection(`companies/${companyId}/recurring_treatments`)
        .add(recurringTreatment);
}

export function updateCurrentCageNumber(companyId: string, animalId: string, cage: Number): Promise<any> {
    return firestoreInstance
        .collection(`companies/${companyId}/animals`)
        .doc(animalId)
        .set({
            current_cage_number: cage
        }, {
            merge: true
        });
}

export function updateCurrentHealthStatus(companyId: string, animalId: string, health_status: any): Promise<any> {
    return firestoreInstance
        .collection(`companies/${companyId}/animals`)
        .doc(animalId)
        .set({
            current_health_status: health_status,
            health_status_updated_on: new Date(Date.now())
        }, {
            merge: true
        });
}