import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GpuPage(),
    );
  }
}

// Виджет стал StatefulWidget — у него есть изменяемое состояние.
class GpuPage extends StatefulWidget {
  const GpuPage({super.key});

  @override
  State<GpuPage> createState() => _GpuPageState();
}

class _GpuPageState extends State<GpuPage> {
  // ===== Новая палитра (зелёно-фиолетовый неон на тёмном фоне) =====
  static const Color deepBlack = Color(0xFF0A0A12);  // фон страницы
  static const Color cardBlack = Color(0xFF16161F);  // фон карточек
  static const Color neonGreen = Color(0xFF00E676);  // главный неоновый акцент
  static const Color neonPurple = Color(0xFFB026FF); // второй неоновый акцент
  static const Color textWhite = Color(0xFFE5E7EB);

  // ===== Состояние =====
  int _currentImage = 0; // индекс текущей картинки (0..4)

  // Список из 5 изображений из ассетов
  final List<String> _images = [
    'assets/images/gpu1.png',
    'assets/images/gpu2.png',
    'assets/images/gpu3.png',
    'assets/images/gpu4.png',
    'assets/images/gpu5.png',
  ];

  // Метод изменения состояния: переводит индекс на следующий по кругу
  void _nextImage() {
    setState(() {
      _currentImage = (_currentImage + 1) % _images.length; // 0,1,2,3,4 → 0...
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepBlack,
      appBar: AppBar(
        title: const Text(
          'МИР ВИДЕОКАРТ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: neonGreen,
            letterSpacing: 2,
            fontFamily: 'OpenSans', // кастомный шрифт для заголовка
          ),
        ),
        centerTitle: true,
        backgroundColor: cardBlack,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Название карты — зелёная рамка и свечение
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: cardBlack,
                border: Border.all(color: neonGreen, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: neonGreen.withOpacity(0.3),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'NVIDIA GeForce RTX 4070',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: neonGreen,
                  letterSpacing: 1.5,
                  fontFamily: 'RussoOne', // кастомный шрифт
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Описание — фиолетовая рамка
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardBlack,
                border: Border.all(color: neonPurple, width: 1.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Графический процессор — это ключевой компонент компьютера, отвечающий за преобразование цифровых данных в визуальное изображение на экране и выполнение параллельных вычислений. Модель GeForce RTX 4070 базируется на архитектуре Ada Lovelace, поддерживает аппаратную трассировку лучей в реальном времени и функцию DLSS 3.',
                style: TextStyle(fontSize: 15, color: textWhite, height: 1.5),
                textAlign: TextAlign.justify,
              ),
            ),

            const SizedBox(height: 16),

            // Картинка + характеристики
            SizedBox(
              height: 180,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: cardBlack,
                        border: Border.all(color: neonGreen, width: 1.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      // Тап по картинке тоже переключает изображение
                      child: GestureDetector(
                        onTap: _nextImage,
                        child: Image.asset(
                          _images[_currentImage],
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: cardBlack,
                        border: Border.all(color: neonPurple, width: 1.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('1. Ada Lovelace',
                              style: TextStyle(fontSize: 14, color: textWhite)),
                          SizedBox(height: 8),
                          Text('2. 12 ГБ GDDR6X',
                              style: TextStyle(fontSize: 14, color: textWhite)),
                          SizedBox(height: 8),
                          Text('3. 5888 ядер CUDA',
                              style: TextStyle(fontSize: 14, color: textWhite)),
                          SizedBox(height: 8),
                          Text('4. 200 Вт TDP',
                              style: TextStyle(fontSize: 14, color: textWhite)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Кнопка смены изображения
            Center(
              child: ElevatedButton(
                onPressed: _nextImage, // смена по нажатию на кнопку
                style: ElevatedButton.styleFrom(
                  backgroundColor: neonGreen,
                  foregroundColor: deepBlack,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text(
                  'Следующая видеокарта',
                  style: TextStyle(fontFamily: 'RussoOne'),
                ),
              ),
            ),

            const SizedBox(height: 16),
            Divider(color: neonGreen.withOpacity(0.5), thickness: 1),
            const SizedBox(height: 16),

            // ФИО и группа
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: cardBlack,
                    border: Border.all(color: neonGreen, width: 1.5),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: neonGreen.withOpacity(0.2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.person, size: 32, color: neonGreen),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: cardBlack,
                      border: Border.all(color: neonPurple, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Половинкин Кирилл ИКБО-62-23',
                      style: TextStyle(fontSize: 15, color: textWhite),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}