import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gemify/gems/gem_detail_screen.dart';
import 'package:gemify/gems/add_gem_screen.dart';
import '../models/gem.dart';

class GemListScreen extends StatefulWidget {
  const GemListScreen({super.key});

  @override
  State<GemListScreen> createState() => _GemListScreenState();
}

class _GemListScreenState extends State<GemListScreen> {
  // In-memory storage for gems with dummy data
  List<Gem> _gems = [];
  String _searchQuery = '';
  String _sortBy = 'name'; // name, date, price, weight

  @override
  void initState() {
    super.initState();
    _loadGems();
  }

  // Load gems with dummy data
  void _loadGems() {
    setState(() {
      _gems = [
        Gem(
          gemName: 'Blue Sapphire',
          gemCode: 'BS001',
          gemVariety: 'Ceylon Sapphire',
          gemHolder: 'John Smith',
          previousOwner: 'Mr. Silva',
          roughWeight: 12.5,
          weightAfterPerform: 10.2,
          weightAfterCutAndPolish: 8.75,
          widthAfterCutPolish: 6.2,
          heightAfterCutPolish: 4.8,
          purchasedPrice: 50000,
          purchasedDate: DateTime(2024, 1, 15),
          performingCharges: 2000,
          cuttingCharges: 3000,
          totalCost: 55000,
          gemImage: 'assets/images/gem_sample_4.png',
        ),
        Gem(
          gemName: 'Ruby Star',
          gemCode: 'RS002',
          gemVariety: 'Burmese Ruby',
          gemHolder: 'Alice Johnson',
          previousOwner: 'Mrs. Perera',
          roughWeight: 15.8,
          weightAfterPerform: 13.4,
          weightAfterCutAndPolish: 11.25,
          widthAfterCutPolish: 7.5,
          heightAfterCutPolish: 5.2,
          purchasedPrice: 75000,
          purchasedDate: DateTime(2024, 2, 20),
          performingCharges: 2500,
          cuttingCharges: 3500,
          totalCost: 81000,
          gemImage: 'assets/images/gem_sample.png',
        ),
        Gem(
          gemName: 'Emerald Green',
          gemCode: 'EG003',
          gemVariety: 'Colombian Emerald',
          gemHolder: 'David Brown',
          previousOwner: 'Mr. Fernando',
          roughWeight: 10.2,
          weightAfterPerform: 8.9,
          weightAfterCutAndPolish: 7.50,
          widthAfterCutPolish: 5.8,
          heightAfterCutPolish: 4.2,
          purchasedPrice: 62000,
          purchasedDate: DateTime(2024, 3, 10),
          performingCharges: 1800,
          cuttingCharges: 2800,
          totalCost: 66600,
          gemImage: 'assets/images/gem_sample_2.png',
        ),
        Gem(
          gemName: 'Pink Topaz',
          gemCode: 'PT004',
          gemVariety: 'Imperial Topaz',
          gemHolder: 'Sarah Wilson',
          previousOwner: 'Mrs. De Silva',
          roughWeight: 18.5,
          weightAfterPerform: 16.2,
          weightAfterCutAndPolish: 14.80,
          widthAfterCutPolish: 8.2,
          heightAfterCutPolish: 6.5,
          purchasedPrice: 45000,
          purchasedDate: DateTime(2024, 4, 5),
          performingCharges: 1500,
          cuttingCharges: 2200,
          totalCost: 48700,
          gemImage: 'assets/images/gem_sample_3.png',
        ),
        Gem(
          gemName: 'Yellow Citrine',
          gemCode: 'YC005',
          gemVariety: 'Madeira Citrine',
          gemHolder: 'Michael Chen',
          previousOwner: 'Mr. Jayawardena',
          roughWeight: 22.3,
          weightAfterPerform: 19.8,
          weightAfterCutAndPolish: 17.50,
          widthAfterCutPolish: 9.5,
          heightAfterCutPolish: 7.2,
          purchasedPrice: 38000,
          purchasedDate: DateTime(2024, 5, 18),
          performingCharges: 1200,
          cuttingCharges: 2000,
          totalCost: 41200,
          gemImage: 'assets/images/gem_sample.png',
        ),
      ];
    });
  }

  // Add new gem to inventory
  void _addGem(Gem gem) {
    setState(() {
      _gems.add(gem);
    });
    // TODO: Save to database
  }

  // Delete gem from inventory
  void _deleteGem(String gemCode) {
    setState(() {
      _gems.removeWhere((gem) => gem.gemCode == gemCode);
    });
    // TODO: Delete from database
  }

  // Get filtered and sorted gems
  List<Gem> get _filteredGems {
    var filtered = _gems.where((gem) {
      final query = _searchQuery.toLowerCase();
      return gem.gemName.toLowerCase().contains(query) ||
          gem.gemCode.toLowerCase().contains(query) ||
          gem.gemVariety.toLowerCase().contains(query);
    }).toList();

    // Sort gems
    switch (_sortBy) {
      case 'name':
        filtered.sort((a, b) => a.gemName.compareTo(b.gemName));
        break;
      case 'date':
        filtered.sort((a, b) => b.purchasedDate.compareTo(a.purchasedDate));
        break;
      case 'price':
        filtered.sort((a, b) => b.totalCost.compareTo(a.totalCost));
        break;
      case 'weight':
        filtered.sort(
          (a, b) =>
              b.weightAfterCutAndPolish.compareTo(a.weightAfterCutAndPolish),
        );
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final filteredGems = _filteredGems;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFE8EAF6),
              const Color(0xFFF3E5F5),
              const Color(0xFFE1F5FE),
              const Color(0xFFFCE4EC),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),

              // Search and Filter Bar
              _buildSearchAndFilter(),

              // Stats Summary
              if (_gems.isNotEmpty) _buildStatsSummary(),

              // Gems List
              Expanded(
                child: _gems.isEmpty
                    ? _buildEmptyState()
                    : _buildGemsList(filteredGems),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildAddButton(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.shade200, Colors.blue.shade200],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.shade100.withOpacity(0.5),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.diamond, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 6),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gem Inventory',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2D3142),
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 45,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    style: const TextStyle(fontSize: 13),
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(
                        color: const Color(0xFF2D3142).withOpacity(0.5),
                        fontSize: 13,
                      ),
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.search,
                        color: const Color(0xFF2D3142).withOpacity(0.6),
                        size: 20,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: PopupMenuButton<String>(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.sort,
                    color: Color(0xFF2D3142),
                    size: 20,
                  ),
                  onSelected: (value) {
                    setState(() {
                      _sortBy = value;
                    });
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'name',
                      child: Row(
                        children: [
                          Icon(Icons.sort_by_alpha, size: 16),
                          SizedBox(width: 8),
                          Text('Name', style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'date',
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, size: 16),
                          SizedBox(width: 8),
                          Text('Date', style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'price',
                      child: Row(
                        children: [
                          Icon(Icons.attach_money, size: 3),
                          SizedBox(width: 2),
                          Text('Price', style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'weight',
                      child: Row(
                        children: [
                          Icon(Icons.monitor_weight, size: 16),
                          SizedBox(width: 8),
                          Text('Weight', style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSummary() {
    final totalValue = _gems.fold<double>(0, (sum, gem) => sum + gem.totalCost);
    final totalWeight = _gems.fold<double>(
      0,
      (sum, gem) => sum + gem.weightAfterCutAndPolish,
    );

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            icon: Icons.inventory,
            label: 'Total Gems',
            value: '${_gems.length}',
            color: Colors.blue.shade300,
          ),
          _buildStatItem(
            icon: Icons.attach_money,
            label: 'Total Value',
            value: '\$${totalValue.toStringAsFixed(0)}',
            color: Colors.green.shade300,
          ),
          _buildStatItem(
            icon: Icons.monitor_weight,
            label: 'Total Weight',
            value: '${totalWeight.toStringAsFixed(2)} ct',
            color: Colors.purple.shade300,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: const Color(0xFF2D3142).withOpacity(0.6),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2D3142),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.diamond_outlined,
              size: 80,
              color: const Color(0xFF2D3142).withOpacity(0.3),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No Gems Yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF2D3142).withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the + button to add your first gem',
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFF2D3142).withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGemsList(List<Gem> gems) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: gems.length,
      itemBuilder: (context, index) {
        final gem = gems[index];
        return _buildGemCard(gem);
      },
    );
  }

  Widget _buildGemCard(Gem gem) {
    return GestureDetector(
      onTap: () async {
        // Navigate to detail screen and wait for result
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GemDetailScreen(gem: gem)),
        );

        // If gem was deleted, remove it from list
        if (result == 'deleted') {
          _deleteGem(gem.gemCode);
        } else if (result != null && result is Gem) {
          // If gem was updated, replace it in the list
          setState(() {
            final index = _gems.indexWhere((g) => g.gemCode == gem.gemCode);
            if (index != -1) {
              _gems[index] = result;
            }
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Row(
            children: [
              // Gem Image
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.purple.shade100, Colors.blue.shade100],
                  ),
                ),
                child: gem.gemImage != null && gem.gemImage!.isNotEmpty
                    ? (gem.gemImage!.startsWith('assets/')
                          ? Image.asset(gem.gemImage!, fit: BoxFit.cover)
                          : Image.file(File(gem.gemImage!), fit: BoxFit.cover))
                    : const Icon(
                        Icons.diamond,
                        size: 45,
                        color: Color(0xFF2D3142),
                      ),
              ),

              // Gem Info
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Gem Name
                      Text(
                        gem.gemName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2D3142),
                          letterSpacing: 0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),

                      // Gem Variety - Fixed overflow
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.purple.shade50,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          gem.gemVariety,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.purple.shade400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Gem Code
                      Row(
                        children: [
                          Icon(
                            Icons.qr_code,
                            size: 14,
                            color: const Color(0xFF2D3142).withOpacity(0.5),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            gem.gemCode,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF2D3142).withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Weight
                      Row(
                        children: [
                          Icon(
                            Icons.monitor_weight,
                            size: 14,
                            color: const Color(0xFF2D3142).withOpacity(0.5),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${gem.weightAfterCutAndPolish} ct',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF2D3142).withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Price
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.green.shade200, Colors.teal.shade200],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '\$${gem.totalCost.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: Color(0xFF2D3142),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return FloatingActionButton(
      onPressed: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddGemScreen()),
        );

        // If a new gem was added, add it to the list
        if (result != null && result is Gem) {
          _addGem(result);
        }
      },
      backgroundColor: Colors.purple.shade300,
      elevation: 4,
      child: const Icon(Icons.add, color: Colors.white, size: 32),
    );
  }
}
