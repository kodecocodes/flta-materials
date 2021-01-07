/*
 * Copyright (c) 2020 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/grocery_item.dart';

class GroceryTile extends StatelessWidget {
  // 1
  final GroceryItem item;
  // 2
  final Function(bool) onComplete;
  // 3
  final TextDecoration textDecoration;

  // 4
  GroceryTile({Key key, this.item, this.onComplete}) 
  : textDecoration = item.isComplete ? TextDecoration.lineThrough : TextDecoration.none,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
        children: [
          // 1
          Row(
            children: [
              // 2
              Container(width: 5, color: item.color),
              // 3
              SizedBox(width: 16),
              // 4
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 5
                    Text(item.name,
                        style: GoogleFonts.lato(
                            decoration: textDecoration,
                            fontSize: 21,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    buildDate(),
                    SizedBox(height: 4),
                    buildImportance()
                  ]),
            ],
          ),
          // 6
          Row(
            children: [
              // 7
              Text(item.quantity.toString(),
                  style:
                      GoogleFonts.lato(
                        decoration: textDecoration, 
                        fontSize: 21)),
              // 8
              buildCheckbox()
          ])
        ])
    );
  }

  buildImportance() {
    if (item.importance == Importance.low) {
      return Text(
        "Low", 
        style: GoogleFonts.lato(decoration: textDecoration));
    } else if (item.importance == Importance.medium) {
      return Text(
        "Medium",
        style: GoogleFonts.lato(fontWeight: FontWeight.w800, decoration: textDecoration));
    } else if (item.importance == Importance.high) {
      return Text(
        "High",
        style: GoogleFonts.lato(color: Colors.red, fontWeight: FontWeight.w900, decoration: textDecoration));
    } else {
      throw Exception("This importance type does not exist");
    }
  }

  buildDate() {
    var dateFormatter = DateFormat('MMMM dd h:mm a');
    var dateString = dateFormatter.format(item.date);
    return Text(
      dateString, 
      style: TextStyle(
        decoration: textDecoration));
  }

  buildCheckbox() {
    return Checkbox(
      // 1
      value: item.isComplete, 
      // 2
      onChanged: onComplete);
  }
}

