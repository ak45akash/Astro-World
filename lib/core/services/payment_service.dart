import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../constants/app_constants.dart';

class PaymentService {
  late Razorpay _razorpay;

  PaymentService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle payment success
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment error
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet
  }

  Future<void> openCheckout({
    required String orderId,
    required double amount,
    required String name,
    required String email,
    required String phone,
    Function(PaymentSuccessResponse)? onSuccess,
    Function(PaymentFailureResponse)? onError,
    Function(ExternalWalletResponse)? onExternalWallet,
  }) async {
    final options = {
      'key': AppConstants.razorpayKeyId,
      'amount': (amount * 100).toInt(), // Amount in paise
      'name': name,
      'description': 'Astrology Consultation',
      'prefill': {
        'contact': phone,
        'email': email,
      },
      'external': {
        'wallets': ['paytm']
      },
      'order_id': orderId,
    };

    _razorpay.open(options);
  }

  void dispose() {
    _razorpay.clear();
  }
}

