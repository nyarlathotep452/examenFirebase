//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController nombre = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController telefono = TextEditingController();

  final _formLogin = GlobalKey<FormState>();
  ScrollController? controller;
  List allData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void _delete(String nombre) async {
    try {
      firestore.collection('users').doc(nombre).delete();
    } catch (e) {
      print(e);
    }
  }

  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('users');

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    // Get data from docs and convert map to List
    setState(() {
      allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    });
    //return personaFromJson(allData);
    print(allData);
  }

  void _update(
      String nombre, String descripcion, int numero, String correo) async {
    try {
      firestore.collection('users').doc(nombre).update({
        'nombre': nombre, // John Doe
        'descripcion': descripcion, // Stokes and Sons
        'telefono': numero,
        'correo_electronico': correo,
      });
    } catch (e) {
      print(e);
    }
  }

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(
      String nombre, String descripcion, int numero, String correo) {
    // Call the user's CollectionReference to add a new user
    return users
        .doc(nombre)
        .set({
          'nombre': nombre, // John Doe
          'descripcion': descripcion, // Stokes and Sons
          'telefono': numero,
          'correo_electronico': correo, // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void _showDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Agregar producto"),
          content: Form(
              child: Column(
            key: _formLogin,
            children: [
              TextFormField(
                controller: nombre,
                maxLength: 80,
                decoration: InputDecoration(labelText: 'nombre'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Debes llenar todos los campos';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: descripcion,
                maxLength: 250,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Debes llenar todos los campos';
                  }

                  return null;
                },
                decoration: InputDecoration(labelText: 'descripcion'),
              ),
              TextFormField(
                controller: correo,
                maxLength: 250,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'correo electronico'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Debes llenar todos los campos';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: telefono,
                maxLength: 10,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'telefono'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Debes llenar todos los campos';
                  }

                  return null;
                },
              ),
            ],
          )),
          actions: <Widget>[
            new ElevatedButton(
              child: new Text("agregar"),
              onPressed: () {
                addUser(nombre.text, descripcion.text, int.parse(telefono.text),
                    correo.text);

                getData();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    dismissDirection: DismissDirection.vertical,
                    duration: Duration(milliseconds: 100),
                    content: Text('La base de datos ha sido actualizada')));
                nombre.clear();
                descripcion.clear();
                telefono.clear();
                correo.clear();
                Navigator.of(context).pop();
              },
            ),
            new ElevatedButton(
              child: new Text("cancelar"),
              onPressed: () {
                nombre.clear();
                descripcion.clear();
                telefono.clear();
                correo.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogA(
    BuildContext context,
  ) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Agregar producto"),
          content: Form(
              child: Column(
            key: _formLogin,
            children: [
              TextFormField(
                controller: descripcion,
                maxLength: 250,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Debes llenar todos los campos';
                  }

                  return null;
                },
                decoration: InputDecoration(labelText: 'descripcion'),
              ),
              TextFormField(
                controller: correo,
                maxLength: 250,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'correo electronico'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Debes llenar todos los campos';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: telefono,
                maxLength: 10,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'telefono'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Debes llenar todos los campos';
                  }

                  return null;
                },
              ),
            ],
          )),
          actions: <Widget>[
            new ElevatedButton(
              child: new Text("actualizar"),
              onPressed: () {
                _update(nombre.text, descripcion.text, int.parse(telefono.text),
                    correo.text);

                getData();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    dismissDirection: DismissDirection.vertical,
                    duration: Duration(milliseconds: 100),
                    content: Text('La base de datos ha sido actualizada')));
                nombre.clear();
                descripcion.clear();
                telefono.clear();
                correo.clear();
                Navigator.of(context).pop();
              },
            ),
            new ElevatedButton(
              child: new Text("cancelar"),
              onPressed: () {
                nombre.clear();
                descripcion.clear();
                telefono.clear();
                correo.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('crud'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: controller,
              padding: const EdgeInsets.all(8),
              itemCount: allData.length,
              itemBuilder: (context, position) {
                var item = allData[position];
                var telefonoD = item['telefono'].toString();
                return Container(
                  child: Column(
                    children: [
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.contact_mail),
                          title: Text(item['nombre']),
                          subtitle: Column(
                            children: [
                              Text('descripcion: ${item['descripcion']}'),
                              //       Text(
                              //   item['correo_electronico']
                              // ),
                              Text('telefono: $telefonoD'),
                              //       Text(
                              //   item['estado_civil']
                              // ),
                            ],
                          ),
                          trailing: SingleChildScrollView(
                            child: Column(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    _delete(item['nombre']);
                                    setState(() {
                                      getData();
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            dismissDirection:
                                                DismissDirection.vertical,
                                            duration:
                                                Duration(milliseconds: 100),
                                            content: Text(
                                                'La base de datos ha sido actualizada')));
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    nombre.text = item['nombre'];
                                    correo.text = item['correo_electronico'];
                                    telefono.text = item['telefono'].toString();
                                    descripcion.text = item['descripcion'];

                                    _showDialogA(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                          isThreeLine: true,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
