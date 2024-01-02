
import 'package:flutter/material.dart';
import 'package:note/models/note.dart';



class edit extends StatefulWidget {
  final Note? note;
  const edit({super.key, this.note});

  @override
  State<edit> createState() => _nameState();
}

class _nameState extends State<edit> {
  TextEditingController _titleController=TextEditingController();
  TextEditingController _contentontroller=TextEditingController();

@override
  void initState() {
    
if(widget.note!=null)
{
_titleController=TextEditingController(text:widget.note!.title);
    _contentontroller=TextEditingController(text: widget.note!.content);
}



    
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    
return MaterialApp(
  debugShowCheckedModeBanner: false,
  home: Scaffold(
    backgroundColor: const Color.fromARGB(255, 107, 107, 107),
    body: Column(
      children: [
        Row(
            
           
            children: [
              
              
              Padding(
                padding: const EdgeInsets.only(top: 30,left: 15,bottom: 0),
                child: IconButton(onPressed:() {Navigator.of(context).pop();},
                 icon: Container(
                          
                  width:  40,
                  height: 40,
                  decoration: BoxDecoration(color: Color.fromARGB(255, 72, 72, 72),borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.arrow_back,color: Colors.white,))),
              )
            ],
          ),

Expanded(child: ListView(
  children: [
    Padding(
      padding: const EdgeInsets.only(left:35,top: 0),
      child: TextField(
        controller: _titleController,
        style: TextStyle(fontSize: 35,color:Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,hintText: 'Başlık',
          hintStyle: TextStyle(fontSize: 35,color:Colors.grey)
        ),
      ),
    ),

  Padding(
    padding: const EdgeInsets.only(left: 15),
    child: TextField(
      controller: _contentontroller,
          style: TextStyle(fontSize: 25,color:Colors.white),
          maxLines: null,
          decoration: InputDecoration(
            border: InputBorder.none,hintText: 'Konu',
            hintStyle: TextStyle(fontSize: 25,color:Colors.grey)
          ),
        ),
  ),

  ],
),
),
      ],
    ),
      floatingActionButton: FloatingActionButton(onPressed: (){
           Navigator.pop(context,{
            _titleController.text,
           _contentontroller.text});
        },
        child: Icon(Icons.save),),
  ),
);



}
}