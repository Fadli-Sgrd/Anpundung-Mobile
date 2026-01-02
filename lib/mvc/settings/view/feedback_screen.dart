import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int rating = 0;
  final TextEditingController feedbackController = TextEditingController();
  String selectedCategory = "Umum";

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text("Rating & Feedback", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF163172),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF1E56A0), Color(0xFF163172)], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(20)),
              child: const Column(children: [Icon(Icons.star, color: Colors.orange, size: 50), SizedBox(height: 10), Text("Berikan Feedback Anda", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), SizedBox(height: 8), Text("Bantu kami meningkatkan aplikasi dengan feedback Anda", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 12))]),
            ),
            const SizedBox(height: 30),
            const Text("Rating Aplikasi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF163172))),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))]),
              child: Column(children: [
                const Text("Berapa rating untuk aplikasi Anpundung?", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(5, (index) => GestureDetector(onTap: () => setState(() => rating = index + 1), child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Icon(Icons.star, size: 40, color: index < rating ? Colors.orange : Colors.grey[300]))))),
                const SizedBox(height: 12),
                if (rating > 0) Text(_getRatingLabel(rating), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1E56A0))),
              ]),
            ),
            const SizedBox(height: 30),
            const Text("Kategori Feedback", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF163172))),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFD6E4F0))),
              child: DropdownButton<String>(isExpanded: true, value: selectedCategory, underline: const SizedBox(), items: const [DropdownMenuItem(value: "Umum", child: Text("Umum")), DropdownMenuItem(value: "Bug/Masalah", child: Text("Bug/Masalah")), DropdownMenuItem(value: "Fitur", child: Text("Saran Fitur")), DropdownMenuItem(value: "UI/UX", child: Text("UI/UX")), DropdownMenuItem(value: "Performa", child: Text("Performa")), DropdownMenuItem(value: "Lainnya", child: Text("Lainnya"))], onChanged: (val) { if (val != null) setState(() => selectedCategory = val); }),
            ),
            const SizedBox(height: 30),
            const Text("Detail Feedback", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF163172))),
            const SizedBox(height: 15),
            TextField(controller: feedbackController, maxLines: 5, decoration: InputDecoration(hintText: "Ceritakan feedback Anda di sini...", alignLabelWithHint: true, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFD6E4F0))), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFD6E4F0))), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF1E56A0), width: 2)), filled: true, fillColor: Colors.white, contentPadding: const EdgeInsets.all(16))),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity, height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E56A0), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 5),
                onPressed: () {
                  if (rating == 0) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Berikan rating terlebih dahulu!"))); return; }
                  if (feedbackController.text.isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Tulis feedback Anda!"))); return; }
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Terima kasih! Feedback Anda telah dikirim."), duration: Duration(seconds: 2)));
                  setState(() { rating = 0; selectedCategory = "Umum"; feedbackController.clear(); });
                },
                child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.send, color: Colors.white), SizedBox(width: 8), Text("Kirim Feedback", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))]),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFBBDEFB))),
              child: Row(children: [const Icon(Icons.info_outline, color: Color(0xFF1976D2), size: 20), const SizedBox(width: 12), Expanded(child: Text("Feedback Anda sangat membantu kami untuk terus berkembang", style: TextStyle(fontSize: 12, color: Colors.grey[800])))]),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  String _getRatingLabel(int rating) {
    switch (rating) {
      case 1: return "Sangat Buruk 😞";
      case 2: return "Buruk 😕";
      case 3: return "Cukup 😐";
      case 4: return "Bagus 😊";
      case 5: return "Sangat Bagus 😍";
      default: return "";
    }
  }
}
