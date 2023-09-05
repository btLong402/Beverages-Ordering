import React from "react";
import { View, Text } from "react-native";
//import Login from './Login';
class SplashScreen extends React.Component {
  performTimeConsumingTask = async () => {
    return new Promise((resolve) =>
      setTimeout(() => {
        resolve("result");
      }, 2000)
    );
  };
  async componentDidMount() {
    // Preload data from an external API
    // Preload data using AsyncStorage
    const data = await this.performTimeConsumingTask();
    if (data !== null) {
      this.props.navigation.navigate("LoginScreen");
    }
  }
  render() {
    return (
      <View style={styles.viewStyles}>
        <Text style={styles.textStyles}>Drink Shop</Text>
      </View>
    );
  }
}
const styles = {
  viewStyles: {
    flex: 1,
    alignItems: "center",
    justifyContent: "center",
    backgroundColor: "orange",
  },
  textStyles: {
    color: "white",
    fontSize: 40,
    fontWeight: "bold",
  },
};
export default SplashScreen;
