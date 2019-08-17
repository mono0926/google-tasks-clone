import * as admin from 'firebase-admin'

export async function deleteCollection(
  collectionRef: FirebaseFirestore.CollectionReference,
  batchSize: number = 500
) {
  const firestore = admin.firestore()
  const query = collectionRef.orderBy('__name__').limit(batchSize)
  await deleteQueryBatch(firestore, query, batchSize)
}
async function deleteQueryBatch(
  firestore: FirebaseFirestore.Firestore,
  query: FirebaseFirestore.Query,
  batchSize: number
): Promise<void> {
  const snapshot = await query.get()
  if (snapshot.size === 0) {
    return
  }

  const results = await updateWithBatch(async batch => {
    snapshot.docs.forEach(doc => {
      batch.delete(doc.ref)
    })
  })
  console.log(`deleted count: ${results.length}`)

  await deleteQueryBatch(firestore, query, batchSize)
}

export async function updateWithBatch(
  f: (batch: FirebaseFirestore.WriteBatch) => Promise<void>
): Promise<FirebaseFirestore.WriteResult[]> {
  const batch = admin.firestore().batch()
  await f(batch)
  return await batch.commit()
}
