part of '../wellcom_page.dart';

class ProfileRow extends StatelessWidget {
  final String title;
  final String value;

  const ProfileRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: AppText(
              text: title,
              model: AppTextModel(
                style: AppFontStyleGlobal(
                  Locale("en"),
                ).label.copyWith(fontWeight: FontWeight.bold, fontSize: 14.sp),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: AppText(
              text: value,
              model: AppTextModel(
                style: AppFontStyleGlobal(
                  Locale("en"),
                ).label.copyWith(fontSize: 14.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
