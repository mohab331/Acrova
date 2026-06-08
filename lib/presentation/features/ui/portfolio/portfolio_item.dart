class PortfolioItem {
  const PortfolioItem({
    required this.id,
    required this.style,
    required this.category,
    required this.title,
    required this.location,
    required this.area,
    required this.floors,
    required this.narrative,
    required this.imageUrls,
    required this.features,
     this.walkthroughVideo,
  });

  final String id;
  final String style;

  /// Matches _Filter enum names: 'exterior', 'modern', 'traditional', 'interior'
  final String category;
  final String title;
  final String location;
  final String area;
  final String floors;
  final String narrative;
  final List<String> imageUrls;
  final List<String> features;

  final String? walkthroughVideo;

  static const List<PortfolioItem> mockItems = [
    PortfolioItem(
      id: 'grand_residence',
      style: 'Neoclassicism',
      category: 'exterior',
      title: 'The Grand Residence',
      location: 'Jeddah',
      area: '620 sqm',
      floors: '3 Floors',
      narrative:
          'A sweeping neoclassical estate that draws on European grand-villa proportions while embracing the Saudi climate. Symmetrical colonnades frame a central porte-cochère, and hand-carved stone detailing flows through every facade elevation.',
      imageUrls: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAGNrH52huyQGEWIQKQDVt92V2iuZo5qfnXAZK9FoC3dzU0Y9NILlAN4FFLdIMcVnyP-G_iZ3RN3xrBhEJdOtMWcWap7toLFJHebSsfzYogzatTwl9D8swWRLXNDOzxKSLX3LjCSFvZX2VEU9uIRFBCfgKVBMCJlQQ6syNRJFiVOXkAlRuCZY7suJqiJ63eQ4m3ucqA8bkltfduLosOXBLwvUOXEfRK0pzy_vAluc6ZWsx_yjGvny4xtx2kQaHb3f-6dMOiNmzTapY',
      ],
      features: ['Grand Foyer', 'Colonnade Facade', 'Formal Gardens', 'Smart Lighting'], walkthroughVideo: 'https://samplelib.com/mp4/sample-5s.mp4',
    ),
    PortfolioItem(
      walkthroughVideo: 'https://samplelib.com/mp4/sample-5s.mp4',
      id: 'alrashidi',
      style: 'Contemporary Arabic',
      category: 'exterior',
      title: 'The Al-Rashidi Residence',
      location: 'Riyadh',
      area: '450 sqm',
      floors: '4 Floors',
      narrative:
          'A grand contemporary Arabic estate featuring carved stone facades and a central courtyard. The architectural narrative seamlessly blends traditional elements with a modern, minimalist spatial philosophy.',
      imageUrls: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBjZBYbSIxfI4qVARxNKv2jJBKCQoXan-O-f3iKjlkk2JtQ2xcLxA-oVm47pp5ruvu4SnFItwbxAkL0QVW-LgY9N7OKmfVodtJrWxAZfAtDVfscwo5OzTEsbBGJ94qvIg7bklMe-4lskjLJ48v0WCLzoMszdKvupIrMzXqF37mWbkkPrXbxzTu7zN4r3OTksusadozSdwgVxYZ8flatVpFwdntFP-7-Q8SsMQKjDJSoq_K3g_nMTDcVXI45fRiR7fTu_Xf0pN9WX6k',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCQcpT-DWz3pj2RjZAHEIJ_jdLkW35Y4LTSQBRuJB0R2FYbX0E49CRJY8rSDSIidxDVooqqFy3OmTAct3QGNf33MCNBcRQSBi-K3rPUbBUe4AMkkj8vMiO-tcWQc4G_vQStpheSV5_NeuvrRr4bg2l4gL9GtNnokLkQs5fUPEOe0OeHjscyilvnsLKQ8mtkKgMGM43JnqvcR96c3u_DVtXd1XGdRlZBJnPNqXJeloL6yedXKazRRRj268SCBk7doMmTLOuHJl41W2I',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAiDtXDeqy4dyOHfaGsSExoqB30G9El5RSlPSoHYL8LQrAs-ojd_nXWhmIDhApQcAdsEQZaY8RrNWjkaeii9o1ZbavTMt8TOtSoYPbSQPSOg7sh1IWEg_Koywx2r0iUBM9evWE-90ToK4tAGhJzvU6DwczTptC-kCsCOUFNcj4dArDB0Vq7qnXdCqAHW59foclC0Z95ghOyXslRF9Bx6aeZPziql14ziMYE1NN9IQe7erVsmHLOGe52s7hEeCMknpXtMDazHEmXJ1k',
      ],
      features: [
        'Majlis',
        'Reflecting Pool',
        'Carved Stone Facades',
        'Central Courtyard',
        'Smart Home Ready',
      ],
    ),
    PortfolioItem(
      id: 'glass_villa',
      style: 'Modernism',
      category: 'modern',
      title: 'Glass Villa',
      location: 'Khobar',
      area: '380 sqm',
      floors: '2 Floors',
      narrative:
          'A minimalist glass and steel villa where interior space dissolves into the surrounding landscape. Floor-to-ceiling glazing on all primary elevations captures the horizon at every moment of the day.',
      imageUrls: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDs86ukcNSgT6YjaCHXIqqQKwqshqFQ0Kg6eJwcJ6X_j5dU84cc_NNlj4phD3fHKqSyctyQK5Q5tjaHC7gBr6p6l7EOjLSTBRFLAvLcWX6IJ_MBMLfrG8-iMCxukKPuRBZNHggSTkltCUdPCePjWp5HMv6nhG_RP6Pp14Lb_2gZl13WuMybXohXVUEsvgkwuQdTVw4t4efI-86hK9iQ2cqf7yUoxucei_mjGtTCObKZFja88hIsmriE_Gbm7aOVk28FBftwnNXruaE',
      ],
      features: ['Floor-to-Ceiling Glazing', 'Infinity Pool', 'Open Plan Living', 'Solar Canopy'],
    ),
    PortfolioItem(
      id: 'al_omran',
      style: 'Traditional',
      category: 'traditional',
      title: 'Al-Omran',
      location: 'Diriyah',
      area: '520 sqm',
      floors: '3 Floors',
      narrative:
          'Rooted in the heritage of Najdi architecture, this residence uses rammed-earth walls and wind-catcher towers to create a home that breathes with the desert rather than against it.',
      imageUrls: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDto-w6kvwsI101UCMMIFGL9Z4Z4om0E5-s8fcgHqHP0GgBxDAfF7m9JpGOvhpaZTVcUouOgdEGrVjbK9Xni9B_sT11-_2sAtokJJaIpAwS727ek6d5MymD_ZBTi2gJny_5hXIoUEhkUcVqSEYRP7k8KPhin7rEQi34zaspyQuPh2-5hVgdOz0XTrdSf5M-H4Q5ZEHKP1CYknhuettYTCaoZbN4ivNFZD9W5FaWDCIh1fbof9KdxNzz6Ir0LXbnmUqajZV3qE8HyuU',
      ],
      features: [
        'Rammed-Earth Walls',
        'Wind-Catcher Towers',
        'Shaded Courtyard',
        'Traditional Mashrabiya',
      ],
    ),
    PortfolioItem(
      id: 'the_majlis',
      style: 'Interior',
      category: 'interior',
      title: 'The Majlis',
      location: 'Riyadh',
      area: '210 sqm',
      floors: '1 Floor',
      narrative:
          'A dedicated reception majlis conceived as a theatre of hospitality. Arched niches, hand-painted plaster ceilings, and layered textiles create an environment that honours guests with quiet grandeur.',
      imageUrls: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCL3hMUFQKigsK2NjEQmac2mm2U1b28oQFOpdaYAWTN97bZrdQNBVPjzLhajNtLQav7gTgq4g6jj5uGBFLoBRwGkS5Ou-imElEjncF5ajr23dHQfaCj4R13eg2gefMm1-nhlQd7y2A1SLkkj9WeYhkBxm71-zkS2I2Ho6ESgnBG26e9-03QhJtaALvra1ribj4b95DHelKa36Y5ukLgc8iUuJDpDLESB39W9bTlcmj1gL2ZTDx5ma0T47uelGynbHiGjptRFKqJDz0',
      ],
      features: ['Arched Niches', 'Hand-Painted Ceilings', 'Custom Textiles', 'Ambient Lighting'],
    ),
    PortfolioItem(
      id: 'desert_pavilion',
      style: 'Exterior',
      category: 'exterior',
      title: 'Desert Pavilion',
      location: 'AlUla',
      area: '290 sqm',
      floors: '1 Floor',
      narrative:
          'A single-storey pavilion that rises from the sandstone landscape of AlUla. Long horizontal lines echo the plateau horizons, and deep overhangs shield interior spaces from the full intensity of the desert sun.',
      imageUrls: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAD_YC3-NAPtdaYzhVv8kQZVATUQE1Zy-FIvyG3ErZoYsCLOCparvVZou_hv56ikseYcpHBOC1Ajry47VDgh7Kh7qSjGG5vsQXI0Vddb8k3Ujllkc7BZBqkv80M-9Y9iL5ezJOd1MBdOG6SbSKrD6snlb-_oxhcnIhY4sEjb6kfyU12JCvHzMKTQUxroumDOa7C8UzmGuYk2Hxr3CDJatGibZpJWJPLJ7KS8UBFRWa_nHHWYo2VEd3_i78Y70mQ0q-8jNVDmtHAOsg',
      ],
      features: ['Deep Overhangs', 'Sandstone Palette', 'Open Terrace', 'Passive Cooling'],
    ),
  ];
}
