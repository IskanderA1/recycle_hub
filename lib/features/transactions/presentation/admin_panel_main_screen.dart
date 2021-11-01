import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:recycle_hub/features/transactions/domain/state/transactions_admin_panel_state.dart/transactions_admin_panel_state.dart';
import 'package:recycle_hub/features/transactions/presentation/scanner_screen.dart';
import 'package:recycle_hub/features/transactions/presentation/transaction_create_admin_paned.dart';
import 'package:recycle_hub/helpers/messager_helper.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/loader_widget.dart';
import 'package:recycle_hub/style/theme.dart';

class AdminTransactionsPanelMainScreen extends StatefulWidget {
  const AdminTransactionsPanelMainScreen({Key key}) : super(key: key);

  @override
  _AdminTransactionsPanelMainScreenState createState() => _AdminTransactionsPanelMainScreenState();
}

class _AdminTransactionsPanelMainScreenState extends State<AdminTransactionsPanelMainScreen> {
  AdminTransactionsState state;
  ReactionDisposer _disposer;
  ReactionDisposer _disposer2;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    state ??= Provider.of<AdminTransactionsState>(context);
    _disposer ??= reaction((_) => state.errorMessage, (String message) => AlertHelper.showMessage(context: context, message: message));
    _disposer2 ??= reaction((_) => state.message, (String message) => AlertHelper.showMessage(context: context, message: message, backColor: kColorGreen));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          if (state.loading) {
            return LoaderWidget();
          }
          if (state.errorMessage != null) {
            return WillPopScope(
              onWillPop: () async {
                state.toState(AdmStoreState.INIT);
                return true;
              },
              child: Scaffold(
                body: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: kColorWhite,
                  child: Center(
                    child: Text(state.errorMessage),
                  ),
                ),
              ),
            );
            ;
          }
          if (state.state == AdmStoreState.INIT) {
            return AdminScannerScreen();
          } else if (state.state == AdmStoreState.SCANNED) {
            return Provider<AdminTransactionsState>(
              create: (_) => state,
              child: TransactionCreateAdminPanelScreen(),
            );
          } else if (state.state == AdmStoreState.CREATED) {
            return WillPopScope(
              onWillPop: () async {
                state.toState(AdmStoreState.INIT);
                return true;
              },
              child: Scaffold(
                body: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: kColorWhite,
                  child: Center(
                    child: Text("Успешно отправлено"),
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
