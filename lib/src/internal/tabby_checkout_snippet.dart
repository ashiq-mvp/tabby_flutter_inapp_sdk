import 'package:flutter/material.dart';
import 'package:tabby_flutter_inapp_sdk/src/resources/colors.dart';
import 'package:tabby_flutter_inapp_sdk/src/resources/locales.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';

class TabbyCheckoutSnippet extends StatefulWidget {
  const TabbyCheckoutSnippet({
    required this.currency,
    required this.price,
    required this.lang,
    this.isSymbol = false,
    Key? key,
  }) : super(key: key);

  final Lang lang;
  final String price;
  final bool isSymbol;
  final Currency currency;

  @override
  State<TabbyCheckoutSnippet> createState() => _TabbyCheckoutSnippetState();
}

const gap = SizedBox(height: 6);

class _TabbyCheckoutSnippetState extends State<TabbyCheckoutSnippet> {
  late List<String> localeStrings;

  @override
  void initState() {
    localeStrings =
        AppLocales.instance().checkoutSnippet(widget.lang).values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currency = widget.currency;
    final installmentPrice =
        getPrice(price: widget.price, currency: widget.currency);
    final fontFamily =
        widget.isSymbol ? widget.currency.symbolFontFamily : null;
    final currencyText =
        widget.isSymbol ? currency.displaySymbol : currency.displayName;
    final amountText = '$currencyText $installmentPrice';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            localeStrings[0],
            style: TextStyle(
              fontSize: 14,
              color: dividerColor,
            ),
          ),
        ),
        gap,
        gap,
        Row(
          children: [
            CheckoutSnippetCell(
              position: 1,
              amountText: amountText,
              fontFamily: fontFamily,
              localeStrings: localeStrings,
            ),
            CheckoutSnippetCell(
              position: 2,
              amountText: amountText,
              fontFamily: fontFamily,
              localeStrings: localeStrings,
            ),
            CheckoutSnippetCell(
              position: 3,
              amountText: amountText,
              fontFamily: fontFamily,
              localeStrings: localeStrings,
            ),
            CheckoutSnippetCell(
              position: 4,
              amountText: amountText,
              fontFamily: fontFamily,
              localeStrings: localeStrings,
            ),
          ],
        ),
      ],
    );
  }
}

class CheckoutSnippetCell extends StatelessWidget {
  const CheckoutSnippetCell({
    required this.position,
    required this.localeStrings,
    required this.amountText,
    this.fontFamily,
    Key? key,
  }) : super(key: key);

  final int position;
  final String amountText;
  final String? fontFamily;
  final List<String> localeStrings;

  @override
  Widget build(BuildContext context) {
    final isFirst = position == 1;
    final isLast = position == 4;
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: isFirst
                    ? const SizedBox.shrink()
                    : Container(
                        height: 1,
                        color: dividerColor,
                      ),
              ),
              CheckoutSnippetImage(position: position),
              Expanded(
                child: isLast
                    ? const SizedBox.shrink()
                    : Container(
                        height: 1,
                        color: dividerColor,
                      ),
              ),
            ],
          ),
          gap,
          CheckoutWhenText(position: position, localeStrings: localeStrings),
          gap,
          CheckoutSnippetAmountText(
            amount: amountText,
            fontFamily: fontFamily,
          ),
        ],
      ),
    );
  }
}

class CheckoutWhenText extends StatelessWidget {
  const CheckoutWhenText({
    required this.position,
    required this.localeStrings,
    Key? key,
  }) : super(key: key);

  final List<String> localeStrings;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Text(
      localeStrings[position],
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class CheckoutSnippetImage extends StatelessWidget {
  const CheckoutSnippetImage({
    required this.position,
    Key? key,
  }) : super(key: key);

  final int position;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Image(
        image: AssetImage(
          'assets/images/r$position.png',
          package: 'tabby_flutter_inapp_sdk',
        ),
        width: 40,
        height: 40,
      ),
    );
  }
}

class CheckoutSnippetAmountText extends StatelessWidget {
  const CheckoutSnippetAmountText({
    required this.amount,
    this.fontFamily,
    Key? key,
  }) : super(key: key);
  final String amount;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      amount,
      style: TextStyle(
        fontSize: 11,
        color: dividerColor,
        fontFamily: fontFamily,
      ),
    );
  }
}
