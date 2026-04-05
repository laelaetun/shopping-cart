import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class POSDashboardPage extends StatelessWidget {
  const POSDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1024) {
          return const _DesktopLayout();
        } else {
          return const _MobileTabletLayout();
        }
      },
    );
  }
}

////////////////////////////////////////////////////////////
/// 📱 MOBILE + TABLET (Drawer)
////////////////////////////////////////////////////////////
class _MobileTabletLayout extends StatelessWidget {
  const _MobileTabletLayout();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("POS Dashboard")),
      drawer: const _AppDrawer(),
      body: const _DashboardBody(),
    );
  }
}

////////////////////////////////////////////////////////////
/// 🖥️ DESKTOP (Sidebar)
////////////////////////////////////////////////////////////
class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: const [
          _Sidebar(),
          Expanded(child: _DashboardBody()),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// 🧾 DASHBOARD BODY
////////////////////////////////////////////////////////////
class _DashboardBody extends StatelessWidget {
  const _DashboardBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // 🔹 STAT CARDS GRID
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2.2,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              _StatCard(
                title: "Revenue",
                value: "\$12,500",
                icon: Icons.attach_money,
              ),
              _StatCard(
                title: "Orders",
                value: "320",
                icon: Icons.shopping_cart,
              ),
              _StatCard(title: "Customers", value: "120", icon: Icons.people),
              _StatCard(
                title: "Growth",
                value: "+12%",
                icon: Icons.trending_up,
              ),
            ],
          ),

          const SizedBox(height: 20),

          // 🔹 CHARTS GRID
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
            physics: const NeverScrollableScrollPhysics(),
            children: const [_LineChartCard(), _PieChartCard()],
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// 📦 STAT CARD
////////////////////////////////////////////////////////////
class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff4facfe), Color(0xff00f2fe)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(blurRadius: 8, color: Colors.black.withOpacity(0.1)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white70)),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// 📈 LINE CHART
////////////////////////////////////////////////////////////
class _LineChartCard extends StatelessWidget {
  const _LineChartCard();

  @override
  Widget build(BuildContext context) {
    return _CardContainer(
      title: "Sales Overview",
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              spots: const [
                FlSpot(0, 1),
                FlSpot(1, 3),
                FlSpot(2, 2),
                FlSpot(3, 5),
                FlSpot(4, 4),
              ],
              barWidth: 4,
              dotData: FlDotData(show: false),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// 🥧 PIE CHART
////////////////////////////////////////////////////////////
class _PieChartCard extends StatelessWidget {
  const _PieChartCard();

  @override
  Widget build(BuildContext context) {
    return _CardContainer(
      title: "Category Sales",
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(value: 40, title: "Food", color: Colors.green),
            PieChartSectionData(value: 30, title: "Drink", color: Colors.blue),
            PieChartSectionData(
              value: 20,
              title: "Snack",
              color: Colors.orange,
            ),
            PieChartSectionData(value: 10, title: "Other", color: Colors.red),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// 📦 CARD CONTAINER
////////////////////////////////////////////////////////////
class _CardContainer extends StatelessWidget {
  final String title;
  final Widget child;

  const _CardContainer({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.05)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Expanded(child: child),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// 📂 DRAWER
////////////////////////////////////////////////////////////
class _AppDrawer extends StatelessWidget {
  const _AppDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: const [
          DrawerHeader(
            child: Text(
              "POS Menu",
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
          ),
          ListTile(title: Text("Dashboard"), leading: Icon(Icons.dashboard)),
          ListTile(title: Text("Products"), leading: Icon(Icons.store)),
          ListTile(title: Text("Orders"), leading: Icon(Icons.receipt)),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// 📌 SIDEBAR
////////////////////////////////////////////////////////////
class _Sidebar extends StatelessWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: Colors.black87,
      child: const Column(
        children: [
          SizedBox(height: 40),
          ListTile(
            leading: Icon(Icons.dashboard, color: Colors.white),
            title: Text("Dashboard", style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            leading: Icon(Icons.store, color: Colors.white),
            title: Text("Products", style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            leading: Icon(Icons.receipt, color: Colors.white),
            title: Text("Orders", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
