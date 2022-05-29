part of view;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  late Future<List<Agency>> futureAgencies;
  bool inputSubmitted = false;

  @override
  void initState() {
    super.initState();
    futureAgencies = API().fetchAgencies('NSA');
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OpenGSA Search'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            children: <Widget>[
              RichText(
                text: TextSpan(
                  style: TextStyle(
                      color: const Color(0xFF003C71),
                      fontSize: 60.0,
                      fontFamily: GoogleFonts.trirong().fontFamily),
                  children: const <TextSpan>[
                    TextSpan(text: 'open'),
                    TextSpan(
                      text: 'GSA',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    inputSubmitted = false;
                    return 'Please enter some text';
                  }
                  return null;
                },
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
              const SizedBox(
                height: 20.0,
              ),
              OutlinedButton(
                onPressed: () {
                  inputSubmitted = true;
                  if (_formKey.currentState!.validate()) {
                    inputSubmitted = true;
                    futureAgencies = API().fetchAgencies(_controller.text);
                  }

                  setState(() {});
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Color(0xFF003C71),
                  ),
                ),
              ),
              inputSubmitted
                  ? FutureBuilder<List<Agency>>(
                      future: futureAgencies,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50.0, vertical: 10.0),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                onTap: () => _launchURL(
                                    snapshot.data!.elementAt(index).infoUrl),
                                title:
                                    Text(snapshot.data!.elementAt(index).name),
                                subtitle: Text(
                                    snapshot.data!.elementAt(index).infoUrl),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          print('${snapshot.error}');
                          return const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50.0),
                            child: Text('Sorry, something went wrong.'),
                          );
                        }
                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
