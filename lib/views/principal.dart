import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dartz/application/cubito.dart';
import 'package:flutter_dartz/application/information.dart';
import 'package:flutter_dartz/main.dart';
import 'package:flutter_dartz/models/student.dart';
import 'package:flutter_dartz/repo/repository.dart';

class Principal extends StatelessWidget {
  const Principal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Cubito(Repository()),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Consumo de Servicios Web"),
        ),
        body: BlocConsumer<Cubito, Information>(
          listenWhen: (lastState, currentState) => currentState.message != '',
          listener: (_contextListener, state) {
            if (state.message != '') {
              ScaffoldMessenger.of(_contextListener).showSnackBar(SnackBar(
                content: Text(state.message),
              ));
            }
          },
          builder: (_contextBuilder, state) {
            Widget _widget;
            if (state.students.isEmpty) {
              _widget = Container(
                padding: EdgeInsets.all(15),
                child: Center(
                  child: Text(
                    "No Students",
                    style: TextStyle(
                        fontSize: 30,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              );
            } else {
              _widget = ListView.builder(
                itemCount: state.students.length,
                itemBuilder: (context, i) {
                  Student _student = state.students[i];
                  return ListTile(
                    trailing: i == state.selected
                        ? IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              context.read<Cubito>().deleteStudent(_student);
                            },
                          )
                        : Container(
                            height: 0,
                            width: 0,
                          ),
                    selected: i == state.selected,
                    selectedTileColor: Theme.of(context).primaryColor,
                    title: Text(
                      _student.name,
                      style: TextStyle(
                          color: i == state.selected ? Colors.white : null),
                    ),
                    onTap: () {
                      context.read<Cubito>().changeSelected(i);
                    },
                  );
                },
              );
            }

            return Column(
              children: [
                Container(
                    child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _contextBuilder.read<Cubito>().editStudent();
                      },
                    ),
                    Expanded(child: TextField(
                      onChanged: (text) {
                        _contextBuilder.read<Cubito>().changeText(text);
                      },
                    )),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        _contextBuilder.read<Cubito>().addStudent();
                      },
                    )
                  ],
                )),
                Expanded(child: _widget)
              ],
            );
          },
        ),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: FloatingActionButton(
                child: Icon(Icons.brightness_6),
                onPressed: () => context.read<ThemeCubit>().toggleTheme(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
