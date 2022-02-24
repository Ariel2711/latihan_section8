import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import '../../../data/models/province_model.dart';
import '../../../data/models/city_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            DropdownSearch<Province>(
              showSearchBox: true,
              popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item.province}"),
              ),
              dropdownSearchDecoration: InputDecoration(
                labelText: "Provinsi Asal",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                border: OutlineInputBorder(),
              ),
              onFind: (text) async {
                var res = await Dio().get(
                    "https://api.rajaongkir.com/starter/province",
                    queryParameters: {
                      "key": "a98cd6a3dcefaa424c1d57d9772eb48a",
                    });
                return Province.fromjsonlist(res.data["rajaongkir"]["results"]);
              },
              onChanged: (value) =>
                  controller.provAsal.value = value?.provinceId ?? "0",
            ),
            SizedBox(
              height: 20,
            ),
            DropdownSearch<City>(
              showSearchBox: true,
              popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item.type} ${item.cityName}"),
              ),
              dropdownSearchDecoration: InputDecoration(
                labelText: "Kota/Kabupaten Asal",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                border: OutlineInputBorder(),
              ),
              onFind: (text) async {
                var res = await Dio().get(
                    "https://api.rajaongkir.com/starter/city?province=${controller.provAsal}",
                    queryParameters: {
                      "key": "a98cd6a3dcefaa424c1d57d9772eb48a",
                    });
                return City.fromjsonlist(res.data["rajaongkir"]["results"]);
              },
              onChanged: (value) =>
                  controller.cityAsal.value = value?.cityId ?? "0",
            ),
            SizedBox(
              height: 20,
            ),
            DropdownSearch<Province>(
              showSearchBox: true,
              popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item.province}"),
              ),
              dropdownSearchDecoration: InputDecoration(
                labelText: "Provinsi Tujuan",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                border: OutlineInputBorder(),
              ),
              onFind: (text) async {
                var res = await Dio().get(
                    "https://api.rajaongkir.com/starter/province",
                    queryParameters: {
                      "key": "a98cd6a3dcefaa424c1d57d9772eb48a",
                    });
                return Province.fromjsonlist(res.data["rajaongkir"]["results"]);
              },
              onChanged: (value) =>
                  controller.provTujuan.value = value?.provinceId ?? "0",
            ),
            SizedBox(
              height: 20,
            ),
            DropdownSearch<City>(
              showSearchBox: true,
              popupItemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item.type} ${item.cityName}"),
              ),
              dropdownSearchDecoration: InputDecoration(
                labelText: "Kota/Kabupaten Tujuan",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                border: OutlineInputBorder(),
              ),
              onFind: (text) async {
                var res = await Dio().get(
                    "https://api.rajaongkir.com/starter/city?province=${controller.provTujuan}",
                    queryParameters: {
                      "key": "a98cd6a3dcefaa424c1d57d9772eb48a",
                    });
                return City.fromjsonlist(res.data["rajaongkir"]["results"]);
              },
              onChanged: (value) =>
                  controller.cityTujuan.value = value?.cityId ?? "0",
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: controller.beratC,
              autocorrect: false,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Berat (gram)",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 25,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            DropdownSearch<Map<String, dynamic>>(
              items: [
                {"code": "jne", "name": "JNE"},
                {"code": "pos", "name": "POS INDONESIA"},
                {"code": "tiki", "name": "TIKI"},
              ],
              showSearchBox: true,
              popupItemBuilder: (context, item, isSelected) => ListTile( 
                title: Text("${item["name"]}"),
              ),
              dropdownSearchDecoration: InputDecoration(
                // labelText: "Pilih Kurir",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                border: OutlineInputBorder(),
              ),
              dropdownBuilder: (context, selectedItem) =>
                  Text("${selectedItem?["name"] ?? "Pilih Kurir"}"),
              onChanged: (value) =>
                  controller.kurir.value = value?['code'] ?? "",
            ),
            SizedBox(
              height: 20,
            ),
            Obx(() => ElevatedButton(
                            onPressed: () {
                              if (controller.load.isFalse) {
                                controller.cekOngkir();
                              }
                            },
                            child: Text(controller.load.isFalse ? "Cek Ongkos Kirim" : "Loading..."),
                            ),
                            ),
          ],
        ));
  }
}
