String _two(int n) => n.toString().padLeft(2, '0');

/// dd/mm/aaaa
String formatDate(DateTime? d) =>
    d == null ? '—' : '${_two(d.day)}/${_two(d.month)}/${d.year}';

/// dd/mm
String formatShortDate(DateTime? d) =>
    d == null ? '—' : '${_two(d.day)}/${_two(d.month)}';

const _weekdays = [
  'Segunda-feira',
  'Terça-feira',
  'Quarta-feira',
  'Quinta-feira',
  'Sexta-feira',
  'Sábado',
  'Domingo',
];

String weekdayName(DateTime? d) => d == null ? '' : _weekdays[d.weekday - 1];
