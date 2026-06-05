import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../../../models/wallet_model.dart';
import '../../../../repository/wallet_repository.dart';
import '../../../utils/app_log.dart';

class WalletController extends GetxController {
  static ChromeSafariBrowser? activeBrowser;
  final WalletRepository _repository = WalletRepository.instance;
  late ScrollController scrollController;

  var isLoadingBalance = false.obs;
  var isLoadingHistory = false.obs;

  var balance = 0.0.obs;
  var currency = 'QAR'.obs;

  var historyList = <TransactionModel>[].obs;

  int currentPage = 1;
  int totalPages = 1;
  var totalTransactions = 0.obs;

  final RxBool isLoadingMore = false.obs;
  bool _isLoadingMoreInternal = false;

  final selectedPaymentMethod =
      0.obs; // 0: Apple Pay, 1: Google Pay, 2: Credit/Debit

  // Text Controllers for Credit/Debit Form
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final routingNumberCtrl = TextEditingController();
  final accountNumberCtrl = TextEditingController();
  final verifyAccountNumberCtrl = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    fetchWalletData();
  }

  @override
  void onClose() {
    scrollController.dispose();
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    routingNumberCtrl.dispose();
    accountNumberCtrl.dispose();
    verifyAccountNumberCtrl.dispose();
    super.onClose();
  }

  void _scrollListener() {
    if (_isLoadingMoreInternal || isLoadingMore.value) return;
    if (!scrollController.hasClients ||
        scrollController.positions.length != 1) {
      return;
    }
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      loadMoreHistory();
    }
  }

  Future<void> fetchWalletData({bool isRefresh = false}) async {
    fetchBalance(isRefresh: isRefresh);
    fetchHistory(isRefresh: isRefresh);
  }

  Future<void> fetchBalance({bool isRefresh = false}) async {
    if (!isRefresh) isLoadingBalance(true);
    try {
      final res = await _repository.getBalance();
      if (res != null) {
        balance.value = res.balance;
        currency.value = res.currency;
      }
    } finally {
      isLoadingBalance(false);
    }
  }

  Future<void> fetchHistory({bool isRefresh = false}) async {
    if (!isRefresh) isLoadingHistory(true);
    try {
      final res = await _repository.getHistory(page: 1, pageSize: 20);
      if (res != null) {
        historyList.clear();
        historyList.addAll(res.transactions);
        currentPage = res.page;
        totalPages = res.totalPages;
        totalTransactions.value = res.total;
      }
    } finally {
      isLoadingHistory(false);
    }
  }

  Future<void> loadMoreHistory() async {
    if (_isLoadingMoreInternal || isLoadingMore.value) return;
    if (currentPage >= totalPages) return;

    _isLoadingMoreInternal = true;
    isLoadingMore.value = true;

    try {
      final nextPage = currentPage + 1;
      final res = await _repository.getHistory(page: nextPage, pageSize: 20);
      if (res != null) {
        historyList.addAll(res.transactions);
        currentPage = res.page;
        totalPages = res.totalPages;
        totalTransactions.value = res.total;
      }
    } finally {
      isLoadingMore.value = false;
      _isLoadingMoreInternal = false;
    }
  }

  void selectPaymentMethod(int index) {
    selectedPaymentMethod.value = index;
  }

  var isToppingUp = false.obs;

  Future<bool> topUpWallet(double amount) async {
    if (amount <= 0) {
      Get.snackbar(
        'Invalid Amount',
        'Please enter a valid amount greater than 0.',
      );
      return false;
    }
    isToppingUp(true);
    try {
      final res = await _repository.topUpWallet(amount: amount);
      if (res != null && res.paymentUrl.isNotEmpty) {
        // Close previous active browser if any
        if (activeBrowser != null) {
          try {
            await activeBrowser?.close();
          } catch (_) {}
        }

        final MyChromeSafariBrowser browser = MyChromeSafariBrowser();
        activeBrowser = browser;

        appLog("[WalletController] Opening payment browser: ${res.paymentUrl}");

        await browser.open(
          url: WebUri(res.paymentUrl),
          settings: ChromeSafariBrowserSettings(
            shareState: CustomTabsShareState.SHARE_STATE_OFF,
            barCollapsingEnabled: true,
            // Keep app in single task, enabling custom tabs transition smoothly
            isSingleInstance: true,
          ),
        );
        return true;
      } else {
        Get.snackbar('Error', 'Failed to initiate payment. Please try again.');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      return false;
    } finally {
      isToppingUp(false);
    }
  }
}

class MyChromeSafariBrowser extends ChromeSafariBrowser {
  @override
  void onOpened() {
    super.onOpened();
    appLog("[MyChromeSafariBrowser] Chrome Safari browser opened successfully");
  }

  @override
  void onClosed() {
    super.onClosed();
    appLog("[MyChromeSafariBrowser] Chrome Safari browser closed by user");
    if (WalletController.activeBrowser == this) {
      WalletController.activeBrowser = null;
    }
  }
}
