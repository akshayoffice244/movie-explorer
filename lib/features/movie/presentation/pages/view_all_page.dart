import 'package:flutter/material.dart';
import 'package:movies_explorer/core/widgets/custom_text.dart';

class ViewAllPage extends StatefulWidget {
  const ViewAllPage({super.key});

  @override
  State<ViewAllPage> createState() => _ViewAllPageState();
}

class _ViewAllPageState extends State<ViewAllPage> {
  int maxPage = 103;
  int currentPage = 1;
  List<int> pages = [1, 2, 3, 4];

  void increase(){


      if(pages.last == currentPage && maxPage - currentPage >= 1 || pages.last ==  pages.first){
        List<int> newPages = [];
        for(int i = 0; i < 4; i++ ){
          if(maxPage - (currentPage + i) >= 0) {
            newPages.add(currentPage + i);
          }
        }
        pages = newPages;


      }
      if(currentPage < maxPage ){
        currentPage++;
      }
  }

  void decrease(){
    if(currentPage > 1){
      currentPage--;
    }

    if(pages.first == currentPage && pages.first != 1){
      List<int> newPages = [];
      for(int i =0; i < 4; i++){
        if(pages.first - i > 0) {
          newPages.add(pages.first - i);
        }
      }
      pages = newPages.reversed.toList();
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(

        children: [
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: .center,
              children: [
                IconButton(onPressed: () {
                      setState(() {
                        decrease();
                      });
                }, icon: Icon(Icons.arrow_back)),

                Center(
                  child: ListView.builder(

                    scrollDirection: .horizontal,
                    shrinkWrap: true,
                    itemCount: pages.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 40,
                        child: Container(
                          color: pages[index] == currentPage ? Colors.deepPurple : Colors.deepOrange,
                          child: TextButton(

                            onPressed: () {

                              print("index: ${pages[index]}");
                            },
                            child: CustomText(text: "${pages[index]}"),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                IconButton(onPressed: () {

                  setState(() {
                    increase();
                  });

                }, icon: Icon(Icons.arrow_forward)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
