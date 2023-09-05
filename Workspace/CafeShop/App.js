// In App.js in a new project

import * as React from "react";
import { View, Text } from "react-native";
import { NavigationContainer } from "@react-navigation/native";
import { createNativeStackNavigator } from "@react-navigation/native-stack";
import HomeScreen from "./screens/Home";
import SplashScreen from "./screens/Splash";
import Login from "./screens/Login";
const Stack = createNativeStackNavigator();

function App() {
  return (
    <NavigationContainer >
      <Stack.Navigator screenOptions={{headerShown: false}}>
        <Stack.Screen
          name="Splash"
          component={SplashScreen}
          // options= {{title: 'Welcome HomeScreen'}}
        />
        <Stack.Screen
          name="LoginScreen"
          component={Login}
          // options= {{title: 'Welcome HomeScreen'}}
        />
        <Stack.Screen
          name="HomeScreen"
          component={HomeScreen}
          // options= {{title: 'Welcome HomeScreen'}}
        />
      </Stack.Navigator>
    </NavigationContainer>
  );
}

export default App;
