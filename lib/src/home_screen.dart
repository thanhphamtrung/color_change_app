import 'package:flutter/material.dart';

import 'package:color_change_app/src/helper/app_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  Color backgroundColor = AppHelper.randomColorGenerator();
  List<Color> colorHistory = [];
  bool isEnableColorPalette = false;
  List<Color> colorPalette = AppHelper.randomColorPaletteGenerator();

  void changeBackgroundColor({Color? color}) {
    setState(() {
      isEnableColorPalette = false;
      backgroundColor = color ?? AppHelper.randomColorGenerator();
    });
    colorHistory.add(backgroundColor);
  }

  @override
  Widget build(BuildContext context) {
    Color foregroundColor =
        backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    var textStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: foregroundColor,
    );

    return Scaffold(
        key: _key,
        body: GestureDetector(
          onTap: changeBackgroundColor,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(color: backgroundColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text('Hello there', style: textStyle),
                ),
                const SizedBox(height: 20),
                if (isEnableColorPalette)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: colorPalette
                        .map(
                          (color) => GestureDetector(
                            onTap: () => changeBackgroundColor(color: color),
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _key.currentState?.openDrawer();
          },
          child: const Icon(Icons.menu),
        ),
        drawer: Drawer(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                title: Text(
                  'Color History',
                  style: textStyle,
                ),
                tileColor: backgroundColor,
                onTap: () {
                  setState(() {
                    isEnableColorPalette = false;
                  });
                  Navigator.pop(context);
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Scaffold(
                          backgroundColor: backgroundColor,
                          bottomNavigationBar: Padding(
                            padding: const EdgeInsets.only(bottom: 24.0),
                            child: TextButton(
                              child: Text(
                                'Clear All',
                                style: textStyle,
                              ),
                              onPressed: () {
                                setState(() {
                                  colorHistory.clear();
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          body: colorHistory.isNotEmpty
                              ? ListView.builder(
                                  itemCount: colorHistory.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final color = colorHistory[index];
                                    return ListTile(
                                      title: Text(index.toString()),
                                      tileColor: color,
                                      onTap: () {
                                        setState(() {
                                          backgroundColor = colorHistory[index];
                                        });
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                )
                              : const Center(
                                  child: Text('There is no history'),
                                ),
                        );
                      });
                },
              ),
              const SizedBox(height: 30),
              ListTile(
                title: Text('Random From A Palette', style: textStyle),
                tileColor: backgroundColor,
                onTap: () {
                  setState(() {
                    isEnableColorPalette = true;
                    colorPalette = AppHelper.randomColorPaletteGenerator();
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ));
  }
}
