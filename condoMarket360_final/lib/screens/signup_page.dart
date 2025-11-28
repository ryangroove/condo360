// Local: lib/screens/signup_page.dart
import 'package:flutter/material.dart';
import '../data.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nome = TextEditingController();
  final email = TextEditingController();
  final senha = TextEditingController();
  final _form = GlobalKey<FormState>();

  String tipoSelecionado = "comprador";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Criar Conta")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Selecione o tipo de usuário",
                style: TextStyle(fontSize: 18, color: Colors.green.shade800),
              ),

              // --- Radio Comprador ---
              RadioListTile(
                title: Text("Comprador"),
                value: "comprador",
                activeColor: Colors.green,
                groupValue: tipoSelecionado,
                onChanged: (v) => setState(() => tipoSelecionado = v!),
              ),

              // --- Radio Vendedor ---
              RadioListTile(
                title: Text("Vendedor"),
                value: "vendedor",
                activeColor: Colors.green,
                groupValue: tipoSelecionado,
                onChanged: (v) => setState(() => tipoSelecionado = v!),
              ),

              SizedBox(height: 12),

              // --- Nome ---
              TextFormField(
                controller: nome,
                decoration: InputDecoration(labelText: 'Nome Completo'),
                validator: (v) => v!.isEmpty ? 'Informe seu nome' : null,
              ),

              SizedBox(height: 12),

              // --- Email ---
              TextFormField(
                controller: email,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (v) => v!.isEmpty ? 'Informe seu email' : null,
              ),

              SizedBox(height: 12),

              // --- Senha ---
              TextFormField(
                controller: senha,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Senha'),
                validator: (v) => v!.length < 4 ? 'Mínimo 4 caracteres' : null,
              ),

              SizedBox(height: 24),

              // --- BOTÃO CORRIGIDO ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_form.currentState!.validate()) {
                      tipoUsuario = tipoSelecionado;

                      if (tipoUsuario == "vendedor") {
                        Navigator.pushReplacementNamed(context, '/stock');
                      } else {
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                    }
                  },
                  child: Text(
                    "Cadastrar",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}