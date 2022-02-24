import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/models/ongkir_model.dart';

class HomeController extends GetxController {
  TextEditingController beratC = TextEditingController();

  List<Ongkir> data = [];

  RxString provAsal = "0".obs;
  RxString cityAsal = "0".obs;
  RxString provTujuan = "0".obs;
  RxString cityTujuan = "0".obs;
  RxString kurir = "0".obs;
  RxBool load = false.obs;

  void cekOngkir() async {
    if (provAsal != "0" &&
        provTujuan != "0" &&
        cityAsal != "0" &&
        cityTujuan != "0" &&
        kurir != "0" &&
        beratC.text != "0") {
      load.value = true;
      var res = await http.post(
        Uri.parse("https://api.rajaongkir.com/starter/cost"),
        headers: {
          "key": "a98cd6a3dcefaa424c1d57d9772eb48a",
          "content-type": "application/x-www-form-urlencoded",
        },
        body: {
          "origin": cityAsal.value,
          "destination": cityTujuan.value,
          "weight": beratC.text,
          "courier": kurir.value,
        },
      );
      load.value = false;
      List ongkir =
          json.decode(res.body)["rajaongkir"]["results"][0]["costs"] as List;
      data = Ongkir.fromjsonlist(ongkir);

      Get.defaultDialog(
          title: "Ongkos Kirim",
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data
                .map((e) => ListTile(
                      title: Text("${e.description!}"),
                      subtitle: Text("Rp. ${e.cost![0].value}"),
                    ))
                .toList(),
          ));
    } else {
      Get.defaultDialog(
          title: "Terjadi Kesalahan", middleText: "Data Belum Lengkap");
    }
  }
}
