import 'package:flutter/material.dart'; 

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      
      backgroundColor: Color.fromARGB(255, 49, 110, 126),

      
       body: Center(
         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
         
          children: [
         
            //profile 
            SizedBox(height: 20.0,),
            CircleAvatar(
              radius: 55.0,
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
         
         
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('lib/images/bkk.jpg'),
              ),
            ), 

            //name section
            SizedBox(height: 10.0,),
            Text("Tanongsak Phetpila",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
            ),

            SizedBox(height: 5.0,),
            Text("student at King Mongkut's University of Technology north Bangkok",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 0, 0, 0),
              fontStyle: FontStyle.italic
            ),
            ),

          
            //images section
            SizedBox(height: 20.0,),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset('lib/images/237-536x354.jpg',
              height: 200.0,
              ),
            ),
            
            //welcome text section
            SizedBox(height: 20.0,),
            Text("study in the second year of the Computer Engineering technology",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
            ),
          
            //description section
            SizedBox(height: 10.0,),
            Text("This is my first flutter app, I hope you like it.",
            textAlign: TextAlign.center, 
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,              
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
            ),


            //button section
            SizedBox(height: 20.0,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                padding: EdgeInsets.symmetric(
                horizontal: 30.0, vertical: 10.0),
                
              ),
              onPressed:(){}, 
              child: Text(
                "About me",
                style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
                )),
            SizedBox(height: 12),

              // ✔ indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.circle, size: 8, color: const Color.fromARGB(255, 0, 0, 0)),
                ],
              )
          ],
         
         
        ),
       ), 
      
    );
  }
}