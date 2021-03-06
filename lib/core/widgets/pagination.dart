import 'package:flutter/material.dart';
import 'package:sp_bill/core/common/constants.dart';

class Pagination extends StatefulWidget {
  final int total;
  final Function(int) callback;
  final int current;


  const Pagination({Key key, @required this.total,@required this.callback, this.current}) : super(key: key);
  @override
  _PaginationState createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  int currentIndex ;
  @override
  void initState() {
    super.initState();
    currentIndex  = widget.current ?? 1;
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(right: 55, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children:  widget.total > 6 ? widget.total - currentIndex > 5 ? [...[
          InkWell(onTap: (){
            setState(() {
              currentIndex = 1;
            });
            widget.callback(currentIndex);
          },
              child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), child: Icon(Icons.arrow_back_ios_outlined, size: 12,),))
        ], ...List.generate(3, (index) {
          return PaginationItem(index: index + currentIndex, currentIndex: currentIndex, onPressed: () {
            setState(() {
              currentIndex = index + currentIndex;
            });
            widget.callback(currentIndex);
          },);}), ...[Container(height:33, width:33, alignment: Alignment.bottomCenter, child: Text('....',))], ...List.generate(3, (index) {
          return PaginationItem(index: index + widget.total - 3+1, currentIndex: currentIndex, onPressed: () {
            setState(() {
              currentIndex = index + widget.total - 3 + 1;
            });
            widget.callback(currentIndex);
          },);})]:[...[
          InkWell(
              onTap: (){
                setState(() {
                  currentIndex = 1;
                });
                widget.callback(currentIndex);
              }, child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), child: Icon(Icons.arrow_back_ios_outlined, size: 12,),))
        ],...List.generate(3, (index) {
          return PaginationItem(index: index + widget.total - 5, currentIndex: currentIndex, onPressed: () {
            setState(() {
              currentIndex = index + widget.total - 5;
            });
            widget.callback(currentIndex);
          },);}), ...[Container(height:33, width:33, alignment: Alignment.bottomCenter, child: Text('....',))], ...List.generate(3, (index) {
          return PaginationItem(index: index + widget.total - 3+1, currentIndex: currentIndex, onPressed: () {
            setState(() {
              currentIndex = index + widget.total - 3 +1;
            });
            widget.callback(currentIndex);
          },);})]:
          [...widget.total > 3 ? [
            InkWell(
                onTap: (){
                  setState(() {
                    currentIndex = 1;
                  });
                  widget.callback(currentIndex);
                }, child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), child: Icon(Icons.arrow_back_ios_outlined, size: 12,),))
          ] : [],...List.generate(widget.total, (index) {
            return PaginationItem(index: index + 1, currentIndex: currentIndex, onPressed: () {
              setState(() {
                currentIndex = index + 1;
              });
              widget.callback(currentIndex);
            },);})]

      ),
    );
  }
  @override
  void didUpdateWidget(covariant Pagination oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.current == 1) {
      currentIndex = 1;
    }
  }
}

class PaginationItem extends StatelessWidget{
  final int currentIndex;
  final int index;
  final VoidCallback onPressed;

  const PaginationItem({Key key, @required this.currentIndex, @required this.index, @required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          constraints: BoxConstraints(
            minWidth: 26,
            minHeight: 26
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
              color: currentIndex == index ? kGreenColor : kPaginationFill,
              border: Border.all(
                  color: currentIndex == index ? Colors.transparent : kPaginationBorder
              )
          ),
          child: Center(child: Text(index.toString(), style: currentIndex == index ? kWhiteSmallText : kBlackSmallText,)),
        ),
      ),
    );
  }

}
