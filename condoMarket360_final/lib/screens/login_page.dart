import 'package:flutter/material.dart';
import '../data.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final senha = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 30),
                Icon(Icons.storefront_rounded, size: 80, color: theme.colorScheme.primary),
                SizedBox(height: 20),
                Text(
                  "CondoMarket 360°",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (v) => v!.isEmpty ? 'Informe seu email' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: senha,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Senha'),
                  validator: (v) => v!.length < 4 ? 'Mínimo 4 caracteres' : null,
                ),
                SizedBox(height: 24),
                FilledButton(
                  onPressed: () {
                    if (_form.currentState!.validate()) {
                      if (tipoUsuario == "vendedor") {
                        Navigator.pushReplacementNamed(context, '/stock');
                      } else {
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                    }
                  },
                  child: Text("Entrar"),
                ),
                SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => Navigator.pushNamed(context, '/signup'),
                  child: Text("Criar Conta"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}