import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note/constants/colors.dart';
import 'package:note/edit.dart';
import 'package:note/models/note.dart';
// ignore: camel_case_types
class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

// ignore: camel_case_types
class _homeState extends State<home> {

List<Note>filtereedNotes=[];

  

@override
void initState(){
  super.initState();
  filtereedNotes=sampleNotes;
}




  getRandomColor(){
    Random random =Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }



void delete (int index){
  setState(() {
    filtereedNotes.removeAt(index);
  });
}



  void onSearchTextChnaged(String searchtext){
    setState(() {
       filtereedNotes=sampleNotes.where((note) => 
  note.content.toLowerCase().contains(searchtext.toLowerCase()) ||
   note.title.toLowerCase().contains(searchtext.toLowerCase()) 
  
  ) .toList();
    });
 


}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {'/edit': (context) => const edit()},
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 107, 107, 107),
        
        body: Column(children: [
          const Padding(padding: EdgeInsets.only(top: 38.5)),
          Row(
            
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
              const Padding(
                padding: EdgeInsets.only(left:15.0),
                child: Text('Notes',style: TextStyle(fontSize: 30,color:Colors.white,)),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: IconButton(onPressed:() {},
                 icon: Container(
                          
                  width:  40,
                  height: 40,
                  decoration: BoxDecoration(color: Color.fromARGB(255, 72, 72, 72),borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.sort,color: Colors.white,))),
              )
            ],
          ),

         
     Container(
      
      decoration: BoxDecoration(
          
              color:  Colors.grey,
        borderRadius: BorderRadius.circular(30)
      ),
      margin: EdgeInsets.only(right: 10,left: 10,top: 20),
      
padding: EdgeInsets.only(right: 15,left: 15,top: 5,bottom: 5),   
          child: TextFormField(
            onChanged: onSearchTextChnaged,

            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "Notlarda ara",
              labelStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(Icons.search,color: Colors.white,),
             
              border: InputBorder.none
            ),
          ),
      
     ),
Expanded(child: ListView.builder(
itemCount: filtereedNotes.length,
itemBuilder: (context,index){
return Padding(
  padding: const EdgeInsets.only(right: 15,left: 15),
  child:   Card(
    color: getRandomColor(),
    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child:   ListTile (
      onTap: () async{
       final result=  await Navigator.push(
            context,MaterialPageRoute(builder: (context)=>edit(note:filtereedNotes[index])
          ),

           ); 
           if(result != null){
    setState(() {
             
           int orginalIndex=sampleNotes.indexOf(filtereedNotes[index]);
           
            sampleNotes[orginalIndex]=
       Note(id: sampleNotes[orginalIndex].id,
             title: result[0],
              content: result[1], 
              modifiedTime:DateTime.now());
          
          
            filtereedNotes[index]=Note(
              id: filtereedNotes[orginalIndex].id,
               title: result[0],
                content: result[1], 
                modifiedTime: DateTime.now());
           

           }
           );
           
     }
      },
      title: RichText( 
        text: TextSpan(
        text: '${filtereedNotes[index].title}\n',
        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontWeight: FontWeight.bold,
        fontSize: 18,
        height: 1.5,
        ),
        children: [  
          TextSpan(text: '${filtereedNotes[index].content}',
          style:TextStyle(color: const Color.fromARGB(255, 139, 136, 136),fontWeight: FontWeight.normal,height: 1.5) ),
        ]
      )
      ),
  
    subtitle: Text('${DateFormat('EEE MMM d, yyyy h:mm a').format(sampleNotes[index].modifiedTime)}'),
    trailing: 
        IconButton(onPressed: ()async{
      final result = await showDialog(
     context: context,
       builder: (BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey,
      icon: Icon(Icons.info),
      title: Text('Oluşturduğunuz not silinsin mi?'),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
       
      delete(index);
    Navigator.of(context).pop();
            },
            child: Text(
              'Evet',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.of(context).pop(); // AlertDialog'ı kapat
            },
            child: Text(
              'Hayır',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
   
  },
  
);


  },
      icon: Icon(Icons.delete),
  ),
    ),
  
  ),
);
},

)
)
        ]


        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
          final result=  await Navigator.push(
            context,MaterialPageRoute(builder: (BuildContext context)=>edit()
          ),

           ); 


          if(result!=null){
           setState(() {
              
  sampleNotes.add(
    Note(
      id: sampleNotes.length,
       title:result[0],
        content: result[1],
         modifiedTime: DateTime.now()));
  filtereedNotes=sampleNotes;
            });
          
        }

         
        },
        child: Icon(Icons.add),),
      ),
    );
  }
}








   