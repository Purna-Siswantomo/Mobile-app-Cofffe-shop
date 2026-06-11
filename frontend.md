<!-- Design System -->
<!DOCTYPE html>

<html lang="id"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Admin Dashboard - QuickServe POS</title>
<!-- Material Symbols -->
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<!-- Google Fonts: Inter -->
<link href="https://fonts.googleapis.com" rel="preconnect"/>
<link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<!-- Tailwind CSS -->
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .icon-fill {
            font-variation-settings: 'FILL' 1;
        }
    </style>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "surface": "#f8f9ff",
                        "on-secondary": "#ffffff",
                        "on-surface": "#0b1c30",
                        "on-error-container": "#93000a",
                        "on-primary": "#ffffff",
                        "background": "#f8f9ff",
                        "surface-container": "#e5eeff",
                        "on-tertiary-container": "#ffb4ad",
                        "inverse-on-surface": "#eaf1ff",
                        "primary-fixed": "#a6f2d1",
                        "tertiary-fixed-dim": "#ffb3ac",
                        "on-tertiary-fixed-variant": "#73332f",
                        "on-surface-variant": "#3f4944",
                        "inverse-primary": "#8bd6b6",
                        "on-primary-fixed-variant": "#00513b",
                        "on-primary-fixed": "#002116",
                        "outline": "#6f7973",
                        "surface-bright": "#f8f9ff",
                        "error-container": "#ffdad6",
                        "surface-variant": "#d3e4fe",
                        "tertiary-fixed": "#ffdad6",
                        "surface-container-highest": "#d3e4fe",
                        "outline-variant": "#bec9c2",
                        "primary-container": "#065f46",
                        "secondary": "#565e74",
                        "on-primary-container": "#8bd6b7",
                        "tertiary": "#652925",
                        "on-tertiary": "#ffffff",
                        "on-background": "#0b1c30",
                        "inverse-surface": "#213145",
                        "surface-container-lowest": "#ffffff",
                        "primary": "#004532",
                        "secondary-fixed-dim": "#bec6e0",
                        "on-tertiary-fixed": "#3b0908",
                        "primary-fixed-dim": "#8bd6b6",
                        "surface-tint": "#1b6b51",
                        "surface-container-high": "#dce9ff",
                        "on-secondary-container": "#5c647a",
                        "tertiary-container": "#823f3a",
                        "on-error": "#ffffff",
                        "surface-dim": "#cbdbf5",
                        "surface-container-low": "#eff4ff",
                        "on-secondary-fixed": "#131b2e",
                        "on-secondary-fixed-variant": "#3f465c",
                        "secondary-fixed": "#dae2fd",
                        "secondary-container": "#dae2fd",
                        "error": "#ba1a1a"
                    },
                    "borderRadius": {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                    "spacing": {
                        "lg": "24px",
                        "md": "16px",
                        "xl": "32px",
                        "xs": "4px",
                        "base": "8px",
                        "gutter-desktop": "24px",
                        "gutter-mobile": "16px",
                        "touch-target": "44px",
                        "sm": "12px"
                    },
                    "fontFamily": {
                        "headline-md": ["Inter"],
                        "title-lg": ["Inter"],
                        "display-lg": ["Inter"],
                        "body-lg": ["Inter"],
                        "headline-lg-mobile": ["Inter"],
                        "body-md": ["Inter"],
                        "label-sm": ["Inter"],
                        "headline-lg": ["Inter"],
                        "label-md": ["Inter"]
                    },
                    "fontSize": {
                        "headline-md": ["24px", { "lineHeight": "32px", "fontWeight": "600" }],
                        "title-lg": ["20px", { "lineHeight": "28px", "fontWeight": "600" }],
                        "display-lg": ["48px", { "lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "700" }],
                        "body-lg": ["18px", { "lineHeight": "28px", "fontWeight": "400" }],
                        "headline-lg-mobile": ["24px", { "lineHeight": "32px", "fontWeight": "600" }],
                        "body-md": ["16px", { "lineHeight": "24px", "fontWeight": "400" }],
                        "label-sm": ["12px", { "lineHeight": "16px", "fontWeight": "600" }],
                        "headline-lg": ["32px", { "lineHeight": "40px", "letterSpacing": "-0.01em", "fontWeight": "600" }],
                        "label-md": ["14px", { "lineHeight": "20px", "letterSpacing": "0.01em", "fontWeight": "500" }]
                    }
                }
            }
        }
    </script>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
  </head>
<body class="bg-background text-on-surface font-body-md text-body-md antialiased h-screen overflow-hidden flex">
<!-- Desktop Sidebar (Hidden on Mobile) -->
<aside class="hidden md:flex flex-col w-64 bg-surface-container-lowest border-r border-outline-variant h-full z-10">
<div class="h-14 flex items-center px-gutter-desktop border-b border-outline-variant">
<span class="font-headline-md text-headline-md font-bold text-primary">QuickServe Admin</span>
</div>
<nav class="flex-1 py-lg px-md space-y-sm">
<a class="flex items-center gap-md px-md py-sm bg-primary-container text-on-primary-container rounded-lg font-label-md text-label-md" href="#">
<span class="material-symbols-outlined icon-fill" data-icon="dashboard">dashboard</span>
                Beranda
            </a>
<a class="flex items-center gap-md px-md py-sm text-on-surface-variant hover:bg-surface-container hover:text-on-surface rounded-lg font-label-md text-label-md transition-colors" href="#">
<span class="material-symbols-outlined" data-icon="inventory_2">inventory_2</span>
                Produk
            </a>
<a class="flex items-center gap-md px-md py-sm text-on-surface-variant hover:bg-surface-container hover:text-on-surface rounded-lg font-label-md text-label-md transition-colors" href="#">
<span class="material-symbols-outlined" data-icon="group">group</span>
                Pengguna
            </a>
<a class="flex items-center gap-md px-md py-sm text-on-surface-variant hover:bg-surface-container hover:text-on-surface rounded-lg font-label-md text-label-md transition-colors" href="#">
<span class="material-symbols-outlined" data-icon="bar_chart">bar_chart</span>
                Laporan
            </a>
</nav>
</aside>
<!-- Main Canvas Area -->
<main class="flex-1 flex flex-col h-full overflow-hidden relative">
<!-- TopAppBar (JSON Sourced) -->
<header class="w-full top-0 sticky z-50 bg-surface dark:bg-surface-dim border-b border-outline-variant dark:border-outline flex justify-between items-center px-gutter-mobile h-14 w-full">
<button class="md:hidden flex items-center justify-center p-2 text-primary hover:bg-surface-container transition-colors rounded-full active:scale-95 transition-transform duration-100">
<span class="material-symbols-outlined" data-icon="menu">menu</span>
</button>
<div class="md:hidden font-headline-md text-headline-md-mobile font-bold text-primary dark:text-primary-fixed-dim">
                QuickServe POS
            </div>
<div class="hidden md:flex flex-1"></div> <!-- Spacer for desktop -->
<button class="flex items-center justify-center p-2 text-primary hover:bg-surface-container transition-colors rounded-full active:scale-95 transition-transform duration-100">
<span class="material-symbols-outlined" data-icon="notifications">notifications</span>
</button>
</header>
<!-- Scrollable Dashboard Content -->
<div class="flex-1 overflow-y-auto p-gutter-mobile md:p-gutter-desktop pb-24 md:pb-lg">
<div class="max-w-7xl mx-auto space-y-lg">
<!-- Page Header -->
<div>
<h1 class="font-headline-lg-mobile md:font-headline-lg text-headline-lg-mobile md:text-headline-lg text-on-surface">Ringkasan Hari Ini</h1>
<p class="font-body-md text-body-md text-on-surface-variant mt-xs">Pantau performa bisnis Anda secara real-time.</p>
</div>
<!-- KPI Bento Grid -->
<div class="grid grid-cols-1 md:grid-cols-3 gap-md">
<!-- KPI Card 1 -->
<div class="bg-surface-container-lowest border border-outline-variant rounded-xl p-md flex flex-col justify-between">
<div class="flex justify-between items-start mb-lg">
<span class="font-label-md text-label-md text-on-surface-variant">Pendapatan</span>
<div class="p-2 bg-primary-container/20 text-primary-container rounded-full">
<span class="material-symbols-outlined" data-icon="payments">payments</span>
</div>
</div>
<div>
<div class="font-headline-md text-headline-md text-on-surface mb-xs">Rp 12.450.000</div>
<div class="flex items-center gap-xs font-label-sm text-label-sm text-primary">
<span class="material-symbols-outlined text-[16px]" data-icon="trending_up">trending_up</span>
<span>+8.2% vs kemarin</span>
</div>
</div>
</div>
<!-- KPI Card 2 -->
<div class="bg-surface-container-lowest border border-outline-variant rounded-xl p-md flex flex-col justify-between">
<div class="flex justify-between items-start mb-lg">
<span class="font-label-md text-label-md text-on-surface-variant">Total Pesanan</span>
<div class="p-2 bg-secondary-container/50 text-secondary rounded-full">
<span class="material-symbols-outlined" data-icon="receipt_long">receipt_long</span>
</div>
</div>
<div>
<div class="font-headline-md text-headline-md text-on-surface mb-xs">342</div>
<div class="flex items-center gap-xs font-label-sm text-label-sm text-on-surface-variant">
<span>Sedang diproses: 12</span>
</div>
</div>
</div>
<!-- KPI Card 3 -->
<div class="bg-surface-container-lowest border border-outline-variant rounded-xl p-md flex flex-col justify-between">
<div class="flex justify-between items-start mb-lg">
<span class="font-label-md text-label-md text-on-surface-variant">Pelanggan Baru</span>
<div class="p-2 bg-tertiary-container/20 text-tertiary-container rounded-full">
<span class="material-symbols-outlined" data-icon="person_add">person_add</span>
</div>
</div>
<div>
<div class="font-headline-md text-headline-md text-on-surface mb-xs">24</div>
<div class="flex items-center gap-xs font-label-sm text-label-sm text-primary">
<span class="material-symbols-outlined text-[16px]" data-icon="trending_up">trending_up</span>
<span>+15% minggu ini</span>
</div>
</div>
</div>
</div>
<!-- Main Content Split -->
<div class="grid grid-cols-1 lg:grid-cols-3 gap-lg">
<!-- Chart Section (Spans 2 cols on Desktop) -->
<div class="lg:col-span-2 bg-surface-container-lowest border border-outline-variant rounded-xl p-md md:p-lg flex flex-col">
<div class="flex justify-between items-center mb-xl">
<h2 class="font-title-lg text-title-lg text-on-surface">Penjualan Mingguan</h2>
<button class="text-primary hover:bg-surface-container px-3 py-1 rounded-full font-label-sm text-label-sm transition-colors">Lihat Detail</button>
</div>
<!-- Simple CSS Bar Chart -->
<div class="flex-1 flex items-end gap-2 md:gap-4 h-48 md:h-64 mt-auto border-b border-outline-variant pb-2 relative">
<!-- Grid lines (visual only) -->
<div class="absolute inset-0 flex flex-col justify-between border-t border-outline-variant/30 pointer-events-none">
<div class="border-b border-outline-variant/30 flex-1"></div>
<div class="border-b border-outline-variant/30 flex-1"></div>
<div class="flex-1"></div>
</div>
<!-- Bars -->
<div class="flex-1 flex flex-col items-center gap-2 z-10 group">
<div class="w-full bg-primary-container/40 group-hover:bg-primary-container rounded-t-sm h-[40%] transition-colors relative"><div class="absolute -top-6 left-1/2 -translate-x-1/2 opacity-0 group-hover:opacity-100 font-label-sm text-label-sm text-on-surface transition-opacity">40</div></div>
<span class="font-label-sm text-label-sm text-on-surface-variant">Sen</span>
</div>
<div class="flex-1 flex flex-col items-center gap-2 z-10 group">
<div class="w-full bg-primary-container/40 group-hover:bg-primary-container rounded-t-sm h-[60%] transition-colors relative"><div class="absolute -top-6 left-1/2 -translate-x-1/2 opacity-0 group-hover:opacity-100 font-label-sm text-label-sm text-on-surface transition-opacity">60</div></div>
<span class="font-label-sm text-label-sm text-on-surface-variant">Sel</span>
</div>
<div class="flex-1 flex flex-col items-center gap-2 z-10 group">
<div class="w-full bg-primary-container/40 group-hover:bg-primary-container rounded-t-sm h-[45%] transition-colors relative"><div class="absolute -top-6 left-1/2 -translate-x-1/2 opacity-0 group-hover:opacity-100 font-label-sm text-label-sm text-on-surface transition-opacity">45</div></div>
<span class="font-label-sm text-label-sm text-on-surface-variant">Rab</span>
</div>
<div class="flex-1 flex flex-col items-center gap-2 z-10 group">
<div class="w-full bg-primary rounded-t-sm h-[85%] shadow-sm relative"><div class="absolute -top-6 left-1/2 -translate-x-1/2 font-label-sm text-label-sm text-on-surface">85</div></div>
<span class="font-label-sm text-label-sm text-primary font-bold">Kam</span>
</div>
<div class="flex-1 flex flex-col items-center gap-2 z-10 group">
<div class="w-full bg-primary-container/40 group-hover:bg-primary-container rounded-t-sm h-[70%] transition-colors relative"><div class="absolute -top-6 left-1/2 -translate-x-1/2 opacity-0 group-hover:opacity-100 font-label-sm text-label-sm text-on-surface transition-opacity">70</div></div>
<span class="font-label-sm text-label-sm text-on-surface-variant">Jum</span>
</div>
<div class="flex-1 flex flex-col items-center gap-2 z-10 group">
<div class="w-full bg-primary-container/40 group-hover:bg-primary-container rounded-t-sm h-[95%] transition-colors relative"><div class="absolute -top-6 left-1/2 -translate-x-1/2 opacity-0 group-hover:opacity-100 font-label-sm text-label-sm text-on-surface transition-opacity">95</div></div>
<span class="font-label-sm text-label-sm text-on-surface-variant">Sab</span>
</div>
<div class="flex-1 flex flex-col items-center gap-2 z-10 group">
<div class="w-full bg-primary-container/40 group-hover:bg-primary-container rounded-t-sm h-[50%] transition-colors relative"><div class="absolute -top-6 left-1/2 -translate-x-1/2 opacity-0 group-hover:opacity-100 font-label-sm text-label-sm text-on-surface transition-opacity">50</div></div>
<span class="font-label-sm text-label-sm text-on-surface-variant">Min</span>
</div>
</div>
</div>
<!-- Quick Actions / Navigation (Visible clearly on mobile, extra links on desktop) -->
<div class="flex flex-col gap-md">
<h2 class="font-title-lg text-title-lg text-on-surface mb-xs md:mb-sm">Aksi Cepat</h2>
<a class="flex items-center p-md bg-surface-container-lowest border border-outline-variant hover:border-primary rounded-xl transition-colors group cursor-pointer" href="#">
<div class="w-12 h-12 bg-surface-variant rounded-lg flex items-center justify-center text-on-surface-variant group-hover:bg-primary-container group-hover:text-on-primary-container transition-colors mr-md">
<span class="material-symbols-outlined" data-icon="inventory_2">inventory_2</span>
</div>
<div class="flex-1">
<div class="font-label-md text-label-md text-on-surface">Kelola Produk</div>
<div class="font-label-sm text-label-sm text-on-surface-variant">Tambah, edit, atau hapus menu</div>
</div>
<span class="material-symbols-outlined text-outline-variant group-hover:text-primary transition-colors" data-icon="chevron_right">chevron_right</span>
</a>
<a class="flex items-center p-md bg-surface-container-lowest border border-outline-variant hover:border-primary rounded-xl transition-colors group cursor-pointer" href="#">
<div class="w-12 h-12 bg-surface-variant rounded-lg flex items-center justify-center text-on-surface-variant group-hover:bg-primary-container group-hover:text-on-primary-container transition-colors mr-md">
<span class="material-symbols-outlined" data-icon="group">group</span>
</div>
<div class="flex-1">
<div class="font-label-md text-label-md text-on-surface">Manajemen Pengguna</div>
<div class="font-label-sm text-label-sm text-on-surface-variant">Atur kasir &amp; akses admin</div>
</div>
<span class="material-symbols-outlined text-outline-variant group-hover:text-primary transition-colors" data-icon="chevron_right">chevron_right</span>
</a>
<a class="flex items-center p-md bg-surface-container-lowest border border-outline-variant hover:border-primary rounded-xl transition-colors group cursor-pointer" href="#">
<div class="w-12 h-12 bg-surface-variant rounded-lg flex items-center justify-center text-on-surface-variant group-hover:bg-primary-container group-hover:text-on-primary-container transition-colors mr-md">
<span class="material-symbols-outlined" data-icon="summarize">summarize</span>
</div>
<div class="flex-1">
<div class="font-label-md text-label-md text-on-surface">Laporan Lengkap</div>
<div class="font-label-sm text-label-sm text-on-surface-variant">Ekspor data &amp; analitik</div>
</div>
<span class="material-symbols-outlined text-outline-variant group-hover:text-primary transition-colors" data-icon="chevron_right">chevron_right</span>
</a>
</div>
</div>
</div>
</div>
</main>
<!-- BottomNavBar (JSON Sourced - Mobile Only) -->
<nav class="md:hidden fixed bottom-0 w-full z-50 border-t border-outline-variant dark:border-outline shadow-sm bg-surface-container-lowest dark:bg-surface-container-low flex justify-around items-center h-20 w-full pb-safe">
<button class="flex flex-col items-center justify-center text-on-surface-variant dark:text-outline-variant px-4 py-1 hover:text-primary dark:hover:text-primary-fixed-dim active:opacity-80 transition-opacity">
<span class="material-symbols-outlined mb-1" data-icon="point_of_sale">point_of_sale</span>
<span class="font-label-sm text-label-sm">Register</span>
</button>
<button class="flex flex-col items-center justify-center text-on-surface-variant dark:text-outline-variant px-4 py-1 hover:text-primary dark:hover:text-primary-fixed-dim active:opacity-80 transition-opacity">
<span class="material-symbols-outlined mb-1" data-icon="receipt_long">receipt_long</span>
<span class="font-label-sm text-label-sm">Orders</span>
</button>
<!-- Active Tab: Admin -->
<button class="flex flex-col items-center justify-center bg-primary-container text-on-primary-container rounded-full px-4 py-1 active:opacity-80 transition-opacity">
<span class="material-symbols-outlined icon-fill mb-1" data-icon="dashboard">dashboard</span>
<span class="font-label-sm text-label-sm">Admin</span>
</button>
<button class="flex flex-col items-center justify-center text-on-surface-variant dark:text-outline-variant px-4 py-1 hover:text-primary dark:hover:text-primary-fixed-dim active:opacity-80 transition-opacity">
<span class="material-symbols-outlined mb-1" data-icon="inventory_2">inventory_2</span>
<span class="font-label-sm text-label-sm">Items</span>
</button>
</nav>
</body></html>

<!-- Dashboard Admin -->
<!DOCTYPE html>

<html lang="id"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Manajemen Pesanan - QuickServe POS</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "surface": "#f8f9ff",
                        "on-secondary": "#ffffff",
                        "on-surface": "#0b1c30",
                        "on-error-container": "#93000a",
                        "on-primary": "#ffffff",
                        "background": "#f8f9ff",
                        "surface-container": "#e5eeff",
                        "on-tertiary-container": "#ffb4ad",
                        "inverse-on-surface": "#eaf1ff",
                        "primary-fixed": "#a6f2d1",
                        "tertiary-fixed-dim": "#ffb3ac",
                        "on-tertiary-fixed-variant": "#73332f",
                        "on-surface-variant": "#3f4944",
                        "inverse-primary": "#8bd6b6",
                        "on-primary-fixed-variant": "#00513b",
                        "on-primary-fixed": "#002116",
                        "outline": "#6f7973",
                        "surface-bright": "#f8f9ff",
                        "error-container": "#ffdad6",
                        "surface-variant": "#d3e4fe",
                        "tertiary-fixed": "#ffdad6",
                        "surface-container-highest": "#d3e4fe",
                        "outline-variant": "#bec9c2",
                        "primary-container": "#065f46",
                        "secondary": "#565e74",
                        "on-primary-container": "#8bd6b7",
                        "tertiary": "#652925",
                        "on-tertiary": "#ffffff",
                        "on-background": "#0b1c30",
                        "inverse-surface": "#213145",
                        "surface-container-lowest": "#ffffff",
                        "primary": "#004532",
                        "secondary-fixed-dim": "#bec6e0",
                        "on-tertiary-fixed": "#3b0908",
                        "primary-fixed-dim": "#8bd6b6",
                        "surface-tint": "#1b6b51",
                        "surface-container-high": "#dce9ff",
                        "on-secondary-container": "#5c647a",
                        "tertiary-container": "#823f3a",
                        "on-error": "#ffffff",
                        "surface-dim": "#cbdbf5",
                        "surface-container-low": "#eff4ff",
                        "on-secondary-fixed": "#131b2e",
                        "on-secondary-fixed-variant": "#3f465c",
                        "secondary-fixed": "#dae2fd",
                        "secondary-container": "#dae2fd",
                        "error": "#ba1a1a"
                    },
                    "borderRadius": {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                    "spacing": {
                        "lg": "24px",
                        "md": "16px",
                        "xl": "32px",
                        "xs": "4px",
                        "base": "8px",
                        "gutter-desktop": "24px",
                        "gutter-mobile": "16px",
                        "touch-target": "44px",
                        "sm": "12px"
                    },
                    "fontFamily": {
                        "headline-md": ["Inter"],
                        "title-lg": ["Inter"],
                        "display-lg": ["Inter"],
                        "body-lg": ["Inter"],
                        "headline-lg-mobile": ["Inter"],
                        "body-md": ["Inter"],
                        "label-sm": ["Inter"],
                        "headline-lg": ["Inter"],
                        "label-md": ["Inter"]
                    },
                    "fontSize": {
                        "headline-md": ["24px", {"lineHeight": "32px", "fontWeight": "600"}],
                        "title-lg": ["20px", {"lineHeight": "28px", "fontWeight": "600"}],
                        "display-lg": ["48px", {"lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "700"}],
                        "body-lg": ["18px", {"lineHeight": "28px", "fontWeight": "400"}],
                        "headline-lg-mobile": ["24px", {"lineHeight": "32px", "fontWeight": "600"}],
                        "body-md": ["16px", {"lineHeight": "24px", "fontWeight": "400"}],
                        "label-sm": ["12px", {"lineHeight": "16px", "fontWeight": "600"}],
                        "headline-lg": ["32px", {"lineHeight": "40px", "letterSpacing": "-0.01em", "fontWeight": "600"}],
                        "label-md": ["14px", {"lineHeight": "20px", "letterSpacing": "0.01em", "fontWeight": "500"}]
                    }
                }
            }
        }
    </script>
<style>
        /* Custom scrollbar for minimal aesthetic */
        ::-webkit-scrollbar { width: 6px; height: 6px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb { background: #bec9c2; border-radius: 9999px; }
        ::-webkit-scrollbar-thumb:hover { background: #6f7973; }
        
        .shadow-level-2 { box-shadow: 0px 10px 15px -3px rgba(0, 0, 0, 0.1); }
    </style>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
  </head>
<body class="bg-background text-on-background font-body-md min-h-screen flex flex-col">
<!-- TopAppBar -->
<header class="w-full top-0 sticky bg-surface dark:bg-surface-dim border-b border-outline-variant dark:border-outline z-40">
<div class="flex justify-between items-center px-gutter-mobile md:px-gutter-desktop h-14 w-full">
<button class="flex items-center justify-center min-w-[44px] min-h-[44px] text-on-surface-variant hover:bg-surface-container dark:hover:bg-surface-container-high transition-colors rounded-full active:scale-95 duration-100">
<span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 0;">menu</span>
</button>
<h1 class="font-headline-md text-headline-md-mobile md:text-headline-md font-bold text-primary dark:text-primary-fixed-dim text-center flex-1">QuickServe POS</h1>
<button class="flex items-center justify-center min-w-[44px] min-h-[44px] text-on-surface-variant hover:bg-surface-container dark:hover:bg-surface-container-high transition-colors rounded-full active:scale-95 duration-100 relative">
<span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 0;">notifications</span>
<span class="absolute top-2 right-2 w-2 h-2 bg-error rounded-full"></span>
</button>
</div>
</header>
<!-- Main Content -->
<main class="flex-1 w-full max-w-[1440px] mx-auto px-gutter-mobile md:px-gutter-desktop py-lg pb-32">
<!-- Dashboard Header & Stats (Bento-style) -->
<div class="mb-lg space-y-md">
<h2 class="font-headline-lg-mobile md:font-headline-lg text-headline-lg-mobile md:text-headline-lg text-on-surface">Manajemen Pesanan</h2>
<div class="grid grid-cols-2 md:grid-cols-4 gap-sm">
<div class="bg-surface-container-lowest border border-outline-variant rounded-xl p-md flex flex-col justify-between hover:border-primary transition-colors cursor-pointer">
<span class="font-label-md text-label-md text-on-surface-variant">Menunggu</span>
<div class="flex items-end justify-between mt-xs">
<span class="font-display-lg text-display-lg text-primary">12</span>
<span class="material-symbols-outlined text-surface-tint">pending_actions</span>
</div>
</div>
<div class="bg-surface-container-lowest border border-outline-variant rounded-xl p-md flex flex-col justify-between hover:border-primary transition-colors cursor-pointer">
<span class="font-label-md text-label-md text-on-surface-variant">Diproses</span>
<div class="flex items-end justify-between mt-xs">
<span class="font-display-lg text-display-lg text-on-surface">5</span>
<span class="material-symbols-outlined text-secondary">skillet</span>
</div>
</div>
<div class="bg-surface-container-lowest border border-outline-variant rounded-xl p-md flex flex-col justify-between hover:border-primary transition-colors cursor-pointer hidden md:flex">
<span class="font-label-md text-label-md text-on-surface-variant">Selesai Hari Ini</span>
<div class="flex items-end justify-between mt-xs">
<span class="font-display-lg text-display-lg text-on-surface">48</span>
<span class="material-symbols-outlined text-primary-fixed-dim">check_circle</span>
</div>
</div>
<div class="bg-surface-container-lowest border border-outline-variant rounded-xl p-md flex flex-col justify-between hover:border-primary transition-colors cursor-pointer hidden md:flex">
<span class="font-label-md text-label-md text-on-surface-variant">Total Pendapatan</span>
<div class="flex items-end justify-between mt-xs">
<span class="font-title-lg text-title-lg text-on-surface">Rp 4.2M</span>
<span class="material-symbols-outlined text-primary">payments</span>
</div>
</div>
</div>
</div>
<!-- Order List Grid -->
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-md">
<!-- Card: Pending -->
<article class="bg-surface-container-lowest border border-outline-variant rounded-xl p-md flex flex-col gap-sm hover:shadow-level-2 transition-shadow">
<div class="flex justify-between items-start border-b border-surface-variant pb-xs">
<div>
<span class="font-label-sm text-label-sm text-on-surface-variant uppercase tracking-wider">#ORD-9021</span>
<h3 class="font-title-lg text-title-lg text-on-surface mt-1">Budi Santoso</h3>
</div>
<div class="bg-surface-variant text-on-surface-variant font-label-sm text-label-sm px-2 py-1 rounded-full flex items-center gap-1">
<span class="material-symbols-outlined text-[14px]">schedule</span>
                        Menunggu
                    </div>
</div>
<div class="flex-1 py-xs space-y-1">
<div class="flex justify-between font-body-md text-body-md text-on-surface">
<span>2x Nasi Goreng Spesial</span>
<span>Rp 70.000</span>
</div>
<div class="flex justify-between font-body-md text-body-md text-on-surface">
<span>1x Es Teh Manis</span>
<span>Rp 10.000</span>
</div>
<p class="font-label-sm text-label-sm text-on-surface-variant mt-2 italic flex gap-1 items-start">
<span class="material-symbols-outlined text-[14px]">speaker_notes</span>
                        Catatan: Pedas sedang, jangan pakai acar.
                    </p>
</div>
<div class="border-t border-surface-variant pt-sm mt-auto">
<div class="flex justify-between items-center mb-md">
<span class="font-label-md text-label-md text-on-surface-variant">Total Harga</span>
<span class="font-title-lg text-title-lg text-primary">Rp 80.000</span>
</div>
<div class="flex gap-2">
<button class="flex-1 border border-error text-error font-label-md text-label-md py-2 rounded-lg hover:bg-error-container transition-colors min-h-[44px]">Tolak</button>
<button class="flex-[2] bg-primary text-on-primary font-label-md text-label-md py-2 rounded-lg hover:bg-primary-container transition-colors min-h-[44px] shadow-sm">Terima Pesanan</button>
</div>
</div>
</article>
<!-- Card: Processing -->
<article class="bg-surface-container-lowest border-2 border-primary rounded-xl p-md flex flex-col gap-sm shadow-level-2 relative overflow-hidden">
<!-- Subtle background accent for active processing -->
<div class="absolute top-0 right-0 w-32 h-32 bg-primary-container opacity-10 rounded-bl-full -z-10"></div>
<div class="flex justify-between items-start border-b border-surface-variant pb-xs">
<div>
<span class="font-label-sm text-label-sm text-on-surface-variant uppercase tracking-wider">#ORD-9018</span>
<h3 class="font-title-lg text-title-lg text-on-surface mt-1">Siti Aminah</h3>
</div>
<div class="bg-secondary-container text-on-secondary-container font-label-sm text-label-sm px-2 py-1 rounded-full flex items-center gap-1">
<span class="material-symbols-outlined text-[14px] animate-spin">sync</span>
                        Diproses
                    </div>
</div>
<div class="flex-1 py-xs space-y-1">
<div class="flex justify-between font-body-md text-body-md text-on-surface">
<span>1x Ayam Bakar Madu</span>
<span>Rp 45.000</span>
</div>
<div class="flex justify-between font-body-md text-body-md text-on-surface">
<span>1x Jus Alpukat</span>
<span>Rp 20.000</span>
</div>
</div>
<div class="border-t border-surface-variant pt-sm mt-auto">
<div class="flex justify-between items-center mb-md">
<span class="font-label-md text-label-md text-on-surface-variant">Total Harga</span>
<span class="font-title-lg text-title-lg text-primary">Rp 65.000</span>
</div>
<div class="flex gap-2">
<button class="w-full bg-primary-fixed text-on-primary-fixed font-label-md text-label-md py-2 rounded-lg hover:bg-inverse-primary transition-colors min-h-[44px] font-semibold">Tandai Selesai</button>
</div>
</div>
</article>
<!-- Card: Completed -->
<article class="bg-surface-container-lowest border border-outline-variant rounded-xl p-md flex flex-col gap-sm opacity-80 hover:opacity-100 transition-opacity">
<div class="flex justify-between items-start border-b border-surface-variant pb-xs">
<div>
<span class="font-label-sm text-label-sm text-on-surface-variant uppercase tracking-wider">#ORD-9010</span>
<h3 class="font-title-lg text-title-lg text-on-surface mt-1">Andi Pratama</h3>
</div>
<div class="bg-primary text-on-primary font-label-sm text-label-sm px-2 py-1 rounded-full flex items-center gap-1">
<span class="material-symbols-outlined text-[14px]">done_all</span>
                        Selesai
                    </div>
</div>
<div class="flex-1 py-xs space-y-1">
<div class="flex justify-between font-body-md text-body-md text-on-surface">
<span class="text-on-surface-variant">3x Mie Goreng Jawa</span>
<span class="text-on-surface-variant">Rp 90.000</span>
</div>
</div>
<div class="border-t border-surface-variant pt-sm mt-auto">
<div class="flex justify-between items-center mb-md">
<span class="font-label-md text-label-md text-on-surface-variant">Total Harga</span>
<span class="font-title-lg text-title-lg text-on-surface-variant">Rp 90.000</span>
</div>
<div class="flex gap-2">
<button class="w-full border border-outline-variant text-on-surface font-label-md text-label-md py-2 rounded-lg hover:bg-surface-container transition-colors min-h-[44px]">Cetak Struk</button>
</div>
</div>
</article>
</div>
</main>
<!-- BottomNavBar -->
<nav class="fixed bottom-0 w-full z-50 bg-surface-container-lowest dark:bg-surface-container-low border-t border-outline-variant dark:border-outline md:hidden">
<div class="flex justify-around items-center h-20 w-full pb-safe">
<!-- Inactive: Register -->
<button class="flex flex-col items-center justify-center text-on-surface-variant dark:text-outline-variant px-4 py-1 hover:text-primary dark:hover:text-primary-fixed-dim active:opacity-80 transition-opacity min-w-[44px] min-h-[44px]">
<span class="material-symbols-outlined mb-1" style="font-variation-settings: 'FILL' 0;">point_of_sale</span>
<span class="font-label-sm text-label-sm">Register</span>
</button>
<!-- Active: Orders -->
<button class="flex flex-col items-center justify-center bg-primary-container text-on-primary-container rounded-full px-4 py-1 active:opacity-80 transition-opacity min-w-[44px] min-h-[44px]">
<span class="material-symbols-outlined mb-1" style="font-variation-settings: 'FILL' 1;">receipt_long</span>
<span class="font-label-sm text-label-sm">Orders</span>
</button>
<!-- Inactive: Admin -->
<button class="flex flex-col items-center justify-center text-on-surface-variant dark:text-outline-variant px-4 py-1 hover:text-primary dark:hover:text-primary-fixed-dim active:opacity-80 transition-opacity min-w-[44px] min-h-[44px]">
<span class="material-symbols-outlined mb-1" style="font-variation-settings: 'FILL' 0;">dashboard</span>
<span class="font-label-sm text-label-sm">Admin</span>
</button>
<!-- Inactive: Items -->
<button class="flex flex-col items-center justify-center text-on-surface-variant dark:text-outline-variant px-4 py-1 hover:text-primary dark:hover:text-primary-fixed-dim active:opacity-80 transition-opacity min-w-[44px] min-h-[44px]">
<span class="material-symbols-outlined mb-1" style="font-variation-settings: 'FILL' 0;">inventory_2</span>
<span class="font-label-sm text-label-sm">Items</span>
</button>
</div>
</nav>
</body></html>

<!-- Pesanan Online -->
<!DOCTYPE html>

<html lang="id"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Manajemen Produk - QuickServe POS</title>
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com" rel="preconnect"/>
<link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
<!-- Material Symbols -->
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<!-- Tailwind CSS -->
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<!-- Tailwind Config -->
<script id="tailwind-config">
      tailwind.config = {
        darkMode: "class",
        theme: {
          extend: {
            "colors": {
                    "surface": "#f8f9ff",
                    "on-secondary": "#ffffff",
                    "on-surface": "#0b1c30",
                    "on-error-container": "#93000a",
                    "on-primary": "#ffffff",
                    "background": "#f8f9ff",
                    "surface-container": "#e5eeff",
                    "on-tertiary-container": "#ffb4ad",
                    "inverse-on-surface": "#eaf1ff",
                    "primary-fixed": "#a6f2d1",
                    "tertiary-fixed-dim": "#ffb3ac",
                    "on-tertiary-fixed-variant": "#73332f",
                    "on-surface-variant": "#3f4944",
                    "inverse-primary": "#8bd6b6",
                    "on-primary-fixed-variant": "#00513b",
                    "on-primary-fixed": "#002116",
                    "outline": "#6f7973",
                    "surface-bright": "#f8f9ff",
                    "error-container": "#ffdad6",
                    "surface-variant": "#d3e4fe",
                    "tertiary-fixed": "#ffdad6",
                    "surface-container-highest": "#d3e4fe",
                    "outline-variant": "#bec9c2",
                    "primary-container": "#065f46",
                    "secondary": "#565e74",
                    "on-primary-container": "#8bd6b7",
                    "tertiary": "#652925",
                    "on-tertiary": "#ffffff",
                    "on-background": "#0b1c30",
                    "inverse-surface": "#213145",
                    "surface-container-lowest": "#ffffff",
                    "primary": "#004532",
                    "secondary-fixed-dim": "#bec6e0",
                    "on-tertiary-fixed": "#3b0908",
                    "primary-fixed-dim": "#8bd6b6",
                    "surface-tint": "#1b6b51",
                    "surface-container-high": "#dce9ff",
                    "on-secondary-container": "#5c647a",
                    "tertiary-container": "#823f3a",
                    "on-error": "#ffffff",
                    "surface-dim": "#cbdbf5",
                    "surface-container-low": "#eff4ff",
                    "on-secondary-fixed": "#131b2e",
                    "on-secondary-fixed-variant": "#3f465c",
                    "secondary-fixed": "#dae2fd",
                    "secondary-container": "#dae2fd",
                    "error": "#ba1a1a"
            },
            "borderRadius": {
                    "DEFAULT": "0.25rem",
                    "lg": "0.5rem",
                    "xl": "0.75rem",
                    "full": "9999px"
            },
            "spacing": {
                    "lg": "24px",
                    "md": "16px",
                    "xl": "32px",
                    "xs": "4px",
                    "base": "8px",
                    "gutter-desktop": "24px",
                    "gutter-mobile": "16px",
                    "touch-target": "44px",
                    "sm": "12px"
            },
            "fontFamily": {
                    "headline-md": ["Inter"],
                    "title-lg": ["Inter"],
                    "display-lg": ["Inter"],
                    "body-lg": ["Inter"],
                    "headline-lg-mobile": ["Inter"],
                    "body-md": ["Inter"],
                    "label-sm": ["Inter"],
                    "headline-lg": ["Inter"],
                    "label-md": ["Inter"]
            },
            "fontSize": {
                    "headline-md": ["24px", {"lineHeight": "32px", "fontWeight": "600"}],
                    "title-lg": ["20px", {"lineHeight": "28px", "fontWeight": "600"}],
                    "display-lg": ["48px", {"lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "700"}],
                    "body-lg": ["18px", {"lineHeight": "28px", "fontWeight": "400"}],
                    "headline-lg-mobile": ["24px", {"lineHeight": "32px", "fontWeight": "600"}],
                    "body-md": ["16px", {"lineHeight": "24px", "fontWeight": "400"}],
                    "label-sm": ["12px", {"lineHeight": "16px", "fontWeight": "600"}],
                    "headline-lg": ["32px", {"lineHeight": "40px", "letterSpacing": "-0.01em", "fontWeight": "600"}],
                    "label-md": ["14px", {"lineHeight": "20px", "letterSpacing": "0.01em", "fontWeight": "500"}]
            }
          }
        }
      }
    </script>
<style>
        .pb-safe { padding-bottom: env(safe-area-inset-bottom, 20px); }
    </style>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
  </head>
<body class="bg-background text-on-background min-h-screen flex flex-col font-sans">
<!-- TopAppBar -->
<header class="w-full top-0 sticky border-b border-outline-variant bg-surface flex justify-between items-center px-gutter-mobile h-14 z-40">
<button aria-label="Menu" class="h-touch-target w-touch-target flex items-center justify-center text-primary hover:bg-surface-container transition-colors active:scale-95 duration-100 rounded-full">
<span class="material-symbols-outlined text-on-surface" data-icon="menu">menu</span>
</button>
<h1 class="font-headline-md text-headline-md font-bold text-primary truncate px-2">QuickServe POS</h1>
<button aria-label="Notifications" class="h-touch-target w-touch-target flex items-center justify-center text-primary hover:bg-surface-container transition-colors active:scale-95 duration-100 rounded-full">
<span class="material-symbols-outlined text-on-surface" data-icon="notifications">notifications</span>
</button>
</header>
<!-- Main Content Canvas -->
<main class="flex-1 px-gutter-mobile md:px-gutter-desktop py-lg pb-32">
<!-- Page Header & Actions -->
<div class="flex flex-col md:flex-row md:items-center justify-between gap-md mb-lg">
<div>
<h2 class="font-title-lg text-title-lg text-on-background">Manajemen Produk</h2>
<p class="font-body-md text-body-md text-on-surface-variant mt-1">Kelola inventaris dan detail menu.</p>
</div>
<div class="relative w-full md:w-72">
<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-outline-variant pointer-events-none" data-icon="search">search</span>
<input class="w-full pl-10 pr-4 py-2 bg-surface-container-lowest border border-outline-variant rounded-lg font-body-md text-body-md text-on-surface focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary transition-colors h-touch-target" placeholder="Cari produk..." type="text"/>
</div>
</div>
<!-- Product Grid (Bento/Card Layout) -->
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-md">
<!-- Product Card 1 (Good Stock) -->
<div class="bg-surface-container-lowest border border-outline-variant rounded-lg overflow-hidden flex flex-col group hover:shadow-md transition-shadow duration-200">
<div class="h-40 w-full bg-surface-variant relative">
<img alt="Pizza" class="w-full h-full object-cover" data-alt="A perfectly styled classic pepperoni pizza on a wooden serving board in a modern, brightly lit restaurant setting. The crust is golden and slightly charred, with glossy melted cheese and vibrant red pepperoni slices. The lighting is crisp, overhead, high-key photography common in modern minimalist POS systems, emphasizing the rich, appetizing colors against a clean, out-of-focus background." src="https://lh3.googleusercontent.com/aida-public/AB6AXuBZ-1Zt-w080JjnsKZx-eZJ79zVrE1d3UoPdPFfD0rmQjdSmhbLk5hDbO5R2nMdBU29MS4TF5zyx1mNiL5WYSEZZl3ziOuVSV0UDLaGIAn45mVJYVPPOwdO0iwOhOwTeoUTfi2fLk6G7-zoyDDQIbdaT9FtEQpxxnISlvs0KKdtsWtofdMhpwtKdLIw6ivvoeojX1IXylLZj1OIZbMIcMjgTTssBZ0QMTdZ0-ItsegwDA2EA7fRFtpOa6Mg6rzBzQ83syIVFayMxc4"/>
<div class="absolute top-2 right-2 bg-surface-container-lowest/90 backdrop-blur-sm px-2 py-1 rounded-md border border-outline-variant">
<span class="font-label-sm text-label-sm text-primary flex items-center gap-1">
<span class="material-symbols-outlined text-[14px]" data-icon="check_circle" data-weight="fill" style="font-variation-settings: 'FILL' 1;">check_circle</span>
                            Stok: 45
                        </span>
</div>
</div>
<div class="p-md flex-1 flex flex-col justify-between">
<div>
<h3 class="font-title-lg text-title-lg text-on-surface mb-1">Pepperoni Pizza</h3>
<p class="font-body-md text-body-md text-on-surface-variant line-clamp-2">Classic pizza with authentic Italian pepperoni and mozzarella.</p>
</div>
<div class="mt-md flex items-end justify-between">
<span class="font-headline-md text-headline-md text-primary font-bold">Rp 85.000</span>
</div>
</div>
<div class="border-t border-outline-variant bg-surface-bright px-md py-sm flex justify-end gap-2">
<button aria-label="Edit Produk" class="h-10 px-4 rounded border border-outline text-on-surface-variant hover:bg-surface-container transition-colors flex items-center justify-center gap-2">
<span class="material-symbols-outlined" data-icon="edit">edit</span>
</button>
<button aria-label="Hapus Produk" class="h-10 px-4 rounded bg-error-container text-on-error-container hover:opacity-90 transition-opacity flex items-center justify-center gap-2">
<span class="material-symbols-outlined" data-icon="delete">delete</span>
</button>
</div>
</div>
<!-- Product Card 2 (Low Stock Warning) -->
<div class="bg-surface-container-lowest border border-outline-variant rounded-lg overflow-hidden flex flex-col group hover:shadow-md transition-shadow duration-200">
<div class="h-40 w-full bg-surface-variant relative">
<img alt="Burger" class="w-full h-full object-cover" data-alt="A close up shot of a gourmet beef burger with melted cheddar cheese, fresh lettuce, and a glossy brioche bun, resting on a clean white ceramic plate. The lighting is bright and modern, creating a professional, clean aesthetic suitable for a high-end food service application. Soft natural light highlights the textures of the ingredients." src="https://lh3.googleusercontent.com/aida-public/AB6AXuDieK03ILFb9_st3OiTiw4ijgm7d24gPAOZBgrpA-5xGPoTKwHCZkmvgNxrytHoDrgGEUiBjioprs6-8fSdRW8K8b2LIbEtVmsuwhNZHGeWD96WjQbAPMN7QHpMCjpWfQ4_k-Au_0huJSOPc9uYAHQt3_lpyukFjaIr2pgq6ufBAazXOvYWr6M63XEuL2MTsexFE9ityLoBI0LlFPvzA3k8jOiM3MnrcmFnCdafUWq_X_2Vvh28Y7RjwxznDjYU4CwH4VpD7stqvIU"/>
<div class="absolute top-2 right-2 bg-error-container/90 backdrop-blur-sm px-2 py-1 rounded-md border border-error/20">
<span class="font-label-sm text-label-sm text-on-error-container flex items-center gap-1">
<span class="material-symbols-outlined text-[14px]" data-icon="warning" data-weight="fill" style="font-variation-settings: 'FILL' 1;">warning</span>
                            Sisa 3
                        </span>
</div>
</div>
<div class="p-md flex-1 flex flex-col justify-between">
<div>
<h3 class="font-title-lg text-title-lg text-on-surface mb-1">Classic Cheeseburger</h3>
<p class="font-body-md text-body-md text-on-surface-variant line-clamp-2">100% beef patty with secret sauce, lettuce, and cheddar.</p>
</div>
<div class="mt-md flex items-end justify-between">
<span class="font-headline-md text-headline-md text-primary font-bold">Rp 60.000</span>
</div>
</div>
<div class="border-t border-outline-variant bg-surface-bright px-md py-sm flex justify-end gap-2">
<button aria-label="Edit Produk" class="h-10 px-4 rounded border border-outline text-on-surface-variant hover:bg-surface-container transition-colors flex items-center justify-center gap-2">
<span class="material-symbols-outlined" data-icon="edit">edit</span>
</button>
<button aria-label="Hapus Produk" class="h-10 px-4 rounded bg-error-container text-on-error-container hover:opacity-90 transition-opacity flex items-center justify-center gap-2">
<span class="material-symbols-outlined" data-icon="delete">delete</span>
</button>
</div>
</div>
<!-- Product Card 3 (Out of Stock) -->
<div class="bg-surface-container-lowest border border-outline-variant rounded-lg overflow-hidden flex flex-col group hover:shadow-md transition-shadow duration-200 opacity-75">
<div class="h-40 w-full bg-surface-variant relative">
<div class="absolute inset-0 bg-surface/50 backdrop-blur-[2px] z-10 flex items-center justify-center">
<span class="bg-surface px-3 py-1 rounded font-label-md text-label-md text-on-surface-variant shadow-sm border border-outline-variant uppercase tracking-wider">Habis</span>
</div>
<img alt="Iced Latte" class="w-full h-full object-cover grayscale-[30%]" data-alt="A refreshing glass of iced latte with visible layers of milk and dark espresso, sitting on a pale marble countertop. Condensation beads on the outside of the glass. The environment is a clean, minimalist cafe setting with soft, diffused daytime lighting, aligning with a pristine, modern corporate aesthetic. The colors are cool and inviting." src="https://lh3.googleusercontent.com/aida-public/AB6AXuD47rnq9aPtD-J1oXP-5V-pxjRTUq6xhIGI6ErXFN1ex0SNB_MDCmL4q9BISt0sLtuX-DVAMSvd62g_11tPJ3n3qQ3SOLbWBv8ttdMrgkw_zHzIoqbR9TIzqGbVZsdPkNdJ3WgwqJv32h9orj34Ajta9iuwLvCapLhxJgL7BKREI8Vq5849DLzrOpeKsLwIyt8QRIxlLq2Qfss6ozavjHZBMu_ZNPZd7ADeythgUkjS5K8wQCaOxh26HD4N_JhhxuhvEj7Llf9Rbzk"/>
</div>
<div class="p-md flex-1 flex flex-col justify-between">
<div>
<h3 class="font-title-lg text-title-lg text-on-surface mb-1">Iced Caramel Latte</h3>
<p class="font-body-md text-body-md text-on-surface-variant line-clamp-2">Signature espresso with cold milk and caramel syrup.</p>
</div>
<div class="mt-md flex items-end justify-between">
<span class="font-headline-md text-headline-md text-on-surface-variant font-bold">Rp 45.000</span>
</div>
</div>
<div class="border-t border-outline-variant bg-surface-bright px-md py-sm flex justify-end gap-2">
<button aria-label="Edit Produk" class="h-10 px-4 rounded border border-outline text-on-surface-variant hover:bg-surface-container transition-colors flex items-center justify-center gap-2">
<span class="material-symbols-outlined" data-icon="edit">edit</span>
</button>
<button aria-label="Hapus Produk" class="h-10 px-4 rounded bg-error-container text-on-error-container hover:opacity-90 transition-opacity flex items-center justify-center gap-2">
<span class="material-symbols-outlined" data-icon="delete">delete</span>
</button>
</div>
</div>
<!-- Product Card 4 (Standard) -->
<div class="bg-surface-container-lowest border border-outline-variant rounded-lg overflow-hidden flex flex-col group hover:shadow-md transition-shadow duration-200">
<div class="h-40 w-full bg-surface-variant relative">
<img alt="Nasi Goreng" class="w-full h-full object-cover" data-alt="A plate of traditional Indonesian Nasi Goreng (fried rice) topped with a perfectly fried sunny-side-up egg and accompanied by fresh cucumber slices and prawn crackers. Presented on a simple, elegant dark plate against a neutral, light-colored background. The high-key lighting creates a sharp, professional look suitable for a modern POS interface." src="https://lh3.googleusercontent.com/aida-public/AB6AXuCvei0HR5TS6NMKT6N11ixmHBi6wYvJ8pl68mep7fGUcqtcu-1BeR5P3kwNGvbv2xwWXKTbEkZ_Jqb-ka9cSy2WGqr7EKpI23LWXLlDK_ka9CAs6mGdUdLdVYaFqAle6OtGUhNn2zwvR5fh6b9qD8dse550s1a59IbQC-bUmRbbXZsMi8mwBwJXQi0hrb_C7DgvYak2GXjw_l9N1AjCdkP_BhruB4NcdZ2yy8hH43xo5Msbe9w5NRsnnoZwuxt934Rx3GBamPnHAVw"/>
<div class="absolute top-2 right-2 bg-surface-container-lowest/90 backdrop-blur-sm px-2 py-1 rounded-md border border-outline-variant">
<span class="font-label-sm text-label-sm text-primary flex items-center gap-1">
<span class="material-symbols-outlined text-[14px]" data-icon="check_circle" data-weight="fill" style="font-variation-settings: 'FILL' 1;">check_circle</span>
                            Stok: 120
                        </span>
</div>
</div>
<div class="p-md flex-1 flex flex-col justify-between">
<div>
<h3 class="font-title-lg text-title-lg text-on-surface mb-1">Nasi Goreng Spesial</h3>
<p class="font-body-md text-body-md text-on-surface-variant line-clamp-2">Nasi goreng bumbu rempah dengan telur mata sapi dan kerupuk.</p>
</div>
<div class="mt-md flex items-end justify-between">
<span class="font-headline-md text-headline-md text-primary font-bold">Rp 35.000</span>
</div>
</div>
<div class="border-t border-outline-variant bg-surface-bright px-md py-sm flex justify-end gap-2">
<button aria-label="Edit Produk" class="h-10 px-4 rounded border border-outline text-on-surface-variant hover:bg-surface-container transition-colors flex items-center justify-center gap-2">
<span class="material-symbols-outlined" data-icon="edit">edit</span>
</button>
<button aria-label="Hapus Produk" class="h-10 px-4 rounded bg-error-container text-on-error-container hover:opacity-90 transition-opacity flex items-center justify-center gap-2">
<span class="material-symbols-outlined" data-icon="delete">delete</span>
</button>
</div>
</div>
</div>
</main>
<!-- Floating Action Button (FAB) -->
<button aria-label="Tambah Produk Baru" class="fixed bottom-[100px] right-gutter-mobile md:right-gutter-desktop w-14 h-14 rounded-full bg-primary text-on-primary shadow-[0px_10px_15px_-3px_rgba(0,0,0,0.1)] flex items-center justify-center z-40 hover:bg-surface-tint active:scale-95 transition-all duration-200">
<span class="material-symbols-outlined text-[28px]" data-icon="add">add</span>
</button>
<!-- BottomNavBar -->
<nav class="fixed bottom-0 w-full z-50 border-t border-outline-variant bg-surface-container-lowest shadow-sm flex justify-around items-center h-20 pb-safe md:hidden">
<!-- Tab 1 -->
<a class="flex flex-col items-center justify-center text-on-surface-variant px-4 py-1 hover:text-primary active:opacity-80 transition-opacity w-full h-full" href="#">
<span class="material-symbols-outlined mb-1" data-icon="point_of_sale">point_of_sale</span>
<span class="font-label-sm text-label-sm">Register</span>
</a>
<!-- Tab 2 -->
<a class="flex flex-col items-center justify-center text-on-surface-variant px-4 py-1 hover:text-primary active:opacity-80 transition-opacity w-full h-full" href="#">
<span class="material-symbols-outlined mb-1" data-icon="receipt_long">receipt_long</span>
<span class="font-label-sm text-label-sm">Orders</span>
</a>
<!-- Tab 3 -->
<a class="flex flex-col items-center justify-center text-on-surface-variant px-4 py-1 hover:text-primary active:opacity-80 transition-opacity w-full h-full" href="#">
<span class="material-symbols-outlined mb-1" data-icon="dashboard">dashboard</span>
<span class="font-label-sm text-label-sm">Admin</span>
</a>
<!-- Tab 4 (Active) -->
<a class="flex flex-col items-center justify-center bg-primary-container text-on-primary-container rounded-full px-4 py-1 mx-2 active:opacity-80 transition-opacity h-[56px] min-w-[64px]" href="#">
<span class="material-symbols-outlined mb-1" data-icon="inventory_2" data-weight="fill" style="font-variation-settings: 'FILL' 1;">inventory_2</span>
<span class="font-label-sm text-label-sm font-bold">Items</span>
</a>
</nav>
</body></html>

<!-- Manajemen Produk -->
<!DOCTYPE html>

<html class="light" lang="id"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover" name="viewport"/>
<title>QuickServe POS - Kasir</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "surface": "#f8f9ff",
                        "on-secondary": "#ffffff",
                        "on-surface": "#0b1c30",
                        "on-error-container": "#93000a",
                        "on-primary": "#ffffff",
                        "background": "#f8f9ff",
                        "surface-container": "#e5eeff",
                        "on-tertiary-container": "#ffb4ad",
                        "inverse-on-surface": "#eaf1ff",
                        "primary-fixed": "#a6f2d1",
                        "tertiary-fixed-dim": "#ffb3ac",
                        "on-tertiary-fixed-variant": "#73332f",
                        "on-surface-variant": "#3f4944",
                        "inverse-primary": "#8bd6b6",
                        "on-primary-fixed-variant": "#00513b",
                        "on-primary-fixed": "#002116",
                        "outline": "#6f7973",
                        "surface-bright": "#f8f9ff",
                        "error-container": "#ffdad6",
                        "surface-variant": "#d3e4fe",
                        "tertiary-fixed": "#ffdad6",
                        "surface-container-highest": "#d3e4fe",
                        "outline-variant": "#bec9c2",
                        "primary-container": "#065f46",
                        "secondary": "#565e74",
                        "on-primary-container": "#8bd6b7",
                        "tertiary": "#652925",
                        "on-tertiary": "#ffffff",
                        "on-background": "#0b1c30",
                        "inverse-surface": "#213145",
                        "surface-container-lowest": "#ffffff",
                        "primary": "#004532",
                        "secondary-fixed-dim": "#bec6e0",
                        "on-tertiary-fixed": "#3b0908",
                        "primary-fixed-dim": "#8bd6b6",
                        "surface-tint": "#1b6b51",
                        "surface-container-high": "#dce9ff",
                        "on-secondary-container": "#5c647a",
                        "tertiary-container": "#823f3a",
                        "on-error": "#ffffff",
                        "surface-dim": "#cbdbf5",
                        "surface-container-low": "#eff4ff",
                        "on-secondary-fixed": "#131b2e",
                        "on-secondary-fixed-variant": "#3f465c",
                        "secondary-fixed": "#dae2fd",
                        "secondary-container": "#dae2fd",
                        "error": "#ba1a1a"
                    },
                    "borderRadius": {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                    "spacing": {
                        "lg": "24px",
                        "md": "16px",
                        "xl": "32px",
                        "xs": "4px",
                        "base": "8px",
                        "gutter-desktop": "24px",
                        "gutter-mobile": "16px",
                        "touch-target": "44px",
                        "sm": "12px"
                    },
                    "fontFamily": {
                        "headline-md": ["Inter"],
                        "title-lg": ["Inter"],
                        "display-lg": ["Inter"],
                        "body-lg": ["Inter"],
                        "headline-lg-mobile": ["Inter"],
                        "body-md": ["Inter"],
                        "label-sm": ["Inter"],
                        "headline-lg": ["Inter"],
                        "label-md": ["Inter"]
                    },
                    "fontSize": {
                        "headline-md": ["24px", { "lineHeight": "32px", "fontWeight": "600" }],
                        "title-lg": ["20px", { "lineHeight": "28px", "fontWeight": "600" }],
                        "display-lg": ["48px", { "lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "700" }],
                        "body-lg": ["18px", { "lineHeight": "28px", "fontWeight": "400" }],
                        "headline-lg-mobile": ["24px", { "lineHeight": "32px", "fontWeight": "600" }],
                        "body-md": ["16px", { "lineHeight": "24px", "fontWeight": "400" }],
                        "label-sm": ["12px", { "lineHeight": "16px", "fontWeight": "600" }],
                        "headline-lg": ["32px", { "lineHeight": "40px", "letterSpacing": "-0.01em", "fontWeight": "600" }],
                        "label-md": ["14px", { "lineHeight": "20px", "letterSpacing": "0.01em", "fontWeight": "500" }]
                    }
                }
            }
        }
    </script>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .material-symbols-outlined.fill {
            font-variation-settings: 'FILL' 1;
        }
        
        /* Hide scrollbar for clean UI */
        .no-scrollbar::-webkit-scrollbar {
            display: none;
        }
        .no-scrollbar {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }
        
        /* Safe area padding for bottom nav */
        .pb-safe {
            padding-bottom: env(safe-area-inset-bottom, 20px);
        }
    </style>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
  </head>
<body class="bg-background text-on-background antialiased min-h-screen flex flex-col md:hidden">
<!-- TopAppBar from JSON -->
<header class="bg-surface text-primary font-headline-md text-headline-md-mobile w-full top-0 sticky border-b border-outline-variant flex justify-between items-center px-gutter-mobile h-14 w-full z-50">
<button class="flex items-center justify-center w-touch-target h-touch-target active:scale-95 transition-transform duration-100 hover:bg-surface-container transition-colors rounded-full text-on-surface-variant">
<span class="material-symbols-outlined" data-icon="menu">menu</span>
</button>
<div class="font-headline-md text-headline-md-mobile font-bold text-primary">
            QuickServe POS
        </div>
<button class="flex items-center justify-center w-touch-target h-touch-target active:scale-95 transition-transform duration-100 hover:bg-surface-container transition-colors rounded-full text-on-surface-variant">
<span class="material-symbols-outlined" data-icon="notifications">notifications</span>
</button>
</header>
<!-- Main Content Canvas -->
<main class="flex-1 overflow-y-auto no-scrollbar pb-[180px]">
<!-- Search & Filter Area -->
<div class="px-gutter-mobile py-md bg-surface sticky top-0 z-40 shadow-[0_4px_10px_-10px_rgba(0,0,0,0.1)]">
<div class="relative w-full">
<span class="material-symbols-outlined absolute left-sm top-1/2 transform -translate-y-1/2 text-outline">search</span>
<input class="w-full bg-surface-container-highest border border-outline-variant text-on-surface font-body-md text-body-md rounded-lg pl-[40px] pr-sm py-sm focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary transition-colors min-h-[44px]" placeholder="Cari produk..." type="text"/>
</div>
<!-- Category Chips -->
<div class="flex overflow-x-auto no-scrollbar gap-base mt-md pb-xs">
<button class="whitespace-nowrap px-md py-base rounded-full bg-primary text-on-primary font-label-md text-label-md border border-primary min-h-[44px] active:scale-95 transition-transform">
                    Semua
                </button>
<button class="whitespace-nowrap px-md py-base rounded-full bg-surface-container-lowest text-on-surface-variant font-label-md text-label-md border border-outline-variant min-h-[44px] active:scale-95 transition-transform">
                    Makanan
                </button>
<button class="whitespace-nowrap px-md py-base rounded-full bg-surface-container-lowest text-on-surface-variant font-label-md text-label-md border border-outline-variant min-h-[44px] active:scale-95 transition-transform">
                    Minuman
                </button>
<button class="whitespace-nowrap px-md py-base rounded-full bg-surface-container-lowest text-on-surface-variant font-label-md text-label-md border border-outline-variant min-h-[44px] active:scale-95 transition-transform">
                    Cemilan
                </button>
</div>
</div>
<!-- Product Grid -->
<div class="p-gutter-mobile grid grid-cols-2 gap-md">
<!-- Product Card 1 -->
<div class="bg-surface-container-lowest rounded-lg border border-outline-variant overflow-hidden flex flex-col relative active:scale-[0.98] transition-transform" onclick="toggleSelection(this)">
<div class="h-24 bg-surface-variant relative">
<img alt="Burger" class="w-full h-full object-cover" data-alt="A perfectly constructed, appetizing classic beef burger presented in a well-lit, modern quick-service restaurant environment. The light-mode aesthetic features clean whites and soft grey tones in the background, allowing the rich colors of the fresh lettuce, bright red tomato, and perfectly grilled meat to stand out vividly. The overall atmosphere is energetic, clean, and professional, characteristic of a high-end fast-casual retail POS display." src="https://lh3.googleusercontent.com/aida-public/AB6AXuDOvR4_RcWi_yOUM9nhfW0bDH28VOy7vP3uRm_1v73LH2vWs5eAIcWzLMuSwYExhYySwuCbnc0WU0GDCUzQEw8tBeKAgQzNNcmwFGfUeQKymuw-j79vfqBy8MTbyvdW5BmnjfCy39gsU4wJhqnROlWvUhIZ3tva8Jwc5EPvjXuxwSYBL9W-JK4ZkQQWbhLDG0aMjp-DM4nM5sbvOk_wUvpA_q7jpKBcyzy-msY6jtalm_r3D7Y_zNLxT7Ybi9V7rpgJE_dglLGGmzQ"/>
</div>
<div class="p-sm flex flex-col flex-1">
<h3 class="font-title-lg text-title-lg text-on-surface line-clamp-1 mb-xs">Classic Burger</h3>
<p class="font-body-md text-body-md text-on-surface-variant line-clamp-1">Daging sapi, keju</p>
<div class="mt-auto pt-sm flex justify-between items-center">
<span class="font-headline-md text-headline-md-mobile text-primary">Rp 45k</span>
<button class="w-8 h-8 rounded-full bg-primary-container text-on-primary-container flex items-center justify-center">
<span class="material-symbols-outlined text-[18px]" data-icon="add">add</span>
</button>
</div>
</div>
</div>
<!-- Product Card 2 -->
<div class="bg-surface-container-lowest rounded-lg border-2 border-primary overflow-hidden flex flex-col relative active:scale-[0.98] transition-transform">
<div class="absolute top-xs right-xs bg-primary text-on-primary w-6 h-6 rounded-full flex items-center justify-center font-label-sm text-label-sm z-10">2</div>
<div class="h-24 bg-surface-variant relative">
<img alt="Fries" class="w-full h-full object-cover" data-alt="A generous portion of golden, crispy French fries served in a simple, elegant container, captured in a brightly lit, modern corporate retail setting. The light-mode visual style emphasizes clarity and freshness, with a subtle depth provided by soft ambient shadows. The background is a clean, neutral surface that directs focus entirely to the appetizing texture and color of the fries, ideal for a fast-paced point-of-sale interface." src="https://lh3.googleusercontent.com/aida-public/AB6AXuAY3uGnpON8cSjN__B7Spz-U88c3uy_8pf3qtNvnT4-QeE4ff3NUTSu7P9BTMURuHIemJVh6behNUUPUN_B9qKG9gbyGvAqDVQTNFuhiTq4sLDJD_5z96aSemqTGQKlmKyUiwLu8Uonw3hN_96PwQ19yFHJVjbme3iMOOPa6MSmuV46smEbh4t5KxkUBhmYRtXDRBW0GZKwV74XPcB8Eoqv5xVRUAU3ifjWg62TH5ENDnxdbeFJgw1i9WJrueQdpqEOjjiwSre3v18"/>
</div>
<div class="p-sm flex flex-col flex-1">
<h3 class="font-title-lg text-title-lg text-on-surface line-clamp-1 mb-xs">Kentang Goreng</h3>
<p class="font-body-md text-body-md text-on-surface-variant line-clamp-1">Renyah &amp; gurih</p>
<div class="mt-auto pt-sm flex justify-between items-center">
<span class="font-headline-md text-headline-md-mobile text-primary">Rp 25k</span>
<div class="flex items-center gap-xs">
<button class="w-8 h-8 rounded-full bg-surface-variant text-on-surface flex items-center justify-center">
<span class="material-symbols-outlined text-[18px]" data-icon="remove">remove</span>
</button>
<span class="font-label-md text-label-md px-1">2</span>
<button class="w-8 h-8 rounded-full bg-primary-container text-on-primary-container flex items-center justify-center">
<span class="material-symbols-outlined text-[18px]" data-icon="add">add</span>
</button>
</div>
</div>
</div>
</div>
<!-- Product Card 3 -->
<div class="bg-surface-container-lowest rounded-lg border border-outline-variant overflow-hidden flex flex-col relative active:scale-[0.98] transition-transform">
<div class="h-24 bg-surface-variant relative">
<img alt="Cola" class="w-full h-full object-cover" data-alt="A refreshing, ice-cold glass of dark cola with condensation beading on the exterior, photographed against a minimalist, bright, and airy background. The lighting is crisp and even, reflecting a clean, corporate modern light-mode design language. The sharp contrast between the dark beverage and the pristine setting creates a highly appealing, professional look tailored for quick-service digital menus." src="https://lh3.googleusercontent.com/aida-public/AB6AXuA5J1DtyzfIUN43P56DeQxgXoFK67W3Tg9QfaH9JT60ThdtjNi7rCpvoEPTdsLwNLXOkEZQkF8o83qwS1FrXM3oWcTWEdnPOb0YQ5XWZetfoeOQg8Tyu1xPaPeUdHnOyFdPz9oJ1VBvbm39a9-L4ph1rlIoyjxFZRuqi5bXzXv-vyRqyzc6xdqz0dR2YFk-OnSrhoOVkCZLfwfR6dRx1SiAQHi7fc9wiu0-rJGgV9RViuhshRPAZFqvOL2l8vILl4gucOhZbEdV7EU"/>
</div>
<div class="p-sm flex flex-col flex-1">
<h3 class="font-title-lg text-title-lg text-on-surface line-clamp-1 mb-xs">Es Cola</h3>
<p class="font-body-md text-body-md text-on-surface-variant line-clamp-1">Dingin, Reguler</p>
<div class="mt-auto pt-sm flex justify-between items-center">
<span class="font-headline-md text-headline-md-mobile text-primary">Rp 15k</span>
<button class="w-8 h-8 rounded-full bg-primary-container text-on-primary-container flex items-center justify-center">
<span class="material-symbols-outlined text-[18px]" data-icon="add">add</span>
</button>
</div>
</div>
</div>
<!-- Product Card 4 -->
<div class="bg-surface-container-lowest rounded-lg border border-outline-variant overflow-hidden flex flex-col relative active:scale-[0.98] transition-transform">
<div class="h-24 bg-surface-variant relative">
<img alt="Iced Tea" class="w-full h-full object-cover" data-alt="A tall glass of clear, amber iced tea garnished with a fresh lemon slice, sitting in a stark, clean, light-mode environment. The lighting is diffused and bright, creating a serene, highly legible aesthetic characteristic of modern POS systems. The lack of visual clutter in the background emphasizes the crispness and refreshing quality of the drink, perfectly aligned with an efficient retail brand identity." src="https://lh3.googleusercontent.com/aida-public/AB6AXuCOlig_SCzuu2ZmmuEs53m2WeOd6g5kWYK-OaXJG--rNNrpO1XyaOrgoCQ1DyrNlXz-IjR6EK5hVuYdJ3QmOQNJCrfpfPuVzzkrWthzQ8CGJB3MpNkfVDJGEDZmegyb92tC_JZJgfl1flewU-ruyzGFw0AdvZ9i51EOcDeipix76JPjYKwec8l608YJqusb74zwXt3qq3zv_04GNFjV_Hl2OT-9PyajCWzUJ-T3hF_5i0yXzyRoQXZPjSxmnFhhovKL3sgrJ-kqfAU"/>
</div>
<div class="p-sm flex flex-col flex-1">
<h3 class="font-title-lg text-title-lg text-on-surface line-clamp-1 mb-xs">Es Teh Manis</h3>
<p class="font-body-md text-body-md text-on-surface-variant line-clamp-1">Teh melati</p>
<div class="mt-auto pt-sm flex justify-between items-center">
<span class="font-headline-md text-headline-md-mobile text-primary">Rp 10k</span>
<button class="w-8 h-8 rounded-full bg-primary-container text-on-primary-container flex items-center justify-center">
<span class="material-symbols-outlined text-[18px]" data-icon="add">add</span>
</button>
</div>
</div>
</div>
</div>
</main>
<!-- Shopping Cart Summary Panel (Sticky above Bottom Nav) -->
<div class="fixed bottom-[80px] w-full bg-surface-container-lowest z-40 rounded-t-xl shadow-[0_-10px_15px_-3px_rgba(0,0,0,0.1)] border-t border-outline-variant px-gutter-mobile py-md">
<div class="flex justify-between items-center mb-sm">
<div class="flex items-center gap-base">
<span class="material-symbols-outlined text-on-surface-variant" data-icon="shopping_basket">shopping_basket</span>
<span class="font-title-lg text-title-lg text-on-surface">2 Item</span>
</div>
<span class="font-headline-md text-headline-md-mobile text-on-surface font-bold">Rp 50.000</span>
</div>
<button class="w-full bg-primary text-on-primary font-title-lg text-title-lg rounded-lg py-sm min-h-[44px] flex justify-center items-center active:scale-[0.98] transition-transform">
            Bayar Sekarang
        </button>
</div>
<!-- BottomNavBar from JSON -->
<nav class="bg-surface-container-lowest text-primary font-label-sm text-label-sm fixed bottom-0 w-full z-50 shadow-sm flex justify-around items-center h-20 w-full pb-safe">
<div class="flex flex-col items-center justify-center bg-primary-container text-on-primary-container rounded-full px-4 py-1">
<span class="material-symbols-outlined fill" data-icon="point_of_sale" data-weight="fill">point_of_sale</span>
<span>Register</span>
</div>
<div class="flex flex-col items-center justify-center text-on-surface-variant px-4 py-1 hover:text-primary active:opacity-80 transition-opacity">
<span class="material-symbols-outlined" data-icon="receipt_long">receipt_long</span>
<span>Orders</span>
</div>
<div class="flex flex-col items-center justify-center text-on-surface-variant px-4 py-1 hover:text-primary active:opacity-80 transition-opacity">
<span class="material-symbols-outlined" data-icon="dashboard">dashboard</span>
<span>Admin</span>
</div>
<div class="flex flex-col items-center justify-center text-on-surface-variant px-4 py-1 hover:text-primary active:opacity-80 transition-opacity">
<span class="material-symbols-outlined" data-icon="inventory_2">inventory_2</span>
<span>Items</span>
</div>
</nav>
<script>
        function toggleSelection(element) {
            // Simple visual toggle for demonstration
            if(element.classList.contains('border-outline-variant')) {
                element.classList.remove('border-outline-variant');
                element.classList.add('border-primary', 'border-2');
                
                // Add a mock quantity badge
                const badge = document.createElement('div');
                badge.className = 'absolute top-xs right-xs bg-primary text-on-primary w-6 h-6 rounded-full flex items-center justify-center font-label-sm text-label-sm z-10 badge-mark';
                badge.textContent = '1';
                element.appendChild(badge);
            } else {
                element.classList.add('border-outline-variant');
                element.classList.remove('border-primary', 'border-2');
                const badge = element.querySelector('.badge-mark');
                if(badge) badge.remove();
            }
        }
    </script>
</body></html>

<!-- POS Kasir -->
<!DOCTYPE html>

<html lang="id"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Manajemen Staf - QuickServe POS</title>
<!-- Material Symbols -->
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .material-symbols-outlined.fill {
            font-variation-settings: 'FILL' 1;
        }
    </style>
<!-- Tailwind CSS -->
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "surface-container-low": "#eff4ff",
                        "surface-dim": "#cbdbf5",
                        "tertiary-container": "#823f3a",
                        "on-secondary-container": "#5c647a",
                        "on-error": "#ffffff",
                        "surface-container-high": "#dce9ff",
                        "secondary-container": "#dae2fd",
                        "error": "#ba1a1a",
                        "secondary-fixed": "#dae2fd",
                        "on-secondary-fixed-variant": "#3f465c",
                        "on-secondary-fixed": "#131b2e",
                        "on-background": "#0b1c30",
                        "inverse-surface": "#213145",
                        "on-tertiary": "#ffffff",
                        "tertiary": "#652925",
                        "surface-tint": "#1b6b51",
                        "primary-fixed-dim": "#8bd6b6",
                        "secondary-fixed-dim": "#bec6e0",
                        "primary": "#004532",
                        "on-tertiary-fixed": "#3b0908",
                        "surface-container-lowest": "#ffffff",
                        "surface-container-highest": "#d3e4fe",
                        "error-container": "#ffdad6",
                        "surface-bright": "#f8f9ff",
                        "tertiary-fixed": "#ffdad6",
                        "surface-variant": "#d3e4fe",
                        "secondary": "#565e74",
                        "on-primary-container": "#8bd6b7",
                        "primary-container": "#065f46",
                        "outline-variant": "#bec9c2",
                        "on-primary": "#ffffff",
                        "on-error-container": "#93000a",
                        "on-surface": "#0b1c30",
                        "surface": "#f8f9ff",
                        "on-secondary": "#ffffff",
                        "on-primary-fixed-variant": "#00513b",
                        "on-primary-fixed": "#002116",
                        "tertiary-fixed-dim": "#ffb3ac",
                        "primary-fixed": "#a6f2d1",
                        "on-tertiary-fixed-variant": "#73332f",
                        "on-surface-variant": "#3f4944",
                        "inverse-primary": "#8bd6b6",
                        "outline": "#6f7973",
                        "surface-container": "#e5eeff",
                        "on-tertiary-container": "#ffb4ad",
                        "inverse-on-surface": "#eaf1ff",
                        "background": "#f8f9ff"
                    },
                    "borderRadius": {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                    "spacing": {
                        "gutter-desktop": "24px",
                        "touch-target": "44px",
                        "sm": "12px",
                        "gutter-mobile": "16px",
                        "lg": "24px",
                        "md": "16px",
                        "xs": "4px",
                        "xl": "32px",
                        "base": "8px"
                    },
                    "fontFamily": {
                        "headline-md": ["Inter", "sans-serif"],
                        "body-lg": ["Inter", "sans-serif"],
                        "display-lg": ["Inter", "sans-serif"],
                        "title-lg": ["Inter", "sans-serif"],
                        "label-sm": ["Inter", "sans-serif"],
                        "headline-lg": ["Inter", "sans-serif"],
                        "headline-lg-mobile": ["Inter", "sans-serif"],
                        "body-md": ["Inter", "sans-serif"],
                        "label-md": ["Inter", "sans-serif"]
                    },
                    "fontSize": {
                        "headline-md": ["24px", {"lineHeight": "32px", "fontWeight": "600"}],
                        "body-lg": ["18px", {"lineHeight": "28px", "fontWeight": "400"}],
                        "display-lg": ["48px", {"lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "700"}],
                        "title-lg": ["20px", {"lineHeight": "28px", "fontWeight": "600"}],
                        "label-sm": ["12px", {"lineHeight": "16px", "fontWeight": "600"}],
                        "headline-lg": ["32px", {"lineHeight": "40px", "letterSpacing": "-0.01em", "fontWeight": "600"}],
                        "headline-lg-mobile": ["24px", {"lineHeight": "32px", "fontWeight": "600"}],
                        "body-md": ["16px", {"lineHeight": "24px", "fontWeight": "400"}],
                        "label-md": ["14px", {"lineHeight": "20px", "letterSpacing": "0.01em", "fontWeight": "500"}]
                    }
                }
            }
        }
    </script>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
  </head>
<body class="bg-background min-h-screen flex flex-col font-body-md text-on-background selection:bg-primary-fixed selection:text-on-primary-fixed">
<!-- TopAppBar -->
<header class="bg-surface dark:bg-surface-dim w-full top-0 sticky z-40 border-b border-outline-variant dark:border-outline flat no shadows flex justify-between items-center px-gutter-mobile h-14 w-full">
<div class="flex items-center gap-md">
<button aria-label="Menu" class="text-on-surface-variant hover:bg-surface-container rounded-full p-2 transition-colors active:scale-95 duration-100 flex items-center justify-center min-h-[44px] min-w-[44px]">
<span class="material-symbols-outlined" data-icon="menu">menu</span>
</button>
<h1 class="font-headline-md text-headline-md-mobile font-bold text-primary dark:text-primary-fixed-dim tracking-tight">QuickServe POS</h1>
</div>
<!-- Desktop Navigation Cluster (Hidden on mobile) -->
<nav class="hidden md:flex items-center gap-lg">
<a class="font-label-md text-label-md text-on-surface-variant hover:text-primary transition-colors py-2" href="#">Register</a>
<a class="font-label-md text-label-md text-on-surface-variant hover:text-primary transition-colors py-2" href="#">Orders</a>
<a class="font-label-md text-label-md text-primary font-bold border-b-2 border-primary py-2" href="#">Admin</a>
<a class="font-label-md text-label-md text-on-surface-variant hover:text-primary transition-colors py-2" href="#">Items</a>
</nav>
<button aria-label="Notifications" class="text-on-surface-variant hover:bg-surface-container rounded-full p-2 transition-colors active:scale-95 duration-100 flex items-center justify-center min-h-[44px] min-w-[44px]">
<span class="material-symbols-outlined" data-icon="notifications">notifications</span>
</button>
</header>
<!-- Main Content Canvas -->
<main class="flex-1 overflow-y-auto px-gutter-mobile md:px-gutter-desktop py-lg pb-[100px] md:pb-lg w-full max-w-[1440px] mx-auto">
<!-- Page Header -->
<div class="flex flex-col md:flex-row md:items-center justify-between gap-md mb-lg">
<div>
<h2 class="font-headline-lg text-headline-lg-mobile text-on-surface">Manajemen Staf</h2>
<p class="font-body-md text-body-md text-on-surface-variant mt-1">Kelola akses dan detail karyawan.</p>
</div>
<button class="bg-primary text-on-primary font-label-md text-label-md px-lg py-sm rounded-full flex items-center justify-center gap-2 hover:bg-on-primary-fixed-variant transition-colors min-h-[44px] shadow-sm">
<span class="material-symbols-outlined" data-icon="add">add</span>
                Tambah Staf
            </button>
</div>
<!-- Staff List Container (Grid for cards) -->
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-md">
<!-- Staff Card 1 (Aktif, Admin) -->
<div class="bg-surface-container-lowest border border-outline-variant rounded-xl p-md flex items-center justify-between hover:shadow-md transition-shadow duration-200 group">
<div class="flex items-center gap-md">
<!-- Avatar Initials -->
<div class="w-12 h-12 rounded-full bg-primary-container text-on-primary-container flex items-center justify-center font-title-lg text-title-lg shadow-inner">
                        BS
                    </div>
<div class="flex flex-col">
<span class="font-title-lg text-title-lg text-on-surface">Budi Santoso</span>
<div class="flex items-center gap-2 mt-1">
<span class="bg-surface-variant text-on-surface-variant font-label-sm text-label-sm px-2 py-0.5 rounded-sm uppercase tracking-wider">Admin</span>
<span class="bg-primary-fixed text-on-primary-fixed-variant font-label-sm text-label-sm px-2 py-0.5 rounded-sm flex items-center gap-1">
<span class="w-1.5 h-1.5 rounded-full bg-primary block"></span> Aktif
                            </span>
</div>
</div>
</div>
<div class="relative">
<button aria-label="Opsi lainnya" class="text-on-surface-variant hover:text-on-surface hover:bg-surface-container p-2 rounded-full transition-colors min-h-[44px] min-w-[44px] flex items-center justify-center">
<span class="material-symbols-outlined" data-icon="more_vert">more_vert</span>
</button>
</div>
</div>
<!-- Staff Card 2 (Aktif, Kasir) -->
<div class="bg-surface-container-lowest border border-outline-variant rounded-xl p-md flex items-center justify-between hover:shadow-md transition-shadow duration-200 group">
<div class="flex items-center gap-md">
<div class="w-12 h-12 rounded-full bg-secondary-container text-on-secondary-container flex items-center justify-center font-title-lg text-title-lg shadow-inner">
                        SA
                    </div>
<div class="flex flex-col">
<span class="font-title-lg text-title-lg text-on-surface">Siti Aminah</span>
<div class="flex items-center gap-2 mt-1">
<span class="bg-surface-variant text-on-surface-variant font-label-sm text-label-sm px-2 py-0.5 rounded-sm uppercase tracking-wider">Kasir</span>
<span class="bg-primary-fixed text-on-primary-fixed-variant font-label-sm text-label-sm px-2 py-0.5 rounded-sm flex items-center gap-1">
<span class="w-1.5 h-1.5 rounded-full bg-primary block"></span> Aktif
                            </span>
</div>
</div>
</div>
<div class="relative">
<button aria-label="Opsi lainnya" class="text-on-surface-variant hover:text-on-surface hover:bg-surface-container p-2 rounded-full transition-colors min-h-[44px] min-w-[44px] flex items-center justify-center">
<span class="material-symbols-outlined" data-icon="more_vert">more_vert</span>
</button>
</div>
</div>
<!-- Staff Card 3 (Non-aktif, Kasir) -->
<div class="bg-surface-container-lowest border border-outline-variant rounded-xl p-md flex items-center justify-between hover:shadow-md transition-shadow duration-200 group opacity-75">
<div class="flex items-center gap-md">
<div class="w-12 h-12 rounded-full bg-surface-variant text-on-surface-variant flex items-center justify-center font-title-lg text-title-lg shadow-inner">
                        AP
                    </div>
<div class="flex flex-col">
<span class="font-title-lg text-title-lg text-on-surface">Agus Pratama</span>
<div class="flex items-center gap-2 mt-1">
<span class="bg-surface-variant text-on-surface-variant font-label-sm text-label-sm px-2 py-0.5 rounded-sm uppercase tracking-wider">Kasir</span>
<span class="bg-error-container text-on-error-container font-label-sm text-label-sm px-2 py-0.5 rounded-sm flex items-center gap-1">
<span class="w-1.5 h-1.5 rounded-full bg-error block"></span> Non-aktif
                            </span>
</div>
</div>
</div>
<div class="relative">
<button aria-label="Opsi lainnya" class="text-on-surface-variant hover:text-on-surface hover:bg-surface-container p-2 rounded-full transition-colors min-h-[44px] min-w-[44px] flex items-center justify-center">
<span class="material-symbols-outlined" data-icon="more_vert">more_vert</span>
</button>
</div>
</div>
<!-- Staff Card 4 (Aktif, Kasir) -->
<div class="bg-surface-container-lowest border border-outline-variant rounded-xl p-md flex items-center justify-between hover:shadow-md transition-shadow duration-200 group">
<div class="flex items-center gap-md">
<div class="w-12 h-12 rounded-full bg-secondary-container text-on-secondary-container flex items-center justify-center font-title-lg text-title-lg shadow-inner">
                        RM
                    </div>
<div class="flex flex-col">
<span class="font-title-lg text-title-lg text-on-surface">Rina Melati</span>
<div class="flex items-center gap-2 mt-1">
<span class="bg-surface-variant text-on-surface-variant font-label-sm text-label-sm px-2 py-0.5 rounded-sm uppercase tracking-wider">Kasir</span>
<span class="bg-primary-fixed text-on-primary-fixed-variant font-label-sm text-label-sm px-2 py-0.5 rounded-sm flex items-center gap-1">
<span class="w-1.5 h-1.5 rounded-full bg-primary block"></span> Aktif
                            </span>
</div>
</div>
</div>
<div class="relative">
<button aria-label="Opsi lainnya" class="text-on-surface-variant hover:text-on-surface hover:bg-surface-container p-2 rounded-full transition-colors min-h-[44px] min-w-[44px] flex items-center justify-center">
<span class="material-symbols-outlined" data-icon="more_vert">more_vert</span>
</button>
</div>
</div>
</div>
</main>
<!-- BottomNavBar (Mobile Only) -->
<nav class="md:hidden bg-surface-container-lowest dark:bg-surface-container-low fixed bottom-0 w-full z-50 border-t border-outline-variant dark:border-outline shadow-sm flex justify-around items-center h-20 w-full pb-safe">
<!-- Inactive: Register -->
<button class="flex flex-col items-center justify-center text-on-surface-variant dark:text-outline-variant px-4 py-1 hover:text-primary dark:hover:text-primary-fixed-dim active:opacity-80 transition-opacity w-full h-full">
<span class="material-symbols-outlined mb-1" data-icon="point_of_sale">point_of_sale</span>
<span class="font-label-sm text-label-sm">Register</span>
</button>
<!-- Inactive: Orders -->
<button class="flex flex-col items-center justify-center text-on-surface-variant dark:text-outline-variant px-4 py-1 hover:text-primary dark:hover:text-primary-fixed-dim active:opacity-80 transition-opacity w-full h-full">
<span class="material-symbols-outlined mb-1" data-icon="receipt_long">receipt_long</span>
<span class="font-label-sm text-label-sm">Orders</span>
</button>
<!-- Active: Admin -->
<button class="flex flex-col items-center justify-center bg-primary-container text-on-primary-container rounded-full px-4 py-1 hover:text-primary dark:hover:text-primary-fixed-dim active:opacity-80 transition-opacity mx-2">
<span class="material-symbols-outlined fill mb-1" data-icon="dashboard" data-weight="fill">dashboard</span>
<span class="font-label-sm text-label-sm font-bold">Admin</span>
</button>
<!-- Inactive: Items -->
<button class="flex flex-col items-center justify-center text-on-surface-variant dark:text-outline-variant px-4 py-1 hover:text-primary dark:hover:text-primary-fixed-dim active:opacity-80 transition-opacity w-full h-full">
<span class="material-symbols-outlined mb-1" data-icon="inventory_2">inventory_2</span>
<span class="font-label-sm text-label-sm">Items</span>
</button>
</nav>
</body></html>

<!-- Manajemen User/Staff -->
<!DOCTYPE html>

<html lang="id"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Admin Dashboard - QuickServe POS</title>
<!-- Material Symbols -->
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<!-- Google Fonts: Inter -->
<link href="https://fonts.googleapis.com" rel="preconnect"/>
<link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<!-- Tailwind CSS -->
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .icon-fill {
            font-variation-settings: 'FILL' 1;
        }
    </style>
<script id="tailwind-config">
  tailwind.config = {
    darkMode: "class",
    theme: {
      extend: {
        "colors": {
                "surface-container": "#ffe9e3",
                "on-tertiary-container": "#ff5f31",
                "inverse-on-surface": "#ffede8",
                "background": "#fff8f6",
                "outline": "#827472",
                "on-primary-fixed-variant": "#5b403c",
                "on-primary-fixed": "#2b1613",
                "inverse-primary": "#e3beb8",
                "on-surface-variant": "#504442",
                "primary-fixed": "#ffdad4",
                "tertiary-fixed-dim": "#ffb5a0",
                "on-tertiary-fixed-variant": "#872000",
                "on-secondary": "#ffffff",
                "surface": "#fff8f6",
                "on-error-container": "#93000a",
                "on-primary": "#ffffff",
                "on-surface": "#2c160e",
                "outline-variant": "#d3c3c0",
                "primary-container": "#3e2723",
                "on-primary-container": "#ae8d87",
                "secondary": "#655d4f",
                "surface-variant": "#ffdbd0",
                "tertiary-fixed": "#ffdbd1",
                "error-container": "#ffdad6",
                "surface-bright": "#fff8f6",
                "surface-container-highest": "#ffdbd0",
                "primary": "#271310",
                "secondary-fixed-dim": "#d0c5b3",
                "on-tertiary-fixed": "#3b0900",
                "surface-container-lowest": "#ffffff",
                "surface-tint": "#745853",
                "primary-fixed-dim": "#e3beb8",
                "on-tertiary": "#ffffff",
                "tertiary": "#360700",
                "inverse-surface": "#442a22",
                "on-background": "#2c160e",
                "on-secondary-fixed": "#201b10",
                "on-secondary-fixed-variant": "#4d4638",
                "secondary-container": "#eadecc",
                "error": "#ba1a1a",
                "secondary-fixed": "#ede1cf",
                "on-secondary-container": "#6a6253",
                "tertiary-container": "#5a1200",
                "on-error": "#ffffff",
                "surface-container-high": "#ffe2da",
                "surface-container-low": "#fff1ed",
                "surface-dim": "#fbd1c4"
        },
        "borderRadius": {
                "DEFAULT": "0.25rem",
                "lg": "0.5rem",
                "xl": "0.75rem",
                "full": "9999px"
        },
        "spacing": {
                "container-max": "1280px",
                "unit": "8px",
                "margin-desktop": "64px",
                "gutter": "24px",
                "margin-mobile": "20px",
                "lg": "24px",
                "md": "16px",
                "xl": "32px",
                "xs": "4px",
                "base": "8px",
                "gutter-desktop": "24px",
                "gutter-mobile": "16px",
                "touch-target": "44px",
                "sm": "12px"
        },
        "fontFamily": {
                "headline-sm": [
                        "Inter"
                ],
                "body-lg": [
                        "Inter"
                ],
                "label-md": [
                        "Inter"
                ],
                "headline-lg-mobile": [
                        "Inter"
                ],
                "body-md": [
                        "Inter"
                ],
                "headline-md": [
                        "Inter"
                ],
                "headline-lg": [
                        "Inter"
                ],
                "body-sm": [
                        "Inter"
                ],
                "title-lg": ["Inter"],
                "display-lg": ["Inter"],
                "label-sm": ["Inter"]
        },
        "fontSize": {
                "headline-sm": [
                        "24px",
                        {
                                "lineHeight": "32px",
                                "letterSpacing": "0",
                                "fontWeight": "600"
                        }
                ],
                "body-lg": [
                        "18px",
                        {
                                "lineHeight": "28px",
                                "letterSpacing": "0",
                                "fontWeight": "400"
                        }
                ],
                "label-md": [
                        "12px",
                        {
                                "lineHeight": "16px",
                                "letterSpacing": "0.05em",
                                "fontWeight": "600"
                        }
                ],
                "headline-lg-mobile": [
                        "32px",
                        {
                                "lineHeight": "40px",
                                "letterSpacing": "-0.02em",
                                "fontWeight": "700"
                        }
                ],
                "body-md": [
                        "16px",
                        {
                                "lineHeight": "24px",
                                "letterSpacing": "0",
                                "fontWeight": "400"
                        }
                ],
                "headline-md": [
                        "32px",
                        {
                                "lineHeight": "40px",
                                "letterSpacing": "-0.01em",
                                "fontWeight": "600"
                        }
                ],
                "headline-lg": [
                        "48px",
                        {
                                "lineHeight": "56px",
                                "letterSpacing": "-0.02em",
                                "fontWeight": "700"
                        }
                ],
                "body-sm": [
                        "14px",
                        {
                                "lineHeight": "20px",
                                "letterSpacing": "0",
                                "fontWeight": "400"
                        }
                ],
                "title-lg": ["20px", { "lineHeight": "28px", "fontWeight": "600" }],
                "display-lg": ["48px", { "lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "700" }],
                "label-sm": ["12px", { "lineHeight": "16px", "fontWeight": "600" }]
        }
},
    },
  }
</script>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
</head>
<body class="bg-background text-on-surface font-body-md text-body-md antialiased h-screen overflow-hidden flex">
<!-- Desktop Sidebar (Hidden on Mobile) -->
<aside class="hidden md:flex flex-col w-64 bg-surface-container-lowest border-r border-outline-variant h-full z-10">
<div class="h-14 flex items-center px-gutter-desktop border-b border-outline-variant">
<span class="font-headline-md text-headline-md font-bold text-primary">QuickServe Admin</span>
</div>
<nav class="flex-1 py-lg px-md space-y-sm">
<a class="flex items-center gap-md px-md py-sm bg-primary-container text-on-primary-container rounded-lg font-label-md text-label-md" href="#">
<span class="material-symbols-outlined icon-fill" data-icon="dashboard">dashboard</span>
                Beranda
            </a>
<a class="flex items-center gap-md px-md py-sm text-on-surface-variant hover:bg-surface-container hover:text-on-surface rounded-lg font-label-md text-label-md transition-colors" href="#">
<span class="material-symbols-outlined" data-icon="inventory_2">inventory_2</span>
                Produk
            </a>
<a class="flex items-center gap-md px-md py-sm text-on-surface-variant hover:bg-surface-container hover:text-on-surface rounded-lg font-label-md text-label-md transition-colors" href="#">
<span class="material-symbols-outlined" data-icon="group">group</span>
                Pengguna
            </a>
<a class="flex items-center gap-md px-md py-sm text-on-surface-variant hover:bg-surface-container hover:text-on-surface rounded-lg font-label-md text-label-md transition-colors" href="#">
<span class="material-symbols-outlined" data-icon="bar_chart">bar_chart</span>
                Laporan
            </a>
</nav>
</aside>
<!-- Main Canvas Area -->
<main class="flex-1 flex flex-col h-full overflow-hidden relative">
<!-- TopAppBar (JSON Sourced) -->
<header class="w-full top-0 sticky z-50 bg-surface dark:bg-surface-dim border-b border-outline-variant dark:border-outline flex justify-between items-center px-gutter-mobile h-14 w-full">
<button class="md:hidden flex items-center justify-center p-2 text-primary hover:bg-surface-container transition-colors rounded-full active:scale-95 transition-transform duration-100">
<span class="material-symbols-outlined" data-icon="menu">menu</span>
</button>
<div class="md:hidden font-headline-sm text-headline-sm font-bold text-primary dark:text-primary-fixed-dim">
                QuickServe POS
            </div>
<div class="hidden md:flex flex-1"></div> <!-- Spacer for desktop -->
<button class="flex items-center justify-center p-2 text-primary hover:bg-surface-container transition-colors rounded-full active:scale-95 transition-transform duration-100">
<span class="material-symbols-outlined" data-icon="notifications">notifications</span>
</button>
</header>
<!-- Scrollable Dashboard Content -->
<div class="flex-1 overflow-y-auto p-gutter-mobile md:p-gutter-desktop pb-24 md:pb-lg">
<div class="max-w-7xl mx-auto space-y-lg">
<!-- Page Header -->
<div>
<h1 class="font-headline-lg-mobile md:font-headline-lg text-headline-lg-mobile md:text-headline-lg text-on-surface">Ringkasan Hari Ini</h1>
<p class="font-body-md text-body-md text-on-surface-variant mt-xs">Pantau performa bisnis Anda secara real-time.</p>
</div>
<!-- KPI Bento Grid -->
<div class="grid grid-cols-1 md:grid-cols-3 gap-md">
<!-- KPI Card 1 -->
<div class="bg-surface-container-lowest border border-outline-variant rounded-xl p-md flex flex-col justify-between">
<div class="flex justify-between items-start mb-lg">
<span class="font-label-md text-label-md text-on-surface-variant">Pendapatan</span>
<div class="p-2 bg-primary-container/20 text-primary-container rounded-full">
<span class="material-symbols-outlined" data-icon="payments">payments</span>
</div>
</div>
<div>
<div class="font-headline-md text-headline-md text-on-surface mb-xs">Rp 12.450.000</div>
<div class="flex items-center gap-xs font-label-sm text-label-sm text-primary">
<span class="material-symbols-outlined text-[16px]" data-icon="trending_up">trending_up</span>
<span>+8.2% vs kemarin</span>
</div>
</div>
</div>
<!-- KPI Card 2 -->
<div class="bg-surface-container-lowest border border-outline-variant rounded-xl p-md flex flex-col justify-between">
<div class="flex justify-between items-start mb-lg">
<span class="font-label-md text-label-md text-on-surface-variant">Total Pesanan</span>
<div class="p-2 bg-secondary-container/50 text-secondary rounded-full">
<span class="material-symbols-outlined" data-icon="receipt_long">receipt_long</span>
</div>
</div>
<div>
<div class="font-headline-md text-headline-md text-on-surface mb-xs">342</div>
<div class="flex items-center gap-xs font-label-sm text-label-sm text-on-surface-variant">
<span>Sedang diproses: 12</span>
</div>
</div>
</div>
<!-- KPI Card 3 -->
<div class="bg-surface-container-lowest border border-outline-variant rounded-xl p-md flex flex-col justify-between">
<div class="flex justify-between items-start mb-lg">
<span class="font-label-md text-label-md text-on-surface-variant">Pelanggan Baru</span>
<div class="p-2 bg-tertiary-container/20 text-tertiary-container rounded-full">
<span class="material-symbols-outlined" data-icon="person_add">person_add</span>
</div>
</div>
<div>
<div class="font-headline-md text-headline-md text-on-surface mb-xs">24</div>
<div class="flex items-center gap-xs font-label-sm text-label-sm text-primary">
<span class="material-symbols-outlined text-[16px]" data-icon="trending_up">trending_up</span>
<span>+15% minggu ini</span>
</div>
</div>
</div>
</div>
<!-- Main Content Split -->
<div class="grid grid-cols-1 lg:grid-cols-3 gap-lg">
<!-- Chart Section (Spans 2 cols on Desktop) -->
<div class="lg:col-span-2 bg-surface-container-lowest border border-outline-variant rounded-xl p-md md:p-lg flex flex-col">
<div class="flex justify-between items-center mb-xl">
<h2 class="font-title-lg text-title-lg text-on-surface">Penjualan Mingguan</h2>
<button class="text-primary hover:bg-surface-container px-3 py-1 rounded-full font-label-sm text-label-sm transition-colors">Lihat Detail</button>
</div>
<!-- Simple CSS Bar Chart -->
<div class="flex-1 flex items-end gap-2 md:gap-4 h-48 md:h-64 mt-auto border-b border-outline-variant pb-2 relative">
<!-- Grid lines (visual only) -->
<div class="absolute inset-0 flex flex-col justify-between border-t border-outline-variant/30 pointer-events-none">
<div class="border-b border-outline-variant/30 flex-1"></div>
<div class="border-b border-outline-variant/30 flex-1"></div>
<div class="flex-1"></div>
</div>
<!-- Bars -->
<div class="flex-1 flex flex-col items-center gap-2 z-10 group">
<div class="w-full bg-primary-container/40 group-hover:bg-primary-container rounded-t-sm h-[40%] transition-colors relative"><div class="absolute -top-6 left-1/2 -translate-x-1/2 opacity-0 group-hover:opacity-100 font-label-sm text-label-sm text-on-surface transition-opacity">40</div></div>
<span class="font-label-sm text-label-sm text-on-surface-variant">Sen</span>
</div>
<div class="flex-1 flex flex-col items-center gap-2 z-10 group">
<div class="w-full bg-primary-container/40 group-hover:bg-primary-container rounded-t-sm h-[60%] transition-colors relative"><div class="absolute -top-6 left-1/2 -translate-x-1/2 opacity-0 group-hover:opacity-100 font-label-sm text-label-sm text-on-surface transition-opacity">60</div></div>
<span class="font-label-sm text-label-sm text-on-surface-variant">Sel</span>
</div>
<div class="flex-1 flex flex-col items-center gap-2 z-10 group">
<div class="w-full bg-primary-container/40 group-hover:bg-primary-container rounded-t-sm h-[45%] transition-colors relative"><div class="absolute -top-6 left-1/2 -translate-x-1/2 opacity-0 group-hover:opacity-100 font-label-sm text-label-sm text-on-surface transition-opacity">45</div></div>
<span class="font-label-sm text-label-sm text-on-surface-variant">Rab</span>
</div>
<div class="flex-1 flex flex-col items-center gap-2 z-10 group">
<div class="w-full bg-primary rounded-t-sm h-[85%] shadow-sm relative"><div class="absolute -top-6 left-1/2 -translate-x-1/2 font-label-sm text-label-sm text-on-surface">85</div></div>
<span class="font-label-sm text-label-sm text-primary font-bold">Kam</span>
</div>
<div class="flex-1 flex flex-col items-center gap-2 z-10 group">
<div class="w-full bg-primary-container/40 group-hover:bg-primary-container rounded-t-sm h-[70%] transition-colors relative"><div class="absolute -top-6 left-1/2 -translate-x-1/2 opacity-0 group-hover:opacity-100 font-label-sm text-label-sm text-on-surface transition-opacity">70</div></div>
<span class="font-label-sm text-label-sm text-on-surface-variant">Jum</span>
</div>
<div class="flex-1 flex flex-col items-center gap-2 z-10 group">
<div class="w-full bg-primary-container/40 group-hover:bg-primary-container rounded-t-sm h-[95%] transition-colors relative"><div class="absolute -top-6 left-1/2 -translate-x-1/2 opacity-0 group-hover:opacity-100 font-label-sm text-label-sm text-on-surface transition-opacity">95</div></div>
<span class="font-label-sm text-label-sm text-on-surface-variant">Sab</span>
</div>
<div class="flex-1 flex flex-col items-center gap-2 z-10 group">
<div class="w-full bg-primary-container/40 group-hover:bg-primary-container rounded-t-sm h-[50%] transition-colors relative"><div class="absolute -top-6 left-1/2 -translate-x-1/2 opacity-0 group-hover:opacity-100 font-label-sm text-label-sm text-on-surface transition-opacity">50</div></div>
<span class="font-label-sm text-label-sm text-on-surface-variant">Min</span>
</div>
</div>
</div>
<!-- Quick Actions / Navigation (Visible clearly on mobile, extra links on desktop) -->
<div class="flex flex-col gap-md">
<h2 class="font-title-lg text-title-lg text-on-surface mb-xs md:mb-sm">Aksi Cepat</h2>
<a class="flex items-center p-md bg-surface-container-lowest border border-outline-variant hover:border-primary rounded-xl transition-colors group cursor-pointer" href="#">
<div class="w-12 h-12 bg-surface-variant rounded-lg flex items-center justify-center text-on-surface-variant group-hover:bg-primary-container group-hover:text-on-primary-container transition-colors mr-md">
<span class="material-symbols-outlined" data-icon="inventory_2">inventory_2</span>
</div>
<div class="flex-1">
<div class="font-label-md text-label-md text-on-surface">Kelola Produk</div>
<div class="font-label-sm text-label-sm text-on-surface-variant">Tambah, edit, atau hapus menu</div>
</div>
<span class="material-symbols-outlined text-outline-variant group-hover:text-primary transition-colors" data-icon="chevron_right">chevron_right</span>
</a>
<a class="flex items-center p-md bg-surface-container-lowest border border-outline-variant hover:border-primary rounded-xl transition-colors group cursor-pointer" href="#">
<div class="w-12 h-12 bg-surface-variant rounded-lg flex items-center justify-center text-on-surface-variant group-hover:bg-primary-container group-hover:text-on-primary-container transition-colors mr-md">
<span class="material-symbols-outlined" data-icon="group">group</span>
</div>
<div class="flex-1">
<div class="font-label-md text-label-md text-on-surface">Manajemen Pengguna</div>
<div class="font-label-sm text-label-sm text-on-surface-variant">Atur kasir &amp; akses admin</div>
</div>
<span class="material-symbols-outlined text-outline-variant group-hover:text-primary transition-colors" data-icon="chevron_right">chevron_right</span>
</a>
<a class="flex items-center p-md bg-surface-container-lowest border border-outline-variant hover:border-primary rounded-xl transition-colors group cursor-pointer" href="#">
<div class="w-12 h-12 bg-surface-variant rounded-lg flex items-center justify-center text-on-surface-variant group-hover:bg-primary-container group-hover:text-on-primary-container transition-colors mr-md">
<span class="material-symbols-outlined" data-icon="summarize">summarize</span>
</div>
<div class="flex-1">
<div class="font-label-md text-label-md text-on-surface">Laporan Lengkap</div>
<div class="font-label-sm text-label-sm text-on-surface-variant">Ekspor data &amp; analitik</div>
</div>
<span class="material-symbols-outlined text-outline-variant group-hover:text-primary transition-colors" data-icon="chevron_right">chevron_right</span>
</a>
</div>
</div>
</div>
</div>
</main>
<!-- BottomNavBar (JSON Sourced - Mobile Only) -->
<nav class="md:hidden fixed bottom-0 w-full z-50 border-t border-outline-variant dark:border-outline shadow-sm bg-surface-container-lowest dark:bg-surface-container-low flex justify-around items-center h-20 w-full pb-safe">
<button class="flex flex-col items-center justify-center text-on-surface-variant dark:text-outline-variant px-4 py-1 hover:text-primary dark:hover:text-primary-fixed-dim active:opacity-80 transition-opacity">
<span class="material-symbols-outlined mb-1" data-icon="point_of_sale">point_of_sale</span>
<span class="font-label-sm text-label-sm">Register</span>
</button>
<button class="flex flex-col items-center justify-center text-on-surface-variant dark:text-outline-variant px-4 py-1 hover:text-primary dark:hover:text-primary-fixed-dim active:opacity-80 transition-opacity">
<span class="material-symbols-outlined mb-1" data-icon="receipt_long">receipt_long</span>
<span class="font-label-sm text-label-sm">Orders</span>
</button>
<!-- Active Tab: Admin -->
<button class="flex flex-col items-center justify-center bg-primary-container text-on-primary-container rounded-full px-4 py-1 active:opacity-80 transition-opacity">
<span class="material-symbols-outlined icon-fill mb-1" data-icon="dashboard">dashboard</span>
<span class="font-label-sm text-label-sm">Admin</span>
</button>
<button class="flex flex-col items-center justify-center text-on-surface-variant dark:text-outline-variant px-4 py-1 hover:text-primary dark:hover:text-primary-fixed-dim active:opacity-80 transition-opacity">
<span class="material-symbols-outlined mb-1" data-icon="inventory_2">inventory_2</span>
<span class="font-label-sm text-label-sm">Items</span>
</button>
</nav>
</body></html>

<!-- Design System -->
<!DOCTYPE html>

<html lang="id"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Manajemen Staf - QuickServe POS</title>
<!-- Material Symbols -->
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .material-symbols-outlined.fill {
            font-variation-settings: 'FILL' 1;
        }
    </style>
<!-- Tailwind CSS -->
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<script id="tailwind-config">
  tailwind.config = {
    darkMode: "class",
    theme: {
      extend: {
        "colors": {
                "surface-container": "#ffe9e3",
                "on-tertiary-container": "#ff5f31",
                "inverse-on-surface": "#ffede8",
                "background": "#fff8f6",
                "outline": "#827472",
                "on-primary-fixed-variant": "#5b403c",
                "on-primary-fixed": "#2b1613",
                "inverse-primary": "#e3beb8",
                "on-surface-variant": "#504442",
                "primary-fixed": "#ffdad4",
                "tertiary-fixed-dim": "#ffb5a0",
                "on-tertiary-fixed-variant": "#872000",
                "on-secondary": "#ffffff",
                "surface": "#fff8f6",
                "on-error-container": "#93000a",
                "on-primary": "#ffffff",
                "on-surface": "#2c160e",
                "outline-variant": "#d3c3c0",
                "primary-container": "#3e2723",
                "on-primary-container": "#ae8d87",
                "secondary": "#655d4f",
                "surface-variant": "#ffdbd0",
                "tertiary-fixed": "#ffdbd1",
                "error-container": "#ffdad6",
                "surface-bright": "#fff8f6",
                "surface-container-highest": "#ffdbd0",
                "primary": "#271310",
                "secondary-fixed-dim": "#d0c5b3",
                "on-tertiary-fixed": "#3b0900",
                "surface-container-lowest": "#ffffff",
                "surface-tint": "#745853",
                "primary-fixed-dim": "#e3beb8",
                "on-tertiary": "#ffffff",
                "tertiary": "#360700",
                "inverse-surface": "#442a22",
                "on-background": "#2c160e",
                "on-secondary-fixed": "#201b10",
                "on-secondary-fixed-variant": "#4d4638",
                "secondary-container": "#eadecc",
                "error": "#ba1a1a",
                "secondary-fixed": "#ede1cf",
                "on-secondary-container": "#6a6253",
                "tertiary-container": "#5a1200",
                "on-error": "#ffffff",
                "surface-container-high": "#ffe2da",
                "surface-container-low": "#fff1ed",
                "surface-dim": "#fbd1c4"
        },
        "borderRadius": {
                "DEFAULT": "0.25rem",
                "lg": "0.5rem",
                "xl": "0.75rem",
                "full": "9999px"
        },
        "spacing": {
                "container-max": "1280px",
                "unit": "8px",
                "margin-desktop": "64px",
                "gutter": "24px",
                "margin-mobile": "20px"
        },
        "fontFamily": {
                "headline-sm": [
                        "Inter"
                ],
                "body-lg": [
                        "Inter"
                ],
                "label-md": [
                        "Inter"
                ],
                "headline-lg-mobile": [
                        "Inter"
                ],
                "body-md": [
                        "Inter"
                ],
                "headline-md": [
                        "Inter"
                ],
                "headline-lg": [
                        "Inter"
                ],
                "body-sm": [
                        "Inter"
                ]
        },
        "fontSize": {
                "headline-sm": [
                        "24px",
                        {
                                "lineHeight": "32px",
                                "letterSpacing": "0",
                                "fontWeight": "600"
                        }
                ],
                "body-lg": [
                        "18px",
                        {
                                "lineHeight": "28px",
                                "letterSpacing": "0",
                                "fontWeight": "400"
                        }
                ],
                "label-md": [
                        "12px",
                        {
                                "lineHeight": "16px",
                                "letterSpacing": "0.05em",
                                "fontWeight": "600"
                        }
                ],
                "headline-lg-mobile": [
                        "32px",
                        {
                                "lineHeight": "40px",
                                "letterSpacing": "-0.02em",
                                "fontWeight": "700"
                        }
                ],
                "body-md": [
                        "16px",
                        {
                                "lineHeight": "24px",
                                "letterSpacing": "0",
                                "fontWeight": "400"
                        }
                ],
                "headline-md": [
                        "32px",
                        {
                                "lineHeight": "40px",
                                "letterSpacing": "-0.01em",
                                "fontWeight": "600"
                        }
                ],
                "headline-lg": [
                        "48px",
                        {
                                "lineHeight": "56px",
                                "letterSpacing": "-0.02em",
                                "fontWeight": "700"
                        }
                ],
                "body-sm": [
                        "14px",
                        {
                                "lineHeight": "20px",
                                "letterSpacing": "0",
                                "fontWeight": "400"
                        }
                ]
        }
},
    },
  }
</script>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
</head>
<body class="bg-background min-h-screen flex flex-col font-body-md text-on-background selection:bg-primary-fixed selection:text-on-primary-fixed">
<!-- TopAppBar -->
<header class="bg-surface dark:bg-surface-dim w-full top-0 sticky z-40 border-b border-outline-variant dark:border-outline flat no shadows flex justify-between items-center px-[20px] h-14 w-full">
<div class="flex items-center gap-4">
<button aria-label="Menu" class="text-on-surface-variant hover:bg-surface-container rounded-full p-2 transition-colors active:scale-95 duration-100 flex items-center justify-center min-h-[44px] min-w-[44px]">
<span class="material-symbols-outlined" data-icon="menu">menu</span>
</button>
<h1 class="font-headline-sm text-headline-sm text-primary dark:text-primary-fixed-dim tracking-tight">QuickServe POS</h1>
</div>
<!-- Desktop Navigation Cluster (Hidden on mobile) -->
<nav class="hidden md:flex items-center gap-6">
<a class="font-body-sm text-body-sm font-medium text-on-surface-variant hover:text-primary transition-colors py-2" href="#">Register</a>
<a class="font-body-sm text-body-sm font-medium text-on-surface-variant hover:text-primary transition-colors py-2" href="#">Orders</a>
<a class="font-body-sm text-body-sm font-bold text-primary border-b-2 border-primary py-2" href="#">Admin</a>
<a class="font-body-sm text-body-sm font-medium text-on-surface-variant hover:text-primary transition-colors py-2" href="#">Items</a>
</nav>
<button aria-label="Notifications" class="text-on-surface-variant hover:bg-surface-container rounded-full p-2 transition-colors active:scale-95 duration-100 flex items-center justify-center min-h-[44px] min-w-[44px]">
<span class="material-symbols-outlined" data-icon="notifications">notifications</span>
</button>
</header>
<!-- Main Content Canvas -->
<main class="flex-1 overflow-y-auto px-[20px] md:px-[64px] py-6 pb-[100px] w-full max-w-container-max mx-auto">
<!-- Page Header -->
<div class="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-6">
<div>
<h2 class="font-headline-md text-headline-md text-on-surface">Manajemen Staf</h2>
<p class="font-body-md text-body-md text-on-surface-variant mt-1">Kelola akses dan detail karyawan.</p>
</div>
<button class="bg-primary text-on-primary font-body-sm text-body-sm font-medium px-6 py-3 rounded-full flex items-center justify-center gap-2 hover:bg-on-primary-fixed-variant transition-colors min-h-[44px] shadow-sm">
<span class="material-symbols-outlined" data-icon="add">add</span>
                Tambah Staf
            </button>
</div>
<!-- Staff List Container (Grid for cards) -->
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
<!-- Staff Card 1 (Aktif, Admin) -->
<div class="bg-surface-container-lowest border border-outline-variant rounded-xl p-4 flex items-center justify-between hover:shadow-md transition-shadow duration-200 group">
<div class="flex items-center gap-4">
<!-- Avatar Initials -->
<div class="w-12 h-12 rounded-full bg-primary-container text-on-primary-container flex items-center justify-center text-[20px] leading-[28px] font-semibold shadow-inner">
                        BS
                    </div>
<div class="flex flex-col">
<span class="text-[20px] leading-[28px] font-semibold text-on-surface">Budi Santoso</span>
<div class="flex items-center gap-2 mt-1">
<span class="bg-surface-variant text-on-surface-variant font-label-md text-label-md px-2 py-0.5 rounded-sm uppercase tracking-wider">Admin</span>
<span class="bg-primary-fixed text-on-primary-fixed-variant font-label-md text-label-md px-2 py-0.5 rounded-sm flex items-center gap-1">
<span class="w-1.5 h-1.5 rounded-full bg-primary block"></span> Aktif
                            </span>
</div>
</div>
</div>
<div class="relative">
<button aria-label="Opsi lainnya" class="text-on-surface-variant hover:text-on-surface hover:bg-surface-container p-2 rounded-full transition-colors min-h-[44px] min-w-[44px] flex items-center justify-center">
<span class="material-symbols-outlined" data-icon="more_vert">more_vert</span>
</button>
</div>
</div>
<!-- Staff Card 2 (Aktif, Kasir) -->
<div class="bg-surface-container-lowest border border-outline-variant rounded-xl p-4 flex items-center justify-between hover:shadow-md transition-shadow duration-200 group">
<div class="flex items-center gap-4">
<div class="w-12 h-12 rounded-full bg-secondary-container text-on-secondary-container flex items-center justify-center text-[20px] leading-[28px] font-semibold shadow-inner">
                        SA
                    </div>
<div class="flex flex-col">
<span class="text-[20px] leading-[28px] font-semibold text-on-surface">Siti Aminah</span>
<div class="flex items-center gap-2 mt-1">
<span class="bg-surface-variant text-on-surface-variant font-label-md text-label-md px-2 py-0.5 rounded-sm uppercase tracking-wider">Kasir</span>
<span class="bg-primary-fixed text-on-primary-fixed-variant font-label-md text-label-md px-2 py-0.5 rounded-sm flex items-center gap-1">
<span class="w-1.5 h-1.5 rounded-full bg-primary block"></span> Aktif
                            </span>
</div>
</div>
</div>
<div class="relative">
<button aria-label="Opsi lainnya" class="text-on-surface-variant hover:text-on-surface hover:bg-surface-container p-2 rounded-full transition-colors min-h-[44px] min-w-[44px] flex items-center justify-center">
<span class="material-symbols-outlined" data-icon="more_vert">more_vert</span>
</button>
</div>
</div>
<!-- Staff Card 3 (Non-aktif, Kasir) -->
<div class="bg-surface-container-lowest border border-outline-variant rounded-xl p-4 flex items-center justify-between hover:shadow-md transition-shadow duration-200 group opacity-75">
<div class="flex items-center gap-4">
<div class="w-12 h-12 rounded-full bg-surface-variant text-on-surface-variant flex items-center justify-center text-[20px] leading-[28px] font-semibold shadow-inner">
                        AP
                    </div>
<div class="flex flex-col">
<span class="text-[20px] leading-[28px] font-semibold text-on-surface">Agus Pratama</span>
<div class="flex items-center gap-2 mt-1">
<span class="bg-surface-variant text-on-surface-variant font-label-md text-label-md px-2 py-0.5 rounded-sm uppercase tracking-wider">Kasir</span>
<span class="bg-error-container text-on-error-container font-label-md text-label-md px-2 py-0.5 rounded-sm flex items-center gap-1">
<span class="w-1.5 h-1.5 rounded-full bg-error block"></span> Non-aktif
                            </span>
</div>
</div>
</div>
<div class="relative">
<button aria-label="Opsi lainnya" class="text-on-surface-variant hover:text-on-surface hover:bg-surface-container p-2 rounded-full transition-colors min-h-[44px] min-w-[44px] flex items-center justify-center">
<span class="material-symbols-outlined" data-icon="more_vert">more_vert</span>
</button>
</div>
</div>
<!-- Staff Card 4 (Aktif, Kasir) -->
<div class="bg-surface-container-lowest border border-outline-variant rounded-xl p-4 flex items-center justify-between hover:shadow-md transition-shadow duration-200 group">
<div class="flex items-center gap-4">
<div class="w-12 h-12 rounded-full bg-secondary-container text-on-secondary-container flex items-center justify-center text-[20px] leading-[28px] font-semibold shadow-inner">
                        RM
                    </div>
<div class="flex flex-col">
<span class="text-[20px] leading-[28px] font-semibold text-on-surface">Rina Melati</span>
<div class="flex items-center gap-2 mt-1">
<span class="bg-surface-variant text-on-surface-variant font-label-md text-label-md px-2 py-0.5 rounded-sm uppercase tracking-wider">Kasir</span>
<span class="bg-primary-fixed text-on-primary-fixed-variant font-label-md text-label-md px-2 py-0.5 rounded-sm flex items-center gap-1">
<span class="w-1.5 h-1.5 rounded-full bg-primary block"></span> Aktif
                            </span>
</div>
</div>
</div>
<div class="relative">
<button aria-label="Opsi lainnya" class="text-on-surface-variant hover:text-on-surface hover:bg-surface-container p-2 rounded-full transition-colors min-h-[44px] min-w-[44px] flex items-center justify-center">
<span class="material-symbols-outlined" data-icon="more_vert">more_vert</span>
</button>
</div>
</div>
</div>
</main>
<!-- BottomNavBar (Mobile Only) -->
<nav class="md:hidden bg-surface-container-lowest dark:bg-surface-container-low fixed bottom-0 w-full z-50 border-t border-outline-variant dark:border-outline shadow-sm flex justify-around items-center h-20 w-full pb-safe">
<!-- Inactive: Register -->
<button class="flex flex-col items-center justify-center text-on-surface-variant dark:text-outline-variant px-4 py-1 hover:text-primary dark:hover:text-primary-fixed-dim active:opacity-80 transition-opacity w-full h-full">
<span class="material-symbols-outlined mb-1" data-icon="point_of_sale">point_of_sale</span>
<span class="font-label-md text-label-md">Register</span>
</button>
<!-- Inactive: Orders -->
<button class="flex flex-col items-center justify-center text-on-surface-variant dark:text-outline-variant px-4 py-1 hover:text-primary dark:hover:text-primary-fixed-dim active:opacity-80 transition-opacity w-full h-full">
<span class="material-symbols-outlined mb-1" data-icon="receipt_long">receipt_long</span>
<span class="font-label-md text-label-md">Orders</span>
</button>
<!-- Active: Admin -->
<button class="flex flex-col items-center justify-center bg-primary-container text-on-primary-container rounded-full px-4 py-1 hover:text-primary dark:hover:text-primary-fixed-dim active:opacity-80 transition-opacity mx-2">
<span class="material-symbols-outlined fill mb-1" data-icon="dashboard" data-weight="fill">dashboard</span>
<span class="font-label-md text-label-md font-bold">Admin</span>
</button>
<!-- Inactive: Items -->
<button class="flex flex-col items-center justify-center text-on-surface-variant dark:text-outline-variant px-4 py-1 hover:text-primary dark:hover:text-primary-fixed-dim active:opacity-80 transition-opacity w-full h-full">
<span class="material-symbols-outlined mb-1" data-icon="inventory_2">inventory_2</span>
<span class="font-label-md text-label-md">Items</span>
</button>
</nav>
</body></html>

<!-- Dashboard Admin -->
<!DOCTYPE html>

<html lang="id"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Manajemen Produk - QuickServe POS</title>
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com" rel="preconnect"/>
<link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
<!-- Material Symbols -->
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<!-- Tailwind CSS -->
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<!-- Tailwind Config -->
<script id="tailwind-config">
      tailwind.config = {
        darkMode: "class",
        theme: {
          extend: {
            "colors": {
                    "surface-container": "#ffe9e3",
                    "on-tertiary-container": "#ff5f31",
                    "inverse-on-surface": "#ffede8",
                    "background": "#fff8f6",
                    "outline": "#827472",
                    "on-primary-fixed-variant": "#5b403c",
                    "on-primary-fixed": "#2b1613",
                    "inverse-primary": "#e3beb8",
                    "on-surface-variant": "#504442",
                    "primary-fixed": "#ffdad4",
                    "tertiary-fixed-dim": "#ffb5a0",
                    "on-tertiary-fixed-variant": "#872000",
                    "on-secondary": "#ffffff",
                    "surface": "#fff8f6",
                    "on-error-container": "#93000a",
                    "on-primary": "#ffffff",
                    "on-surface": "#2c160e",
                    "outline-variant": "#d3c3c0",
                    "primary-container": "#3e2723",
                    "on-primary-container": "#ae8d87",
                    "secondary": "#655d4f",
                    "surface-variant": "#ffdbd0",
                    "tertiary-fixed": "#ffdbd1",
                    "error-container": "#ffdad6",
                    "surface-bright": "#fff8f6",
                    "surface-container-highest": "#ffdbd0",
                    "primary": "#271310",
                    "secondary-fixed-dim": "#d0c5b3",
                    "on-tertiary-fixed": "#3b0900",
                    "surface-container-lowest": "#ffffff",
                    "surface-tint": "#745853",
                    "primary-fixed-dim": "#e3beb8",
                    "on-tertiary": "#ffffff",
                    "tertiary": "#360700",
                    "inverse-surface": "#442a22",
                    "on-background": "#2c160e",
                    "on-secondary-fixed": "#201b10",
                    "on-secondary-fixed-variant": "#4d4638",
                    "secondary-container": "#eadecc",
                    "error": "#ba1a1a",
                    "secondary-fixed": "#ede1cf",
                    "on-secondary-container": "#6a6253",
                    "tertiary-container": "#5a1200",
                    "on-error": "#ffffff",
                    "surface-container-high": "#ffe2da",
                    "surface-container-low": "#fff1ed",
                    "surface-dim": "#fbd1c4"
            },
            "borderRadius": {
                    "DEFAULT": "0.25rem",
                    "lg": "0.5rem",
                    "xl": "0.75rem",
                    "full": "9999px"
            },
            "spacing": {
                    "lg": "24px",
                    "md": "16px",
                    "xl": "32px",
                    "xs": "4px",
                    "base": "8px",
                    "gutter-desktop": "24px",
                    "gutter-mobile": "16px",
                    "touch-target": "44px",
                    "sm": "12px"
            },
            "fontFamily": {
                    "headline-md": ["Inter"],
                    "title-lg": ["Inter"],
                    "display-lg": ["Inter"],
                    "body-lg": ["Inter"],
                    "headline-lg-mobile": ["Inter"],
                    "body-md": ["Inter"],
                    "label-sm": ["Inter"],
                    "headline-lg": ["Inter"],
                    "label-md": ["Inter"]
            },
            "fontSize": {
                    "headline-md": ["24px", {"lineHeight": "32px", "fontWeight": "600"}],
                    "title-lg": ["20px", {"lineHeight": "28px", "fontWeight": "600"}],
                    "display-lg": ["48px", {"lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "700"}],
                    "body-lg": ["18px", {"lineHeight": "28px", "fontWeight": "400"}],
                    "headline-lg-mobile": ["24px", {"lineHeight": "32px", "fontWeight": "600"}],
                    "body-md": ["16px", {"lineHeight": "24px", "fontWeight": "400"}],
                    "label-sm": ["12px", {"lineHeight": "16px", "fontWeight": "600"}],
                    "headline-lg": ["32px", {"lineHeight": "40px", "letterSpacing": "-0.01em", "fontWeight": "600"}],
                    "label-md": ["14px", {"lineHeight": "20px", "letterSpacing": "0.01em", "fontWeight": "500"}]
            }
          }
        }
      }
    </script>
<style>
        .pb-safe { padding-bottom: env(safe-area-inset-bottom, 20px); }
    </style>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
</head>
<body class="bg-background text-on-background min-h-screen flex flex-col font-sans">
<!-- TopAppBar -->
<header class="w-full top-0 sticky border-b border-outline-variant bg-surface flex justify-between items-center px-gutter-mobile h-14 z-40">
<button aria-label="Menu" class="h-touch-target w-touch-target flex items-center justify-center text-primary hover:bg-surface-container transition-colors active:scale-95 duration-100 rounded-full">
<span class="material-symbols-outlined text-on-surface" data-icon="menu">menu</span>
</button>
<h1 class="font-headline-md text-headline-md font-bold text-primary truncate px-2">QuickServe POS</h1>
<button aria-label="Notifications" class="h-touch-target w-touch-target flex items-center justify-center text-primary hover:bg-surface-container transition-colors active:scale-95 duration-100 rounded-full">
<span class="material-symbols-outlined text-on-surface" data-icon="notifications">notifications</span>
</button>
</header>
<!-- Main Content Canvas -->
<main class="flex-1 px-gutter-mobile md:px-gutter-desktop py-lg pb-32">
<!-- Page Header & Actions -->
<div class="flex flex-col md:flex-row md:items-center justify-between gap-md mb-lg">
<div>
<h2 class="font-title-lg text-title-lg text-on-background">Manajemen Produk</h2>
<p class="font-body-md text-body-md text-on-surface-variant mt-1">Kelola inventaris dan detail menu.</p>
</div>
<div class="relative w-full md:w-72">
<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-outline-variant pointer-events-none" data-icon="search">search</span>
<input class="w-full pl-10 pr-4 py-2 bg-surface-container-lowest border border-outline-variant rounded-lg font-body-md text-body-md text-on-surface focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary transition-colors h-touch-target" placeholder="Cari produk..." type="text"/>
</div>
</div>
<!-- Product Grid (Bento/Card Layout) -->
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-md">
<!-- Product Card 1 (Good Stock) -->
<div class="bg-surface-container-lowest border border-outline-variant rounded-lg overflow-hidden flex flex-col group hover:shadow-md transition-shadow duration-200">
<div class="h-40 w-full bg-surface-variant relative">
<img alt="Pizza" class="w-full h-full object-cover" data-alt="A perfectly styled classic pepperoni pizza on a wooden serving board in a modern, brightly lit restaurant setting. The crust is golden and slightly charred, with glossy melted cheese and vibrant red pepperoni slices. The lighting is crisp, overhead, high-key photography common in modern minimalist POS systems, emphasizing the rich, appetizing colors against a clean, out-of-focus background." src="https://lh3.googleusercontent.com/aida-public/AB6AXuBZ-1Zt-w080JjnsKZx-eZJ79zVrE1d3UoPdPFfD0rmQjdSmhbLk5hDbO5R2nMdBU29MS4TF5zyx1mNiL5WYSEZZl3ziOuVSV0UDLaGIAn45mVJYVPPOwdO0iwOhOwTeoUTfi2fLk6G7-zoyDDQIbdaT9FtEQpxxnISlvs0KKdtsWtofdMhpwtKdLIw6ivvoeojX1IXylLZj1OIZbMIcMjgTTssBZ0QMTdZ0-ItsegwDA2EA7fRFtpOa6Mg6rzBzQ83syIVFayMxc4"/>
<div class="absolute top-2 right-2 bg-surface-container-lowest/90 backdrop-blur-sm px-2 py-1 rounded-md border border-outline-variant">
<span class="font-label-sm text-label-sm text-primary flex items-center gap-1">
<span class="material-symbols-outlined text-[14px]" data-icon="check_circle" data-weight="fill" style="font-variation-settings: 'FILL' 1;">check_circle</span>
                            Stok: 45
                        </span>
</div>
</div>
<div class="p-md flex-1 flex flex-col justify-between">
<div>
<h3 class="font-title-lg text-title-lg text-on-surface mb-1">Pepperoni Pizza</h3>
<p class="font-body-md text-body-md text-on-surface-variant line-clamp-2">Classic pizza with authentic Italian pepperoni and mozzarella.</p>
</div>
<div class="mt-md flex items-end justify-between">
<span class="font-headline-md text-headline-md text-primary font-bold">Rp 85.000</span>
</div>
</div>
<div class="border-t border-outline-variant bg-surface-bright px-md py-sm flex justify-end gap-2">
<button aria-label="Edit Produk" class="h-10 px-4 rounded border border-outline text-on-surface-variant hover:bg-surface-container transition-colors flex items-center justify-center gap-2">
<span class="material-symbols-outlined" data-icon="edit">edit</span>
</button>
<button aria-label="Hapus Produk" class="h-10 px-4 rounded bg-error-container text-on-error-container hover:opacity-90 transition-opacity flex items-center justify-center gap-2">
<span class="material-symbols-outlined" data-icon="delete">delete</span>
</button>
</div>
</div>
<!-- Product Card 2 (Low Stock Warning) -->
<div class="bg-surface-container-lowest border border-outline-variant rounded-lg overflow-hidden flex flex-col group hover:shadow-md transition-shadow duration-200">
<div class="h-40 w-full bg-surface-variant relative">
<img alt="Burger" class="w-full h-full object-cover" data-alt="A close up shot of a gourmet beef burger with melted cheddar cheese, fresh lettuce, and a glossy brioche bun, resting on a clean white ceramic plate. The lighting is bright and modern, creating a professional, clean aesthetic suitable for a high-end food service application. Soft natural light highlights the textures of the ingredients." src="https://lh3.googleusercontent.com/aida-public/AB6AXuDieK03ILFb9_st3OiTiw4ijgm7d24gPAOZBgrpA-5xGPoTKwHCZkmvgNxrytHoDrgGEUiBjioprs6-8fSdRW8K8b2LIbEtVmsuwhNZHGeWD96WjQbAPMN7QHpMCjpWfQ4_k-Au_0huJSOPc9uYAHQt3_lpyukFjaIr2pgq6ufBAazXOvYWr6M63XEuL2MTsexFE9ityLoBI0LlFPvzA3k8jOiM3MnrcmFnCdafUWq_X_2Vvh28Y7RjwxznDjYU4CwH4VpD7stqvIU"/>
<div class="absolute top-2 right-2 bg-error-container/90 backdrop-blur-sm px-2 py-1 rounded-md border border-error/20">
<span class="font-label-sm text-label-sm text-on-error-container flex items-center gap-1">
<span class="material-symbols-outlined text-[14px]" data-icon="warning" data-weight="fill" style="font-variation-settings: 'FILL' 1;">warning</span>
                            Sisa 3
                        </span>
</div>
</div>
<div class="p-md flex-1 flex flex-col justify-between">
<div>
<h3 class="font-title-lg text-title-lg text-on-surface mb-1">Classic Cheeseburger</h3>
<p class="font-body-md text-body-md text-on-surface-variant line-clamp-2">100% beef patty with secret sauce, lettuce, and cheddar.</p>
</div>
<div class="mt-md flex items-end justify-between">
<span class="font-headline-md text-headline-md text-primary font-bold">Rp 60.000</span>
</div>
</div>
<div class="border-t border-outline-variant bg-surface-bright px-md py-sm flex justify-end gap-2">
<button aria-label="Edit Produk" class="h-10 px-4 rounded border border-outline text-on-surface-variant hover:bg-surface-container transition-colors flex items-center justify-center gap-2">
<span class="material-symbols-outlined" data-icon="edit">edit</span>
</button>
<button aria-label="Hapus Produk" class="h-10 px-4 rounded bg-error-container text-on-error-container hover:opacity-90 transition-opacity flex items-center justify-center gap-2">
<span class="material-symbols-outlined" data-icon="delete">delete</span>
</button>
</div>
</div>
<!-- Product Card 3 (Out of Stock) -->
<div class="bg-surface-container-lowest border border-outline-variant rounded-lg overflow-hidden flex flex-col group hover:shadow-md transition-shadow duration-200 opacity-75">
<div class="h-40 w-full bg-surface-variant relative">
<div class="absolute inset-0 bg-surface/50 backdrop-blur-[2px] z-10 flex items-center justify-center">
<span class="bg-surface px-3 py-1 rounded font-label-md text-label-md text-on-surface-variant shadow-sm border border-outline-variant uppercase tracking-wider">Habis</span>
</div>
<img alt="Iced Latte" class="w-full h-full object-cover grayscale-[30%]" data-alt="A refreshing glass of iced latte with visible layers of milk and dark espresso, sitting on a pale marble countertop. Condensation beads on the outside of the glass. The environment is a clean, minimalist cafe setting with soft, diffused daytime lighting, aligning with a pristine, modern corporate aesthetic. The colors are cool and inviting." src="https://lh3.googleusercontent.com/aida-public/AB6AXuD47rnq9aPtD-J1oXP-5V-pxjRTUq6xhIGI6ErXFN1ex0SNB_MDCmL4q9BISt0sLtuX-DVAMSvd62g_11tPJ3n3qQ3SOLbWBv8ttdMrgkw_zHzIoqbR9TIzqGbVZsdPkNdJ3WgwqJv32h9orj34Ajta9iuwLvCapLhxJgL7BKREI8Vq5849DLzrOpeKsLwIyt8QRIxlLq2Qfss6ozavjHZBMu_ZNPZd7ADeythgUkjS5K8wQCaOxh26HD4N_JhhxuhvEj7Llf9Rbzk"/>
</div>
<div class="p-md flex-1 flex flex-col justify-between">
<div>
<h3 class="font-title-lg text-title-lg text-on-surface mb-1">Iced Caramel Latte</h3>
<p class="font-body-md text-body-md text-on-surface-variant line-clamp-2">Signature espresso with cold milk and caramel syrup.</p>
</div>
<div class="mt-md flex items-end justify-between">
<span class="font-headline-md text-headline-md text-on-surface-variant font-bold">Rp 45.000</span>
</div>
</div>
<div class="border-t border-outline-variant bg-surface-bright px-md py-sm flex justify-end gap-2">
<button aria-label="Edit Produk" class="h-10 px-4 rounded border border-outline text-on-surface-variant hover:bg-surface-container transition-colors flex items-center justify-center gap-2">
<span class="material-symbols-outlined" data-icon="edit">edit</span>
</button>
<button aria-label="Hapus Produk" class="h-10 px-4 rounded bg-error-container text-on-error-container hover:opacity-90 transition-opacity flex items-center justify-center gap-2">
<span class="material-symbols-outlined" data-icon="delete">delete</span>
</button>
</div>
</div>
<!-- Product Card 4 (Standard) -->
<div class="bg-surface-container-lowest border border-outline-variant rounded-lg overflow-hidden flex flex-col group hover:shadow-md transition-shadow duration-200">
<div class="h-40 w-full bg-surface-variant relative">
<img alt="Nasi Goreng" class="w-full h-full object-cover" data-alt="A plate of traditional Indonesian Nasi Goreng (fried rice) topped with a perfectly fried sunny-side-up egg and accompanied by fresh cucumber slices and prawn crackers. Presented on a simple, elegant dark plate against a neutral, light-colored background. The high-key lighting creates a sharp, professional look suitable for a modern POS interface." src="https://lh3.googleusercontent.com/aida-public/AB6AXuCvei0HR5TS6NMKT6N11ixmHBi6wYvJ8pl68mep7fGUcqtcu-1BeR5P3kwNGvbv2xwWXKTbEkZ_Jqb-ka9cSy2WGqr7EKpI23LWXLlDK_ka9CAs6mGdUdLdVYaFqAle6OtGUhNn2zwvR5fh6b9qD8dse550s1a59IbQC-bUmRbbXZsMi8mwBwJXQi0hrb_C7DgvYak2GXjw_l9N1AjCdkP_BhruB4NcdZ2yy8hH43xo5Msbe9w5NRsnnoZwuxt934Rx3GBamPnHAVw"/>
<div class="absolute top-2 right-2 bg-surface-container-lowest/90 backdrop-blur-sm px-2 py-1 rounded-md border border-outline-variant">
<span class="font-label-sm text-label-sm text-primary flex items-center gap-1">
<span class="material-symbols-outlined text-[14px]" data-icon="check_circle" data-weight="fill" style="font-variation-settings: 'FILL' 1;">check_circle</span>
                            Stok: 120
                        </span>
</div>
</div>
<div class="p-md flex-1 flex flex-col justify-between">
<div>
<h3 class="font-title-lg text-title-lg text-on-surface mb-1">Nasi Goreng Spesial</h3>
<p class="font-body-md text-body-md text-on-surface-variant line-clamp-2">Nasi goreng bumbu rempah dengan telur mata sapi dan kerupuk.</p>
</div>
<div class="mt-md flex items-end justify-between">
<span class="font-headline-md text-headline-md text-primary font-bold">Rp 35.000</span>
</div>
</div>
<div class="border-t border-outline-variant bg-surface-bright px-md py-sm flex justify-end gap-2">
<button aria-label="Edit Produk" class="h-10 px-4 rounded border border-outline text-on-surface-variant hover:bg-surface-container transition-colors flex items-center justify-center gap-2">
<span class="material-symbols-outlined" data-icon="edit">edit</span>
</button>
<button aria-label="Hapus Produk" class="h-10 px-4 rounded bg-error-container text-on-error-container hover:opacity-90 transition-opacity flex items-center justify-center gap-2">
<span class="material-symbols-outlined" data-icon="delete">delete</span>
</button>
</div>
</div>
</div>
</main>
<!-- Floating Action Button (FAB) -->
<button aria-label="Tambah Produk Baru" class="fixed bottom-[100px] right-gutter-mobile md:right-gutter-desktop w-14 h-14 rounded-full bg-primary text-on-primary shadow-[0px_10px_15px_-3px_rgba(0,0,0,0.1)] flex items-center justify-center z-40 hover:bg-surface-tint active:scale-95 transition-all duration-200">
<span class="material-symbols-outlined text-[28px]" data-icon="add">add</span>
</button>
<!-- BottomNavBar -->
<nav class="fixed bottom-0 w-full z-50 border-t border-outline-variant bg-surface-container-lowest shadow-sm flex justify-around items-center h-20 pb-safe md:hidden">
<!-- Tab 1 -->
<a class="flex flex-col items-center justify-center text-on-surface-variant px-4 py-1 hover:text-primary active:opacity-80 transition-opacity w-full h-full" href="#">
<span class="material-symbols-outlined mb-1" data-icon="point_of_sale">point_of_sale</span>
<span class="font-label-sm text-label-sm">Register</span>
</a>
<!-- Tab 2 -->
<a class="flex flex-col items-center justify-center text-on-surface-variant px-4 py-1 hover:text-primary active:opacity-80 transition-opacity w-full h-full" href="#">
<span class="material-symbols-outlined mb-1" data-icon="receipt_long">receipt_long</span>
<span class="font-label-sm text-label-sm">Orders</span>
</a>
<!-- Tab 3 -->
<a class="flex flex-col items-center justify-center text-on-surface-variant px-4 py-1 hover:text-primary active:opacity-80 transition-opacity w-full h-full" href="#">
<span class="material-symbols-outlined mb-1" data-icon="dashboard">dashboard</span>
<span class="font-label-sm text-label-sm">Admin</span>
</a>
<!-- Tab 4 (Active) -->
<a class="flex flex-col items-center justify-center bg-primary-container text-on-primary-container rounded-full px-4 py-1 mx-2 active:opacity-80 transition-opacity h-[56px] min-w-[64px]" href="#">
<span class="material-symbols-outlined mb-1" data-icon="inventory_2" data-weight="fill" style="font-variation-settings: 'FILL' 1;">inventory_2</span>
<span class="font-label-sm text-label-sm font-bold">Items</span>
</a>
</nav>
</body></html>

<!-- Manajemen User/Staff -->
<!DOCTYPE html>

<html lang="id"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Manajemen Pesanan - QuickServe POS</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "surface-container": "#ffe9e3",
                        "on-tertiary-container": "#ff5f31",
                        "inverse-on-surface": "#ffede8",
                        "background": "#fff8f6",
                        "outline": "#827472",
                        "on-primary-fixed-variant": "#5b403c",
                        "on-primary-fixed": "#2b1613",
                        "inverse-primary": "#e3beb8",
                        "on-surface-variant": "#504442",
                        "primary-fixed": "#ffdad4",
                        "tertiary-fixed-dim": "#ffb5a0",
                        "on-tertiary-fixed-variant": "#872000",
                        "on-secondary": "#ffffff",
                        "surface": "#fff8f6",
                        "on-error-container": "#93000a",
                        "on-primary": "#ffffff",
                        "on-surface": "#2c160e",
                        "outline-variant": "#d3c3c0",
                        "primary-container": "#3e2723",
                        "on-primary-container": "#ae8d87",
                        "secondary": "#655d4f",
                        "surface-variant": "#ffdbd0",
                        "tertiary-fixed": "#ffdbd1",
                        "error-container": "#ffdad6",
                        "surface-bright": "#fff8f6",
                        "surface-container-highest": "#ffdbd0",
                        "primary": "#271310",
                        "secondary-fixed-dim": "#d0c5b3",
                        "on-tertiary-fixed": "#3b0900",
                        "surface-container-lowest": "#ffffff",
                        "surface-tint": "#745853",
                        "primary-fixed-dim": "#e3beb8",
                        "on-tertiary": "#ffffff",
                        "tertiary": "#360700",
                        "inverse-surface": "#442a22",
                        "on-background": "#2c160e",
                        "on-secondary-fixed": "#201b10",
                        "on-secondary-fixed-variant": "#4d4638",
                        "secondary-container": "#eadecc",
                        "error": "#ba1a1a",
                        "secondary-fixed": "#ede1cf",
                        "on-secondary-container": "#6a6253",
                        "tertiary-container": "#5a1200",
                        "on-error": "#ffffff",
                        "surface-container-high": "#ffe2da",
                        "surface-container-low": "#fff1ed",
                        "surface-dim": "#fbd1c4"
                    },
                    "borderRadius": {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                    "spacing": {
                        "lg": "24px",
                        "md": "16px",
                        "xl": "32px",
                        "xs": "4px",
                        "base": "8px",
                        "gutter-desktop": "24px",
                        "gutter-mobile": "16px",
                        "touch-target": "44px",
                        "sm": "12px"
                    },
                    "fontFamily": {
                        "headline-md": ["Inter"],
                        "title-lg": ["Inter"],
                        "display-lg": ["Inter"],
                        "body-lg": ["Inter"],
                        "headline-lg-mobile": ["Inter"],
                        "body-md": ["Inter"],
                        "label-sm": ["Inter"],
                        "headline-lg": ["Inter"],
                        "label-md": ["Inter"]
                    },
                    "fontSize": {
                        "headline-md": ["24px", {"lineHeight": "32px", "fontWeight": "600"}],
                        "title-lg": ["20px", {"lineHeight": "28px", "fontWeight": "600"}],
                        "display-lg": ["48px", {"lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "700"}],
                        "body-lg": ["18px", {"lineHeight": "28px", "fontWeight": "400"}],
                        "headline-lg-mobile": ["24px", {"lineHeight": "32px", "fontWeight": "600"}],
                        "body-md": ["16px", {"lineHeight": "24px", "fontWeight": "400"}],
                        "label-sm": ["12px", {"lineHeight": "16px", "fontWeight": "600"}],
                        "headline-lg": ["32px", {"lineHeight": "40px", "letterSpacing": "-0.01em", "fontWeight": "600"}],
                        "label-md": ["14px", {"lineHeight": "20px", "letterSpacing": "0.01em", "fontWeight": "500"}]
                    }
                }
            }
        }
    </script>
<style>
        /* Custom scrollbar for minimal aesthetic */
        ::-webkit-scrollbar { width: 6px; height: 6px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb { background: #d3c3c0; border-radius: 9999px; }
        ::-webkit-scrollbar-thumb:hover { background: #827472; }
        
        .shadow-level-2 { box-shadow: 0px 10px 15px -3px rgba(0, 0, 0, 0.1); }
    </style>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
</head>
<body class="bg-background text-on-background font-body-md min-h-screen flex flex-col">
<!-- TopAppBar -->
<header class="w-full top-0 sticky bg-surface dark:bg-surface-dim border-b border-outline-variant dark:border-outline z-40">
<div class="flex justify-between items-center px-gutter-mobile md:px-gutter-desktop h-14 w-full">
<button class="flex items-center justify-center min-w-[44px] min-h-[44px] text-on-surface-variant hover:bg-surface-container dark:hover:bg-surface-container-high transition-colors rounded-full active:scale-95 duration-100">
<span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 0;">menu</span>
</button>
<h1 class="font-headline-md text-headline-md-mobile md:text-headline-md font-bold text-primary dark:text-primary-fixed-dim text-center flex-1">QuickServe POS</h1>
<button class="flex items-center justify-center min-w-[44px] min-h-[44px] text-on-surface-variant hover:bg-surface-container dark:hover:bg-surface-container-high transition-colors rounded-full active:scale-95 duration-100 relative">
<span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 0;">notifications</span>
<span class="absolute top-2 right-2 w-2 h-2 bg-error rounded-full"></span>
</button>
</div>
</header>
<!-- Main Content -->
<main class="flex-1 w-full max-w-[1440px] mx-auto px-gutter-mobile md:px-gutter-desktop py-lg pb-32">
<!-- Dashboard Header & Stats (Bento-style) -->
<div class="mb-lg space-y-md">
<h2 class="font-headline-lg-mobile md:font-headline-lg text-headline-lg-mobile md:text-headline-lg text-on-surface">Manajemen Pesanan</h2>
<div class="grid grid-cols-2 md:grid-cols-4 gap-sm">
<div class="bg-surface-container-lowest border border-outline-variant rounded-xl p-md flex flex-col justify-between hover:border-primary transition-colors cursor-pointer">
<span class="font-label-md text-label-md text-on-surface-variant">Menunggu</span>
<div class="flex items-end justify-between mt-xs">
<span class="font-display-lg text-display-lg text-primary">12</span>
<span class="material-symbols-outlined text-surface-tint">pending_actions</span>
</div>
</div>
<div class="bg-surface-container-lowest border border-outline-variant rounded-xl p-md flex flex-col justify-between hover:border-primary transition-colors cursor-pointer">
<span class="font-label-md text-label-md text-on-surface-variant">Diproses</span>
<div class="flex items-end justify-between mt-xs">
<span class="font-display-lg text-display-lg text-on-surface">5</span>
<span class="material-symbols-outlined text-secondary">skillet</span>
</div>
</div>
<div class="bg-surface-container-lowest border border-outline-variant rounded-xl p-md flex flex-col justify-between hover:border-primary transition-colors cursor-pointer hidden md:flex">
<span class="font-label-md text-label-md text-on-surface-variant">Selesai Hari Ini</span>
<div class="flex items-end justify-between mt-xs">
<span class="font-display-lg text-display-lg text-on-surface">48</span>
<span class="material-symbols-outlined text-primary-fixed-dim">check_circle</span>
</div>
</div>
<div class="bg-surface-container-lowest border border-outline-variant rounded-xl p-md flex flex-col justify-between hover:border-primary transition-colors cursor-pointer hidden md:flex">
<span class="font-label-md text-label-md text-on-surface-variant">Total Pendapatan</span>
<div class="flex items-end justify-between mt-xs">
<span class="font-title-lg text-title-lg text-on-surface">Rp 4.2M</span>
<span class="material-symbols-outlined text-primary">payments</span>
</div>
</div>
</div>
</div>
<!-- Order List Grid -->
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-md">
<!-- Card: Pending -->
<article class="bg-surface-container-lowest border border-outline-variant rounded-xl p-md flex flex-col gap-sm hover:shadow-level-2 transition-shadow">
<div class="flex justify-between items-start border-b border-surface-variant pb-xs">
<div>
<span class="font-label-sm text-label-sm text-on-surface-variant uppercase tracking-wider">#ORD-9021</span>
<h3 class="font-title-lg text-title-lg text-on-surface mt-1">Budi Santoso</h3>
</div>
<div class="bg-surface-variant text-on-surface-variant font-label-sm text-label-sm px-2 py-1 rounded-full flex items-center gap-1">
<span class="material-symbols-outlined text-[14px]">schedule</span>
                        Menunggu
                    </div>
</div>
<div class="flex-1 py-xs space-y-1">
<div class="flex justify-between font-body-md text-body-md text-on-surface">
<span>2x Nasi Goreng Spesial</span>
<span>Rp 70.000</span>
</div>
<div class="flex justify-between font-body-md text-body-md text-on-surface">
<span>1x Es Teh Manis</span>
<span>Rp 10.000</span>
</div>
<p class="font-label-sm text-label-sm text-on-surface-variant mt-2 italic flex gap-1 items-start">
<span class="material-symbols-outlined text-[14px]">speaker_notes</span>
                        Catatan: Pedas sedang, jangan pakai acar.
                    </p>
</div>
<div class="border-t border-surface-variant pt-sm mt-auto">
<div class="flex justify-between items-center mb-md">
<span class="font-label-md text-label-md text-on-surface-variant">Total Harga</span>
<span class="font-title-lg text-title-lg text-primary">Rp 80.000</span>
</div>
<div class="flex gap-2">
<button class="flex-1 border border-error text-error font-label-md text-label-md py-2 rounded-lg hover:bg-error-container transition-colors min-h-[44px]">Tolak</button>
<button class="flex-[2] bg-primary text-on-primary font-label-md text-label-md py-2 rounded-lg hover:bg-primary-container transition-colors min-h-[44px] shadow-sm">Terima Pesanan</button>
</div>
</div>
</article>
<!-- Card: Processing -->
<article class="bg-surface-container-lowest border-2 border-primary rounded-xl p-md flex flex-col gap-sm shadow-level-2 relative overflow-hidden">
<!-- Subtle background accent for active processing -->
<div class="absolute top-0 right-0 w-32 h-32 bg-primary-container opacity-10 rounded-bl-full -z-10"></div>
<div class="flex justify-between items-start border-b border-surface-variant pb-xs">
<div>
<span class="font-label-sm text-label-sm text-on-surface-variant uppercase tracking-wider">#ORD-9018</span>
<h3 class="font-title-lg text-title-lg text-on-surface mt-1">Siti Aminah</h3>
</div>
<div class="bg-secondary-container text-on-secondary-container font-label-sm text-label-sm px-2 py-1 rounded-full flex items-center gap-1">
<span class="material-symbols-outlined text-[14px] animate-spin">sync</span>
                        Diproses
                    </div>
</div>
<div class="flex-1 py-xs space-y-1">
<div class="flex justify-between font-body-md text-body-md text-on-surface">
<span>1x Ayam Bakar Madu</span>
<span>Rp 45.000</span>
</div>
<div class="flex justify-between font-body-md text-body-md text-on-surface">
<span>1x Jus Alpukat</span>
<span>Rp 20.000</span>
</div>
</div>
<div class="border-t border-surface-variant pt-sm mt-auto">
<div class="flex justify-between items-center mb-md">
<span class="font-label-md text-label-md text-on-surface-variant">Total Harga</span>
<span class="font-title-lg text-title-lg text-primary">Rp 65.000</span>
</div>
<div class="flex gap-2">
<button class="w-full bg-primary-fixed text-on-primary-fixed font-label-md text-label-md py-2 rounded-lg hover:bg-inverse-primary transition-colors min-h-[44px] font-semibold">Tandai Selesai</button>
</div>
</div>
</article>
<!-- Card: Completed -->
<article class="bg-surface-container-lowest border border-outline-variant rounded-xl p-md flex flex-col gap-sm opacity-80 hover:opacity-100 transition-opacity">
<div class="flex justify-between items-start border-b border-surface-variant pb-xs">
<div>
<span class="font-label-sm text-label-sm text-on-surface-variant uppercase tracking-wider">#ORD-9010</span>
<h3 class="font-title-lg text-title-lg text-on-surface mt-1">Andi Pratama</h3>
</div>
<div class="bg-primary text-on-primary font-label-sm text-label-sm px-2 py-1 rounded-full flex items-center gap-1">
<span class="material-symbols-outlined text-[14px]">done_all</span>
                        Selesai
                    </div>
</div>
<div class="flex-1 py-xs space-y-1">
<div class="flex justify-between font-body-md text-body-md text-on-surface">
<span class="text-on-surface-variant">3x Mie Goreng Jawa</span>
<span class="text-on-surface-variant">Rp 90.000</span>
</div>
</div>
<div class="border-t border-surface-variant pt-sm mt-auto">
<div class="flex justify-between items-center mb-md">
<span class="font-label-md text-label-md text-on-surface-variant">Total Harga</span>
<span class="font-title-lg text-title-lg text-on-surface-variant">Rp 90.000</span>
</div>
<div class="flex gap-2">
<button class="w-full border border-outline-variant text-on-surface font-label-md text-label-md py-2 rounded-lg hover:bg-surface-container transition-colors min-h-[44px]">Cetak Struk</button>
</div>
</div>
</article>
</div>
</main>
<!-- BottomNavBar -->
<nav class="fixed bottom-0 w-full z-50 bg-surface-container-lowest dark:bg-surface-container-low border-t border-outline-variant dark:border-outline md:hidden">
<div class="flex justify-around items-center h-20 w-full pb-safe">
<!-- Inactive: Register -->
<button class="flex flex-col items-center justify-center text-on-surface-variant dark:text-outline-variant px-4 py-1 hover:text-primary dark:hover:text-primary-fixed-dim active:opacity-80 transition-opacity min-w-[44px] min-h-[44px]">
<span class="material-symbols-outlined mb-1" style="font-variation-settings: 'FILL' 0;">point_of_sale</span>
<span class="font-label-sm text-label-sm">Register</span>
</button>
<!-- Active: Orders -->
<button class="flex flex-col items-center justify-center bg-primary-container text-on-primary-container rounded-full px-4 py-1 active:opacity-80 transition-opacity min-w-[44px] min-h-[44px]">
<span class="material-symbols-outlined mb-1" style="font-variation-settings: 'FILL' 1;">receipt_long</span>
<span class="font-label-sm text-label-sm">Orders</span>
</button>
<!-- Inactive: Admin -->
<button class="flex flex-col items-center justify-center text-on-surface-variant dark:text-outline-variant px-4 py-1 hover:text-primary dark:hover:text-primary-fixed-dim active:opacity-80 transition-opacity min-w-[44px] min-h-[44px]">
<span class="material-symbols-outlined mb-1" style="font-variation-settings: 'FILL' 0;">dashboard</span>
<span class="font-label-sm text-label-sm">Admin</span>
</button>
<!-- Inactive: Items -->
<button class="flex flex-col items-center justify-center text-on-surface-variant dark:text-outline-variant px-4 py-1 hover:text-primary dark:hover:text-primary-fixed-dim active:opacity-80 transition-opacity min-w-[44px] min-h-[44px]">
<span class="material-symbols-outlined mb-1" style="font-variation-settings: 'FILL' 0;">inventory_2</span>
<span class="font-label-sm text-label-sm">Items</span>
</button>
</div>
</nav>
</body></html>

<!-- Manajemen Produk -->
<!DOCTYPE html>

<html class="light" lang="id"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover" name="viewport"/>
<title>QuickServe POS - Kasir</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "surface-container": "#ffe9e3",
                        "on-tertiary-container": "#ff5f31",
                        "inverse-on-surface": "#ffede8",
                        "background": "#fff8f6",
                        "outline": "#827472",
                        "on-primary-fixed-variant": "#5b403c",
                        "on-primary-fixed": "#2b1613",
                        "inverse-primary": "#e3beb8",
                        "on-surface-variant": "#504442",
                        "primary-fixed": "#ffdad4",
                        "tertiary-fixed-dim": "#ffb5a0",
                        "on-tertiary-fixed-variant": "#872000",
                        "on-secondary": "#ffffff",
                        "surface": "#fff8f6",
                        "on-error-container": "#93000a",
                        "on-primary": "#ffffff",
                        "on-surface": "#2c160e",
                        "outline-variant": "#d3c3c0",
                        "primary-container": "#3e2723",
                        "on-primary-container": "#ae8d87",
                        "secondary": "#655d4f",
                        "surface-variant": "#ffdbd0",
                        "tertiary-fixed": "#ffdbd1",
                        "error-container": "#ffdad6",
                        "surface-bright": "#fff8f6",
                        "surface-container-highest": "#ffdbd0",
                        "primary": "#271310",
                        "secondary-fixed-dim": "#d0c5b3",
                        "on-tertiary-fixed": "#3b0900",
                        "surface-container-lowest": "#ffffff",
                        "surface-tint": "#745853",
                        "primary-fixed-dim": "#e3beb8",
                        "on-tertiary": "#ffffff",
                        "tertiary": "#360700",
                        "inverse-surface": "#442a22",
                        "on-background": "#2c160e",
                        "on-secondary-fixed": "#201b10",
                        "on-secondary-fixed-variant": "#4d4638",
                        "secondary-container": "#eadecc",
                        "error": "#ba1a1a",
                        "secondary-fixed": "#ede1cf",
                        "on-secondary-container": "#6a6253",
                        "tertiary-container": "#5a1200",
                        "on-error": "#ffffff",
                        "surface-container-high": "#ffe2da",
                        "surface-container-low": "#fff1ed",
                        "surface-dim": "#fbd1c4"
                    },
                    "borderRadius": {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                    "spacing": {
                        "lg": "24px",
                        "md": "16px",
                        "xl": "32px",
                        "xs": "4px",
                        "base": "8px",
                        "gutter-desktop": "24px",
                        "gutter-mobile": "16px",
                        "touch-target": "44px",
                        "sm": "12px"
                    },
                    "fontFamily": {
                        "headline-md": ["Inter"],
                        "title-lg": ["Inter"],
                        "display-lg": ["Inter"],
                        "body-lg": ["Inter"],
                        "headline-lg-mobile": ["Inter"],
                        "body-md": ["Inter"],
                        "label-sm": ["Inter"],
                        "headline-lg": ["Inter"],
                        "label-md": ["Inter"]
                    },
                    "fontSize": {
                        "headline-md": ["24px", { "lineHeight": "32px", "fontWeight": "600" }],
                        "title-lg": ["20px", { "lineHeight": "28px", "fontWeight": "600" }],
                        "display-lg": ["48px", { "lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "700" }],
                        "body-lg": ["18px", { "lineHeight": "28px", "fontWeight": "400" }],
                        "headline-lg-mobile": ["24px", { "lineHeight": "32px", "fontWeight": "600" }],
                        "body-md": ["16px", { "lineHeight": "24px", "fontWeight": "400" }],
                        "label-sm": ["12px", { "lineHeight": "16px", "fontWeight": "600" }],
                        "headline-lg": ["32px", { "lineHeight": "40px", "letterSpacing": "-0.01em", "fontWeight": "600" }],
                        "label-md": ["14px", { "lineHeight": "20px", "letterSpacing": "0.01em", "fontWeight": "500" }]
                    }
                }
            }
        }
    </script>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .material-symbols-outlined.fill {
            font-variation-settings: 'FILL' 1;
        }
        
        /* Hide scrollbar for clean UI */
        .no-scrollbar::-webkit-scrollbar {
            display: none;
        }
        .no-scrollbar {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }
        
        /* Safe area padding for bottom nav */
        .pb-safe {
            padding-bottom: env(safe-area-inset-bottom, 20px);
        }
    </style>
<style>
    body {
      min-height: max(884px, 100dvh);
    }
  </style>
</head>
<body class="bg-background text-on-background antialiased min-h-screen flex flex-col md:hidden">
<!-- TopAppBar from JSON -->
<header class="bg-surface text-primary font-headline-md text-headline-md-mobile w-full top-0 sticky border-b border-outline-variant flex justify-between items-center px-gutter-mobile h-14 w-full z-50">
<button class="flex items-center justify-center w-touch-target h-touch-target active:scale-95 transition-transform duration-100 hover:bg-surface-container transition-colors rounded-full text-on-surface-variant">
<span class="material-symbols-outlined" data-icon="menu">menu</span>
</button>
<div class="font-headline-md text-headline-md-mobile font-bold text-primary">
            QuickServe POS
        </div>
<button class="flex items-center justify-center w-touch-target h-touch-target active:scale-95 transition-transform duration-100 hover:bg-surface-container transition-colors rounded-full text-on-surface-variant">
<span class="material-symbols-outlined" data-icon="notifications">notifications</span>
</button>
</header>
<!-- Main Content Canvas -->
<main class="flex-1 overflow-y-auto no-scrollbar pb-[180px]">
<!-- Search & Filter Area -->
<div class="px-gutter-mobile py-md bg-surface sticky top-0 z-40 shadow-[0_4px_10px_-10px_rgba(0,0,0,0.1)]">
<div class="relative w-full">
<span class="material-symbols-outlined absolute left-sm top-1/2 transform -translate-y-1/2 text-outline">search</span>
<input class="w-full bg-surface-container-highest border border-outline-variant text-on-surface font-body-md text-body-md rounded-lg pl-[40px] pr-sm py-sm focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary transition-colors min-h-[44px]" placeholder="Cari produk..." type="text"/>
</div>
<!-- Category Chips -->
<div class="flex overflow-x-auto no-scrollbar gap-base mt-md pb-xs">
<button class="whitespace-nowrap px-md py-base rounded-full bg-primary text-on-primary font-label-md text-label-md border border-primary min-h-[44px] active:scale-95 transition-transform">
                    Semua
                </button>
<button class="whitespace-nowrap px-md py-base rounded-full bg-surface-container-lowest text-on-surface-variant font-label-md text-label-md border border-outline-variant min-h-[44px] active:scale-95 transition-transform">
                    Makanan
                </button>
<button class="whitespace-nowrap px-md py-base rounded-full bg-surface-container-lowest text-on-surface-variant font-label-md text-label-md border border-outline-variant min-h-[44px] active:scale-95 transition-transform">
                    Minuman
                </button>
<button class="whitespace-nowrap px-md py-base rounded-full bg-surface-container-lowest text-on-surface-variant font-label-md text-label-md border border-outline-variant min-h-[44px] active:scale-95 transition-transform">
                    Cemilan
                </button>
</div>
</div>
<!-- Product Grid -->
<div class="p-gutter-mobile grid grid-cols-2 gap-md">
<!-- Product Card 1 -->
<div class="bg-surface-container-lowest rounded-lg border border-outline-variant overflow-hidden flex flex-col relative active:scale-[0.98] transition-transform" onclick="toggleSelection(this)">
<div class="h-24 bg-surface-variant relative">
<img alt="Burger" class="w-full h-full object-cover" data-alt="A perfectly constructed, appetizing classic beef burger presented in a well-lit, modern quick-service restaurant environment. The light-mode aesthetic features clean whites and soft grey tones in the background, allowing the rich colors of the fresh lettuce, bright red tomato, and perfectly grilled meat to stand out vividly. The overall atmosphere is energetic, clean, and professional, characteristic of a high-end fast-casual retail POS display." src="https://lh3.googleusercontent.com/aida-public/AB6AXuDOvR4_RcWi_yOUM9nhfW0bDH28VOy7vP3uRm_1v73LH2vWs5eAIcWzLMuSwYExhYySwuCbnc0WU0GDCUzQEw8tBeKAgQzNNcmwFGfUeQKymuw-j79vfqBy8MTbyvdW5BmnjfCy39gsU4wJhqnROlWvUhIZ3tva8Jwc5EPvjXuxwSYBL9W-JK4ZkQQWbhLDG0aMjp-DM4nM5sbvOk_wUvpA_q7jpKBcyzy-msY6jtalm_r3D7Y_zNLxT7Ybi9V7rpgJE_dglLGGmzQ"/>
</div>
<div class="p-sm flex flex-col flex-1">
<h3 class="font-title-lg text-title-lg text-on-surface line-clamp-1 mb-xs">Classic Burger</h3>
<p class="font-body-md text-body-md text-on-surface-variant line-clamp-1">Daging sapi, keju</p>
<div class="mt-auto pt-sm flex justify-between items-center">
<span class="font-headline-md text-headline-md-mobile text-primary">Rp 45k</span>
<button class="w-8 h-8 rounded-full bg-primary-container text-on-primary-container flex items-center justify-center">
<span class="material-symbols-outlined text-[18px]" data-icon="add">add</span>
</button>
</div>
</div>
</div>
<!-- Product Card 2 -->
<div class="bg-surface-container-lowest rounded-lg border-2 border-primary overflow-hidden flex flex-col relative active:scale-[0.98] transition-transform">
<div class="absolute top-xs right-xs bg-primary text-on-primary w-6 h-6 rounded-full flex items-center justify-center font-label-sm text-label-sm z-10">2</div>
<div class="h-24 bg-surface-variant relative">
<img alt="Fries" class="w-full h-full object-cover" data-alt="A generous portion of golden, crispy French fries served in a simple, elegant container, captured in a brightly lit, modern corporate retail setting. The light-mode visual style emphasizes clarity and freshness, with a subtle depth provided by soft ambient shadows. The background is a clean, neutral surface that directs focus entirely to the appetizing texture and color of the fries, ideal for a fast-paced point-of-sale interface." src="https://lh3.googleusercontent.com/aida-public/AB6AXuAY3uGnpON8cSjN__B7Spz-U88c3uy_8pf3qtNvnT4-QeE4ff3NUTSu7P9BTMURuHIemJVh6behNUUPUN_B9qKG9gbyGvAqDVQTNFuhiTq4sLDJD_5z96aSemqTGQKlmKyUiwLu8Uonw3hN_96PwQ19yFHJVjbme3iMOOPa6MSmuV46smEbh4t5KxkUBhmYRtXDRBW0GZKwV74XPcB8Eoqv5xVRUAU3ifjWg62TH5ENDnxdbeFJgw1i9WJrueQdpqEOjjiwSre3v18"/>
</div>
<div class="p-sm flex flex-col flex-1">
<h3 class="font-title-lg text-title-lg text-on-surface line-clamp-1 mb-xs">Kentang Goreng</h3>
<p class="font-body-md text-body-md text-on-surface-variant line-clamp-1">Renyah &amp; gurih</p>
<div class="mt-auto pt-sm flex justify-between items-center">
<span class="font-headline-md text-headline-md-mobile text-primary">Rp 25k</span>
<div class="flex items-center gap-xs">
<button class="w-8 h-8 rounded-full bg-surface-variant text-on-surface flex items-center justify-center">
<span class="material-symbols-outlined text-[18px]" data-icon="remove">remove</span>
</button>
<span class="font-label-md text-label-md px-1">2</span>
<button class="w-8 h-8 rounded-full bg-primary-container text-on-primary-container flex items-center justify-center">
<span class="material-symbols-outlined text-[18px]" data-icon="add">add</span>
</button>
</div>
</div>
</div>
</div>
<!-- Product Card 3 -->
<div class="bg-surface-container-lowest rounded-lg border border-outline-variant overflow-hidden flex flex-col relative active:scale-[0.98] transition-transform">
<div class="h-24 bg-surface-variant relative">
<img alt="Cola" class="w-full h-full object-cover" data-alt="A refreshing, ice-cold glass of dark cola with condensation beading on the exterior, photographed against a minimalist, bright, and airy background. The lighting is crisp and even, reflecting a clean, corporate modern light-mode design language. The sharp contrast between the dark beverage and the pristine setting creates a highly appealing, professional look tailored for quick-service digital menus." src="https://lh3.googleusercontent.com/aida-public/AB6AXuA5J1DtyzfIUN43P56DeQxgXoFK67W3Tg9QfaH9JT60ThdtjNi7rCpvoEPTdsLwNLXOkEZQkF8o83qwS1FrXM3oWcTWEdnPOb0YQ5XWZetfoeOQg8Tyu1xPaPeUdHnOyFdPz9oJ1VBvbm39a9-L4ph1rlIoyjxFZRuqi5bXzXv-vyRqyzc6xdqz0dR2YFk-OnSrhoOVkCZLfwfR6dRx1SiAQHi7fc9wiu0-rJGgV9RViuhshRPAZFqvOL2l8vILl4gucOhZbEdV7EU"/>
</div>
<div class="p-sm flex flex-col flex-1">
<h3 class="font-title-lg text-title-lg text-on-surface line-clamp-1 mb-xs">Es Cola</h3>
<p class="font-body-md text-body-md text-on-surface-variant line-clamp-1">Dingin, Reguler</p>
<div class="mt-auto pt-sm flex justify-between items-center">
<span class="font-headline-md text-headline-md-mobile text-primary">Rp 15k</span>
<button class="w-8 h-8 rounded-full bg-primary-container text-on-primary-container flex items-center justify-center">
<span class="material-symbols-outlined text-[18px]" data-icon="add">add</span>
</button>
</div>
</div>
</div>
<!-- Product Card 4 -->
<div class="bg-surface-container-lowest rounded-lg border border-outline-variant overflow-hidden flex flex-col relative active:scale-[0.98] transition-transform">
<div class="h-24 bg-surface-variant relative">
<img alt="Iced Tea" class="w-full h-full object-cover" data-alt="A tall glass of clear, amber iced tea garnished with a fresh lemon slice, sitting in a stark, clean, light-mode environment. The lighting is diffused and bright, creating a serene, highly legible aesthetic characteristic of modern POS systems. The lack of visual clutter in the background emphasizes the crispness and refreshing quality of the drink, perfectly aligned with an efficient retail brand identity." src="https://lh3.googleusercontent.com/aida-public/AB6AXuCOlig_SCzuu2ZmmuEs53m2WeOd6g5kWYK-OaXJG--rNNrpO1XyaOrgoCQ1DyrNlXz-IjR6EK5hVuYdJ3QmOQNJCrfpfPuVzzkrWthzQ8CGJB3MpNkfVDJGEDZmegyb92tC_JZJgfl1flewU-ruyzGFw0AdvZ9i51EOcDeipix76JPjYKwec8l608YJqusb74zwXt3qq3zv_04GNFjV_Hl2OT-9PyajCWzUJ-T3hF_5i0yXzyRoQXZPjSxmnFhhovKL3sgrJ-kqfAU"/>
</div>
<div class="p-sm flex flex-col flex-1">
<h3 class="font-title-lg text-title-lg text-on-surface line-clamp-1 mb-xs">Es Teh Manis</h3>
<p class="font-body-md text-body-md text-on-surface-variant line-clamp-1">Teh melati</p>
<div class="mt-auto pt-sm flex justify-between items-center">
<span class="font-headline-md text-headline-md-mobile text-primary">Rp 10k</span>
<button class="w-8 h-8 rounded-full bg-primary-container text-on-primary-container flex items-center justify-center">
<span class="material-symbols-outlined text-[18px]" data-icon="add">add</span>
</button>
</div>
</div>
</div>
</div>
</main>
<!-- Shopping Cart Summary Panel (Sticky above Bottom Nav) -->
<div class="fixed bottom-[80px] w-full bg-surface-container-lowest z-40 rounded-t-xl shadow-[0_-10px_15px_-3px_rgba(0,0,0,0.1)] border-t border-outline-variant px-gutter-mobile py-md">
<div class="flex justify-between items-center mb-sm">
<div class="flex items-center gap-base">
<span class="material-symbols-outlined text-on-surface-variant" data-icon="shopping_basket">shopping_basket</span>
<span class="font-title-lg text-title-lg text-on-surface">2 Item</span>
</div>
<span class="font-headline-md text-headline-md-mobile text-on-surface font-bold">Rp 50.000</span>
</div>
<button class="w-full bg-primary text-on-primary font-title-lg text-title-lg rounded-lg py-sm min-h-[44px] flex justify-center items-center active:scale-[0.98] transition-transform">
            Bayar Sekarang
        </button>
</div>
<!-- BottomNavBar from JSON -->
<nav class="bg-surface-container-lowest text-primary font-label-sm text-label-sm fixed bottom-0 w-full z-50 shadow-sm flex justify-around items-center h-20 w-full pb-safe">
<div class="flex flex-col items-center justify-center bg-primary-container text-on-primary-container rounded-full px-4 py-1">
<span class="material-symbols-outlined fill" data-icon="point_of_sale" data-weight="fill">point_of_sale</span>
<span>Register</span>
</div>
<div class="flex flex-col items-center justify-center text-on-surface-variant px-4 py-1 hover:text-primary active:opacity-80 transition-opacity">
<span class="material-symbols-outlined" data-icon="receipt_long">receipt_long</span>
<span>Orders</span>
</div>
<div class="flex flex-col items-center justify-center text-on-surface-variant px-4 py-1 hover:text-primary active:opacity-80 transition-opacity">
<span class="material-symbols-outlined" data-icon="dashboard">dashboard</span>
<span>Admin</span>
</div>
<div class="flex flex-col items-center justify-center text-on-surface-variant px-4 py-1 hover:text-primary active:opacity-80 transition-opacity">
<span class="material-symbols-outlined" data-icon="inventory_2">inventory_2</span>
<span>Items</span>
</div>
</nav>
<script>
        function toggleSelection(element) {
            // Simple visual toggle for demonstration
            if(element.classList.contains('border-outline-variant')) {
                element.classList.remove('border-outline-variant');
                element.classList.add('border-primary', 'border-2');
                
                // Add a mock quantity badge
                const badge = document.createElement('div');
                badge.className = 'absolute top-xs right-xs bg-primary text-on-primary w-6 h-6 rounded-full flex items-center justify-center font-label-sm text-label-sm z-10 badge-mark';
                badge.textContent = '1';
                element.appendChild(badge);
            } else {
                element.classList.add('border-outline-variant');
                element.classList.remove('border-primary', 'border-2');
                const badge = element.querySelector('.badge-mark');
                if(badge) badge.remove();
            }
        }
    </script>
</body></html>
