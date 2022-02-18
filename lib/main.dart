import 'package:flutter/material.dart';
import 'basepreguntas.dart';
 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Practica 13 Grupo 3'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
  
//Rodrigo
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int score = 0;
  int img = 0;

  List<Map<String, dynamic>> datos = [];

  bool _isLoading = true;
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      datos = data;
      _isLoading = false;
    });
  }
  

  @override
  void initState() {
    super.initState();
    _refreshJournals(); 
  }
//////////

  @override
  Widget build(BuildContext context) {
    //Diego
    _addItem();
     String pregunta,r1,r2,r3,image;
     image = img.toString();
     int rc=0;
     bool _visible=true;
     
    try{
      if(_counter==10){
        pregunta = '\n\n\nGanador';
        r1 = '';
        r2 = '';
        r3 = '';
        rc = 0;
        _visible=false;
      }else{
        if(img == 6){
          pregunta = '\n\n\nPerdedor';
          r1 = '';
          r2 = '';
          r3 = '';
          rc = 0;
          _visible=false;
        }else{
          pregunta = '\n\n\n'+datos[_counter]['pregunta'];
          r1 = datos[_counter]['r1'];
          r2 = datos[_counter]['r2'];
          r3 = datos[_counter]['r3'];
          rc = datos[_counter]['rc'];
        } 
      }
    }catch(e){
      pregunta = e.toString() + '\nno vale';
      r1 = '';
      r2 = '';
      r3 = '';
      rc = 0;
    }
    ///////
    
    //Suany
    const double kDefaultPadding = 5.0;
    return Container(
      
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      
      child: Column(
        
        children: [
          Text(
            pregunta + '\n',
            style: Theme.of(context)
                .textTheme
                .headline6
          ),
          
          Opacity(
                opacity: _visible ? 1.0 : 0.0,
                child: ButtonBar(
                  children: [
                    RaisedButton(
                  child: Text(
                    r1,
                  ),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {
                    if(rc == 1){
                      if(_counter < 4){
                      _counter++;
                      score++;
                      }else{
                        _counter= 10;
                      }
                    }else{
                      score--;
                      img++;
                    }                    
                  },
                ),
                RaisedButton(
                  child: Text(r2),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {
                    if(rc == 2){
                      if(_counter < 4){
                      _counter++;
                      score++;
                      }else{
                        _counter= 10;
                      }
                    }else{
                      score--;
                      img++;
                    }                   
                  },
                ),
                RaisedButton(
                  child: Text(r3),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {
                    if(rc == 3){
                      if(_counter < 4){
                      _counter++;
                      score++;
                      }else{
                        _counter= 10;
                      }
                    }else{
                      score--;
                      img++;
                    }                   
                  },
                ),
                  ],
                ),
              
              ),
/////////////
///Ivan
          Text(
            'Score: '+score.toString(),
          ),
          Spacer(flex: 1,),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image(
              color: Colors.black,
              height: 300,
              //fit: BoxFit.fitWidth,
              filterQuality: FilterQuality.high,
              image: AssetImage('assets/$image.png'),
            ),
          ),

          Opacity(
            opacity: !_visible ? 1.0 : 0.0,
            child: FloatingActionButton(
              onPressed: () {
                score = 0;
                img=0;
                _counter=0;
              },
              child: Icon(Icons.refresh_outlined),
              ),
            )

        ],
      ),
      
    );
  }


  Future<void> _addItem() async {
    await SQLHelper.createItem();
    _refreshJournals();
  }
  
}
/////