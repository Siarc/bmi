import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';

/// Heart-Healthy Diet Guide page matching the Stitch reference design.
class HeartHealthyDietPage extends StatefulWidget {
  const HeartHealthyDietPage({super.key});

  @override
  State<HeartHealthyDietPage> createState() => _HeartHealthyDietPageState();
}

class _HeartHealthyDietPageState extends State<HeartHealthyDietPage> {
  bool _isExpanded = false;
  bool _isLimitExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          color: colorScheme.primary,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Heart-Healthy Diet'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Hero Banner ──
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingLg),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                child: SizedBox(
                  height: 192, // h-48 in Tailwind
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuDajHPnwiXX2hy-59TKcz_YT4jaBvnKvBGYxSToOzKqFKRBnwHRRj-GVvtB3WnROxtR8PXJKjufFxdUplXVtzg9mxW7nZv-Hyp7UsH61lpjD3Tl6Lin7H69jbgMUFJrukcNhq2N-TVw2jgpFQWcPg445duw_p1FD9Si-yRcc_rtTFKFJZzn7sVu3_PfwH4y_lirxhNV_QSXtx4b4GjZuxKOXWUuXkYfgZsfK9Bk0e2cSaMyH5tUbrkpJy_67uCFZGZ9JKj5kieqVrs',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              colorScheme.primary.withValues(alpha: 0.9),
                              colorScheme.primary.withValues(alpha: 0.4),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Eat a Heart-Healthy Diet',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Lower your BMI and blood pressure.',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white.withValues(alpha: 0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── What to Eat ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'What to Eat',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: AnimatedCrossFade(
                          firstChild: Text(
                            'List View',
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: colorScheme.primary,
                            ),
                          ),
                          secondChild: Text(
                            'Grid View',
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: colorScheme.primary,
                            ),
                          ),
                          crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                          duration: const Duration(milliseconds: 300),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacingLg),
                  AnimatedCrossFade(
                    firstChild: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: AppTheme.spacingMd,
                      crossAxisSpacing: AppTheme.spacingMd,
                      childAspectRatio: 1.2,
                      children: [
                        _FoodCard(
                          icon: Icons.eco,
                          iconColor: Colors.green[500]!, // Green
                          iconBgColor: isDark ? Colors.green[500]!.withValues(alpha: 0.2) : Colors.green[100]!,
                          title: 'Fruits & Veggies',
                          subtitle: 'Leafy greens, berries, citrus fruits.',
                          whyItHelps: 'They are rich in dietary fiber, vitamins, and minerals, which help protect your heart and lower blood pressure.',
                          bestChoices: 'Spinach, kale, broccoli, carrots, apples, berries (blueberries, strawberries), and citrus fruits.',
                          dailyGoal: 'Aim for 4 to 5 servings of each per day.',
                          proTip: '"Eat the rainbow." The more colors on your plate, the wider the variety of nutrients you are getting. Avoid canned veggies with high sodium or fruits packed in heavy syrup.',
                        ),
                        _FoodCard(
                          icon: Icons.bakery_dining,
                          iconColor: Colors.amber[500]!, // Amber
                          iconBgColor: isDark ? Colors.amber[500]!.withValues(alpha: 0.2) : Colors.amber[100]!,
                          title: 'Whole Grains',
                          subtitle: 'Oatmeal, brown rice, and quinoa.',
                          whyItHelps: 'Whole grains contain soluble fiber, which binds to cholesterol in your digestive tract and drags it out of your body, lowering your "bad" LDL cholesterol.',
                          bestChoices: 'Oatmeal, brown rice, quinoa, barley, whole-wheat pasta, and 100% whole-grain bread.',
                          dailyGoal: 'Make sure at least half of the grains you eat daily are whole grains (roughly 3-6 servings).',
                          proTip: 'Always check the ingredient list. The first word should be "whole" (e.g., "whole wheat flour").',
                        ),
                        _FoodCard(
                          icon: Icons.set_meal,
                          iconColor: Colors.blue[400]!, // Blue
                          iconBgColor: isDark ? Colors.blue[500]!.withValues(alpha: 0.2) : Colors.blue[100]!,
                          title: 'Lean Proteins',
                          subtitle: 'Fish, beans, skinless poultry.',
                          whyItHelps: 'Protein builds muscle, but fatty meats can clog arteries. Lean proteins give you the building blocks you need without the harmful saturated fats.',
                          bestChoices: 'Fatty fish (salmon, mackerel, tuna - rich in Omega-3s), skinless chicken or turkey breasts, lentils, beans, chickpeas, and tofu.',
                          dailyGoal: 'About 5.5 ounces per day. Aim for two servings of fatty fish per week.',
                          proTip: 'Preparation matters. Bake, grill, roast, or broil your proteins. Frying them undoes the heart-healthy benefits.',
                        ),
                        _FoodCard(
                          icon: Icons.water_drop,
                          iconColor: AppColors.accentEmerald, // Emerald
                          iconBgColor: AppColors.emeraldCardBg,
                          title: 'Healthy Fats',
                          subtitle: 'Nuts, seeds, and avocados.',
                          whyItHelps: 'Replacing saturated and trans fats with unsaturated fats (monounsaturated and polyunsaturated) lowers cholesterol and reduces your risk of heart disease.',
                          bestChoices: 'Extra virgin olive oil, avocados, unsalted nuts (almonds, walnuts, pecans), and seeds (chia, flaxseed).',
                          dailyGoal: 'Keep fats to about 25-35% of your total daily calories, focusing almost entirely on these healthy fats.',
                          proTip: 'Healthy fats are great for you, but they are highly calorie-dense. Watch your portion sizes—a small handful of nuts is all you need!',
                        ),
                      ],
                    ),
                    secondChild: Column(
                      children: [
                        _FoodAccordion(
                          icon: Icons.eco,
                          iconColor: Colors.green[500]!,
                          iconBgColor: isDark ? Colors.green[500]!.withValues(alpha: 0.2) : Colors.green[100]!,
                          title: 'Fruits & Veggies',
                          whyItHelps: 'They are rich in dietary fiber, vitamins, and minerals, which help protect your heart and lower blood pressure.',
                          bestChoices: 'Spinach, kale, broccoli, carrots, apples, berries (blueberries, strawberries), and citrus fruits.',
                          dailyGoal: 'Aim for 4 to 5 servings of each per day.',
                          proTip: '"Eat the rainbow." The more colors on your plate, the wider the variety of nutrients you are getting. Avoid canned veggies with high sodium or fruits packed in heavy syrup.',
                        ),
                        const SizedBox(height: AppTheme.spacingMd),
                        _FoodAccordion(
                          icon: Icons.bakery_dining,
                          iconColor: Colors.amber[500]!,
                          iconBgColor: isDark ? Colors.amber[500]!.withValues(alpha: 0.2) : Colors.amber[100]!,
                          title: 'Whole Grains',
                          whyItHelps: 'Whole grains contain soluble fiber, which binds to cholesterol in your digestive tract and drags it out of your body, lowering your "bad" LDL cholesterol.',
                          bestChoices: 'Oatmeal, brown rice, quinoa, barley, whole-wheat pasta, and 100% whole-grain bread.',
                          dailyGoal: 'Make sure at least half of the grains you eat daily are whole grains (roughly 3-6 servings).',
                          proTip: 'Always check the ingredient list. The first word should be "whole" (e.g., "whole wheat flour").',
                        ),
                        const SizedBox(height: AppTheme.spacingMd),
                        _FoodAccordion(
                          icon: Icons.set_meal,
                          iconColor: Colors.blue[400]!,
                          iconBgColor: isDark ? Colors.blue[500]!.withValues(alpha: 0.2) : Colors.blue[100]!,
                          title: 'Lean Proteins',
                          whyItHelps: 'Protein builds muscle, but fatty meats can clog arteries. Lean proteins give you the building blocks you need without the harmful saturated fats.',
                          bestChoices: 'Fatty fish (salmon, mackerel, tuna - rich in Omega-3s), skinless chicken or turkey breasts, lentils, beans, chickpeas, and tofu.',
                          dailyGoal: 'About 5.5 ounces per day. Aim for two servings of fatty fish per week.',
                          proTip: 'Preparation matters. Bake, grill, roast, or broil your proteins. Frying them undoes the heart-healthy benefits.',
                        ),
                        const SizedBox(height: AppTheme.spacingMd),
                        _FoodAccordion(
                          icon: Icons.water_drop,
                          iconColor: AppColors.accentEmerald,
                          iconBgColor: AppColors.emeraldCardBg,
                          title: 'Healthy Fats',
                          whyItHelps: 'Replacing saturated and trans fats with unsaturated fats (monounsaturated and polyunsaturated) lowers cholesterol and reduces your risk of heart disease.',
                          bestChoices: 'Extra virgin olive oil, avocados, unsalted nuts (almonds, walnuts, pecans), and seeds (chia, flaxseed).',
                          dailyGoal: 'Keep fats to about 25-35% of your total daily calories, focusing almost entirely on these healthy fats.',
                          proTip: 'Healthy fats are great for you, but they are highly calorie-dense. Watch your portion sizes—a small handful of nuts is all you need!',
                        ),
                      ],
                    ),
                    crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                    sizeCurve: Curves.easeInOutCubic,
                    alignment: Alignment.topCenter,
                  ),
                ],
              ),
            ),

            // ── What to Limit ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'What to Limit',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isLimitExpanded = !_isLimitExpanded;
                          });
                        },
                        child: AnimatedCrossFade(
                          firstChild: Text(
                            'List View',
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: colorScheme.primary,
                            ),
                          ),
                          secondChild: Text(
                            'Grid View',
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: colorScheme.primary,
                            ),
                          ),
                          crossFadeState: _isLimitExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                          duration: const Duration(milliseconds: 300),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacingLg),
                  AnimatedCrossFade(
                    firstChild: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: AppTheme.spacingMd,
                      crossAxisSpacing: AppTheme.spacingMd,
                      childAspectRatio: 1.2,
                      children: [
                        _LimitCard(
                          icon: Icons.do_not_disturb_on,
                          iconColor: Colors.red[500]!,
                          iconBgColor: isDark ? Colors.red[500]!.withValues(alpha: 0.1) : Colors.red[50]!,
                          title: 'Sodium & Salts',
                          subtitle: 'Aim for less than 2,300mg per day.',
                          whyLimitIt: 'Excess sodium pulls water into your blood vessels. This increases the total volume of blood, which raises your blood pressure and forces your heart to work harder.',
                          hiddenSources: 'Canned soups, frozen meals, deli meats, and condiments. (Most sodium in a typical diet comes from processed foods, not the salt shaker!)',
                          dailyGoal: 'Less than 2,300mg per day. An ideal limit is 1,500mg for most adults, especially those with elevated blood pressure.',
                          proTip: 'Substitute salt with herbs, spices, garlic, and citrus juices to flavor your food without adding sodium.',
                        ),
                        _LimitCard(
                          icon: Icons.warning,
                          iconColor: Colors.orange[500]!,
                          iconBgColor: isDark ? Colors.orange[500]!.withValues(alpha: 0.1) : Colors.orange[50]!,
                          title: 'Saturated Fats',
                          subtitle: 'Limit butter, cheese, and red meats.',
                          whyLimitIt: 'These fats directly raise your LDL ("bad") cholesterol levels. High LDL can build up as plaque in your arteries, narrowing them and increasing the risk of a heart attack.',
                          hiddenSources: 'Store-bought baked goods, fried foods, coconut oil, palm oil, and full-fat dairy products.',
                          dailyGoal: 'Limit saturated fats to no more than 5% to 6% of your total daily calories.',
                          proTip: 'Swap butter for olive oil or avocado oil when cooking, and trim any visible fat off meats before preparing them.',
                        ),
                        _LimitCard(
                          icon: Icons.icecream,
                          iconColor: isDark ? Colors.yellow[500]! : Colors.yellow[600]!,
                          iconBgColor: isDark ? Colors.yellow[500]!.withValues(alpha: 0.1) : Colors.yellow[50]!,
                          title: 'Added Sugars',
                          subtitle: 'Reduce soda, sweets, and desserts.',
                          whyLimitIt: 'Diets high in added sugars are linked to weight gain, chronic inflammation, and elevated triglyceride levels, all of which severely stress your cardiovascular system.',
                          hiddenSources: 'Ketchup, barbecue sauce, salad dressings, pasta sauces, and flavored yogurts.',
                          dailyGoal: 'Keep added sugars to a minimum (generally advised to be under 25g per day for women and 36g for men).',
                          proTip: 'Always check ingredient labels for sneaky sugars. Look out for words ending in "-ose" (like dextrose, fructose, or sucrose) and syrups (like high-fructose corn syrup).',
                        ),
                      ],
                    ),
                    secondChild: Column(
                      children: [
                        _LimitAccordion(
                          icon: Icons.do_not_disturb_on,
                          iconColor: Colors.red[500]!,
                          iconBgColor: isDark ? Colors.red[500]!.withValues(alpha: 0.1) : Colors.red[50]!,
                          title: 'Sodium & Salts',
                          whyLimitIt: 'Excess sodium pulls water into your blood vessels. This increases the total volume of blood, which raises your blood pressure and forces your heart to work harder.',
                          hiddenSources: 'Canned soups, frozen meals, deli meats, and condiments. (Most sodium in a typical diet comes from processed foods, not the salt shaker!)',
                          dailyGoal: 'Less than 2,300mg per day. An ideal limit is 1,500mg for most adults, especially those with elevated blood pressure.',
                          proTip: 'Substitute salt with herbs, spices, garlic, and citrus juices to flavor your food without adding sodium.',
                        ),
                        const SizedBox(height: AppTheme.spacingMd),
                        _LimitAccordion(
                          icon: Icons.warning,
                          iconColor: Colors.orange[500]!,
                          iconBgColor: isDark ? Colors.orange[500]!.withValues(alpha: 0.1) : Colors.orange[50]!,
                          title: 'Saturated Fats',
                          whyLimitIt: 'These fats directly raise your LDL ("bad") cholesterol levels. High LDL can build up as plaque in your arteries, narrowing them and increasing the risk of a heart attack.',
                          hiddenSources: 'Store-bought baked goods, fried foods, coconut oil, palm oil, and full-fat dairy products.',
                          dailyGoal: 'Limit saturated fats to no more than 5% to 6% of your total daily calories.',
                          proTip: 'Swap butter for olive oil or avocado oil when cooking, and trim any visible fat off meats before preparing them.',
                        ),
                        const SizedBox(height: AppTheme.spacingMd),
                        _LimitAccordion(
                          icon: Icons.icecream,
                          iconColor: isDark ? Colors.yellow[500]! : Colors.yellow[600]!,
                          iconBgColor: isDark ? Colors.yellow[500]!.withValues(alpha: 0.1) : Colors.yellow[50]!,
                          title: 'Added Sugars',
                          whyLimitIt: 'Diets high in added sugars are linked to weight gain, chronic inflammation, and elevated triglyceride levels, all of which severely stress your cardiovascular system.',
                          hiddenSources: 'Ketchup, barbecue sauce, salad dressings, pasta sauces, and flavored yogurts.',
                          dailyGoal: 'Keep added sugars to a minimum (generally advised to be under 25g per day for women and 36g for men).',
                          proTip: 'Always check ingredient labels for sneaky sugars. Look out for words ending in "-ose" (like dextrose, fructose, or sucrose) and syrups (like high-fructose corn syrup).',
                        ),
                      ],
                    ),
                    crossFadeState: _isLimitExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                    sizeCurve: Curves.easeInOutCubic,
                    alignment: Alignment.topCenter,
                  ),
                ],
              ),
            ),


            // ── Quick Tips ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Tips',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingLg),
                  _QuickTipCard(
                    icon: Icons.manage_search,
                    title: 'Read Nutrition Labels',
                    subtitle: 'Focus on sodium % Daily Value (DV).',
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                  _QuickTipCard(
                    icon: Icons.swap_horiz,
                    title: 'Smart Swaps',
                    subtitle: 'Use herbs instead of salt for flavoring.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Private Widgets
// ─────────────────────────────────────────────

class _FoodCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final String whyItHelps;
  final String bestChoices;
  final String dailyGoal;
  final String proTip;

  const _FoodCard({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    required this.whyItHelps,
    required this.bestChoices,
    required this.dailyGoal,
    required this.proTip,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radiusLg)),
              backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingLg),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: iconBgColor,
                              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                            ),
                            child: Icon(icon, color: iconColor, size: 24),
                          ),
                          const SizedBox(width: AppTheme.spacingMd),
                          Expanded(
                            child: Text(
                              title,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            tooltip: 'Close',
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.spacingLg),
                      _AccordionDetailRow(title: 'Why it helps', text: whyItHelps),
                      _AccordionDetailRow(title: 'Best Choices', text: bestChoices),
                      _AccordionDetailRow(title: 'Daily Goal', text: dailyGoal),
                      _AccordionDetailRow(title: 'Pro-Tip', text: proTip),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacingLg),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(
            color: isDark ? const Color(0xFF334155).withValues(alpha: 0.5) : colorScheme.outline.withValues(alpha: 0.1),
          ),
          boxShadow: isDark
              ? [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 16)]
              : [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
              const SizedBox(height: AppTheme.spacingMd),
            Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.3,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LimitCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final String whyLimitIt;
  final String hiddenSources;
  final String dailyGoal;
  final String proTip;

  const _LimitCard({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    required this.whyLimitIt,
    required this.hiddenSources,
    required this.dailyGoal,
    required this.proTip,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radiusLg)),
              backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingLg),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: iconBgColor,
                              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                            ),
                            child: Icon(icon, color: iconColor, size: 24),
                          ),
                          const SizedBox(width: AppTheme.spacingMd),
                          Expanded(
                            child: Text(
                              title,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            tooltip: 'Close',
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.spacingLg),
                      _AccordionDetailRow(title: 'Why limit it', text: whyLimitIt),
                      _AccordionDetailRow(title: 'Hidden Sources', text: hiddenSources),
                      _AccordionDetailRow(title: 'Daily Goal', text: dailyGoal),
                      _AccordionDetailRow(title: 'Pro-Tip', text: proTip),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacingLg),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(
            color: isDark ? const Color(0xFF334155).withValues(alpha: 0.5) : colorScheme.outline.withValues(alpha: 0.1),
          ),
          boxShadow: isDark
              ? [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 16)]
              : [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(height: AppTheme.spacingMd),
            Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.3,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LimitAccordion extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String whyLimitIt;
  final String hiddenSources;
  final String dailyGoal;
  final String proTip;

  const _LimitAccordion({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.whyLimitIt,
    required this.hiddenSources,
    required this.dailyGoal,
    required this.proTip,
  });

  @override
  State<_LimitAccordion> createState() => _LimitAccordionState();
}

class _LimitAccordionState extends State<_LimitAccordion> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: isDark ? const Color(0xFF334155).withValues(alpha: 0.5) : colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (expanded) {
            setState(() {
              _isOpen = expanded;
            });
          },
          tilePadding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg, vertical: 8),
          childrenPadding: const EdgeInsets.only(
            left: AppTheme.spacingLg,
            right: AppTheme.spacingLg,
            bottom: AppTheme.spacingLg,
          ),
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: widget.iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(widget.icon, color: widget.iconColor, size: 24),
          ),
          title: Text(
            widget.title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(
            _isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: colorScheme.onSurfaceVariant,
          ),
          children: [
            _AccordionDetailRow(title: 'Why limit it', text: widget.whyLimitIt),
            _AccordionDetailRow(title: 'Hidden Sources', text: widget.hiddenSources),
            _AccordionDetailRow(title: 'Daily Goal', text: widget.dailyGoal),
            _AccordionDetailRow(title: 'Pro-Tip', text: widget.proTip),
          ],
        ),
      ),
    );
  }
}

class _QuickTipCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _QuickTipCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: colorScheme.primary, size: 32),
          const SizedBox(width: AppTheme.spacingLg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FoodAccordion extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String whyItHelps;
  final String bestChoices;
  final String dailyGoal;
  final String proTip;

  const _FoodAccordion({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.whyItHelps,
    required this.bestChoices,
    required this.dailyGoal,
    required this.proTip,
  });

  @override
  State<_FoodAccordion> createState() => _FoodAccordionState();
}

class _FoodAccordionState extends State<_FoodAccordion> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: isDark ? const Color(0xFF334155).withValues(alpha: 0.5) : colorScheme.outline.withValues(alpha: 0.1),
        ),
        boxShadow: isDark
            ? [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 16)]
            : [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4)],
      ),
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (expanded) {
            setState(() {
              _isOpen = expanded;
            });
          },
          tilePadding: const EdgeInsets.all(AppTheme.spacingLg),
          childrenPadding: const EdgeInsets.only(
            left: AppTheme.spacingLg,
            right: AppTheme.spacingLg,
            bottom: AppTheme.spacingLg,
          ),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: widget.iconBgColor,
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: Icon(widget.icon, color: widget.iconColor, size: 24),
          ),
          title: Text(
            widget.title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(
            _isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: colorScheme.onSurfaceVariant,
          ),
          children: [
            _AccordionDetailRow(title: 'Why it helps', text: widget.whyItHelps),
            _AccordionDetailRow(title: 'Best Choices', text: widget.bestChoices),
            _AccordionDetailRow(title: 'Daily Goal', text: widget.dailyGoal),
            _AccordionDetailRow(title: 'Pro-Tip', text: widget.proTip),
          ],
        ),
      ),
    );
  }
}

class _AccordionDetailRow extends StatelessWidget {
  final String title;
  final String text;

  const _AccordionDetailRow({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
                children: [
                  TextSpan(
                    text: '$title: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: text),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
