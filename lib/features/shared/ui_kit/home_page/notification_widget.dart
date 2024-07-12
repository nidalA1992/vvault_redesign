import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../home_screen/presentation/home_page/provider/notifications_provider.dart';
import '../../../home_screen/presentation/p2p_market/my_deals/deal_extended_page.dart';
import 'notification_model.dart';

String formatLimit(String limit) {
  if (limit == null || limit.isEmpty) return '0.00';
  try {
    double value = double.parse(limit);
    return value.toStringAsFixed(2);
  } catch (e) {
    return '0.00';
  }
}

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const NotificationItem({required this.notification});

  @override
  Widget build(BuildContext context) {
    switch (notification.type) {
      case 'new_login_occurred':
        return _buildNewLoginOccurred(context);
      case 'deal_approved_for_fiat_handler':
        return _buildDealApprovedForFiatHandler(context);
      case 'deal_cancelled_for_crypto_handler_after_time':
        return _buildDealCancelledForCryptoHandlerAfterTime(context);
      case 'deal_time_almost_ended':
        return _buildDealTimeAlmostEnded(context);
      case 'exchange_user_punished_cancell':
        return _buildExchangeUserPunishedCancell(context);
      case 'deal_cancelled_for_fiat_handler_after_time':
        return _buildDealCancelledForFiatHandlerAfterTime(context);
      case 'deal_reported_for_applicant':
        return _buildDealReportedForApplicant(context);
      case 'deal_reported_for_defendant':
        return _buildDealReportedForDefendant(context);
      case 'support_updated_for_report':
        return _buildSupportUpdatedForReport(context);
      case 'report_cancelled_for_defendant':
        return _buildReportCancelledForDefendant(context);
      case 'report_cancelled_for_applicant':
        return _buildReportCancelledForApplicant(context);
      case 'incoming_transfer':
        return _buildIncomingTransfer(context);
      case 'outgoing_transfer':
        return _buildOutgoingTransfer(context);
      case 'withdraw':
        return _buildWithdraw(context);
      case 'deposit':
        return _buildDeposit(context);
      case 'deal_started_for_maker':
        return _buildDealStartedForMaker(context);
      case 'deal_approved_for_crypto_handler':
        return _buildDealApprovedForCryptoHandler(context);
      case 'deal_cancelled_for_fiat_handler':
        return _buildDealCancelledForFiatHandler(context);
      case 'deal_cancelled_for_crypto_handler':
        return _buildDealCancelledForCryptoHandler(context);
      case 'deal_notified_for_crypto_handler':
        return _buildDealNotifiedForCryptoHandler(context);
      case 'payment_approved_after_wallet_for_maker':
        return _buildPaymentApprovedAfterWalletForMaker(context);
      case 'payment_approved_after_wallet_for_payer':
        return _buildPaymentApprovedAfterWalletForPayer(context);
      case 'exchange_user_punished':
      case 'wallet_user_punished':
      case 'user_banned_event':
      default:
        return _buildDefaultNotification(context);
    }
  }

  Widget _buildNewLoginOccurred(BuildContext context) {
    final ip = notification.message['ip'];
    final time = notification.message['time'];
    final formattedTime = _formatTime(time);
    return _buildRichText(
      context,
      'Новый вход с IP: $ip в $formattedTime',
    );
  }

  Widget _buildDealApprovedForFiatHandler(BuildContext context) {
    final amount = notification.message['amount'];
    final currency = notification.message['currency'];
    final dealId = notification.message['deal_id'];
    return _buildRichText(
      context,
      'Сделка подтверждена на $amount $currency (ID сделки: $dealId)',
    );
  }

  Widget _buildDealCancelledForCryptoHandlerAfterTime(BuildContext context) {
    final dealId = notification.message['deal_id'];
    return _buildRichTextWithLink(
      context,
      'Сделка ',
      dealId,
      ' отменена по причине истечения времени',
    );
  }

  Widget _buildDealTimeAlmostEnded(BuildContext context) {
    final dealId = notification.message['deal_id'];
    return _buildRichTextWithLink(
      context,
      'Закройте сделку',
      dealId,
      '. Истекает таймер',
    );
  }

  Widget _buildExchangeUserPunishedCancell(BuildContext context) {
    final until = notification.message['until'];
    DateTime? untilDate;
    try {
      untilDate = DateTime.parse(until.replaceAll(' UTC', ''));
    } catch (e) {
      untilDate = null;
    }

    String formattedDate = untilDate != null
        ? '${untilDate.day.toString().padLeft(2, '0')}.${untilDate.month.toString().padLeft(2, '0')}, ${untilDate.hour.toString().padLeft(2, '0')}:${untilDate.minute.toString().padLeft(2, '0')}'
        : 'Invalid date format';

    return _buildRichText(
      context,
      'Вы превысили лимит по отменам сделок, и не можете создавать новые. Ограничение действует до $formattedDate',
    );
  }

  Widget _buildDealCancelledForFiatHandlerAfterTime(BuildContext context) {
    final dealId = notification.message['deal_id'];
    return _buildRichTextWithLink(
      context,
      'Сделка ',
      dealId,
      ' отменена по причине истечения времени',
    );
  }

  Widget _buildDealReportedForApplicant(BuildContext context) {
    final dealId = notification.message['deal_id'];
    final userName = notification.message['user_name'];
    return _buildRichTextWithLink(
      context,
      'Вы начали спор по сделке',
      dealId,
      ' с пользователем $userName',
    );
  }

  Widget _buildDealReportedForDefendant(BuildContext context) {
    final dealId = notification.message['deal_id'];
    return _buildRichTextWithLink(
      context,
      'По сделке',
      dealId,
      ' начат спор',
    );
  }

  Widget _buildSupportUpdatedForReport(BuildContext context) {
    final dealId = notification.message['deal_id'];
    return _buildRichTextWithLink(
      context,
      'Модератор приступил к рассмотрению спора по сделке',
      dealId,
      '',
    );
  }

  Widget _buildReportCancelledForDefendant(BuildContext context) {
    final dealId = notification.message['deal_id'];
    final userName = notification.message['user_name'];
    return _buildRichTextWithLink(
      context,
      'Пользователь $userName отменил спор по сделке',
      dealId,
      '',
    );
  }

  Widget _buildReportCancelledForApplicant(BuildContext context) {
    final dealId = notification.message['deal_id'];
    final userName = notification.message['user_name'];
    return _buildRichTextWithLink(
      context,
      'Вы отменили спор по сделке с пользователем $userName',
      dealId,
      '',
    );
  }

  Widget _buildIncomingTransfer(BuildContext context) {
    final amount = notification.message['amount'];
    final currency = notification.message['currency'];
    final userName = notification.message['user_name'];
    return _buildRichText(
      context,
      'Входящий перевод $amount $currency от пользователя $userName',
    );
  }

  Widget _buildOutgoingTransfer(BuildContext context) {
    final amount = notification.message['amount'];
    final currency = notification.message['currency'];
    final userName = notification.message['user_name'];
    return _buildRichText(
      context,
      'Исходящий перевод $amount $currency пользователю $userName',
    );
  }

  Widget _buildWithdraw(BuildContext context) {
    final taxAmount = notification.message['tax_amount'];
    final currency = notification.message['currency'];
    return _buildRichText(
      context,
      'Вывод средств - $taxAmount $currency',
    );
  }

  Widget _buildDeposit(BuildContext context) {
    final amount = notification.message['amount'];
    final currency = notification.message['currency'];
    return _buildRichText(
      context,
      'Пополнение баланса $currency на $amount',
    );
  }

  Widget _buildDealStartedForMaker(BuildContext context) {
    final userName = notification.message['user_name'];
    final dealId = notification.message['deal_id'];
    return _buildRichTextWithLink(
      context,
      'Пользователь $userName начал с вами сделку',
      dealId,
      '',
    );
  }

  Widget _buildDealApprovedForCryptoHandler(BuildContext context) {
    final userName = notification.message['user_name'];
    final cryptoAmount = notification.message['crypto_amount'];
    final cryptoCurrency = notification.message['crypto_currency'];
    return _buildRichText(
      context,
      'Вы подтвердили получение средств по сделке. С вашего счета списано $cryptoAmount $cryptoCurrency от пользователя $userName',
    );
  }

  Widget _buildDealCancelledForFiatHandler(BuildContext context) {
    final userName = notification.message['user_name'];
    final dealId = notification.message['deal_id'];
    return _buildRichTextWithLink(
      context,
      'Вы отменили сделку с пользователем $userName',
      dealId,
      '',
    );
  }

  Widget _buildDealCancelledForCryptoHandler(BuildContext context) {
    final userName = notification.message['user_name'];
    final dealId = notification.message['deal_id'];
    return _buildRichTextWithLink(
      context,
      'Пользователь $userName отменил сделку',
      dealId,
      '',
    );
  }

  Widget _buildDealNotifiedForCryptoHandler(BuildContext context) {
    final userName = notification.message['user_name'];
    final fiatAmount = notification.message['fiat_amount'];
    final fiatCurrency = notification.message['fiat_currency'];
    final dealId = notification.message['deal_id'];
    return _buildRichTextWithLink(
      context,
      'Пользователь $userName перевел вам $fiatAmount $fiatCurrency по сделке',
      dealId,
      '',
    );
  }

  Widget _buildPaymentApprovedAfterWalletForMaker(BuildContext context) {
    final userName = notification.message['user_name'];
    final amount = notification.message['amount'];
    final currency = notification.message['currency'];
    return _buildRichText(
      context,
      'Пользователь $userName перевел вам $amount $currency через SenPay',
    );
  }

  Widget _buildPaymentApprovedAfterWalletForPayer(BuildContext context) {
    final userName = notification.message['user_name'];
    final amount = notification.message['amount'];
    final currency = notification.message['currency'];
    return _buildRichText(
      context,
      'Вы перевели пользователю $userName $amount $currency через SenPay',
    );
  }

  Widget _buildDefaultNotification(BuildContext context) {
    final message = notification.message.toString();
    return _buildRichText(context, message);
  }

  Widget _buildRichText(BuildContext context, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.close_outlined, color: Colors.white, size: 16.sp,),
          onPressed: () {
            Provider.of<NotificationsProvider>(context, listen: false).deleteNotification(notification.id);
          },
        ),
      ],
    );
  }

  Widget _buildRichTextWithLink(BuildContext context, String prefix, String dealId, String suffix) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: prefix,
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
                WidgetSpan(
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DealExtended(dealNumber: dealId),
                      ),
                    ),
                    child: Text(
                      'сделку',
                      style: TextStyle(color: Colors.blue, fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TextSpan(
                  text: suffix,
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.close_outlined, color: Colors.white, size: 16.sp,),
          onPressed: () {
            Provider.of<NotificationsProvider>(context, listen: false).deleteNotification(notification.id);
          },
        ),
      ],
    );
  }

  String _formatTime(String time) {
    final trimmedTime = time.split('.').first;
    final dateTime = DateTime.parse(trimmedTime);
    final formattedDay = dateTime.day.toString().padLeft(2, '0');
    final formattedMonth = dateTime.month.toString().padLeft(2, '0');
    final formattedTime = '$formattedDay.$formattedMonth, ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    return formattedTime;
  }
}
