import 'package:flutter_test/flutter_test.dart';
import 'package:simplenewsfeed/news_controller.dart';
import 'rss_fake_data_test.dart';

void main () {
  TestWidgetsFlutterBinding.ensureInitialized();
  final testSourceModel = SourceModel(link: 'http://www.cnbc.com/id/19789731/device/rss/rss.xml');
  sourceModelNotifier.value = testSourceModel;
  final ViewedNewsController viewedNewsController = ViewedNewsController();
  final fakeData = FakeData();

  test("Testing the network call", (){


  });

  test('Testing controller', () {
    
    viewedNewsController.fetchNews();
    expect(viewedNewsController.viewedState.value.items.isNotEmpty, true);
  });

  test ('testing checkedViewedNews', () {
    
    viewedNewsController.checkViewedNews(fakeData.fakeRssFeed);
    print(fakeData.fakeRssFeed);
    expect(viewedNewsController.viewedState.value.items.length, fakeData.fakePreparedFeed.items.length);
    
  });
}