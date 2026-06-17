/* eslint-disable */
// Deterministic seed generator for Dwellio's mock REST API.
// Run with: node generate.js   ->   writes db.json
// Re-run any time to regenerate a fresh, realistic dataset.

const fs = require('fs');
const path = require('path');

// --- Deterministic PRNG (mulberry32) so the dataset is stable across runs ---
function mulberry32(seed) {
  return function () {
    seed |= 0;
    seed = (seed + 0x6d2b79f5) | 0;
    let t = Math.imul(seed ^ (seed >>> 15), 1 | seed);
    t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t;
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}
const rnd = mulberry32(20260616);
const pick = (arr) => arr[Math.floor(rnd() * arr.length)];
const between = (min, max) => min + Math.floor(rnd() * (max - min + 1));
const chance = (p) => rnd() < p;

// --- Reference data ----------------------------------------------------------
const propertyTypes = [
  { id: 'apartment', name: 'Apartment', icon: 'apartment' },
  { id: 'house', name: 'House', icon: 'house' },
  { id: 'condo', name: 'Condo', icon: 'domain' },
  { id: 'townhouse', name: 'Townhouse', icon: 'holiday_village' },
  { id: 'studio', name: 'Studio', icon: 'single_bed' },
  { id: 'villa', name: 'Villa', icon: 'villa' },
  { id: 'land', name: 'Land', icon: 'landscape' },
];

const amenities = [
  { id: 'gym', name: 'Gym', icon: 'fitness_center' },
  { id: 'pool', name: 'Pool', icon: 'pool' },
  { id: 'pet_friendly', name: 'Pet Friendly', icon: 'pets' },
  { id: 'elevator', name: 'Elevator', icon: 'elevator' },
  { id: 'parking', name: 'Parking', icon: 'local_parking' },
  { id: 'balcony', name: 'Balcony', icon: 'balcony' },
  { id: 'garden', name: 'Garden', icon: 'yard' },
  { id: 'air_conditioning', name: 'Air Conditioning', icon: 'ac_unit' },
  { id: 'security', name: '24/7 Security', icon: 'security' },
  { id: 'furnished', name: 'Furnished', icon: 'chair' },
  { id: 'wifi', name: 'High-Speed WiFi', icon: 'wifi' },
  { id: 'laundry', name: 'In-unit Laundry', icon: 'local_laundry_service' },
];
const amenityIds = amenities.map((a) => a.id);

const agencies = [
  'Cornerstone Realty', 'Brightside Homes', 'Vista Properties',
  'Anchor & Key', 'Metro Living Group', 'Habita Estates',
];
const firstNames = ['Maria', 'James', 'Sofia', 'Daniel', 'Aisha', 'Lucas', 'Elena', 'Noah'];
const lastNames = ['Reyes', 'Carter', 'Nguyen', 'Okafor', 'Rossi', 'Haddad', 'Sterling', 'Vega'];

const agents = Array.from({ length: 6 }).map((_, i) => {
  const id = `agt_${String(i + 1).padStart(2, '0')}`;
  return {
    id,
    name: `${pick(firstNames)} ${pick(lastNames)}`,
    photo: `https://i.pravatar.cc/300?img=${10 + i}`,
    agency: pick(agencies),
    phone: `+1 (555) ${between(100, 999)}-${between(1000, 9999)}`,
    rating: Math.round((3.8 + rnd() * 1.2) * 10) / 10,
    reviewCount: between(12, 240),
  };
});

// Cities with a center coordinate; listings scatter around these.
const cities = [
  { name: 'CDMX', country: 'MX', lat: 19.4326, lng: -99.1332, currency: 'USD' },
  { name: 'Austin', country: 'US', lat: 30.2672, lng: -97.7431, currency: 'USD' },
  { name: 'Lisbon', country: 'PT', lat: 38.7223, lng: -9.1393, currency: 'USD' },
];

const streets = [
  'Av. Reforma', 'Calle Roma', 'Oak Ridge Blvd', 'Maple Street', 'Rua Augusta',
  'Sunset Terrace', 'Harbor View', 'Pine Hollow', 'Cedar Lane', 'Bloom Avenue',
];

const adjectives = ['Sunlit', 'Modern', 'Cozy', 'Spacious', 'Charming', 'Elegant', 'Bright', 'Stylish'];
const features = ['City Views', 'Garden Patio', 'Open-Plan Kitchen', 'Rooftop Access',
  'Walk-in Closet', 'Hardwood Floors', 'Floor-to-Ceiling Windows', 'Private Balcony'];

// Real property photos (Unsplash CDN, free to hotlink under the Unsplash
// license). Each listing draws several from this pool. `?w=800` keeps them light.
const PHOTO_IDS = [
  '1568605114967-8130f3a36994', // modern house exterior
  '1570129477492-45c003edd2be', // suburban house
  '1512917774080-9991f1c4c750', // white two-storey house
  '1600596542815-ffad4c1539a9', // modern villa
  '1600585154340-be6161a56a0c', // bright living room
  '1600607687939-ce8a6c25118c', // open-plan interior
  '1600566753086-00f18fb6b3ea', // minimalist living room
  '1600210492493-0946911123ea', // bedroom
  '1600047509807-ba8f99d2cdde', // apartment interior
  '1493809842364-78817add7ffb', // cozy living room
  '1502005229762-cf1b2da7c5d6', // modern kitchen
  '1484154218962-a197022b5858', // kitchen
  '1560448204-e02f11c3d0e2',    // apartment building
  '1564013799919-ab600027ffc6', // house with pool
  '1583608205776-bfd35f0d9f83', // contemporary house
  '1576941089067-2de3c901e126', // dining area
  '1505691938895-1758d7feb511', // bright bedroom
  '1556909114-f6e7ad7d3136',    // living room with sofa
  '1502672260266-1c1ef2d93688', // styled interior
  '1554995207-c18c203602cb',    // modern lounge
];

function photoUrl(id) {
  return `https://images.unsplash.com/photo-${id}?auto=format&fit=crop&w=800&q=60`;
}

const descriptions = [
  'Bright corner unit with floor-to-ceiling windows and an open layout perfect for entertaining.',
  'Freshly renovated home in a quiet, walkable neighborhood close to parks and cafés.',
  'Thoughtfully designed space combining comfort and contemporary finishes throughout.',
  'A rare find with generous natural light, smart storage, and a flexible floor plan.',
  'Move-in ready with updated appliances, central air, and a welcoming community.',
];

function makeListing(i) {
  const city = pick(cities);
  const type = pick(propertyTypes);
  const dealType = chance(0.5) ? 'buy' : 'rent';
  const beds = type.id === 'studio' || type.id === 'land' ? 0 : between(1, 5);
  const baths = type.id === 'land' ? 0 : between(1, Math.max(1, beds));
  const areaSqm = type.id === 'land' ? between(200, 1200) : between(38, 320);
  const parking = chance(0.6) ? between(1, 3) : 0;

  const basePrice = dealType === 'rent'
    ? between(700, 6500)
    : between(95000, 1850000);

  const amenitySet = new Set();
  const amenityCount = between(2, 6);
  while (amenitySet.size < amenityCount) amenitySet.add(pick(amenityIds));
  if (parking > 0) amenitySet.add('parking');

  const photoCount = between(3, 6);
  const offset = (i * 3) % PHOTO_IDS.length;
  const photos = Array.from({ length: photoCount }).map(
    (_, p) => photoUrl(PHOTO_IDS[(offset + p) % PHOTO_IDS.length])
  );

  // Scatter within ~0.06 deg (~6km) of the city center.
  const lat = +(city.lat + (rnd() - 0.5) * 0.12).toFixed(6);
  const lng = +(city.lng + (rnd() - 0.5) * 0.12).toFixed(6);

  const month = String(between(1, 6)).padStart(2, '0');
  const day = String(between(1, 28)).padStart(2, '0');

  return {
    id: `lst_${1000 + i}`,
    title: `${pick(adjectives)} ${beds > 0 ? beds + '-Bed ' : ''}${type.name} with ${pick(features)}`,
    dealType,
    price: basePrice,
    currency: city.currency,
    propertyType: type.id,
    beds,
    baths,
    areaSqm,
    parking,
    address: `${pick(streets)} ${between(1, 480)}, ${city.name}`,
    city: city.name,
    lat,
    lng,
    amenities: Array.from(amenitySet),
    photos,
    agentId: pick(agents).id,
    description: pick(descriptions),
    featured: chance(0.25),
    listedAt: `2026-${month}-${day}T09:00:00Z`,
  };
}

const listings = Array.from({ length: 40 }).map((_, i) => makeListing(i));

const user = {
  id: 'usr_001',
  name: 'Alex Morgan',
  email: 'demo@dwellio.app',
  phone: '+1 (555) 012-3456',
  photo: 'https://i.pravatar.cc/300?img=5',
  // NOTE: mock-only. Real auth would never store a plaintext password.
  password: 'password',
};

const savedSearches = [
  {
    id: 'ss_01',
    label: '2+ bed rentals in Austin',
    filters: { dealType: 'rent', q: 'Austin', beds: 2, maxPrice: 3000 },
    createdAt: '2026-06-05T10:00:00Z',
  },
  {
    id: 'ss_02',
    label: 'Houses to buy under $600k',
    filters: { dealType: 'buy', type: 'house', maxPrice: 600000 },
    createdAt: '2026-06-08T14:30:00Z',
  },
];

const inquiries = [
  {
    id: 'inq_01',
    listingId: listings[2].id,
    type: 'tour',
    lastMessage: 'Your tour is confirmed for Saturday at 2:00 PM.',
    status: 'confirmed',
    date: '2026-06-12T16:00:00Z',
    messages: [
      { from: 'user', text: "I'd like to schedule a tour.", at: '2026-06-11T09:00:00Z' },
      { from: 'agent', text: 'Sure! Does Saturday 2 PM work?', at: '2026-06-11T10:15:00Z' },
      { from: 'user', text: 'Perfect, see you then.', at: '2026-06-11T10:20:00Z' },
    ],
  },
  {
    id: 'inq_02',
    listingId: listings[7].id,
    type: 'message',
    lastMessage: 'Is the price negotiable?',
    status: 'open',
    date: '2026-06-13T11:00:00Z',
    messages: [
      { from: 'user', text: 'Is the price negotiable?', at: '2026-06-13T11:00:00Z' },
    ],
  },
];

const notifications = [
  { id: 'ntf_01', title: 'Price drop', body: `A home you viewed dropped by 5%.`, type: 'price_drop', read: false, date: '2026-06-15T08:00:00Z', listingId: listings[4].id },
  { id: 'ntf_02', title: 'Tour confirmed', body: 'Your Saturday tour is confirmed.', type: 'tour', read: false, date: '2026-06-12T16:05:00Z', listingId: listings[2].id },
  { id: 'ntf_03', title: 'New match', body: '3 new listings match your saved search.', type: 'match', read: true, date: '2026-06-11T07:30:00Z', listingId: listings[9].id },
  { id: 'ntf_04', title: 'New match', body: 'A new rental matches "2+ bed rentals in Austin".', type: 'match', read: true, date: '2026-06-10T07:30:00Z', listingId: listings[12].id },
  { id: 'ntf_05', title: 'Welcome to Dwellio', body: 'Find your next home with confidence.', type: 'system', read: true, date: '2026-06-01T12:00:00Z', listingId: null },
  { id: 'ntf_06', title: 'Price drop', body: 'A saved home is now more affordable.', type: 'price_drop', read: false, date: '2026-06-14T09:45:00Z', listingId: listings[18].id },
];

const db = {
  users: [user],
  agents,
  'property-types': propertyTypes,
  amenities,
  listings,
  favorites: [],
  'saved-searches': savedSearches,
  tours: [],
  inquiries,
  notifications,
};

fs.writeFileSync(path.join(__dirname, 'db.json'), JSON.stringify(db, null, 2));
console.log(`Wrote db.json with ${listings.length} listings, ${agents.length} agents.`);
