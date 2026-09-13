import 'package:acrova/presentation/app/navigation/args/navigation_args.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NavigationArgs tests', () {
    test('ProjectDetailArgs value equality and props', () {
      const args1 = ProjectDetailArgs(id: '1', title: 'Test');
      const args2 = ProjectDetailArgs(id: '1', title: 'Test');
      const args3 = ProjectDetailArgs(id: '2', title: 'Test 2');

      expect(args1, equals(args2));
      expect(args1 == args3, isFalse);
      expect(args1.props, ['1', 'Test', null]);
    });

    test('InteriorDesignArgs value equality and props', () {
      const args1 = InteriorDesignArgs(projectId: 'proj_1');
      const args2 = InteriorDesignArgs(projectId: 'proj_1');
      const args3 = InteriorDesignArgs(projectId: 'proj_2');

      expect(args1, equals(args2));
      expect(args1 == args3, isFalse);
      expect(args1.props, ['proj_1']);
    });

    test('PortfolioDetailArgs value equality and props', () {
      const args1 = PortfolioDetailArgs(portfolioId: 'port_1');
      const args2 = PortfolioDetailArgs(portfolioId: 'port_1');
      const args3 = PortfolioDetailArgs(portfolioId: 'port_2');

      expect(args1, equals(args2));
      expect(args1 == args3, isFalse);
      expect(args1.props, [null, 'port_1']);
    });

    test('EditProfileArgs value equality and props', () {
      const args1 = EditProfileArgs();
      const args2 = EditProfileArgs();

      expect(args1, equals(args2));
      expect(args1.props, [null]);
    });

    test('ContactUsArgs value equality and props', () {
      const args1 = ContactUsArgs(email: 'test@example.com', mobileNumber: '+123456789');
      const args2 = ContactUsArgs(email: 'test@example.com', mobileNumber: '+123456789');
      const args3 = ContactUsArgs(email: 'other@example.com');

      expect(args1, equals(args2));
      expect(args1 == args3, isFalse);
      expect(args1.props, ['test@example.com', '+123456789']);
    });

    test('RevisionDetailArgs value equality and props', () {
      const args1 = RevisionDetailArgs(revisionId: 'rev_1');
      const args2 = RevisionDetailArgs(revisionId: 'rev_1');
      const args3 = RevisionDetailArgs(revisionId: 'rev_2');

      expect(args1, equals(args2));
      expect(args1 == args3, isFalse);
      expect(args1.props, [null, 'rev_1']);
    });

    test('WalkthroughArgs value equality and props', () {
      const args1 = WalkthroughArgs();
      const args2 = WalkthroughArgs();

      expect(args1, equals(args2));
      expect(args1.props, [null]);
    });

    test('PaymentDetailsArgs value equality and props', () {
      const args1 = PaymentDetailsArgs(paymentId: 'pay_1');
      const args2 = PaymentDetailsArgs(paymentId: 'pay_1');
      const args3 = PaymentDetailsArgs(paymentId: 'pay_2');

      expect(args1, equals(args2));
      expect(args1 == args3, isFalse);
      expect(args1.props, ['pay_1', null]);
    });

    test('PaymentSuccessArgs value equality and props', () {
      const args1 = PaymentSuccessArgs(amount: '\$500', referenceNumber: 'REF123');
      const args2 = PaymentSuccessArgs(amount: '\$500', referenceNumber: 'REF123');
      const args3 = PaymentSuccessArgs(amount: '\$600', referenceNumber: 'REF123');

      expect(args1, equals(args2));
      expect(args1 == args3, isFalse);
      expect(args1.props, ['\$500', 'REF123']);
    });

    test('MakePaymentArgs value equality and props', () {
      const args1 = MakePaymentArgs(projectId: 'proj_1', stage: 'stage_1');
      const args2 = MakePaymentArgs(projectId: 'proj_1', stage: 'stage_1');
      const args3 = MakePaymentArgs(projectId: 'proj_2', stage: 'stage_1');

      expect(args1, equals(args2));
      expect(args1 == args3, isFalse);
      expect(args1.props, ['proj_1', 'stage_1']);
    });

    test('PdfViewerArgs value equality and props', () {
      const args1 = PdfViewerArgs(title: 'Plan PDF', urlOrAsset: 'assets/doc.pdf');
      const args2 = PdfViewerArgs(title: 'Plan PDF', urlOrAsset: 'assets/doc.pdf');
      const args3 = PdfViewerArgs(title: 'Other PDF', urlOrAsset: 'assets/doc.pdf');

      expect(args1, equals(args2));
      expect(args1 == args3, isFalse);
      expect(args1.props, ['Plan PDF', 'assets/doc.pdf']);
    });

    test('ImageViewerArgs value equality and props', () {
      const args1 = ImageViewerArgs(title: 'Render 1', urlOrAsset: 'assets/render.png');
      const args2 = ImageViewerArgs(title: 'Render 1', urlOrAsset: 'assets/render.png');
      const args3 = ImageViewerArgs(title: 'Render 2', urlOrAsset: 'assets/render.png');

      expect(args1, equals(args2));
      expect(args1 == args3, isFalse);
      expect(args1.props, ['Render 1', 'assets/render.png']);
    });

    test('WebViewArgs value equality and props', () {
      const args1 = WebViewArgs(title: 'Terms', url: 'https://example.com/terms');
      const args2 = WebViewArgs(title: 'Terms', url: 'https://example.com/terms');
      const args3 = WebViewArgs(title: 'Privacy', url: 'https://example.com/terms');

      expect(args1, equals(args2));
      expect(args1 == args3, isFalse);
      expect(args1.props, ['Terms', 'https://example.com/terms']);
    });
  });
}

