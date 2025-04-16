
import 'package:fastcampus_wabiz_client/model/project/project_model.dart';
import 'package:fastcampus_wabiz_client/theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class ProjectWidget extends StatelessWidget {
  final ProjectItemModel data;
  const ProjectWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16,16,16,5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(data.type ?? "??"),
                  Icon(Icons.keyboard_arrow_right),
                ],
              ),
              SizedBox(height: 12),
              Text(
                "${data.title}",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    "${NumberFormat("###,###,###").format(
                      ((data.totalFunded ?? 0) /
                          (data.price ?? 1)) *
                          100,
                    )} % 달성",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 4),
                    child: Text(
                      "${DateTime.parse(data.deadline ?? "").difference(DateTime.now()).inDays}일 남음",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    "${NumberFormat.currency(
                      locale: "ko_KR",
                      symbol: "",
                    ).format(data.totalFunded)} 원 달성",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.bg,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      "${data.totalFundedCount} 명 참여",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          color: AppColors.newBg,
          height: 32,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "프로젝트 스토리",
                style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 16),
              ),
              Gap(12),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.newBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(12),
                child: Text("도서산간에 해당하는 서포터님은 배송 가능 여부를 반드시 메이커에게 문의 후 참여해주세요."),
              ),
              Gap(12),
              Image.asset(
                "assets/image/advertising_image.png",
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
        ),
      ],
    );
  }
}