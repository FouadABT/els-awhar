import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/admin_colors.dart';

/// Reusable data table card widget
class DataTableCard extends StatelessWidget {
  final String title;
  final List<String> columns;
  final List<List<String>> rows;
  final Function(int rowIndex, String action)? onRowAction;

  const DataTableCard({
    super.key,
    required this.title,
    required this.columns,
    required this.rows,
    this.onRowAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AdminColors.surfaceElevatedLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AdminColors.borderSoftLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AdminColors.textPrimaryLight,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Showing ${rows.length} entries',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AdminColors.textMutedLight,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          // Table
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: DataTable(
                  columnSpacing: 32,
                  headingRowColor: WidgetStateProperty.all(
                    AdminColors.backgroundLight,
                  ),
                  headingTextStyle: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AdminColors.textSecondaryLight,
                  ),
                  dataTextStyle: GoogleFonts.inter(
                    fontSize: 14,
                    color: AdminColors.textPrimaryLight,
                  ),
                  columns: columns.map((col) => DataColumn(
                    label: Text(col),
                  )).toList(),
                  rows: rows.asMap().entries.map((entry) {
                    final index = entry.key;
                    final row = entry.value;
                    return DataRow(
                      cells: row.map((cell) {
                        if (cell == 'actions') {
                          return DataCell(_buildActionButtons(index));
                        } else if (cell == 'Active') {
                          return DataCell(_buildStatusChip(cell, AdminColors.success));
                        } else if (cell == 'Suspended') {
                          return DataCell(_buildStatusChip(cell, AdminColors.warning));
                        } else if (cell == 'Banned') {
                          return DataCell(_buildStatusChip(cell, AdminColors.error));
                        } else if (cell == 'Pending') {
                          return DataCell(_buildStatusChip(cell, AdminColors.info));
                        } else if (cell == 'Completed') {
                          return DataCell(_buildStatusChip(cell, AdminColors.success));
                        } else if (cell == 'Verified') {
                          return DataCell(_buildStatusChip(cell, AdminColors.success));
                        } else if (cell == 'Unverified') {
                          return DataCell(_buildStatusChip(cell, AdminColors.warning));
                        } else if (cell.startsWith('#')) {
                          return DataCell(
                            Text(
                              cell,
                              style: GoogleFonts.robotoMono(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: AdminColors.primary,
                              ),
                            ),
                          );
                        }
                        return DataCell(Text(cell));
                      }).toList(),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          
          const Divider(height: 1),
          
          // Pagination
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Page 1 of 10',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AdminColors.textMutedLight,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: null,
                      icon: const Icon(Icons.chevron_left),
                      iconSize: 20,
                    ),
                    ...List.generate(5, (i) => _buildPageButton(i + 1, i == 0)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.chevron_right),
                      iconSize: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  Widget _buildActionButtons(int rowIndex) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => onRowAction?.call(rowIndex, 'view'),
          icon: const Icon(Icons.visibility_outlined),
          iconSize: 18,
          tooltip: 'View',
          color: AdminColors.info,
        ),
        IconButton(
          onPressed: () => onRowAction?.call(rowIndex, 'edit'),
          icon: const Icon(Icons.edit_outlined),
          iconSize: 18,
          tooltip: 'Edit',
          color: AdminColors.warning,
        ),
        IconButton(
          onPressed: () => onRowAction?.call(rowIndex, 'delete'),
          icon: const Icon(Icons.delete_outline),
          iconSize: 18,
          tooltip: 'Delete',
          color: AdminColors.error,
        ),
      ],
    );
  }

  Widget _buildPageButton(int page, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Material(
        color: isActive ? AdminColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(6),
          child: Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            child: Text(
              '$page',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isActive ? Colors.white : AdminColors.textSecondaryLight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
