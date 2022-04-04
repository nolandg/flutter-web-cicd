import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

class PostsList extends StatelessWidget {
  const PostsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final postsQuery = FirebaseFirestore.instance.collection('posts').orderBy('title');

        return FirestoreQueryBuilder<Map<String, dynamic>>(
          key: snapshot.hasData ? Key(snapshot.data!.uid) : null,
          query: postsQuery,
          builder: (context, snapshot, _) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.docs.length,
              itemBuilder: (context, index) {
                if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                  snapshot.fetchMore();
                }

                final post = snapshot.docs[index].data();

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(border: BorderDirectional(bottom: BorderSide(color: Colors.black12))),
                  child: Text('${post['title']}', style: Theme.of(context).textTheme.headline6),
                );
              },
            );
          },
        );
      },
    );

    // return FirestoreListView<Map<String, dynamic>>(
    //   query: postsQuery,
    //   shrinkWrap: true,
    //   itemBuilder: (context, snapshot) {
    //     Map<String, dynamic> post = snapshot.data();

    //     return Container(
    //       padding: const EdgeInsets.all(16),
    //       decoration: const BoxDecoration(border: BorderDirectional(bottom: BorderSide(color: Colors.black12))),
    //       child: Text('${post['title']}', style: Theme.of(context).textTheme.headline6),
    //     );
    //   },
    // );
  }
}
