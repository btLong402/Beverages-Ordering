import { StatusBar } from "expo-status-bar";
import React, { useState } from "react";
import {
  StyleSheet,
  Text,
  View,
  Image,
  TextInput,
  Button,
  TouchableOpacity,
  Dimensions
} from "react-native";
const windowWidth = Dimensions.get('window').width;
const windowHeight = Dimensions.get('window').height;
const SIGN_IN = 'SIGN_IN';
const SIGN_UP = 'SIGN_UP';
export default Login = ({navigation}) => {
  const [page, setPage] = useState(SIGN_IN);
  return(
    <View style={{width: '100%', height: '100%'}}>
      <View style={{height : '25%', width: '100%'}}>
        <Part1 page={page} setPage={setPage}/>
      </View>
      <View style={{height: '40%', width: '100%', backgroundColor: '#f5f5f5'}}>
      {page === SIGN_IN ? <Part2_1 navigation={navigation}/>: <Part2_2/>}
      </View>
      <View style={{ flex: 1}}>
        <Part3/>
      </View>
    </View>
  );
}

const Part1 = ({page, setPage}) => {
  return (
    <View style={{flex : 1}}>
      <StatusBar barStyle='Light-content'/>
      <View style={{ width: '100%', height: '100%'}}>
        <View style={{width: '100%', flex: 1, backgroundColor: '#229E5C', justifyContent: 'center', alignItems: 'center'}}>
          <Text style={{fontSize: 35, fontWeight: '600', color: '#ffffff'}}>Drink Shop</Text>
        </View>
        <View style={{ height: 50, flexDirection: 'row',backgroundColor: 'white'}}>
          <TouchableOpacity style={{borderWidth: 0, width: '50%', height: '100%', justifyContent: 'center', alignItems: 'center', }}
          onPress={() => {setPage(SIGN_IN)}}
          disabled={page === SIGN_IN?  true: false}
          >
            <Text style={{ fontSize: 25, color: '#229E5C'}}>Sign In</Text>
            {page === SIGN_IN ? <View style={{position: 'absolute', bottom: 0, height: 3, width: '100%', backgroundColor: '#229E5C'}}></View>: null}
          </TouchableOpacity>
          <TouchableOpacity style={{borderWidth: 0, width: '50%', height: '100%', justifyContent: 'center', alignItems: 'center'}}
          onPress={() => {setPage(SIGN_UP)}}
          disabled={page === SIGN_UP?  true: false}
          >
            <Text style={{ fontSize: 25, color: '#229E5C'}}>Sign Up</Text>
            {page === SIGN_UP ? <View style={{position: 'absolute', bottom: 0, height: 3, width: '100%', backgroundColor: '#229E5C'}}></View>: null}
          </TouchableOpacity>
        </View>
      </View>
    </View>
  );
}
const Part2_1 = ({navigation}) =>{
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [pwHidden, setPwHidden] = useState(true);
  return(
    <View style={{width:'100%', height:'100%', justifyContent: 'center'}}>
      <Text style={{fontSize: 24, marginLeft: 30}}> Login in your account
      </Text>
      <View style={{width : windowWidth - 60, height: 45, marginTop: 20, marginLeft: 30, flexDirection: 'row', alignItems: 'center', backgroundColor: 'white'}}>
        <Image source={require('../assets/Icon/mail.png')} resizeMode='stretch' style={{width: 30, height: 30, marginLeft: 10}}/>
        <TextInput
          style={{height: '100%', flex: 1, marginLeft: 10, fontSize: 16}}
          autoCapitalize={false}
          placeholder='E-mail'
        />
      </View>
      <View style={{width : windowWidth - 60, height: 45, marginTop: 20, marginLeft: 30, flexDirection: 'row', alignItems: 'center', backgroundColor: 'white'}}>
        <Image source={require('../assets/Icon/lock.png')} resizeMode='stretch' style={{width: 25, height: 25, marginLeft: 15}}/>
        <TextInput
          style={{height: '100%', flex: 1, marginLeft: 10, fontSize: 16}}
          autoCapitalize={false}
          placeholder='Password'
          secureTextEntry={pwHidden? true: false}
        />
        <TouchableOpacity style={{ height: '100%', aspectRatio: 1, justifyContent: 'center', alignItems: 'center'}}
        onPress={() => setPwHidden(!pwHidden)}
        >
          <Image source={require('../assets/Icon/show.png')} resizeMode='stretch' style={{width: 25, height: 25}}/>
        </TouchableOpacity>
      </View>
      <View style={{width : windowWidth - 60, marginTop: 30, marginLeft: 30, flexDirection: 'row', alignItems: 'center'}}>
        <TouchableOpacity>
          <Text style={{color: '#707070', position: 'absolute', right: 0}}>
        Forgot password ?
          </Text>
        </TouchableOpacity>
      </View>
      <View>
        <TouchableOpacity style={{height: 50, width: '40%', justifyContent: 'center', alignItems: 'center', backgroundColor: '#229E5C', marginLeft:120, marginTop: 50, borderRadius: 100}}
        onPress={() => navigation.navigate('HomeScreen')}
        >
          <Text style={{color: 'white', fontSize : 16}}>Login</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
}
const Part2_2 = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [pwHidden, setPwHidden] = useState(true);
  return(
    <View style={{width:'100%', height:'100%', justifyContent: 'center'}}>
      <Text style={{fontSize: 24, marginLeft: 30}}> Create your account!
      </Text>
      <View style={{width : windowWidth - 60, height: 45, marginTop: 20, marginLeft: 30, flexDirection: 'row', alignItems: 'center', backgroundColor: 'white'}}>
        <Image source={require('../assets/Icon/mail.png')} resizeMode='stretch' style={{width: 30, height: 30, marginLeft: 10}}/>
        <TextInput
          style={{height: '100%', flex: 1, marginLeft: 10, fontSize: 16}}
          autoCapitalize={false}
          placeholder='E-mail'
        />
      </View>
      <View style={{width : windowWidth - 60, height: 45, marginTop: 20, marginLeft: 30, flexDirection: 'row', alignItems: 'center', backgroundColor: 'white'}}>
        <Image source={require('../assets/Icon/lock.png')} resizeMode='stretch' style={{width: 25, height: 25, marginLeft: 15}}/>
        <TextInput
          style={{height: '100%', flex: 1, marginLeft: 10, fontSize: 16}}
          autoCapitalize={false}
          placeholder='Password'
          secureTextEntry={pwHidden? true: false}
        />
        <TouchableOpacity style={{ height: '100%', aspectRatio: 1, justifyContent: 'center', alignItems: 'center'}}
        onPress={() => setPwHidden(!pwHidden)}
        >
          <Image source={require('../assets/Icon/show.png')} resizeMode='stretch' style={{width: 25, height: 25}}/>
        </TouchableOpacity>
      </View>
      <View style={{width : windowWidth - 60, height: 45, marginTop: 20, marginLeft: 30, flexDirection: 'row', alignItems: 'center', backgroundColor: 'white'}}>
        <TextInput
          style={{height: '100%', flex: 1, marginLeft: 30, fontSize: 16}}
          autoCapitalize={false}
          placeholder='Confirm'
          secureTextEntry={true}
        />
        <Image source={require('../assets/Icon/confirm.png')} resizeMode='stretch' style={{width: 20, height: 20, marginRight: 10}}/>
      </View>
      <View>
        <TouchableOpacity style={{height: 50, width: '40%', justifyContent: 'center', alignItems: 'center', backgroundColor: '#229E5C', marginLeft:120, marginTop: 50, borderRadius: 100}}>
          <Text style={{color: 'white', fontSize : 16}}>Create</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
}
const Part3 = () =>{
  return(
    <View style={{width: '100%', height: '100%'}}>
      <View style={{flexDirection: 'row', justifyContent: 'center', alignItems: 'center', height: 40, width: windowWidth - 60, marginLeft: 30}}>
        <View style={{height: 1, width: '30%', backgroundColor: '#707070'}}></View>
        <Text style={{color: '#229E5C', fontSize: 20}}>Or</Text>
        <View style={{height: 1, width: '30%', backgroundColor: '#707070'}}></View>
        
      </View>
      <TouchableOpacity style={{height: 50, width: windowWidth - 60, marginLeft: 30, borderWidth: 1, marginTop: 20,flexDirection: 'row', justifyContent: 'center', alignItems: 'center', borderRadius: 100, backgroundColor: '#3982E4'}}>
        <Text style={{color: 'white', fontStyle: 'italic', fontSize: 18}}>FaceBook</Text>
      </TouchableOpacity>
      <TouchableOpacity style={{height: 50, width: windowWidth - 60, marginLeft: 30, borderWidth: 1, marginTop: 20,flexDirection: 'row', justifyContent: 'center', alignItems: 'center', borderRadius: 100, backgroundColor: '#EA4335'}}>
        <Text style={{color: 'white', fontStyle: 'italic', fontSize: 18}}>Gmail</Text>
      </TouchableOpacity>
      <TouchableOpacity style={{height: 50, width: windowWidth - 60, marginLeft: 30, borderWidth: 1, marginTop: 20,flexDirection: 'row', justifyContent: 'center', alignItems: 'center', borderRadius: 100, backgroundColor: '#24292F'}}>
        <Text style={{color: 'white', fontStyle: 'italic', fontSize: 18}}>Github</Text>
      </TouchableOpacity>
      
    </View>
  );
}