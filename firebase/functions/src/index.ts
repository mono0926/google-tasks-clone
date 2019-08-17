import * as admin from 'firebase-admin'
import * as functions from 'firebase-functions'

// import { api as _api } from './api'

admin.initializeApp()

// export const api = functions.https.onRequest(_api)

export const xxx = functions.firestore
  .document('users/{userId}')
  .onCreate((snap, context) => {
    console.log(snap)
    console.log(context)
  })
