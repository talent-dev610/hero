import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
admin.initializeApp();

// const db = admin.firestore();
// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript


export const resetWeek = functions.pubsub.schedule("0 22 * * 6")
    .timeZone("America/New_York")
    .onRun(async () => {
      const stingrays = admin.firestore().collection("stingrays");
      const stingray = await stingrays.get();
      stingray.forEach((snapshot) => {
        snapshot.ref.delete();
      });

      await admin.firestore().collection("users").
          where("isStingray", "==", true).get().then((querySnapshot) => {
            querySnapshot.forEach(async (doc) => {
              await doc.ref.update({isStingray: false});
            });
          });

      await admin.firestore().collection("users").
          orderBy("votes", "desc").limit(2).get().then((querySnapshot) => {
            querySnapshot.forEach(async (doc) => {
              await admin.firestore().collection("stingrays")
                  .add({name: doc.data().name, bio: doc.data().bio,
                    id: doc.data().id, age: doc.data().age,
                    // eslint-disable-next-line max-len
                    imageUrls: doc.data().imageUrls, interests: doc.data().interests, jobTitle: doc.data().jobTitle, isStingray: doc.data().isStingray, Team: doc.data().team, likes: [], dislikes: []});
              await doc.ref.update({isStingray: true});
            });
          });

      await admin.firestore().collection("users")
          .get().then((querySnapshot) => {
            querySnapshot.forEach(async (doc) => {
              // eslint-disable-next-line max-len
              await doc.ref.update({"votes": 0, "votesUsable": 1, "stingrays": []});
            });
          })
          .catch((error) => {
            console.log("Error getting documents: ", error);
          });
      return null;
    });

// exports.resetStingrayBooleans = functions.pubsub.schedule("03 15 * * *")
//     .timeZone("America/New_York")
//     .onRun(async () => {
//       await admin.firestore().collection("users").
//           where("isStingray", "==", true).get().then((querySnapshot) => {
//             querySnapshot.forEach(async (doc) => {
//               await doc.ref.update({isStingray: false});
//             });
//           })
//           .catch((error) => {
//             console.log("Error getting documents: ", error);
//           });
//       return null;
//     });

// exports.addNewStingrays = functions.pubsub.schedule("04 15 * * *")
//     .timeZone("America/New_York")
//     .onRun(async () => {
//       await admin.firestore().collection("users").
//           orderBy("votes", "desc").limit(2).get().then((querySnapshot) => {
//             querySnapshot.forEach(async (doc) => {
//               await admin.firestore().collection("stingrays")
//                   .add({name: doc.data().name, bio: doc.data().bio});
//               await doc.ref.update({isStingray: true});
//             });
//           })
//           .catch((error) => {
//             console.log("Error getting documents: ", error);
//           });
//       return null;
//     });

// exports.resetVotes = functions.pubsub.schedule("05 15 * * *")
//     .timeZone("America/New_York")
//     .onRun(async () => {
//       await admin.firestore().collection("users")
//           .get().then((querySnapshot) => {
//             querySnapshot.forEach(async (doc) => {
//               // eslint-disable-next-line max-len
// eslint-disable-next-line max-len
//               await doc.ref.update({"votes": 0, "votesUsable": 1, "stingrays": []});
//             });
//           })
//           .catch((error) => {
//             console.log("Error getting documents: ", error);
//           });
//       return null;
//     });
