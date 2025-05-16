# 🔔 Flutter Firebase Push Notifications (Android Custom Sound & Icon)

Este proyecto Flutter implementa notificaciones push en Android utilizando **Firebase Cloud Messaging (FCM)**. Incluye configuración para reproducir **sonido personalizado** y mostrar un **ícono personalizado** al recibir la notificación, incluso cuando la app está en segundo plano o cerrada.

## 🚀 Características

- 📲 Integración con Firebase Cloud Messaging.
- 🌓 Recepción de notificaciones en foreground, background y terminated.
- 🔊 Sonido personalizado para notificaciones.
- 🎨 Ícono de notificación personalizado.
- 🤖 Soporte exclusivo para Android.

## 📦 Dependencias principales

```yaml
firebase_core: ^2.x.x
firebase_messaging: ^14.x.x
```

> Asegúrate de revisar [pub.dev](https://pub.dev/packages/firebase_messaging) para las versiones más recientes.

---

## 🔧 Configuración

### 1. 🔥 Firebase Setup

- Crea un proyecto en [Firebase Console](https://console.firebase.google.com).
- Agrega tu app Android (`com.tuempresa.tuapp`).
- Descarga el archivo `google-services.json` y colócalo en `android/app/`.

### 2. ⚙️ Configura Android

En tu `android/build.gradle`:

```gradle
classpath 'com.google.gms:google-services:4.4.0'
```

En `android/app/build.gradle`:

```gradle
apply plugin: 'com.google.gms.google-services'
```

Agrega los permisos al `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```

### 3. 🔊 Sonido Personalizado

1. Crea una carpeta `res/raw` dentro de `android/app/src/main/`.
2. Agrega tu archivo de sonido `.mp3` o `.wav` (ejemplo: `noti_sound.mp3`).
3. El nombre **debe estar en minúsculas** y sin guiones ni espacios.

### 4. 🖼️ Ícono Personalizado

1. Crea tu ícono en blanco (formato `.png`, fondo transparente).
2. Agrégalo en `android/app/src/main/res/drawable` con el nombre `ic_notification.png`.
3. También puedes usar [Android Asset Studio](https://romannurik.github.io/AndroidAssetStudio/icons-notification.html).

---

## 📬 Envío de notificaciones desde Firebase

Ejemplo de payload desde Firebase Console:

```json
{
  "to": "FCM_TOKEN",
  "notification": {
    "title": "¡Hola Pierre!",
    "body": "Esto es una notificación con sonido e ícono personalizado",
    "sound": "noti_sound"
  },
  "android": {
    "notification": {
      "icon": "ic_notification"
    }
  }
}
```

---

## 🧪 Pruebas en Foreground / Background / Terminated

Asegúrate de manejar bien los distintos estados con los métodos de `FirebaseMessaging`:

```dart
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  // App en primer plano
});

FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  // Notificación clickeada
});
```

---

## ✅ Estado del proyecto

🚧 En desarrollo — ¡contribuciones y sugerencias son bienvenidas!

---

## 👨‍💻 Créditos

Desarrollado con ♥️ por [Pierre Juarez](https://www.linkedin.com/in/pierre-juarez/) 😊
