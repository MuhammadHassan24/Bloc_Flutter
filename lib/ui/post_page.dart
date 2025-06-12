import 'package:bloc_counter_app/bloc/fetchdata/fetchdata_bloc.dart';
import 'package:bloc_counter_app/bloc/fetchdata/fetchdata_event.dart';
import 'package:bloc_counter_app/bloc/fetchdata/fetchdata_state.dart';
import 'package:bloc_counter_app/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  void initState() {
    context.read<FetchDataBloc>().add(PostFetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post")),
      body: BlocBuilder<FetchDataBloc, FetchDataState>(
        builder: (context, state) {
          switch (state.postStatus) {
            case PostStatus.loading:
              return Center(child: CircularProgressIndicator());
            case PostStatus.failure:
              return Center(child: Text("Error"));
            case PostStatus.success:
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  spacing: 10,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onChanged: (value) {
                        context.read<FetchDataBloc>().add(
                          SearchPost(input: value),
                        );
                      },
                    ),
                    Expanded(
                      child:
                          state.searchResult.isNotEmpty
                              ? Center(
                                child: Text(state.searchResult.toString()),
                              )
                              : ListView.builder(
                                itemCount:
                                    state.temPostList.isEmpty
                                        ? state.postList.length
                                        : state.temPostList.length,
                                itemBuilder: (context, index) {
                                  if (state.temPostList.isNotEmpty) {
                                    final post = state.temPostList[index];
                                    return Card(
                                      child: ListTile(
                                        title: Text(post.email.toString()),
                                        subtitle: Text(post.body.toString()),
                                      ),
                                    );
                                  } else {
                                    final post = state.postList[index];
                                    return Card(
                                      child: ListTile(
                                        title: Text(post.email.toString()),
                                        subtitle: Text(post.body.toString()),
                                      ),
                                    );
                                  }
                                },
                              ),
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
