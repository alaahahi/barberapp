import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:barber/data/fetcher.dart';
import 'package:barber/models/CategoriesModel.dart';
import 'package:barber/models/CompanyModel.dart';
import 'package:barber/models/ProductModel.dart';
import 'package:barber/models/OrderModel.dart';
import 'package:barber/models/SearchResult.dart';
import 'package:barber/models/GiftModel.dart';
import 'package:barber/models/AdminCompany.dart';
import 'package:barber/models/SliderModel.dart';
import 'package:barber/services/CartItem.dart';
import 'package:barber/models/ActivationResult.dart';
import 'package:barber/models/WeeklyAndMonthlyPullModel.dart';
import 'package:http/http.dart' as http;
import 'package:barber/models/AppConfigModel.dart';
import 'package:barber/models/UserInfoModel.dart';
import 'package:path_provider/path_provider.dart';

class Api extends Fetcher {
  Api({this.baseUrl, this.langFunc});

  String baseUrl;
  String Function() langFunc;

  String get lang => (langFunc() == 'fa' ? 'ku' : langFunc()) ?? 'en';

//  Future<List<CategoryModel>> getCategories() async {
//    print('getCategories');
//    return await Future.delayed(
//        Duration(seconds: 4),
//        () => getParsedList(
//              '$baseUrl/categories/$lang',
//              (data) => CategoryModel.fromJson(data),
//            ));
//  }

  Future<List<CategoryModel>> getCategories() async {
    String fileName = "CategoriessData.json";
    var cacheDir = await getTemporaryDirectory();
    File file = new File(cacheDir.path + "/" + fileName);
    if (await file.exists()) {
      Timer(Duration(seconds: 4), () {});

      var jsonData = file.readAsStringSync();
      List<dynamic> body = jsonDecode(jsonData);
      List<CategoryModel> users = body
          .map(
            (dynamic item) => CategoryModel.fromJson(item),
          )
          .toList();
      return users;
    } else {
      final response = await http.get(Uri.parse('$baseUrl/categories/$lang'));
      var tempDir = await getTemporaryDirectory();
      File file = new File(tempDir.path + "/" + fileName);
      file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<CategoryModel> users = body
            .map(
              (dynamic item) => CategoryModel.fromJson(item),
            )
            .toList();
        return users;
      } else {
        throw Exception('Failed to load Users from API');
      }
    }
  }

  Future<List<CompanyModel>> getCompanies({int categoryId}) async {
    String fileName = "CompaniesData.json";
    var cacheDir = await getTemporaryDirectory();
    File file = new File(cacheDir.path + "/" + fileName + '$categoryId');
    if (await file.exists()) {
      var jsonData = file.readAsStringSync();
      List<dynamic> body = jsonDecode(jsonData);
      List<CompanyModel> users = body
          .map(
            (dynamic item) => CompanyModel.fromJson(item),
          )
          .toList();
      return users;
    } else {
      final response = await http
          .get(Uri.parse('$baseUrl/categories/$categoryId/companies/$lang'));
      var tempDir = await getTemporaryDirectory();
      File file = new File(tempDir.path + "/" + fileName + '$categoryId');
      file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<CompanyModel> users = body
            .map(
              (dynamic item) => CompanyModel.fromJson(item),
            )
            .toList();
        return users;
      } else {
        throw Exception('Failed to load Users from API');
      }
    }
  }

//  Future<List<ProductModel>> getProducts({int comapnyId}) async {
//    print('getProducts');
//    return await getParsedList(
//      '$baseUrl/companies/$comapnyId/products/$lang',
//          (data) => ProductModel.fromJson(data),
//    );
//  }

  Future<List<ProductModel>> getProducts({int comapnyId}) async {
    String fileName = "CompaniesData.json";
    var cacheDir = await getTemporaryDirectory();
    File file = new File(cacheDir.path + "/" + fileName + '$comapnyId');
    if (await file.exists()) {
      var jsonData = file.readAsStringSync();
      List<dynamic> body = jsonDecode(jsonData);
      List<ProductModel> users = body
          .map(
            (dynamic item) => ProductModel.fromJson(item),
          )
          .toList();
      return users;
    } else {
      final response = await http
          .get(Uri.parse('$baseUrl/details/$comapnyId'));
      var tempDir = await getTemporaryDirectory();
      File file = new File(tempDir.path + "/" + fileName + '$comapnyId');
      file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<ProductModel> users = body
            .map(
              (dynamic item) => ProductModel.fromJson(item),
            )
            .toList();
        return users;
      } else {
        throw Exception('Failed to load Users from API');
      }
  }}

  Future<List<WeeklyAndMonthlyPullModel>> getWeeklyAndMonthlyPull() async {
    print('getWeeklyAndMonthlyPull');
    return await getParsedList(
      '$baseUrl/winner/$lang',
      (data) => WeeklyAndMonthlyPullModel.fromJson(data),
    );
  }

  Future<String> activation({String phone, String card}) async {
    print('activation');
    return await Future.delayed(
        Duration(seconds: 3),
        () => getParsed<String>('$baseUrl/charge_card/$card/$phone', (data) {
              final isData = RegExp(
                r'^([0-9]{4}|[0-9]{2})[-]([0]?[1-9]|[1][0-2])[-]([0]?[1-9]|[1|2][0-9]|[3][0|1])$',
                multiLine: false,
              );

              if (isData.hasMatch(data.toString()) ||
                  data
                      .toString()
                      .trim()
                      .replaceAll('"', '')
                      .startsWith("310")) {
                return data.toString();
              }
              throw Exception(data.toString());
            }));
  }

  Future<ActivationResult> checkActivation({String phone}) async {
    print('checkActivation');
    return await Future.delayed(
        Duration(seconds: 1),
        () => getParsed<ActivationResult>(
              '$baseUrl/check_card/$phone',
              (data) => data == false
                  ? ActivationResult(active: false)
                  : ActivationResult(
                      active: true,
                      from: data[0].toString(),
                      until: data[1].toString(),
                    ),
            ));
  }

  Future<List<ProductModel>> getProductByIds({List<int> ids}) async {
    print('getProductByIds');
    return await getParsedList(
      '$baseUrl/products/${ids.join(",")}/$lang',
      (data) => ProductModel.fromJson(data),
    );
  }
  Future<List<CompanyModel>> getCompaniesByIds({List<int> ids}) async {
    print('getCompaniesByIds');
    return await getParsedList(
      '$baseUrl/companies/${ids.join(",")}/$lang',
      (data) => CompanyModel.fromJson(data),
    );
  }

  Future<SearchResult> search({String query}) async {
    print('search');
    return await getParsed(
      '$baseUrl/search/$query/$lang',
      (data) => SearchResult.fromJson(data),
    );
  }

//  Future<SearchResult> getHome() async {
//    print('getHome');
//    return await Future.delayed(
//        Duration(seconds: 10),
//        () => getParsed(
//              '$baseUrl/home/$lang',
//              (data) => SearchResult.fromJson(data),
//            ));
//  }


  Future<SearchResult> getHome() async {
    String fileName = "getUserHome.json";
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/" + fileName);
    if (file.existsSync()) {
      print("Loading from cache");
      var jsonData = file.readAsStringSync();
      SearchResult response = SearchResult.fromJson(json.decode(jsonData));
      return response;
    } else {
      print("Loading from API");
      var response = await http.get(Uri.parse('$baseUrl/home/$lang'));
      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        SearchResult res = SearchResult.fromJson(json.decode(jsonResponse));
        file.writeAsStringSync(jsonResponse, flush: true, mode: FileMode.write);
        return res;
      }
    }
  }







  Future<int> userPoints({String phone}) async {
    print('ActivationResult');
    return await Future.delayed(
        Duration(seconds: 8),
        () => getParsed(
              '$baseUrl/user_point/$phone',
              (data) =>
                  int.tryParse(data.toString().trim().replaceAll('"', '')) ?? 0,
            ));
  }

  Future<String> submitOrder({List<CartItem> items, String phone}) async {
    final res = await post(
      '$baseUrl/orders/$phone',
      body: {
        'data': items
            .map((e) => ({
                  'productId': e.id,
                  'quantity': e.quantity,
                }))
            .toList()
      },
    );
    return res;
  }

  Future<List<OrderModel>> getOrders({String phone}) async {
    print('OrderModel');
    return await getParsedList(
      '$baseUrl/getorders/$phone/$lang',
      (data) => OrderModel.fromJson(data),
    );
  }

  Future<List<AdminCompanyModel>> getUserCompany({String phone}) async {
    print('AdminCompanyModel');
    return await getParsedList(
      '$baseUrl/getusercompany/$phone',
      (data) => AdminCompanyModel.fromJson(data),
    );
  }

  Future<List<GiftModel>> getGift() async {
    String fileName = "UserCacheData.json";
    var cacheDir = await getTemporaryDirectory();
    File file = new File(cacheDir.path + "/" + fileName);
    if (await file.exists()) {
      var jsonData = file.readAsStringSync();
      List<dynamic> body = jsonDecode(jsonData);
      List<GiftModel> users = body
          .map(
            (dynamic item) => GiftModel.fromJson(item),
          )
          .toList();
      return users;
    } else {
      final response = await http.get(Uri.parse('$baseUrl/gift/$lang'));
      var tempDir = await getTemporaryDirectory();
      File file = new File(tempDir.path + "/" + fileName);
      file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<GiftModel> users = body
            .map(
              (dynamic item) => GiftModel.fromJson(item),
            )
            .toList();
        return users;
      } else {
        throw Exception('Failed to load Users from API');
      }
    }
  }
  Future<List<SliderModel>> getSlider() async {
    String fileName = "SlideCacheData.json";
    var cacheDir = await getTemporaryDirectory();
    File file = new File(cacheDir.path + "/" + fileName);
    if (await file.exists()) {
      var jsonData = file.readAsStringSync();
      List<dynamic> body = jsonDecode(jsonData);
      List<SliderModel> users = body
          .map(
            (dynamic item) => SliderModel.fromJson(item),
      )
          .toList();
      return users;
    } else {
      final response = await http.get(Uri.parse('$baseUrl/slider'));
      var tempDir = await getTemporaryDirectory();
      File file = new File(tempDir.path + "/" + fileName);
      file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<SliderModel> users = body
            .map(
              (dynamic data) => SliderModel.fromJson(data),
        )
            .toList();
        print("---------------------------------------------------");
        print(body.toString());
        return users;
      } else {
        throw Exception('Failed to load Users from API');
      }
    }
  }

  Future<UserInfoModel> getUserInfo({String Number}) async {
    print('UserInfoModel');
    return await Future.delayed(
        Duration(seconds: 1),
        () => getParsed(
              '$baseUrl/user_info/$Number',
              (data) => UserInfoModel.fromJson(data),
            ));
  }

  Future<List<AppConfigModel>> getAppConfig() async {
    print('AppConfigModel');
    return await getParsedList(
      '$baseUrl/app_config',
      (data) => AppConfigModel.fromJson(data),
    );
  }

  Future<void> submitProduct({Map<String, dynamic> json, String phone}) async {
    print('submitProduct');
    await post('$baseUrl/productcompany/$phone', body: json);
  }

//  Future<String> editUserInfo({String name, String phone}) async {
//    print('editUserInfo');
//    return await post(
//      '$baseUrl/edit_user_info/$phone',
//      body: {'name': name},
//    );
//  }

  Future<String> editUserInfo({String name, String phone}) async {
    return await getParsed(
      '$baseUrl/edit_user_info/$phone/$name',
      (data) => data.toString(),
    );
  }

  Future<http.Response> deletedCompany(String id) async {
    print('deletedCompany');
    final http.Response response = await http.delete(
      Uri.parse('$baseUrl/removorder/$id'),
      headers: <String, String>{
        'id': id,
      },
    );
    return response;
  }

  Future<String> sendUser({String id, double evaluation, String messag}) async {
    print('sendUser');
    return await getParsed(
      '$baseUrl/feedbackorder/$id/$evaluation/$messag',
      (data) => data.toString(),
    );
  }
}
