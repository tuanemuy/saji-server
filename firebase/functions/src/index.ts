import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import fetch from "node-fetch";

admin.initializeApp();

export const setCustomClaims = functions.auth.user().onCreate(async (user) => {
  const customClaims = {
    "https://hasura.io/jwt/claims": {
      "x-hasura-default-role": "user",
      "x-hasura-allowed-roles": ["user"],
      "x-hasura-user-id": user.uid,
    },
  };

  try {
    await admin.auth().setCustomUserClaims(user.uid, customClaims);

    await fetch(functions.config().hasura.endpoint, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "x-hasura-admin-secret": functions.config().hasura.admin_secret,
      },
      body: JSON.stringify({
        query: `
          mutation CreateUser($id: String!, $firebase_id: String!) {
            insert_users_one(object: {id: $id, firebase_id: $firebase_id}) {
              id
            }
          }
        `,
        variables: {
          id: user.uid,
          firebase_id: user.uid,
        },
      }),
    });
  } catch (e) {
    console.error(e);
  }
});
