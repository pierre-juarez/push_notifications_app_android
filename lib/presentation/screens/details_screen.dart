import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app/config/domain/entities/push_message.dart';
import 'package:push_app/presentation/blocs/notifications/notifications_bloc.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.pushMessageID});

  final String pushMessageID;

  @override
  Widget build(BuildContext context) {
    final PushMessage? message = context.watch<NotificationsBloc>().getMessageById(pushMessageID);

    return Scaffold(
      appBar: AppBar(title: Text('Detalles push')),
      body: message != null ? _DetailsView(message: message) : Center(child: Text("Notificacion no encontrada")),
    );
  }
}

class _DetailsView extends StatelessWidget {
  const _DetailsView({required this.message});

  final PushMessage message;

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          if (message.imageUrl != null) Image.network(message.imageUrl!),

          SizedBox(height: 30),

          Text(message.title, style: textStyles.titleMedium),
          Text(message.body),
          Divider(),
          Text(message.data.toString()),
        ],
      ),
    );
  }
}
