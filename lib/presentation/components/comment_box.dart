import 'package:flutter/material.dart';

class CommentBox extends StatelessWidget {
  final String username;
  final String comment;

  const CommentBox({
    super.key,
    required this.username,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: const DecorationImage(
                          image: NetworkImage('https://picsum.photos/200/300'),
                          fit: BoxFit.cover)),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$username • thus ',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ],
                ),
                const Spacer(),
                // Container(
                //   height: 25,
                //   alignment: Alignment.center,
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(25),
                //       color: Colors.grey.withOpacity(0.1)),
                //   child: Text(
                //     widget.name,
                //     style:
                //         const TextStyle(fontSize: 14, color: Colors.blue),
                //   ),
                // ),
                const SizedBox(width: 5),
                const Icon(Icons.more_vert)
              ],
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                comment,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ));
  }
}
