part of view;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();
  late Future<Agency> futureAgency;

  @override
  void initState() {
    super.initState();
    futureAgency = API().fetchAgency('NSA');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OpenGSA Search'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                'OpenGSA Search',
                style: TextStyle(color: Color(0xFF003C71), fontSize: 20.0),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Ex. \'NSA\'',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: OutlinedButton(
                onPressed: () {
                  print('Submit');
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Color(0xFF003C71),
                  ),
                ),
              ),
            ),
            FutureBuilder<Agency>(
              future: futureAgency,
              builder: (context, snapshot) {
                print(snapshot);
                if (snapshot.hasData) {
                  return Text(snapshot.data!.name);
                } else if (snapshot.hasError) {
                  // print('${snapshot.error}');
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }
}
