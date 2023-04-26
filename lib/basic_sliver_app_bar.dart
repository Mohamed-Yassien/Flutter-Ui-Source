import 'package:flutter/material.dart';

class BasicSliverAppBar extends StatelessWidget {
  const BasicSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.amber,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ),
            ],
            expandedHeight: 250,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Basic Sliver',
              ),
              centerTitle: true,
              background: Image.network(
                'https://images.pexels.com/photos/4126318/pexels-photo-4126318.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                fit: BoxFit.cover,
              ),
              collapseMode: CollapseMode.pin,
            ),
          ),
          SliverToBoxAdapter(
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              primary: false,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return Image.network(
                  'https://images.pexels.com/photos/16106135/pexels-photo-16106135.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                  height: 100,
                  fit: BoxFit.cover,
                );
              },
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
