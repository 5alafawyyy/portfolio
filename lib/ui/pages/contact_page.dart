import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../core/theme/app_theme.dart';
import 'dart:ui';
import 'package:flutter_animate/flutter_animate.dart';

// Bloc Events
abstract class ContactFormEvent {}

class ContactFormNameChanged extends ContactFormEvent {
  final String name;
  ContactFormNameChanged(this.name);
}

class ContactFormEmailChanged extends ContactFormEvent {
  final String email;
  ContactFormEmailChanged(this.email);
}

class ContactFormMessageChanged extends ContactFormEvent {
  final String message;
  ContactFormMessageChanged(this.message);
}

class ContactFormSubmitted extends ContactFormEvent {}

// Bloc State
class ContactFormState {
  final String name;
  final String email;
  final String message;
  final bool loading;
  final String? feedback;
  final bool success;
  const ContactFormState({
    this.name = '',
    this.email = '',
    this.message = '',
    this.loading = false,
    this.feedback,
    this.success = false,
  });
  ContactFormState copyWith({
    String? name,
    String? email,
    String? message,
    bool? loading,
    String? feedback,
    bool? success,
  }) => ContactFormState(
    name: name ?? this.name,
    email: email ?? this.email,
    message: message ?? this.message,
    loading: loading ?? this.loading,
    feedback: feedback,
    success: success ?? false,
  );
}

// Bloc
class ContactFormBloc extends Bloc<ContactFormEvent, ContactFormState> {
  ContactFormBloc() : super(const ContactFormState()) {
    on<ContactFormNameChanged>((e, emit) => emit(state.copyWith(name: e.name)));
    on<ContactFormEmailChanged>(
      (e, emit) => emit(state.copyWith(email: e.email)),
    );
    on<ContactFormMessageChanged>(
      (e, emit) => emit(state.copyWith(message: e.message)),
    );
    on<ContactFormSubmitted>(_onSubmit);
  }

  Future<void> _onSubmit(
    ContactFormSubmitted event,
    Emitter<ContactFormState> emit,
  ) async {
    emit(state.copyWith(loading: true, feedback: null, success: false));
    const serviceId = '5alafawyyy';
    const templateId = 'template_nrrebts';
    const publicKey = 'REPeqWYLJgcPmHLhz';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': publicKey,
        'template_params': {
          'name': state.name,
          'email': state.email,
          'message': state.message,
        },
      }),
    );
    if (response.statusCode == 200) {
      emit(
        const ContactFormState(
          feedback: 'Message sent successfully!',
          success: true,
        ),
      );
    } else {
      emit(
        state.copyWith(
          loading: false,
          feedback: 'Failed to send message. Please try again.',
          success: false,
        ),
      );
    }
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [Color(0xFFF5EFE7), Color(0xFFE6DCC2), Color(0xFFD6C89C)],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.75),
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.mochaMousse.withValues(
                                  alpha: 0.10,
                                ),
                                blurRadius: 32,
                                offset: const Offset(0, 12),
                              ),
                            ],
                            border: Border.all(
                              color: AppTheme.mochaMousse.withValues(
                                alpha: 0.18,
                              ),
                              width: 1.5,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 36,
                          ),
                          child: BlocProvider(
                            create: (_) => ContactFormBloc(),
                            child: BlocBuilder<
                              ContactFormBloc,
                              ContactFormState
                            >(
                              builder: (context, state) {
                                final bloc = context.read<ContactFormBloc>();
                                return Form(
                                  key: formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppTheme.mochaMousse
                                                .withValues(alpha: 0.13),
                                            shape: BoxShape.circle,
                                          ),
                                          padding: const EdgeInsets.all(20),
                                          child: Icon(
                                            Icons.mail_rounded,
                                            size: 54,
                                            color: AppTheme.mochaMousse,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 28),
                                      TextFormField(
                                        initialValue: state.name,
                                        decoration: InputDecoration(
                                          labelText: 'Name',
                                          prefixIcon: const Icon(
                                            Icons.person_outline,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppTheme.mochaMousse,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                          ),
                                        ),
                                        onChanged:
                                            (v) => bloc.add(
                                              ContactFormNameChanged(v),
                                            ),
                                        validator:
                                            (v) =>
                                                v == null || v.isEmpty
                                                    ? 'Enter your name'
                                                    : null,
                                      ),
                                      const SizedBox(height: 18),
                                      TextFormField(
                                        initialValue: state.email,
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                          prefixIcon: const Icon(
                                            Icons.email_outlined,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppTheme.mochaMousse,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                          ),
                                        ),
                                        onChanged:
                                            (v) => bloc.add(
                                              ContactFormEmailChanged(v),
                                            ),
                                        validator:
                                            (v) =>
                                                v == null || !v.contains('@')
                                                    ? 'Enter a valid email'
                                                    : null,
                                      ),
                                      const SizedBox(height: 18),
                                      TextFormField(
                                        initialValue: state.message,
                                        decoration: InputDecoration(
                                          labelText: 'Message',
                                          prefixIcon: const Icon(
                                            Icons.edit_outlined,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppTheme.mochaMousse,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                          ),
                                        ),
                                        minLines: 4,
                                        maxLines: 8,
                                        onChanged:
                                            (v) => bloc.add(
                                              ContactFormMessageChanged(v),
                                            ),
                                        validator:
                                            (v) =>
                                                v == null || v.isEmpty
                                                    ? 'Enter your message'
                                                    : null,
                                      ),
                                      const SizedBox(height: 32),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppTheme.mochaMousse,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 18,
                                          ),
                                          textStyle: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                          ),
                                          elevation: 2,
                                        ),
                                        onPressed:
                                            state.loading
                                                ? null
                                                : () {
                                                  if (formKey.currentState
                                                          ?.validate() ??
                                                      false) {
                                                    bloc.add(
                                                      ContactFormSubmitted(),
                                                    );
                                                  }
                                                },
                                        child:
                                            state.loading
                                                ? const SizedBox(
                                                  width: 24,
                                                  height: 24,
                                                  child:
                                                      CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        color: Colors.white,
                                                      ),
                                                )
                                                : const Text('Send'),
                                      ),
                                      if (state.feedback != null) ...[
                                        const SizedBox(height: 20),
                                        Text(
                                          state.feedback!,
                                          style: TextStyle(
                                            color:
                                                state.success
                                                    ? Colors.green
                                                    : Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 700.ms)
                      .slideY(begin: 0.1, end: 0, duration: 700.ms),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
