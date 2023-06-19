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

const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
  payload.data.data = JSON.parse(JSON.stringify(payload.data));
  return self.registration.showNotification(
    payload.notification.title,
    {
      body: payload.notification.body,
      icon: 'icons/App-logo.svg',
    },
  );
});

self.addEventListener('notificationclick', function (event) {
  const target = event.notification.data.click_action || '/';
  event.notification.close();
  event.waitUntil(clients.matchAll({
    type: 'window',
    includeUncontrolled: true
  }).then(function (clientList) {
    for (let i = 0; i < clientList.length; i++) {
      const client = clientList[i];
      if (client.url === target && 'focus' in client) {
        return client.focus();
      }
    }
    return clients.openWindow(target);
  }));
});
