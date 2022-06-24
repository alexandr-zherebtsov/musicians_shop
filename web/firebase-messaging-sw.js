importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
    apiKey: 'AIzaSyDBhPNzsu450AraKSTxED4vv73I0teR4FU',
    appId: '1:670066810894:web:90e98f3d393ac6b41fdc5f',
    messagingSenderId: '670066810894',
    projectId: 'g-shop-4fe02',
    authDomain: 'g-shop-4fe02.firebaseapp.com',
    storageBucket: 'g-shop-4fe02.appspot.com',
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});
